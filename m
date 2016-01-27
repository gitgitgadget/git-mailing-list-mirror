From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Wed, 27 Jan 2016 10:10:02 -0800
Message-ID: <xmqqmvrq99mt.fsf@gitster.mtv.corp.google.com>
References: <20160125212208.GB26169@LykOS>
	<56A73DE6.5050201@drmicha.warpmail.net> <20160126152941.GA31951@LykOS>
	<20160126202651.GA1090@sigill.intra.peff.net>
	<56A87056.2010309@drmicha.warpmail.net>
	<20160127073357.GA7066@sigill.intra.peff.net>
	<56A87764.9070101@drmicha.warpmail.net>
	<20160127080901.GA7651@sigill.intra.peff.net>
	<56A88A69.6030503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Santiago Torres <santiago@nyu.edu>,
	Git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:10:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOUXj-0002b9-DL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 19:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934135AbcA0SKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 13:10:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933910AbcA0SKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 13:10:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F1403D07E;
	Wed, 27 Jan 2016 13:10:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MMtoPsm1ZpEg21Fz4jTfFC+YOLs=; b=lgOERH
	gx00xKCNfniG8jzs8DqDOPsgtP5XpHn0y9ZZAG2ylVJ9oAM42HB4ntonYePpp5li
	wlsjiIrYbtZcdWkNY+zwKeuEe1GxqDcHIFyObJZA0PbayQ/NqsTR0iewKnyTnymw
	HEKjcGllm6xTpoOuit01/SApDg2WpfrTrawtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WN9OtXsoeEzkttXUXZhrYEURamoLsPWT
	nxqwOAh/C/CHrMKGTKyeMeieHCrulk5P+HL0L6ZIOsFPyrnhKkTe6upYaArcbN2C
	Z45Ouy0jpz3VTv00Cf/TVzYeL+Zbz9q/ihBuSkJeIZSvaz3H3LK/dIIE9A3x2c+m
	TjoYbeoBDfY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 658523D07D;
	Wed, 27 Jan 2016 13:10:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D186E3D07C;
	Wed, 27 Jan 2016 13:10:03 -0500 (EST)
In-Reply-To: <56A88A69.6030503@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 27 Jan 2016 10:14:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 303FD7EA-C521-11E5-8815-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284945>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff King venit, vidit, dixit 27.01.2016 09:09:
>
>> The bigger issue is that gpg seems to give us only _one_ uid, when there
>> may be several. E.g., Junio's v2.7.0 is signed by 96AFE6CB, which is a
>> sub-key that has several uids associated with it. The one that "git
>> verify-tag --raw" shows from gpg is gitster@pobox.com, which is good,
>> but I think that's just because it happens to be the first uid. Or maybe
>> there is some gpg arcana going on that I don't know about.
>
> You do not sign with a uid, you sign with a (sub)key, and the tag is
> signed with Junio's primary key. His subkey is encryption only.

Hmm, actually I meant to sign my tags with signing subkey, not the
primary one, but I may have made a mistake.

> You do sign a uid.
>
> So, if you want to be sure that a tag is signed "with a specific uid" by
> relying on signatures from a set of signers, you would really need to
> check that the key that signed the tag has a signature on the correct
> uid. Having a signed key with the right uid in it doesn't mean much
> unlss the right uid is signed.
>
> E.g., I have a key with many signatures, and I could have Junio's uid on
> it in a minute without invalidating any of those signatures.

I have signatures on my primary key from others, and my signing key
is signed by my primary key and by no other keys.  Here is an
abbreviated output from running "gpg --list-sigs 96AFE6CB":

pub   4096R/713660A7 2011-10-01
uid                  Junio C Hamano <gitster@pobox.com>
sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
sig          F3119B9A 2011-10-01  Junio C Hamano <gitster@pobox.com>
sig          493BACE4 2011-10-04  H. Peter Anvin (hpa) <hpa@zytor.com>
sig          93674C40 2011-10-04  Theodore Y. Ts'o <tytso@mit.edu>
sig          00411886 2012-07-20  Linus Torvalds <torvalds@linux-foundation.org>
sig          C11804F0 2011-10-04  Theodore Ts'o <tytso@mit.edu>
sig          02A80207 2011-10-05  Andrew Morton (akpm) <akpm@linux-foundation.org>
uid                  Junio C Hamano <junio@pobox.com>
sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
sig          F3119B9A 2011-10-01  Junio C Hamano <gitster@pobox.com>
sig          493BACE4 2011-10-04  H. Peter Anvin (hpa) <hpa@zytor.com>
sig          00411886 2012-07-20  Linus Torvalds <torvalds@linux-foundation.org>
sig          C11804F0 2011-10-04  Theodore Ts'o <tytso@mit.edu>
uid                  Junio C Hamano <jch@google.com>
sig 3        713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
sig          F3119B9A 2011-10-01  Junio C Hamano <gitster@pobox.com>
sig          493BACE4 2011-10-04  H. Peter Anvin (hpa) <hpa@zytor.com>
sig          00411886 2012-07-20  Linus Torvalds <torvalds@linux-foundation.org>
sub   4096R/833262C4 2011-10-01
sig          713660A7 2011-10-01  Junio C Hamano <gitster@pobox.com>
sub   4096R/96AFE6CB 2011-10-03 [expires: 2017-09-20]
sig          713660A7 2015-09-21  Junio C Hamano <gitster@pobox.com>
sub   4096R/B3F7CAC9 2014-09-20 [expires: 2017-09-19]
sig          713660A7 2014-09-20  Junio C Hamano <gitster@pobox.com>

So I understand that the way you trust 96AFE6CB has to be indirect.
You may have somebody's key you know belongs to that somebody you
trust (say, Linus) in the list of signers of 713660A7 (my primary),
and you know 96AFE6CB is a key I use because it is signed by my
primary key.

You can add a subkey to your keyring a uid that says "Junio", but
the signature on that subkey would not have a signature by me you
can verify by following the web of trust.  You are correct to point
out that "this key claims to be by somebody, and it has some
signature" is not a sufficient reason for you to trust it.

> That one is easy already by setting "GNUPGHOME" to a special dir with a
> small keyring and tight trust settings (or having a dedicated account on
> the incoming side in the first place).

Yes, I understand that the above is how automated services per
project should be set up, with a dedicated verification keyring that
holds keys the project trusts.
