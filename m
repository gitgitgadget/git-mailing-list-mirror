From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Sun, 09 Oct 2011 18:32:48 +0200
Message-ID: <4E91CCB0.4080809@drmicha.warpmail.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org> <robbat2-20111006T221637-481195848Z@orbis-terrarum.net> <4E8EBAFE.8020805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Oct 09 18:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCwJ7-00053n-78
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 18:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab1JIQcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 12:32:52 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36239 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929Ab1JIQcv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 12:32:51 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4F2D32051A;
	Sun,  9 Oct 2011 12:32:50 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 09 Oct 2011 12:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=eC5f8uR6+WWLP9JA4GThDI
	pg4d4=; b=GyP3Mjj4RDh9MB/ebHs9NkZx4s9YNRwoTndzlQeJq/WdmDR8IhEM37
	hcgCpqR3E1Etii2WVVowP+dPb6MhYdciOaVPrX66i7uE+84tJPSDd3YAOST8Fxxg
	Gs1gsRJYTvvhk2KuSECcM3VcLF0KN1lmzFdhnm4og1A+YZI4owpbo=
X-Sasl-enc: 4kZKrZYLz4JAHGyWd7fAfdOaqfCS3l7nHFp0D1Qt3V5k 1318177969
Received: from localhost.localdomain (p54859556.dip0.t-ipconnect.de [84.133.149.86])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8DE7D4022B3;
	Sun,  9 Oct 2011 12:32:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <4E8EBAFE.8020805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183205>

Michael J Gruber venit, vidit, dixit 07.10.2011 10:40:
> [readding JCH to cc whom you dropped]
> Robin H. Johnson venit, vidit, dixit 07.10.2011 00:24:
>> On Wed, Oct 05, 2011 at 05:56:55PM -0700,  Junio C Hamano wrote:
>>> And this uses the gpg-interface.[ch] to allow signing the commit, i.e.
>>>
>>>     $ git commit --gpg-sign -m foo
>>>     You need a passphrase to unlock the secret key for
>>>     user: "Junio C Hamano <gitster@pobox.com>"
>>>     4096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main key ID 713660A7)
>>>
>>>     [master 8457d13] foo
>>>      1 files changed, 1 insertions(+), 0 deletions(-)
>> I like it, but I have a couple of questions: 
>> 1. Are the sig lines used in computed SHA1/commitid of a given commit (I
>>    see examples w/ --amend and that would usually change the SHA1)?
> 
> Yes, just like with tag objects.
> 
>> 2. Can we allow more than one person sign a commit?
> 
> I don't think we support it now (tags) but we could allow concatenating
> signatures since they are detached.

Quick update:
Sticking two signatures into a signed tag works perfectly with current
git, both signatures are verified and displayed.

So, it might make sense to have "commit --amend" append to an existing
signature.

> There's a somewhat delicate issue here: The signature (tag/commit) is a
> signature on the contents of the object, and is itself not part of the
> contents (or else we would have a chicken-egg-problem).
> 
> The sha1 of the object is determined by the content+header, i.e.
> including the signature.

NB: "header" is the wrong term here, it's "data" I think.

> So, by adding a signature, you change the sha1, but any existing
> signature remains valid.
> 
> This is also how you can try to achieve a specific sha1 for a given
> object content...
> 
