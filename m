From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 23:47:30 +0100
Message-ID: <1660121.8PEbpzfRYH@al>
References: <6997784.RuzRO1AFsK@al> <27811375.1kgEM3BV3q@al> <20141124222243.GA9055@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:47:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2Q2-0002OK-NX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbaKXWrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 17:47:39 -0500
Received: from lekensteyn.nl ([178.21.112.251]:38793 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbaKXWri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=TSB2Q6orUkPlYZA1YAIcNU/Ib/LY5/UaUDGZ9OL4/I0=;
	b=aDKHgb3sidDBK/LBTnYEAok5ihVqh6w4NARuwno41/xh5rAzBYGZesc86EJw926Jp8XgQgOWD9+Qyvec4qd0LFnAavMTlXreSDQ8mApmjfFV1GU4CULchEvxVQZz4ud8HgnA2ZpAedPSvkSqBIcFI/9+gAm96QHrrpThwqB520X467sj5ZkMUk7Bt2vH62guSTBtGSxBJLFg4n8cK3PfsUTZVGSnTkMOST2U5/KG6HY8gkElTTzDBZddS0DknEaaQrbID8Ih4Ad68AONIBcu4aNCSS4F8+LYdMzhsmhFkJ+5Fq7TJ5u5mEtp/JikHbiXI5dsOA1vin00Jiz2hwEPCA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1Xt2Pr-0006IZ-30; Mon, 24 Nov 2014 23:47:31 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <20141124222243.GA9055@peff.net>
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260161>

On Monday 24 November 2014 17:22:44 Jeff King wrote:
> On Mon, Nov 24, 2014 at 11:16:03PM +0100, Peter Wu wrote:
> 
> > > A new option "--fetch" introducing a different behaviour is
> > > perfectly fine; existing users who are not using it will not be
> > > harmed by sudden behaviour change.
> > 
> > As stated before, I took care to avoid backwards incompatibilities. The
> > command will still work as expected by the users who are aware of this
> > particular behavior.
> 
> Right. My original complaint was only that "--fetch" is not as
> orthogonal to "--push" (and an optionless set-url) as it could be. I
> think the alternatives for going forward are basically:
> 
>   1. Name it something besides --fetch (but that's rather clunky).

It is not orthogonal to --push in the config, but the behavior exposed
to the user is orthogonal unless I am missing something?

I can understand that --fetch sounds a bit weird, what about this
natural translation:

    "git remote: set the URL (only the fetch one) for NAME to URL"
    git remote set-url --only=fetch NAME URL

    "git remote: set the URL (only the push one) for NAME to URL"
    git remote set-url --only=push NAME URL
    (obsoletes --push)

    "git remote: set the URL (both) for NAME to URL"
    git remote set-url --only=both NAME URL
    (it would be nice if --only=both (weird!) can be removed in the
    future such that the option is more natural)

    "git remote: set the URL for NAME to URL"
    git remote set-url NAME URL
    (current behavior: YOU git guru knows what I do right?)


>   2. Migrate to new behavior, which is what is being discussed here.
>      Probably needs a transition period?

A transition period would also help to solicit feedback.

>   3. Live with it. Probably address the weirdness in the documentation.
> 
>   4. Do nothing, drop the patch.
> 
> I think I'd be OK with (3), with an appropriate documentation update.

I prefer 1 for now as it avoids the extra manual action I have to take
when changing URLs.

Peter
