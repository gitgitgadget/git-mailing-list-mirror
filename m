From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/8] git-remote-mediawiki: actually send empty comment when they're empty
Date: Mon, 16 Jul 2012 21:06:33 +0200
Message-ID: <vpqr4sbv83q.fsf@bauges.imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
	<1342440053-3058-3-git-send-email-Matthieu.Moy@imag.fr>
	<7vd33v377x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:08:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqqeL-0005ur-1L
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab2GPTIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:08:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33907 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab2GPTH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:07:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJ4wcl005437
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:04:58 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sqqcs-00013d-Ir; Mon, 16 Jul 2012 21:06:34 +0200
In-Reply-To: <7vd33v377x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 16 Jul 2012 11:13:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 21:04:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJ4wcl005437
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343070300.68487@rkFhiRZl2ZkZJTY26F3sgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201549>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  contrib/mw-to-git/git-remote-mediawiki | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
>> index a6ad8cf..a2da52f 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki
>> +++ b/contrib/mw-to-git/git-remote-mediawiki
>> @@ -51,6 +51,9 @@ use constant EMPTY_CONTENT => "<!-- empty page -->\n";
>>  # used to reflect file creation or deletion in diff.
>>  use constant NULL_SHA1 => "0000000000000000000000000000000000000000";
>>  
>> +# Used on Git's side to reflect empty edit messages on the wiki
>> +use constant EMPTY_MESSAGE => '*Empty MediaWiki Message*';
>> +
>
> Is there a reason why this sentinel value cannot be a real empty
> string?

That would mean having an empty commit message on the Git side, which is
against the use (although possible with fast-import). The import turns
empty mediawiki messages (which are very common in my experience) into
this string to provide a nicer-looking history.

It's not like EMPTY_CONTENT, which is explicitely forbidden on the
MediaWiki side, hence really cannot be the empty string.

Ideally, EMPTY_MESSAGE could be configurable, and the empty string could
be an acceptable value to make this conversion optional.

(note that the string was already there, my patch only makes it a
constant to be able to use it in two distinct places).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
