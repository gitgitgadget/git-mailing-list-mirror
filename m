From: David Aguilar <davvid@gmail.com>
Subject: Re: Combining APPLE_COMMON_CRYPTO=1 and NO_OPENSSL=1 produces
 unexpected result
Date: Sat, 2 Jan 2016 15:49:23 -0800
Message-ID: <20160102234923.GA14424@gmail.com>
References: <CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com>
 <CAPig+cS2+NP=-XEYA6e=doQu=+Qn-Lzut-7OCeYJRFZFchNepg@mail.gmail.com>
 <xmqqy4cf9ugm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jack Nagel <jacknagel@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 00:49:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aFVvT-0001hh-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jan 2016 00:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbcABXtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2016 18:49:32 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36411 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbcABXta (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2016 18:49:30 -0500
Received: by mail-oi0-f51.google.com with SMTP id o62so233296160oif.3
        for <git@vger.kernel.org>; Sat, 02 Jan 2016 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vtHFaZ4BnNucwpRuBri6O1DxdVNYRT23gLWn5STArek=;
        b=wadZ41bVpkx3774DWbvXmQamgJBEtfaO/biTi485d3uDxi+7PzYJhdpVM6rpsK4wfd
         j0WfN4RImqmT0ycpyq88/slB99uIILDej43p3xGXLm88bkg2pCdu9yxrzCKz87BK0oLz
         HCCqwg/WRDCse8xOkDi1gzPyjPlnTwihYvkK89uKK8HTxSbk8nJq6wVqA8+7v1LLxDGF
         fD9qBn1d2Qoa5+HNDQrbIh8b4Q765iVt+UDg/8RXykW06xxg6hdHm1RJZZePkLffa7vd
         GUZuPuOii7iyMzBhothteZuLbbkxFR3c6VzamimUTAdS1uRjOPvRx3FZ9+8sbpuxHL3g
         9nYA==
X-Received: by 10.202.72.137 with SMTP id v131mr53366801oia.90.1451778569614;
        Sat, 02 Jan 2016 15:49:29 -0800 (PST)
Received: from gmail.com ([32.150.217.149])
        by smtp.gmail.com with ESMTPSA id k6sm30866967oia.18.2016.01.02.15.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jan 2016 15:49:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqy4cf9ugm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283270>

On Sun, Dec 27, 2015 at 06:29:29PM -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > So, it might be easier to think of NO_OPENSSL as really meaning NO_SSL
> > (that is, "disable all SSL-related functionality"). Since the only SSL
> > implementation Git knows how to use is OpenSSL, perhaps one can
> > consider the name NO_OPENSSL a historic anomaly.
> 
> That is a good explanation of what is observed.  I am not sure if it
> is a good justification, though.  If you tell somebody who needs to
> link an implementation of SHA-1 in that you (1) do not want to use
> OpenSSL (or do not want to have SSL at all), and (2) do not mind
> using Apple's CommonCrypto, and if you _know_ that CommonCrypto is
> a possible source of the SHA-1 implementation, then I would think it
> is reasonable to expect that CommonCrypto SHA-1 to be used.
> 
> 	Note. To further explain the situation, the only reason we
> 	added CommonCrypto knob in the build system was to allow
> 	people to use OpenSSL as the SSL implementation.  Those who
> 	added the knob weren't making a conscious decision on which
> 	SHA-1 implementation to use in that scenario---they may not
> 	even have been aware of the fact that SHA-1 was offered by
> 	CommonCrypto for that matter.

My original motivation for going down the CommonCrypto route was,
"bummer, git is not compiling.. let me try to fix that, somehow".

I think the best long-term solution would be to abandon the
CommonCrypto backend, if possible.  There's not a strong reason
for its existence.  It always seemed kinda hacky, and bolted-on.

> A few questions we should be asking Apple users are:
> 
>  - Is there a strong-enough reason why those who do not want to use
>    SSL should be able to choose the SHA-1 implementation available
>    from CommonCrypto over block-sha1?

IMO, no.

>  - Is CommonCrypto SHA-1 a better implementation than block-sha1?

I do not believe this to be true.

My gut feeling is that we cannot rely on the long-term stability
and availability of Apple's APIs.  Block-sha1 works fine on
the current Apple hardware and I suspect that it (or openssl)
will continue to work fine in the future.

> Depending on the answers to these questions, we might want to:
> 
>  - add a knob to allow choosing between two available
>    implementations (i.e. when NO_APPLE_COMMON_CRYPTO is unset) of
>    SHA-1, regardless of the setting of NO_OPENSSL.
> 
>  - decide which one between CommonCrypto and block-sha1 should be
>    the default.

How about, drop support for CommonCrypto so that there's no need
for the end-user to choose?  That means we would get block-sha1
by default.

> If we end up deciding that we use block-sha1 as the default, we
> should do so even when both NO_OPENSSL and NO_APPLE_COMMON_CRYPTO
> are left unset.  If we decide that block-sha1 should merely be a
> fallback when no other SHA-1 implementation is availble, on the
> other hand, we should be using CommonCrypto SHA-1 as long as the
> user did not set NO_APPLE_COMMON_CRYPTO explicitly, even when we are
> building with NO_OPENSSL.
> 
> If people do not care, we can leave things as they are.  It would
> seem mysterious to use block-sha1 when we are not using CommonCrypto
> for SSL (i.e. NO_OPENSSL), and otherwise CommonCrypto SHA-1, and
> would invite a puzzlement we saw in this thread, though.

I'm curious to see what others think about dropping CommonCrypto.
It seems like a good choice from a maintenance POV.
-- 
David
