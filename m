From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] add git credential login to remote mediawiki
Date: Tue, 12 Jun 2012 17:21:47 +0200
Message-ID: <vpqsje0mu7o.fsf@bauges.imag.fr>
References: <1339512125-32761-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	<vpq8vfsoa6x.fsf@bauges.imag.fr>
	<303c1249341d6f305d315b0a8d9cd20c@telesun.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <Javier.Roucher-Iglesias@ensimag.imag.fr>, <git@vger.kernel.org>,
	Javier Roucher <jroucher@gmail.com>
To: roucherj <roucherj@telesun.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 17:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSus-0000sS-31
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 17:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab2FLPVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 11:21:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59556 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab2FLPVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 11:21:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5CFCeTB023542
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 17:12:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeSui-00080G-I7; Tue, 12 Jun 2012 17:21:48 +0200
In-Reply-To: <303c1249341d6f305d315b0a8d9cd20c@telesun.imag.fr>
	(roucherj@telesun.imag.fr's message of "Tue, 12 Jun 2012 17:10:05
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 12 Jun 2012 17:12:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CFCeTB023542
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340118763.41467@5HfcCqAS9xzcxHJv/SWrCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199802>

roucherj <roucherj@telesun.imag.fr> writes:

> On Tue, 12 Jun 2012 16:51:18 +0200, Matthieu Moy wrote:
>> Javier.Roucher-Iglesias@ensimag.imag.fr writes:
>>
>>>  # MediaWiki API instance, created lazily.
>>> +sub run_credential {
>>
>> How is the code related to the comment right above?
>>
>
> Sorry a old comment, i think it's a cause of git rebase i will erase.

The comment was already there in the code, but it was right above

my $mediawiki;

and therefore meaningful.

> sorry but before it's like:
> +	my $Prog = "git credential $op";
> +	open2(*Reader, *Writer, $Prog);
> +	print Writer $msg;
> +	close(Writer);

No it wasn't (this is the expected version). It was "close (Writer);"
with an extra space.

>> Didn't I already mention (twice?) that this declaration was meant to
>> stay right above mw_connect_maybe?
>
> yes but 'ask_credential' used $mediawiki then i think i have to
> declare before 'ask_credential'

But do you have any reason not to declare ask_credential after
mw_connect_maybe?

>>> +			run_credential("reject");
>>> +#			exit 1;
>>
>> Do you, or do you not want to "exit 1". Either remove this, or
>> uncomment
>> it.
>>
>
> i have comment this line to see the opinion of the community, because
> i ask all the time to authenticate
> but there are few operations who we don't have to authenticate it.
>
> now if we comment this line the login will fail but they will continue
> with the operation (like, git clone)
> and try to do it, if the wiki need to be authenticate will refuse the
> operation if not they will continue.
[...]
>> This means you can't use the wiki anonymously anymore. This is an
>> unacceptable regression.
>
> yes you can use anonymously but login will fail and try to the
> operation, this is the reason because i have comment the 'exit 1'.

But in this case, you still prompt for login and password, right?.
That's weird for the user to have to type a dummy login/password and see
an error message to use a wiki anonymously.

>>>  sub mw_connect_maybe {
>>> +
>>>  	if ($mediawiki) {
>>
>> Why do you add this blank line? (already mentionned)
>>
>
> because we need the structure $mediawiki to get the url if is not
> declare it will return with out doing the operation

I'm talking about the blank line, not the if.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
