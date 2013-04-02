From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] add: add a newline at the end of pathless 'add [-u|-A]' warning
Date: Tue, 02 Apr 2013 16:43:55 +0200
Message-ID: <vpqehetgfh0.fsf@grenoble-inp.fr>
References: <vpqk3pefjs4.fsf@grenoble-inp.fr>
	<1362988893-27539-1-git-send-email-Matthieu.Moy@imag.fr>
	<1362988893-27539-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v7gldc44p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 16:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN2Tc-0007Er-Im
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 16:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444Ab3DBOpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 10:45:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60148 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332Ab3DBOpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 10:45:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r32Ehs6m021973
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Apr 2013 16:43:54 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UN2RH-000356-NK; Tue, 02 Apr 2013 16:43:55 +0200
In-Reply-To: <7v7gldc44p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 11 Mar 2013 09:06:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Apr 2013 16:43:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r32Ehs6m021973
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1365518634.79064@NmOJhtx0HzynZQ21wcbUhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219776>

Sorry for the late reply,

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> When the commands give an actual output (e.g. when ran with -v), the
>> output is visually mixed with the warning. The newline makes the actual
>> output more visible.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>
> It would have been easier to immediately understand what is going on
> if you said "blank line" instead of "newline" ;-)

Indeed.

> An obvious issues is what if user does not run with "-v" or if "-v"
> produces no results.  We will be left with an extra blank line at
> the end.

Right, but displaying the blank line only when there's an actual output
does not seem easy, and I'd rather avoid too much damage in the code for
a warning which is only temporary.

> I suspect that the true reason why the warning does not stand out
> and other output looks mixed in it may be because we only prefix the
> first line with the "warning: " label.  In the longer term, I have a
> feeling that we should be showing something like this instead:
>
>     $ cd t && echo >>t0000*.sh && git add -u -v
>     warning: The behavior of 'git add --update (or -u)' with no path ar...
>     warning: subdirectory of the tree will change in Git 2.0 and should...
>     warning: To add content for the whole tree, run:

I personnally do not like this kind of output, the "warning:" on the 2nd
and 3rd lines break the flow reading the message. But that's probably a
matter of taste.

> using a logic similar to what strbuf_add_commented_lines() and
> strbuf_add_lines() use.

This would mean changing the warning() function, which would change all
warnings.

I'm fine with either dropping my patch or applying it as-is (with
s/newline/blank line/ in the commit message); a bit reluctant to
changing the output of warning(...), but that's an option if other
people like it.

>>  builtin/add.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index ab1c9e8..620bf00 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -344,7 +344,7 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
>>  		  "  git add %s .\n"
>>  		  "  (or git add %s .)\n"
>>  		  "\n"
>> -		  "With the current Git version, the command is restricted to the current directory."),
>> +		  "With the current Git version, the command is restricted to the current directory.\n"),
>>  		option_name, short_name,
>>  		option_name, short_name,
>>  		option_name, short_name);
>
>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
