From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 13:10:21 +0530
Message-ID: <CAFZEwPOU_CNPMxTwuXf64rMrjApm7dfsjEr7i4xE=M3Ak9xdrw@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 09:40:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrQ2-0006yd-R4
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 09:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbcEDHkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 03:40:23 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:32920 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcEDHkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 03:40:22 -0400
Received: by mail-yw0-f170.google.com with SMTP id t10so71792309ywa.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gXv9530/x8+oyTWfd4scyT9IwdueEKpQxGZyJtruEWM=;
        b=FL1o2VHDJGy/n2RrLNseW9SSP04TTvf+K5cTnkasnUurlymWxFDR1jR7z066NiuI+3
         UQYB9jEJuEvviYmtjAVo183nTcFGoIYYFa0t3PNXM0r4CkytDrGSes2qMqi6UhpCNnNg
         IGhn1Hh8afqk5qedw+JSUrdIbHGCUiGx8Do9+QMgdTze2Ftz1BH5S/2jovGtnw6iDd+E
         zMMpNRb95U91Dxsq3SkLEYpUtiLDmXU/1JGduydxDF1982XA9Rxfc6u4sPHomyJNfw5n
         O//MOtPkFf/OE3UhEIf8dLAZExm1RBiDIeGMc5a645aWMWy06bO+SZenYXwBxXa3TdJl
         HiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gXv9530/x8+oyTWfd4scyT9IwdueEKpQxGZyJtruEWM=;
        b=YoNDVDmz+fTM/ipHkssHMYBn49KmlOyulSXQ+4wfuIlNJCT1KywnO2f/j9db2L6xJe
         zMc1Q2lVcLzCGhV4fOaFPUKeufrOqn1GS8LIqV4cK4kOX+f2SnRNv+IEhPZsvjgJsrKq
         HqYMwTnhzR3YJ6Np/B5fX79pfJcsKfXxfLEzi13CqJBL0yY9fVc0UaP9meMsABtdSyx6
         5ADoFC1c4jOCaTAVgfsp+ja6SqFkgu+tQvKMNH7tsQrtVAExKq9Tlc3TbdDANFnZ7Qg5
         w6joODLupo2MDww3mJy03/hn28PRpo+gZ9XOWtCq50XwLvZxGtu2bx8s3xvdo0fCv3xB
         q+vw==
X-Gm-Message-State: AOPr4FVh4TMTysBJZPyhuj6r5LK3x00RsGW+UwqGwmdzuVjFWYKhPIsQClrBTSjuXh/1QHuIzxT2Zlo0We0o9A==
X-Received: by 10.37.216.133 with SMTP id p127mr4004527ybg.154.1462347621458;
 Wed, 04 May 2016 00:40:21 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 4 May 2016 00:40:21 -0700 (PDT)
In-Reply-To: <CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293507>

On Wed, May 4, 2016 at 1:06 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:

>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/293489
>
> [2]: http://article.gmane.org/gmane.comp.version-control.git/293489
>
> [3]: http://article.gmane.org/gmane.comp.version-control.git/293489

These are incorrect links.

The correct ones are:
[1]: http://article.gmane.org/gmane.comp.version-control.git/289477

[2]: http://article.gmane.org/gmane.comp.version-control.git/289487

[3]: http://article.gmane.org/gmane.comp.version-control.git/289511
