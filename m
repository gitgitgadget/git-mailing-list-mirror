Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5047AC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 23:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGYXhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiGYXhb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 19:37:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF286345
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:37:30 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id u12so9453990qtk.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7zHAMZottVmxXeBNp4mttnpX4ApNOGsr4l8U3nH9e1k=;
        b=F5qMIsj6LA0ROk7SiKBHXWdPlkd0Hq/gH+GnYoc/ESljwcr+SK/Z79oGf6OIvYZcRI
         OujwJMXDrietRLNlpaMPPG16W3AKiuQVUJjhE8e+snOVHN5URTWXT0VEvci01+CjiRoT
         aK7VKVxLLWNnvnRx18bvh93N9IlRKAQiP0gPPAcPrb+CQyQYMyvF7Ev0nrkACAS+V+3a
         qNgUhMACXpV/TCxwo25ILGBF9+k24bPv8IfMz7JnT5ot9J3pCUziaHNl6j674p7D7UW7
         CNDud4W8I1qtHHrvsoYtPWg/15qyYz1csHfPzu56QORjxNfznoAzHhVR7PpPozbIJfsI
         cXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7zHAMZottVmxXeBNp4mttnpX4ApNOGsr4l8U3nH9e1k=;
        b=cNNMkOGgMQKaSt54npFq67GZW4L8bAzo1LJCTcpMOlZ3hCv6qU4QA17+XYn6Glh5QD
         G1UOwTaRbD3mesPZpVw+40QykLSBWQjZEXJi3DE7RLoYGhZo3oQ7q7vCz8z2ftCu3q6p
         1VOmRyWWAzsYcXEZ+hPJxKrWhTqR9wzy4owNukDbpH9eDqVn6Ws3IdX7mU55iPil1/oU
         JHO0rX75o49VOkG2cB2vG4e3VknHmYn1AyTyomAFnmvpkva2tiDz4XxabdBkEvcPU7eo
         ZydjGrYLfQVv2RrUus/UT7xOByNF8fpTl+kl/3jL7obaG7s7n+ypx0pGTytGLb2EJSTt
         YDYA==
X-Gm-Message-State: AJIora9qgv5RBTByyPIKWnATi71CDkpgGvvQM5qZ6bPjGdFVF/KMGTkc
        J26jlIXG7KosaPM5Abav1kyilg==
X-Google-Smtp-Source: AGRyM1vW1tZiQChFdT9JLB1OmGbCK+YG33cz1UVtbS/3pKnUAl80DlrrUgtMQPheZvffKhiQlFLIqg==
X-Received: by 2002:a05:622a:1210:b0:31e:e139:a6d4 with SMTP id y16-20020a05622a121000b0031ee139a6d4mr12377044qtx.160.1658792249632;
        Mon, 25 Jul 2022 16:37:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bj26-20020a05620a191a00b006af50b6f10csm10087490qkb.61.2022.07.25.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:37:29 -0700 (PDT)
Date:   Mon, 25 Jul 2022 19:37:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <derrickstolee@github.com>,
        'Abhradeep Chakraborty' <chakrabortyabhradeep79@gmail.com>,
        'git' <git@vger.kernel.org>,
        'Junio C Hamano' <gitster@pobox.com>,
        'Kaartic Sivaraam' <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?J8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>,
        'Jakub =?utf-8?Q?Nar=C4=99bski'?= <jnareb@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
Message-ID: <Yt8pNOTNbq5VHFhY@nand.local>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com>
 <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
 <Yt8VzTLmVOKCALxr@nand.local>
 <028201d8a076$dbb5a7d0$9320f770$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <028201d8a076$dbb5a7d0$9320f770$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 06:35:30PM -0400, rsbecker@nexbridge.com wrote:
> It is possible to use a Clean/Smudge filter to normalize the format to
> be independent of the endian-ness of the target platforms?
>
> I have to admit being a fan of that approach.

We aren't checking these files in, since these are just the .bitmap
files stored in $GIT_DIR/objects/pack. So we'd have to invent such a
mechanism, and I suspect it would be less effort (and more
straightforward to implement) if we write all numbers in network byte
order from the start.

Thanks,
Taylor
