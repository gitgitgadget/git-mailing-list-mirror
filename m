Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA36C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 03:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiKHDAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKHDAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 22:00:51 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E42F658
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 19:00:50 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e189so10522078iof.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 19:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WKOZrX/q2NyyA8qM/IhOyubmibH+bJV4SdPW7Cu+nQw=;
        b=ILfqPfcpUh60KM+0NtPf4UrwLW3uuvb+/bGBlqck938tZHxdro7pR1n5pVemSuzIYG
         q5KR0W6bA3LPbpIqGkunmJXctr+TWV/PHoCgWIBVpyE7TEyevAhBiaALRNtp+KtB4HVD
         D1svS0u9xDx3CBK9yes0jofDRXdQaU5QmwwyNZk956cuMPyCwMlCiLX5SmV3CAV5y3hk
         wAGSbrMrLPRuxG/rikk504d5ErNzT6uzy3M5hIcWTbd5z+41RvezaDjB38NGosXoE6lm
         p2NHUjN4qCErPM7wA8FogNAoMY661OYjfhMK+/z4dq5ZaLwOiDwUZMqEw62HM1xOdWS+
         Doww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WKOZrX/q2NyyA8qM/IhOyubmibH+bJV4SdPW7Cu+nQw=;
        b=0/fGUiultJLqNF7V34Bo5mkRKqB5uSn5w/JjHN8xCqgON0HdAHS79cEovqD2MeNfPa
         6Y/WLL0atv8eTuP+vJjvudFopNma3GLK5Ua6NYRCKllUlIjAh4dOWtZpc+b8DHWdVmHo
         JRDtDBC0tU9XBh+5j/2axWe6Vvwip2VUjiRlhxzjF4Sw1bR4fP3kUZxrsxndIy0c15a3
         JusgUcmyEdIn3Zi9G66JAlENNibdMlN6NT39Pqt8/o6Klw7E9kpSepa9xkVpB8XTjenj
         xJD2xyglVxIcQDBwD1U/VDKq65NTjzNze8SXDlb/gAB6dYckIwkaKLSdw0Zf4Y7FasS9
         cCCQ==
X-Gm-Message-State: ACrzQf0CsZeyEmvpFeXNZCY4bQt83meYJAbKEteQ7si0TmYllcntECb/
        fNpjCLi7xcayQCNp2gSTLEnP6Q==
X-Google-Smtp-Source: AMsMyM6pDgUSumZDGKm2hF3Hg0Muf879TCGGUX0hXMGpP56jhPf1AayK/Fyg7ajdO01Tr/n8+O5u9Q==
X-Received: by 2002:a05:6602:164f:b0:6d4:8783:8019 with SMTP id y15-20020a056602164f00b006d487838019mr18976384iow.77.1667876450037;
        Mon, 07 Nov 2022 19:00:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 9-20020a92c649000000b002fff117027dsm3474451ill.13.2022.11.07.19.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:00:49 -0800 (PST)
Date:   Mon, 7 Nov 2022 22:00:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: compat/fsmonitor/fsm-listen-darwin warning on macOS Ventura
Message-ID: <Y2nGYFHOIYmzMhsG@nand.local>
References: <5dbd5dd1-3a50-c0ce-d06a-227ec0a89bc6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dbd5dd1-3a50-c0ce-d06a-227ec0a89bc6@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 06:26:57PM +0100, René Scharfe wrote:
> No idea how to use FSEventStreamSetDispatchQueue.  I could run tests
> if that helps.

Ditto to both :-).

Thanks,
Taylor
