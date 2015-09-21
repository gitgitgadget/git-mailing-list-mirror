From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Mon, 21 Sep 2015 10:09:52 -0700
Message-ID: <xmqqh9mnbswv.fsf@gitster.mtv.corp.google.com>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
	<xmqqfv2cj03t.fsf@gitster.mtv.corp.google.com>
	<20150917212016.GF606@cruxbox>
	<xmqq7fnoitra.fsf@gitster.mtv.corp.google.com>
	<20150918071525.GA482@cruxbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:09:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4bG-0005JU-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbbIURJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:09:55 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36112 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504AbbIURJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:09:54 -0400
Received: by padbj2 with SMTP id bj2so12028148pad.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Tti0dix0fKRf70/y41s+evykbQBAET+9+h/OOet0/FE=;
        b=VKe3sW6hBBsjlmMBSG6c3aUs6jJuZ6dQb9PO2AaLvImtoWkTkodAjpaLggX1jMZc06
         LQ5FglrdBiIw7wtY3Cy9u2utQ38atunQ8j70LnwBv3HGiSnoCBhpORNLQXGzsWedhUad
         8eoiuw8GmTy5KpALpOKzF4frAkCclxTT2twWTiWTG/Ba2q04Uvj0esIU2NvH9GOMi2gg
         v6v50aoD7HN3+Uyf19eHL30Yi68sCGYBiLsVreM/AuBQKSV6RO0OtxeCeajHFYrOHXMq
         BQaCUqKX55qJnxR6g1gjoyVa/kjuGtkOc+eOWE0hGApRSrn5d5zQZgMYK4RSB6StgyjI
         U5aw==
X-Received: by 10.68.104.227 with SMTP id gh3mr26270275pbb.108.1442855393592;
        Mon, 21 Sep 2015 10:09:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id dk2sm25512847pbd.57.2015.09.21.10.09.52
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 10:09:52 -0700 (PDT)
In-Reply-To: <20150918071525.GA482@cruxbox> (Remi Pommarel's message of "Fri,
	18 Sep 2015 09:17:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278312>

Remi Pommarel <repk@triplefau.lt> writes:

> On Thu, Sep 17, 2015 at 03:08:25PM -0700, Junio C Hamano wrote:
>> That is, for most people, linking with -lcrypto was sufficient, but
>> some people needed to grab things from -lssl when they need to do
>> so, because things in -lcrypto referred to what was only in -lssl.
>
> Oh I see what you mean, I misinterpreted what NEEDS_SSL_WITH_CRYPTO
> does.
>
> The problem on static compiled target is that libcurl.a got linked with
> libssl symbols. 

I think I said this already, but I found these bits from your patch

-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)

that first uses libcurl and then libs (which has ssl bits) totally
sensible.  Shouldn't that be sufficient?

> The proper variable I should have used is
> NEEDS_SSL_WITH_CURL. But this variable is not setted on Linux and not
> configurable,...

Really?  Anything is configurable from your config.mak, I would have
thought.
