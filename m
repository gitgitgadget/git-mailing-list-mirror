From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 21:09:31 +0100
Message-ID: <56A923FB.4050308@drmicha.warpmail.net>
References: <20160125212208.GB26169@LykOS>
 <56A73DE6.5050201@drmicha.warpmail.net> <20160126152941.GA31951@LykOS>
 <20160126202651.GA1090@sigill.intra.peff.net>
 <56A87056.2010309@drmicha.warpmail.net>
 <20160127073357.GA7066@sigill.intra.peff.net>
 <56A87764.9070101@drmicha.warpmail.net>
 <20160127080901.GA7651@sigill.intra.peff.net>
 <56A88A69.6030503@drmicha.warpmail.net>
 <xmqqmvrq99mt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Santiago Torres <santiago@nyu.edu>,
	Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:09:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOWPP-0001z8-UV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 21:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967467AbcA0UJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 15:09:39 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55655 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965741AbcA0UJe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2016 15:09:34 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 9E5F821923
	for <git@vger.kernel.org>; Wed, 27 Jan 2016 15:09:33 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 27 Jan 2016 15:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=bJ6es9H6c+QBw2cs9yKoUfky/9U=; b=IoIjF1
	wKYR0wo5Q3OSGplTdB5JzSMNHFzNphk75DCEux/G/IXrTfVozwmT/tesw+8OwHxI
	1Cv9fnlLI4mBpblwXgKXJeEYIcuYZAxNGWcFB1c21Hmpbuy8pAQv+P9LUuuIkej2
	qwh+vSItXzRNMttjmNVHZO47SZpOfYuwW+mmo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=bJ6es9H6c+QBw2c
	s9yKoUfky/9U=; b=AoyKr3VAMO+TZPF6gLTfwZiYSHMQ8CVSpPd+3gw0JOxgrYb
	np/lnAvBFjCgUd6cDhPnYMdKtCqQIvxaOaGdxuOAZrMq9ghUFptvEKI9DhcmvFNc
	Hbz8y27sTnBp5Cb7D3mHYvrhC92wbaU/usFMB0x/vv+POo3o/mkHZa/EBiMM=
X-Sasl-enc: IxV5T1JUHY3ChhvRtnnoNXNRBR34e4AramUHTaI0J8BO 1453925373
Received: from UltraSam.fritz.box (dslc-082-083-023-202.pools.arcor-ip.net [82.83.23.202])
	by mail.messagingengine.com (Postfix) with ESMTPA id B870468014A;
	Wed, 27 Jan 2016 15:09:32 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqmvrq99mt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 27.01.2016 19:10:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Jeff King venit, vidit, dixit 27.01.2016 09:09:
>>
>>> The bigger issue is that gpg seems to give us only _one_ uid, when there
>>> may be several. E.g., Junio's v2.7.0 is signed by 96AFE6CB, which is a
>>> sub-key that has several uids associated with it. The one that "git
>>> verify-tag --raw" shows from gpg is gitster@pobox.com, which is good,
>>> but I think that's just because it happens to be the first uid. Or maybe
>>> there is some gpg arcana going on that I don't know about.
>>
>> You do not sign with a uid, you sign with a (sub)key, and the tag is
>> signed with Junio's primary key. His subkey is encryption only.
> 
> Hmm, actually I meant to sign my tags with signing subkey, not the
> primary one, but I may have made a mistake.

Oops, I needed to refresh my copy of your key, sorry. You did sign 2.7.0
with the subkey 0xB0B5E88696AFE6CB

>> You do sign a uid.
>>
>> So, if you want to be sure that a tag is signed "with a specific uid" by
>> relying on signatures from a set of signers, you would really need to
>> check that the key that signed the tag has a signature on the correct
>> uid. Having a signed key with the right uid in it doesn't mean much
>> unlss the right uid is signed.
>>
>> E.g., I have a key with many signatures, and I could have Junio's uid on
>> it in a minute without invalidating any of those signatures.
> 
> I have signatures on my primary key from others, and my signing key
> is signed by my primary key and by no other keys.  Here is an
> abbreviated output from running "gpg --list-sigs 96AFE6CB":
> 
> pub   4096R/713660A7 2011-10-01
> uid                  Junio C Hamano <gitster@pobox.com>
> sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sig          F3119B9A 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sig          493BACE4 2011-10-04  H. Peter Anvin (hpa) <hpa@zytor.com>
> sig          93674C40 2011-10-04  Theodore Y. Ts'o <tytso@mit.edu>
> sig          00411886 2012-07-20  Linus Torvalds <torvalds@linux-foundation.org>
> sig          C11804F0 2011-10-04  Theodore Ts'o <tytso@mit.edu>
> sig          02A80207 2011-10-05  Andrew Morton (akpm) <akpm@linux-foundation.org>
> uid                  Junio C Hamano <junio@pobox.com>
> sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sig          F3119B9A 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sig          493BACE4 2011-10-04  H. Peter Anvin (hpa) <hpa@zytor.com>
> sig          00411886 2012-07-20  Linus Torvalds <torvalds@linux-foundation.org>
> sig          C11804F0 2011-10-04  Theodore Ts'o <tytso@mit.edu>
> uid                  Junio C Hamano <jch@google.com>
> sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sig          F3119B9A 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sig          493BACE4 2011-10-04  H. Peter Anvin (hpa) <hpa@zytor.com>
> sig          00411886 2012-07-20  Linus Torvalds <torvalds@linux-foundation.org>
> sub   4096R/833262C4 2011-10-01
> sig          713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
> sub   4096R/96AFE6CB 2011-10-03 [expires: 2017-09-20]
> sig          713660A7 2015-09-21  Junio C Hamano <gitster@pobox.com>
> sub   4096R/B3F7CAC9 2014-09-20 [expires: 2017-09-19]
> sig          713660A7 2014-09-20  Junio C Hamano <gitster@pobox.com>
> 
> So I understand that the way you trust 96AFE6CB has to be indirect.
> You may have somebody's key you know belongs to that somebody you
> trust (say, Linus) in the list of signers of 713660A7 (my primary),
> and you know 96AFE6CB is a key I use because it is signed by my
> primary key.
> 
> You can add a subkey to your keyring a uid that says "Junio", but
> the signature on that subkey would not have a signature by me you
> can verify by following the web of trust.  You are correct to point
> out that "this key claims to be by somebody, and it has some
> signature" is not a sufficient reason for you to trust it.

"subkey" and "uid" are different things. You bind a subkey to your
primary key with that self-signature. subkeys don't carry any other
signatures.

A primary key "carries" the uids, and whenever someone "signs your key"
they in fact sign a specific uid - usually all, resulting in multiple
signatures, one for each uid of the (primary) key.

A key is usually considered trusted if it carries "a" signature from a
trusted key.

So, assuming my key carries a signature from a trusted key to at least
one uid, it would be trusted no matter what (fake) uids I add to it later.

>> That one is easy already by setting "GNUPGHOME" to a special dir with a
>> small keyring and tight trust settings (or having a dedicated account on
>> the incoming side in the first place).
> 
> Yes, I understand that the above is how automated services per
> project should be set up, with a dedicated verification keyring that
> holds keys the project trusts.

Michael
