From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: insecurity in verify-tag?
Date: Wed, 25 Nov 2009 13:54:53 +0100
Message-ID: <4B0D291D.4060100@drmicha.warpmail.net>
References: <117f2cc80911240856lbbb923buc7d0407bc2cba6a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	David Roundy <roundyd@physics.oregonstate.edu>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:56:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDHPh-0001qQ-JR
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 13:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934604AbZKYMzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 07:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934580AbZKYMzx
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 07:55:53 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42582 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934562AbZKYMzx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 07:55:53 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 381BAC0BEA;
	Wed, 25 Nov 2009 07:55:59 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 25 Nov 2009 07:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/GUo7M6ciEHVDB1Dzt2LgE/Rr2I=; b=UP5zaHwk4AavEp9qHbCURRqH+QGMXoPFUJpLSpgqBxdzH4k3wPCZe2kG43vexdf6BemuRBjT3q3JZOgAYyWdhBMUCsq8hYKeIbW0dYpHQUJt5c5d03lBinr/x8LK2U+2TW/ZG+scp33Aeie3RLBHpAv21tJ/XliweNnRfEu5wjA=
X-Sasl-enc: 2DM/VTJakTymlwWpvcz+AVI7kEnjU+c1wdmNs3UB8tcd 1259153758
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 54C303BB3F;
	Wed, 25 Nov 2009 07:55:58 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <117f2cc80911240856lbbb923buc7d0407bc2cba6a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133635>

David Roundy venit, vidit, dixit 24.11.2009 17:56:
> I've just been looking at the code and I see what looks like a (minor)
> security hole in the verify-tag feature.  In particular, the tag
> verification code doesn't check that the tag is signed by the same
> user that created the tag.  To be fair, gpg does output the identity
> of the key that created the signature as well as the key used to
> create the signature, so an astute user could detect that some
> shenanigans is going on.
> 
> An attack would simply require getting one's own public key into the
> keyring of a user.  This probably wouldn't be very easy at the moment,
> but if people were to actually use encrypted email (and if they set
> their mail agents to download public keys), it might require no more
> then sending a signed email to a mailing list.
> 
> Of course, you'd also somehow have to trick them into pulling (or
> cloning) your corrupt tag, which probably requires compromising a
> server (or mirror) somewhere.  But of course, the whole point of
> signing tags is to eliminate precisely this danger.
> 
> What should be done about this? First, there ought to be a feature to
> limit git verify-tag to use a specific keyring.  Maybe there is an
> environment variable, and it's just not documented in the man page?
> 
> It would also seem like a good idea to at a minimum check that the
> name/email associated with the signature is the same as that of the
> tagger.  This doesn't gain you *too* much, since an attacker can
> always create his own key with any name and email he likes, but at
> least it means that users could feel safe adding keys to their public
> keyring, as long as those keys have reasonable names/emails associated
> with them, and as long as they run git show on a tag before trusting
> that that tag came from a particular person.  i.e. it seems reasonable
> for me to expect that if I run:
> 
> $ git show v1.0
> tag v1.0
> Tagger: Linus Torvalds ...
> ...
> [user carefully reads the Tagger line...]
> $ git verify-tag v1.0 && make
> 
> That I won't be running make on a repository that wasn't signed by a
> key that at least *claims* to belong to Linus Torvalds.
> 
> Thoughts?

My thought is that this is the wrong way to deal with signatures, be it
signatures on tags or signatures on other documents such as e-mails.

Everyone can produce a valid signature. Everyone can set an arbitrary
tagger name or commit author. They are meaningless. A "Tagger" really is
the committer of a tag object, whereas the signer is the actual author
of the signature.

The only case where a signature bears any value is when

- the signature is valid (in the sense of formal validity)
AND
- you trust the signer (i.e. the person and the key).

Specifically, you are supposed NOT to go by the return code of gpg
--verify (which is behind verify-tag). It doesn't mean all that much. On
a side note, that was an attack vector on gpg users last year or so.

All that git itself could do is compare the tagger and the signer, and
warn you if they differ, that is: the signer's key contains no uid
matching the tagger. But this piece of information is really orthogonal
to the issue of trustworthiness.

Note that the actual signature verification process depends also on the
gpg trust model (pgp/classic/...) that you're using and your trustdb. If
you want to use a specific gpg setup or keyring for tag purposes you can
do something like

GNUPGHOME=~/.gpgforgit git verify-tag v1.6.5

Michael
