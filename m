From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 16:47:19 -0800
Message-ID: <20160120004719.GC16090@google.com>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
 <20160119213705.GA28656@sigill.intra.peff.net>
 <xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
 <20160119215100.GB28656@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:48:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLgwZ-0006VU-7A
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 01:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766AbcATArb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 19:47:31 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33355 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933506AbcATArW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 19:47:22 -0500
Received: by mail-pf0-f194.google.com with SMTP id e65so13916306pfe.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 16:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LGo/xTLIw/f3OkgjHdMcQHIxTmGL4mxe35hJIVryMd4=;
        b=STODFRBGh4oKfqAGxheLcAv1WefLB6GZfORNhVGJoiKJ5dZsKgPPRZqr9SbofYKH1B
         3N5UGb9FRDG+93wONKh6JjPh2An2APcSvvI6s000/it8CAEuFfPsm0iTUG/UwodH8Zoj
         LnFLsgD3Nwln0j19WLUnl1KLkLnw5u0mwPROTEDM/9QD/S7uHHThHcHoEm/An5wicIjb
         D5dqHaj1bw1LrG+70w73VvpJjg0MlkWZ4fe48+H1s902dfCeZptEOvj0Q2g7XgVw/wlF
         aaOIUbI9s86zA3x7Tpnq4DIwU5jPiCb9GuO3KNFGOV2JidZ7uWRZeQJGPACO8KGgjZjR
         NlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LGo/xTLIw/f3OkgjHdMcQHIxTmGL4mxe35hJIVryMd4=;
        b=eozySdrCexkuv7JeaQI5t2dSkccahwdnOknqJYy/ntr2I9b/4pI9ONECEOjPcjHbJi
         ytoQys01oy8Y9/j7CLRABOLoPpqmiQC8ERhd3gEsSccxR6PiJpmo2fKfR2jVeQvkF0un
         37XaX0W71U6jQsVyIOv/R5SXjhVGcsQXGL1jXDOkd5xGL5h4aJ7w3c5ZsU0IDOH3ibu5
         vFEOtO3wmKHTm7u/4msrAW1WymjiczBtDhlRAWB4ILxXWIRKXIyRORZNncUCkWe03ZKg
         if0CCi/rJS/4a4vu9qqt0fkC09TiHsEiRZgHwwJaAHCTZPNNs0lluSYieEcd/tKwjlCt
         kUeg==
X-Gm-Message-State: ALoCoQka4cE5QTWSIRKB5NUGBpJXJgjDGHbchRW+Sjytx5xUHBE8wQBejE/N51br3GbAyLGBmoa1XGbQ8p8FF2M+V7TVhj4fRA==
X-Received: by 10.98.65.203 with SMTP id g72mr48941964pfd.44.1453250841714;
        Tue, 19 Jan 2016 16:47:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b491:2661:5545:c04e])
        by smtp.gmail.com with ESMTPSA id z5sm44454488pas.29.2016.01.19.16.47.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jan 2016 16:47:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160119215100.GB28656@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284404>

Jeff King wrote:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-filter-branch.sh     | 2 +-
>  t/t7003-filter-branch.sh | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
