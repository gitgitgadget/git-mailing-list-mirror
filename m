From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Wed, 6 Nov 2013 15:47:13 -0800
Message-ID: <CAJo=hJvX5wDcr0OxaQEjRtm1-mVNbAMLcLQxgEJWT=J8NPwEKg@mail.gmail.com>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
 <xmqqbo1x8e60.fsf@gitster.dls.corp.google.com> <1383774082.2850.10.camel@centaur.cmartin.tk>
 <xmqqvc056uc1.fsf@gitster.dls.corp.google.com> <20131106225414.GA15920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 07 00:47:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeCp1-0008J8-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 00:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab3KFXrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 18:47:35 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:59479 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab3KFXre (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 18:47:34 -0500
Received: by mail-wg0-f42.google.com with SMTP id n12so4931581wgh.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 15:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L34waA82TzzkwVTMU0UqaLJn9zPZ+/nBY8UWyJKSQaE=;
        b=IInWVTNrxoeGoA3ozSp3Zk+CnyglFZjOQG2uH+SVciV6I4bJTBC+yvanH4Sluz/Y+z
         9AiozI51B43fNBRkahoEk5om38jXCVLHE2WQX99/02z5CbDNWbiLTXw9OrEieWZ52ayi
         7xivQ/VdTt/PJod+uIRzR+XGnVEHCnhiwnGpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=L34waA82TzzkwVTMU0UqaLJn9zPZ+/nBY8UWyJKSQaE=;
        b=ZMoxqToVPdyma2NM5t57HItmN7KNg41YBgrnNNN4y1EzlB4/GHMODq3NJTKWOGLLyt
         LzZDBcwpYSQnPTOBeZrF2tBvzUw8fB3FwanCrU380SCFURV1qIFm/LF0jm6kmz8/K+rb
         vix5MySA89KvKph87NoeAEwk1o29YlsxRNnjYZc8UWIucTH0pYRLb9V6Hsui9P7PtxW/
         7MMIysUnmJ0u0/3HumjwKI5I0dHPIIGn/VZjKdy+vCRRm1C7sEbdPfnscpXedjy/brjm
         7G57CVSeZdfjfQA/ixZcPLd0M8sefssfGqJAq82LvveGJGbYcE74xVLPT43OJ6q+R2s/
         JTrQ==
X-Gm-Message-State: ALoCoQka/owZhSM9wYfttGIxE7flLTEHF3UnrkC2ONj46+d+++oQcwnX854eyMFm8skKsVmrJO00
X-Received: by 10.194.6.161 with SMTP id c1mr86086wja.89.1383781653644; Wed,
 06 Nov 2013 15:47:33 -0800 (PST)
Received: by 10.227.62.140 with HTTP; Wed, 6 Nov 2013 15:47:13 -0800 (PST)
In-Reply-To: <20131106225414.GA15920@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237385>

On Wed, Nov 6, 2013 at 2:54 PM, Jeff King <peff@peff.net> wrote:
> If we instead introduced "no-thin", it is more like:
>
>   1. Receive-pack starts advertising "no-thin" (as dictated by
>      circumstances, as Carlos describes).
>
>   2. Send-pack which does not understand no-thin will ignore it and send
>      a thin pack. This is the same as now, and the same as step 2 above.
>
>   3. An upgraded send-pack will understand no-thin and do as the server
>      asks.
>
> So an upgraded client and server can start cooperating immediately, and
> we do not have to wait for the long assumption time to pass before
> applying the second half.
>
> It is tempting to think about a "thin" flag because that would be the
> natural way to have implemented it from the very beginning. But it is
> not the beginning, and the negative flag is the only way at this point
> to say "if you understand this, please behave differently than we used
> to" (because the status quo is "send a thin pack, whether I said it was
> OK or not").

I think the only sane option at this point is a "no-thin" flag, or
just require servers that want to be wire compatible to accept thin
packs.
