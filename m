From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Mon, 30 Jun 2014 12:52:29 +0200
Message-ID: <CAP8UFD3w2s8tQ0OVe2eb9AmdsZhDeVJqNBUXewcbBxqs=id+HA@mail.gmail.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
	<CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
	<CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
	<CAPc5daWBycdmKBZXGhhy4_649p_JFfGf7RQbqa08XA1hL9mFTg@mail.gmail.com>
	<CAP8UFD25k4X0vVUDDTOj_XDqmShz-aHXFLKD5bruUYYLX6awow@mail.gmail.com>
	<xmqqr426zyw6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 12:52:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1ZCM-0006rL-IT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 12:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbaF3Kwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 06:52:30 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:53018 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbaF3Kwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 06:52:30 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so8086831veb.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zP71k+OONuZFFVML51ImaOwiszvr9a4OSXGHYYFpufU=;
        b=udyejIP5zdYm5wODt8+6p+i2ePyLw3pOIWW//Ibl0Z95hPgtXLoNsH54souIM1eJU3
         4kUnql5Xzu0qlM1sBfAvUwttgVhQJVuhQsa3E7Xr/F+8n+jzc5rmK37kxWfhaBGoquqP
         3QnM0geshUa7RUPQmP2tB1r1qdMecM2129xz7Eb1iAo2KwjOSrKNOVzQ5STHkZ+gid3W
         vEeT31RZJeIt6W/0bphxpjs0xyg+Ij40e3oydtts6du3UXZE84G2Rj6B1KhrMQ/3tmVl
         v236XKjbFhNWvcxrxgt6yWaHqfELcbWjaLv7SIeq+ln5enkNtLE2EV26GX/K1wTuMRGF
         HIsg==
X-Received: by 10.53.1.231 with SMTP id bj7mr107965vdd.49.1404125549365; Mon,
 30 Jun 2014 03:52:29 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Mon, 30 Jun 2014 03:52:29 -0700 (PDT)
In-Reply-To: <xmqqr426zyw6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252662>

On Mon, Jun 30, 2014 at 8:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Now, after having read the recent thread about "git verify-commit", I understand
>> that you also want me to drop the signature of a tag that was merged, because
>> such signatures are added to the commit message.
>
> Huh?  I am not sure if I follow.  Perhaps we are talking about
> different things?

I think we are talking about the same thing but I might not have been clear.

> When you are preparing a replacement for an existing commit that
> merges a signed tag, there are two cases:
>
>  - The replacement commit still merges the same signed tag; or
>
>  - The replacement commit does not merge that signed tag (it may
>    become a single-parent commit, or it may stay to be a merge but
>    merges a different commit on the side branch).
>
> In the former, it would be sensible to keep the "mergetag" and
> propagate it to the replacement; it is a signature over the tip of
> the side branch being merged by the original (and the replacement)
> merge, and the replacement will not affect the validity of the
> signature at all.

Ok, this is what is done right now by the patch series.

> In the latter, we do want to drop the "mergetag"
> for the parent you are losing in the replacement, because by
> definition it will be irrelevant.

Yeah, it might be a good idea to drop the "mergetag", but note that
anyway such a commit probably has a title like "Merge tag '<tag>'" and
we won't automatically change this title and this title will be wrong
(because we are not merging anymore this tag).

So anyway in this case, --graft will do something that is not good. So
it might be better in this case to just error out and say that it
would be better to use --edit instead of --graft.
