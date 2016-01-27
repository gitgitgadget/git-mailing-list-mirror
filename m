From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 10:14:17 +0100
Message-ID: <56A88A69.6030503@drmicha.warpmail.net>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net> <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <56A87056.2010309@drmicha.warpmail.net>
 <20160127073357.GA7066@sigill.intra.peff.net>
 <56A87764.9070101@drmicha.warpmail.net>
 <20160127080901.GA7651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Santiago Torres <santiago@nyu.edu>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:14:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOMBL-0001e3-VT
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcA0JO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 04:14:27 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39961 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752114AbcA0JOU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 04:14:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 65C7C2ACC0
	for <git@vger.kernel.org>; Wed, 27 Jan 2016 04:14:19 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 27 Jan 2016 04:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=29cp3692AS7/tCuzHZ0NhDdgWP8=; b=JxdVNh
	/JoH5cBO3WIa6GtM98+Y+cABTvasrnYSK3Gu7mDELyFXaDJvW2T7jXIUODDLwYMU
	U5BPiWFrW5f91NeX+G0ihF+s7RbBPyWAH44jV4Qlzy2B9Tn31UnPUiW9HCRzZSdu
	B/iq5Wh1hetVleyLxyVnTeGfXRPwN1sJyNZ9Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=29cp3692AS7/tCu
	zHZ0NhDdgWP8=; b=r+qRV9WERAT9+v2NXOcwxROFKdIC1xPtoQnkmMSdznwxLBq
	vHDn4ayagX7PdEKNFVFZ2ONYx/824ByDnEsAh9zD3hfPcDT7wwfh4FawQmWRxZTz
	8Kfwuc8qXB0jZARlTYq3DXioOo217k4DHmK0wiAd6AS9gJE60sz7axBf9Deo=
X-Sasl-enc: Ara3zcPSzCvyO4zRJTlVDwzC33C0laY/sYL0sjNwmuP9 1453886059
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id C4D4CC01715;
	Wed, 27 Jan 2016 04:14:18 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <20160127080901.GA7651@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284899>

Jeff King venit, vidit, dixit 27.01.2016 09:09:
> On Wed, Jan 27, 2016 at 08:53:08AM +0100, Michael J Gruber wrote:
> 
>>> Yeah, definitely. My thinking was that `verify-tag` could learn a series
>>> of optional consistency checks, enabled by command line options, and
>>> verifying programs (or humans) could turn them on to avoid having to
>>> replicate them manually. So something like:
>>>
>>>   git verify-tag \
>>>     --verify-tagger-matches-key \
>>>     --verify-tag-matches-ref \ # or --verify-tag-matches=v2.0.0
>>>     v2.0.0
>>>
>>> or to implement more specific policy, maybe an option to check for a
>>> _specific_ tagger, either by email (as provided by gpg) or even key-id.
>>>
>>> Those are all things that are not _too_ hard to do if you're willing to
>>> parse gpg or git output, but we could make life easier for our callers.
>>> And hopefully by asking for specific, concrete checks, it doesn't
>>> introduce a false sense of security. I.e., we're not making a foolproof
>>> tool; we're making building blocks that one could use for a more
>>> foolproof tool.
>>
>> OK, let's make a tool that helps fooling as well as proofing :)
>>
>> I'll look into the tag header check. Maybe "--check-tagname"? "check"
>> seems to imply less than "verify".
> 
> Yeah, I think that is fine (I actually wrote --check originally; I'm not
> quite sure why I decided to change it).
> 
>> As for the gpg related stuff: We provide the full diagnostic output from
>> gpg on request. But I think a mismatch between the signing key's uid and
>> the taggers' name/email is more common than not,
> 
> Is it? I'd think if you are using that name with a signed tag, you would
> bother to issue (and get people to sign) the matching uid. Certainly it
> is the case for git and linux signatures, but I admit that it a pretty
> small sampling size.
> 
> The bigger issue is that gpg seems to give us only _one_ uid, when there
> may be several. E.g., Junio's v2.7.0 is signed by 96AFE6CB, which is a
> sub-key that has several uids associated with it. The one that "git
> verify-tag --raw" shows from gpg is gitster@pobox.com, which is good,
> but I think that's just because it happens to be the first uid. Or maybe
> there is some gpg arcana going on that I don't know about.

You do not sign with a uid, you sign with a (sub)key, and the tag is
signed with Junio's primary key. His subkey is encryption only.

uids do not identify keys, you can add and delete them at will without
changing the primary key id. To help recognize ("identify") a key, gpg
displays the uid with the most recent self-signature, which is usually
the most "recent uid".

You do sign a uid.

So, if you want to be sure that a tag is signed "with a specific uid" by
relying on signatures from a set of signers, you would really need to
check that the key that signed the tag has a signature on the correct
uid. Having a signed key with the right uid in it doesn't mean much
unlss the right uid is signed.

E.g., I have a key with many signatures, and I could have Junio's uid on
it in a minute without invalidating any of those signatures.

>> and on the other hand a
>> signature by a key identified by its uid is meaningless unless you keep
>> your keyring tidy... We could punt on that and let users identify the
>> key by any means that gpg allows, of course, and check that the
>> signature comes from whatever "gpg --list-key <userspecified>" gives as
>> long as it's unique.
> 
> Right, I think it's an open question whether people actually participate
> in the web of trust. I don't have a good signature path to Junio's key,
> but I happen to know what it is based on past interaction.
> 
> But then, I also do not really verify tags. Why would I? I routinely
> fetch and run "make" on the result, and there is no cryptographic
> protection there at all. Verifying tag signatures after a release seems
> all but pointless. :)

No signature protects us from our own dogfood :)

> I think for any of this to be useful, it has to be part of some tool
> that is very opinionated on policy. E.g., imagine a post-fetch hook that
> validated that each incoming commit was signed, and that the signer was
> part of a whitelisted group of keys that you "somehow" got hold of
> out-of-band for your project. That is not that useful for an open-source
> project, but I could see the appeal for a proprietary development
> environment.

That one is easy already by setting "GNUPGHOME" to a special dir with a
small keyring and tight trust settings (or having a dedicated account on
the incoming side in the first place).

Michael
