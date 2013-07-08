From: Steven Klass <sklass@7stalks.com>
Subject: Re: [PATCH] Corrects an Abort Trap: 6 error with completions.
Date: Mon, 8 Jul 2013 10:45:43 -0700
Message-ID: <9699781D-9A21-4C65-86E7-50156F934C08@7stalks.com>
References: <5FF738AB-DA01-4460-9ADF-D960E2FD6309@7stalks.com> <7vwqp1yn1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 19:45:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwFVX-0000M0-8q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 19:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab3GHRpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 13:45:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:60536 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3GHRpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 13:45:45 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so4568546pab.20
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 10:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer
         :x-gm-message-state;
        bh=3ODypw7qv8octTCwVW6b/zt+2ShynyIWk+ePBmyKUYU=;
        b=ZOxsVZ8bcMlCI7vQVTjteI5wYbvl/emMHxYHU8HxF05g2vLOLnEgu/cv3+/LUTf7IZ
         ItcRf+njqAnOCwjPyIP3ma11gaHx0X6XR7h2wZ+c4/N13AUFSeDo2TUcl6aOakgj9pDF
         xOSUeGoIZsgSS8hHoIujlfYWu7PONHrRTxfjTRo9Y3+yZHyjEBNRv/Xp9BjVJkE1K2WN
         Npc0yLebSVoHcxudZGHcz2Og3FMfsq4gjW00WPjxXVvgVYw28/SmRd9xEsY4/Oaimypx
         jaUlmS9xGu4lHCwAdjFGr+AXCKK0+PAYlHeQfAxq41r26OR5q1PxZVs8nKZ2eEGUasyK
         rcuA==
X-Received: by 10.67.8.98 with SMTP id dj2mr23851280pad.47.1373305545242;
        Mon, 08 Jul 2013 10:45:45 -0700 (PDT)
Received: from [192.168.4.28] (ip-64-134-222-51.public.wayport.net. [64.134.222.51])
        by mx.google.com with ESMTPSA id lk9sm7496375pab.2.2013.07.08.10.45.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 10:45:44 -0700 (PDT)
In-Reply-To: <7vwqp1yn1w.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1508)
X-Gm-Message-State: ALoCoQmpH0TAtCeTRX0abC0gE/u5zJGK/DBX8JdDVigRi8DlUwj+HH5UR2Ln6K2NOlqg1RSusVLY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229881>

Hi Junio,

First - Thanks so much for your reply!  

	The original cause was simply running a non-related command.  Specifically I was trying to build some internal software.  Our internal software uses a build build tool from perforce called jam (http://www.perforce.com/resources/documentation/jam).  Similar to the make build tool this looks up a Jamfile (ergo Makefile) and does the recipe.  The issue is that running `jam` fatally aborts right from the start with an unintuitive `abort trap: 6` error.  

	As you can well imagine figuring out what was causing this was pretty difficult - because both the error was cryptic and so unrelated.  I started backing out my environment until I was able to narrow this down to the bash_completions file.  Further investigation finally nailed it on the concatenation of the  `branch. remote.` line 2165.    In summary when the lines were joined it showed the error, when they were on separate lines everything processed as expected.

	Again - my only change was to shift them (  branch. remote. ) to two separate lines.

HTH

---

Steven Klass

(480) 225-1112
sklass@7stalks.com
http://www.7stalks.com

On Jul 8, 2013, at 10:32 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Steven Klass <sklass@7stalks.com> writes:
> 
>> Hi Folks,
>> 
>> 	Corrects an Abort Trap: 6 error with completions.
>> 	Fixed an issue where the two commands on a single line  would cause a strange unrelated 'Abort trap: 6' error on  non-git commands on Mac OSX 10.8.
>> 
>> Signed-off-by: Steven Klass <sklass@7stalks.com>
> 
> Can you explain how/why the original causes "abort trap: 6"
> (whatever it is) and how/why the updated one avoids it in the log
> message?
> 
> It also is not quite clear when the error happens.  Do you mean, by
> "non-git commands", something like:
> 
>    $ ca<TAB>
> 
> does not complete to "cal", "case", "cat", etc. and instead breaks
> the shell?
> 
> I am confused.  The only change I can see in the patch is that it
> makes the argument to this call to the __gitcomp shell function be a
> string with tokens separated by LF and HT and no SP (the original
> assumes that the tokens will be split by LF, HT or SP, and the shell
> function locally sets $IFS to make sure that the change in this
> patch does not make any difference).  And in many other places in
> the same script, the __gitcomp shell function is called with an
> argument with LF, HT or SP spearated tokens, e.g.
> 
>    _git_add ()
>    {
>            case "$cur" in
>            --*)
>                    __gitcomp "
>                            --interactive --refresh --patch --update --dry-run
>                            --ignore-errors --intent-to-add
>                            "
>                    return
>            esac
> 
> 
> 
>> 
>> ---
>> contrib/completion/git-completion.bash | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> mode change 100644 => 100755 contrib/completion/git-completion.bash
>> 
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> old mode 100644
>> new mode 100755
>> index 6c3bafe..d63b1ba
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2165,7 +2165,8 @@ _git_config ()
>>           user.name
>>           user.signingkey
>>           web.browser
>> -          branch. remote.
>> +          branch.
>> +          remote.
>>      "
>> }
>> 
>> ---
>> 
>> Steven Klass
>> 
>> (480) 225-1112
>> sklass@7stalks.com
>> http://www.7stalks.com
