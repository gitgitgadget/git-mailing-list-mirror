Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F9F1F855
	for <e@80x24.org>; Wed, 27 Jul 2016 21:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbcG0Vxn (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 17:53:43 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35124 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbcG0Vx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 17:53:29 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so4746796ywg.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 14:53:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qsvStGjZ7kTNlBuvu+xdYtuQoWdQc6Isdv1jT0yO4Zg=;
        b=pTLF1Tf0mpmS8qZqBauFeACWL7S5FjWOf0eNG91+53HB7P4zfEupZ/dAzJBdj/XwMx
         XWnI3TWMpC/9aKgGnDashGCUBXsRT5xqA50kA8MCrbHCPi7nh3itPacCva9UnEhaFRJo
         g81xTMO/GeBgVNsctQm/nSXc2yyDyfbrF8zSWHL573zhSA+5qZVHpPi4JH9JJR1+kQMc
         i0qUfhYzUaA0HqxqsugSksGYzOwaxK1MkyWWI1njdWi4YlcusP8lF3xVqdJAi2xHLijG
         PvNWq68yB3dGyQG++SERfpJK00yWdgEiyI5yHvgMcTyVnSyj/uC4VdNUnHQjJFZ5wdJt
         D0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qsvStGjZ7kTNlBuvu+xdYtuQoWdQc6Isdv1jT0yO4Zg=;
        b=VNO2+JBeqpUdpHlBfT8tnlrHQ7L7/BLpdy32A5eG8E/p0eYxHUrTD0WdNZky2OLNq2
         MPD3K+pGYr4NL7fRxF7JYa8oweSnYVX+WZeqnQO1uhj7/57/aCNi/QVYZsq555dDhumi
         IMlTeMnzqhdOtI0vBjvSlilVsbDvbksoJCDeZzE5MbJeYM2jy1t9S+lTLw8RZQzV52lY
         qvYal0PoM+UuMTb0RvKRXVKw2zQPupp/bw9AsBA615/XcSgkySYjI8QCoHdUDExWaymh
         LaNAmeCzRG3+ey/XcGyW/sGnO5PhxEnyRkQt7OkyeA0ZhayvdLcn5Ulk/khV8cd5TCBJ
         CjJQ==
X-Gm-Message-State: AEkoouu9jjMAsE5tJkhqZDE64Oobb97axil3pu7SnstOnFYLRfoQUd7SrN+4b4IqC8lsjrrySweP5wYPSDhpRA==
X-Received: by 10.13.251.66 with SMTP id l63mr27391843ywf.69.1469656408255;
 Wed, 27 Jul 2016 14:53:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 27 Jul 2016 14:53:08 -0700 (PDT)
In-Reply-To: <xmqqh9bavk2x.fsf@gitster.mtv.corp.google.com>
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
 <cover.1469547160.git.johannes.schindelin@gmx.de> <349bdfacfffa11d06241655c9e0b62506e58758b.1469547160.git.johannes.schindelin@gmx.de>
 <xmqqh9bavk2x.fsf@gitster.mtv.corp.google.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 27 Jul 2016 14:53:08 -0700
X-Google-Sender-Auth: jxhMbN2KH5zFXfQ31ndn-RoJ510
Message-ID: <CAPc5daUv_csGM963pE=PD+LSSnTFZq57_Shse-x+PsJBSh0dZg@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] merge-recursive: flush output buffer before
 printing error messages
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> +     strbuf_vaddf(&o->obuf, err, params);
>> +     error("%s", o->obuf.buf);
>> +     strbuf_reset(&o->obuf);
>
> Sneaky ;-)

Just to avoid confusion, I am _fine_ with this "we happen to have
a strbuf that we know to be empty at this point, so let's reuse it
and clean after ourselves before returning".

I just found it somewhere between clever and ugly, and "sneaky"
was the first word that came to my mind.
