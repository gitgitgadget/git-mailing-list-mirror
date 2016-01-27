From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 08:53:08 +0100
Message-ID: <56A87764.9070101@drmicha.warpmail.net>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net> <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <56A87056.2010309@drmicha.warpmail.net>
 <20160127073357.GA7066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 08:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOKuv-0003vK-GX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbcA0HxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:53:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50668 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754020AbcA0HxN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 02:53:13 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 49DFD2992A
	for <git@vger.kernel.org>; Wed, 27 Jan 2016 02:53:11 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 27 Jan 2016 02:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=pdBDRDOtmUkUt5/w9OmkyahdRD0=; b=eulrlb
	UND7uHouc716/904MHdf+vlh9lPC/9HeJLH3lp0rZqiuA5RLxAUYuyrHunCdtMTx
	mRvaSlp9i8VRgKmxrxl5O9T/A5T+2amtJlPR9pzuofEc9SZnFDjFnXPJudqv4W0c
	s6gCez51HeWz6PzNG6EF0RLdJA4T1W4M3vFTk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=pdBDRDOtmUkUt5/
	w9OmkyahdRD0=; b=AV8AmkR9pnVoRwaXL2ysRpOciSmVgBlbthHJPG+BkoFpRK6
	CSHv/D/hzk5pqv0iJh+re8vfY9AwpzXXSN27L/nOcmP04K/kRclCU1X6J+IlI3Sf
	upQGx4PPnaaXpxiHpJ/KVp9B+jdFLwW0+43oZSbOM+w3E+OeXk6IEMh1JANY=
X-Sasl-enc: 1UvxHH7mr1cJCxtPHc9HeGkUrNw3YqV3M+kuHZ06KHct 1453881190
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id ABB5468015E;
	Wed, 27 Jan 2016 02:53:10 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <20160127073357.GA7066@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284891>

Jeff King venit, vidit, dixit 27.01.2016 08:33:
> On Wed, Jan 27, 2016 at 08:23:02AM +0100, Michael J Gruber wrote:
> 
>>> Tag objects already have a "tag" header, which is part of the signed
>>> content. If you use "git verify-tag -v", you can check both that the
>>> signature is valid and that the tag is the one you are expecting.
>>
>> Yes, that's what I described in my last paragraph, using the term
>> (embedded) tag "name" which is technically wrong (it's not the tag
>> object's name, which would be a sha1) but the natural term for users.
> 
> Indeed. I should have read further back in the quoting. :)
> 
>>> Git pretty much punts on all of these issues and assumes either a human
>>> or a smarter tool is looking at the verification output. But I don't
>>> think it would hurt to build in some features to let git automatically
>>> check some things, if only to avoid callers duplicating work to
>>> implement the checks themselves.
>>
>> That is really a can of worms for several reasons:
>> [...]
>> So, for those who shy away from for-each-ref and such, we may add the
>> header check to verify-tag, with a big warning about the marginal gain
>> in security (or the requirements for an actual gain).
> 
> Yeah, definitely. My thinking was that `verify-tag` could learn a series
> of optional consistency checks, enabled by command line options, and
> verifying programs (or humans) could turn them on to avoid having to
> replicate them manually. So something like:
> 
>   git verify-tag \
>     --verify-tagger-matches-key \
>     --verify-tag-matches-ref \ # or --verify-tag-matches=v2.0.0
>     v2.0.0
> 
> or to implement more specific policy, maybe an option to check for a
> _specific_ tagger, either by email (as provided by gpg) or even key-id.
> 
> Those are all things that are not _too_ hard to do if you're willing to
> parse gpg or git output, but we could make life easier for our callers.
> And hopefully by asking for specific, concrete checks, it doesn't
> introduce a false sense of security. I.e., we're not making a foolproof
> tool; we're making building blocks that one could use for a more
> foolproof tool.

OK, let's make a tool that helps fooling as well as proofing :)

I'll look into the tag header check. Maybe "--check-tagname"? "check"
seems to imply less than "verify".

As for the gpg related stuff: We provide the full diagnostic output from
gpg on request. But I think a mismatch between the signing key's uid and
the taggers' name/email is more common than not, and on the other hand a
signature by a key identified by its uid is meaningless unless you keep
your keyring tidy... We could punt on that and let users identify the
key by any means that gpg allows, of course, and check that the
signature comes from whatever "gpg --list-key <userspecified>" gives as
long as it's unique.

But maybe I'm biased by my zoo of uids/emails addresses/full name
spellings... and general paranoia regarding the term "verify" ;)

Michael
