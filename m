From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 08:23:02 +0100
Message-ID: <56A87056.2010309@drmicha.warpmail.net>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net> <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:23:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOKRe-00008Q-F8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbcA0HXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:23:09 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56318 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751629AbcA0HXF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 02:23:05 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 413DA2458E
	for <git@vger.kernel.org>; Wed, 27 Jan 2016 02:23:04 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 27 Jan 2016 02:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=wB6jFhuQiJKQtWVDHqnpXWEHsPk=; b=b3CPnn
	S2Cuu2+rgLOaHQY11KGkOoaQAfqANOJF7jmqMaewtfPdhtjnwnW98lG8ETYiFsU9
	4TC+Oh2S44kTqKSqm7ifyXyrqRamNI0Yxeo5bszslMT5X7QISV11280Gp3iVqlYs
	HSRbBbeM+WqqbQXXQ22u8t1TLc8Y7PB431Y1c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=wB6jFhuQiJKQtWV
	DHqnpXWEHsPk=; b=UmaOP85Tf/tfwtowBvBVe+RaOrxCAZIbHecAzMnkca3BC8Z
	EIb+gCg+kd7YpRFLN7Z9PzOIMw4Q2cHtrA/4mKVOkSgpnna6KgjPi2gWaNK0A2QP
	ZFqqWU7Aqd/XM9tp2ZUMhYyY/XdhQpWVwXh1+sPIl3K+ITpvgMMyk0R8rK9c=
X-Sasl-enc: 71qCm9FV+xfO9Cdi0zcc8mIDYIYGHRW93D+cJhjhmDnK 1453879383
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9670DC01718;
	Wed, 27 Jan 2016 02:23:03 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <20160126202651.GA1090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284888>

Jeff King venit, vidit, dixit 26.01.2016 21:26:
> On Tue, Jan 26, 2016 at 10:29:42AM -0500, Santiago Torres wrote:
> 
>>> If you cannot trust those with write access to a repo that you are
>>> pulling and installing from you might want to re-check where you are
>>> pulling or installing from ;)
>>
>> Yeah, I see your point, but mechanisms to ensure the server's origin can
>> be bypassed (e.g., a MITM). I don't think it would hurt to ensure the
>> source pointed to is the source itself. The tag signature can help us do
>> this.
> 
> Right. I think the more interesting use case here is "I trust the
> upstream repository owner, but I do not trust their hosting site of
> choice."
> 
>>> Your best bet is checking the signature of signed tags. Now, if you're
>>> worried about someone maliciously pointing you to the wrong, correctly
>>> signed tag then you should verify that the tag object contains the tag
>>> "name" that you expect (for example by using "git verify-tag -v" or "git
>>> cat-file -p"), since that is part of the signed content.
>>
>> Yep, this is my intuition behind my proposal. While someone can manually
>> inspect a tag (git tag -v [ref]) to ensure he's getting the correct one,
>> there's no mechanism to ensure that the ref is pointing to the intended
>> tag. I do believe that package managers and git submodules could check
>> whether the ref is pointing to the right tag with a small change in the
>> tag header. Although it would be up to each tool to implement this
>> check.
>>
>> I don't think that an addition like this would get in the way of any
>> existing git workflow, and should be backwards-compatible right?
> 
> Doesn't this already exist?
> 
>   $ git cat-file tag v2.0.0
>   object e156455ea49124c140a67623f22a393db62d5d98
>   type commit
>   tag v2.0.0
>   tagger Junio C Hamano <gitster@pobox.com> 1401300269 -0700
> 
>   Git 2.0
>   -----BEGIN PGP SIGNATURE-----
>   [...]
>   -----END PGP SIGNATURE-----
> 
> Tag objects already have a "tag" header, which is part of the signed
> content. If you use "git verify-tag -v", you can check both that the
> signature is valid and that the tag is the one you are expecting.

Yes, that's what I described in my last paragraph, using the term
(embedded) tag "name" which is technically wrong (it's not the tag
object's name, which would be a sha1) but the natural term for users.

> Of course, "verify-tag" could do this for you if you give it a refname,
> too, but I think that may be the tip of the iceberg in terms of
> automatic verification. In particular, verify-tag knows it was signed by
> _somebody_, but it doesn't know what the signing policy is. As a human,
> _I_ know that Junio is the right person to be signing the release tag,
> but no tool does.
> 
> Git pretty much punts on all of these issues and assumes either a human
> or a smarter tool is looking at the verification output. But I don't
> think it would hurt to build in some features to let git automatically
> check some things, if only to avoid callers duplicating work to
> implement the checks themselves.

That is really a can of worms for several reasons:

- Do you fetch tags into refs/tags/ or refs/tags/upstream/ or wherever,
and which part of the tag refname should we check for?

We can DWIM that to the last part after / and allow "--tagname" to
override, of course.

- By all means, we need to avoid a false sense of security. "GOOD
SIGNATURE" in gpg terms is bad enough with the usual trust model when
users don't check who actually made that signature.

If you don't *really* check the signature then anyone can shove a signed
tag object under your nose with the *expected tag header* (tag "name")
so that there is no gain at all, unless you envison a scenario where Man
I. T. Middle can mess with refs but not objects.

So, for those who shy away from for-each-ref and such, we may add the
header check to verify-tag, with a big warning about the marginal gain
in security (or the requirements for an actual gain).

Michael
