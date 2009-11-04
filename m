From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare repos
Date: Wed, 04 Nov 2009 21:42:43 +0100
Message-ID: <vpqr5se58e4.fsf@bauges.imag.fr>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
	<alpine.DEB.1.00.0911041422170.2788@felix-maschine>
	<vpqzl729j72.fsf@bauges.imag.fr>
	<7v3a4ugjea.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:43:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mhT-0001TH-Fq
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbZKDUnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbZKDUnO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:43:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57983 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932366AbZKDUnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 15:43:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nA4Kg2JG007642
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Nov 2009 21:42:02 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N5mgl-0003Mh-UM; Wed, 04 Nov 2009 21:42:43 +0100
In-Reply-To: <7v3a4ugjea.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 04 Nov 2009 11\:49\:33 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 04 Nov 2009 21:42:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nA4Kg2JG007642
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1257972125.77403@62rD2fqykXBKtQIytmS1dw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132146>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I can't think of any, and I just tried launching two
>>
>> while true; do git pull; date > foo.txt ; git add .; git commit -m "xxx"; git push; done
>>
>> in parallel, with two different users pushing to a --bare --shared
>> repository, and it did work well. But I may very well have missed
>> something.
>>
>> (and actually, if it causes problem, it's an argument in favor of
>> defaulting to false when core.shared is true, not when core.bare).
>>
>> Unless I missed something, I think core.logAllRefUpdates should be
>> enabled for bare repos.
>
> Your experiment justifies "could be enabled safely" and saying "should be"
> based on that is a bit too strong and also premature.

Right, there were no cause/effect relationship between the first part
and the "should".

> As reflog is a local thing, and not exposed to outside world,
> enabling it alone would not help a lot to people who do not have
> such a direct access to the bare repository, which by definition is
> the majority because the reason why the repository is bare to begin
> with.

For sure, it's the majority. But it's not 100% cases either.

And in most cases, even if the user doesn't have access to the repo,
there exists a sysadmin somewhere who has. And the day a user will
send a mail "hey, I've messed up everything, I did a push -f and what
happened?", this sysadmin will appreciate to have a log somewhere.

And another use-case for the reflog is to find know reliable where a
piece of code is comming from. "git blame" tells you who the commiter
said he was, while the reflog says reliably who the push-er was.

So, clearly, the reflog on a bare repo is not usefull for daily use
like it is for non-bare repos (where, really, it's a killer
feature ;-) ). But it doesn't seem useless either, and it doesn't cost
much, so ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
