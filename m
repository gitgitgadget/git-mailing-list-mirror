From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Fri, 07 Oct 2011 10:40:30 +0200
Message-ID: <4E8EBAFE.8020805@drmicha.warpmail.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org> <robbat2-20111006T221637-481195848Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 10:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC5yy-0007ct-5r
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 10:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934911Ab1JGIke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 04:40:34 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39470 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759437Ab1JGIkd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 04:40:33 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BCD5020D98;
	Fri,  7 Oct 2011 04:40:32 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 07 Oct 2011 04:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=jjsHqclOld+K2rhZn6Wq6+
	P7I2M=; b=rB4z1t3acne4jzZomtO5IWPTRfAjR1kiK51rGSUAENl2aDiZUkAjNy
	tiQHVeKhepp83PZjH5NxX0IHVKfaGxH3aJtBHWaPnRVVER8OKr9FjV09rTlCFs4E
	mxasflVqjAFIQP8n8wBAAcUR9Ghd/ketRXzT67wXitA17exC17p7o=
X-Sasl-enc: GjdkkovPcQlw3RbfaMSQYZWlxNYswUKrelU+ibJRxj8P 1317976832
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 243E84011AD;
	Fri,  7 Oct 2011 04:40:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <robbat2-20111006T221637-481195848Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183065>

[readding JCH to cc whom you dropped]
Robin H. Johnson venit, vidit, dixit 07.10.2011 00:24:
> On Wed, Oct 05, 2011 at 05:56:55PM -0700,  Junio C Hamano wrote:
>> And this uses the gpg-interface.[ch] to allow signing the commit, i.e.
>>
>>     $ git commit --gpg-sign -m foo
>>     You need a passphrase to unlock the secret key for
>>     user: "Junio C Hamano <gitster@pobox.com>"
>>     4096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main key ID 713660A7)
>>
>>     [master 8457d13] foo
>>      1 files changed, 1 insertions(+), 0 deletions(-)
> I like it, but I have a couple of questions: 
> 1. Are the sig lines used in computed SHA1/commitid of a given commit (I
>    see examples w/ --amend and that would usually change the SHA1)?

Yes, just like with tag objects.

> 2. Can we allow more than one person sign a commit?

I don't think we support it now (tags) but we could allow concatenating
signatures since they are detached.

There's a somewhat delicate issue here: The signature (tag/commit) is a
signature on the contents of the object, and is itself not part of the
contents (or else we would have a chicken-egg-problem).

The sha1 of the object is determined by the content+header, i.e.
including the signature.

So, by adding a signature, you change the sha1, but any existing
signature remains valid.

This is also how you can try to achieve a specific sha1 for a given
object content...

> 3. If I have prepared a series on a local branch, and I want to sign all
>    of them, is this a variant of rebase or?

If you really want to sign all you can rebase-i and use "exec" to do
that automatically, but there's no point: signing the top-most commit
serves the same purpose.

> I think this isn't a replacement for push certificates, but has value in
> itself. It's certainly provides better integration than the
> signature-in-note variants.
> 

I do think it's meant as an implementation of push certificates. I don't
see any other value in it which could not be achieved by signed tags.
Can you describe any?

Michael
