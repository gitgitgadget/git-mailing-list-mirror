Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA2ECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 12:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiIEMvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbiIEMu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 08:50:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A451F29
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 05:50:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l3so8405244plb.10
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=E75yhK1vSewf/305bonzamWswUIs59rcrP1zFMaRX9M=;
        b=RfqbZfAC+j4mAnOCzuM9jGBtspI0RpfrQFCP97kiwx30+w2K3HCAyE0MYxJ1sL+2p8
         A1mLqx385mzhfG3tlX+z08GdcWAQlt0pvV/L3YGJ79btAcJK6wh+0sMYqOuI+Qklp58j
         M9jr+X60oL7T49Ynk+TVs8+19w1BgRTIbxt77cQqvZTW9uR+O7V//buzwMDuNJbW869t
         NWQwLHQgbriH4jJifTOna3cADUEC58k5k8hFTQMvKpMjQOR3/K1SBYGZ8irHePhEwV1n
         0yZYiFWYU2OuJCfZ17bR5DmxCA6hMPRFV9MOKU4IiVZD9GVBCHz2vzNMMRUJXSSpWRHH
         U4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E75yhK1vSewf/305bonzamWswUIs59rcrP1zFMaRX9M=;
        b=wEhmvmoEvi/LpiS746LS+lK3+WM2L+P2blHuTg3CGJfTaFE5h+Yb0SJiCIqNMWt1Zv
         ai1ji9lZVCKXOjKu+oZJlf+cDAw8gFwGrXlzR/RKR84jXfin+r88ueg+2Pb/yt5tYOf0
         2qZmEwnG80Rpo4331tu3fwgFX/WCvTfuo8v5SHr0dWjjX7QME/c9qkMuSCAZd8qeN17j
         6dN5v72cM7EaaPxtOIDBLp7PdYTFTIPPDLD83ipUCUTaTuA4r2jcWSfTBlLKG52A8ZBK
         2naj/TQ7ZD6g8bKlgOACDuGHpt1RtwAyjQZ7mRUhTrUSnmrcIoaYe9lVsxxQTIiILT57
         eaPA==
X-Gm-Message-State: ACgBeo0bIYfHQrLFvlCfNONT7YEDmidmk1LBYbEDGO0XbwUtF7dT4Mdy
        bf6LhdNrHmHx+BDyNP/Zh6g=
X-Google-Smtp-Source: AA6agR7zyChRVumDOuzjffpa75sUxLqAeixAc1MUMg5B3lYn5pKp1BSKwgKGCHykgcg5pGDbQ29JUw==
X-Received: by 2002:a17:90a:181:b0:1fb:824:d33f with SMTP id 1-20020a17090a018100b001fb0824d33fmr18791130pjc.225.1662382257906;
        Mon, 05 Sep 2022 05:50:57 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902900300b0017693722e7dsm4293739plp.6.2022.09.05.05.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Sep 2022 05:50:56 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitgitgadget@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, mjcheetham@outlook.com,
        newren@gmail.com, steadmon@google.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 7/7] bundle-uri: fetch a list of bundles
Date:   Mon,  5 Sep 2022 20:50:50 +0800
Message-Id: <20220905125050.83312-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.235.g7b45c06cc9e.dirty
In-Reply-To: <7b45c06cc9e0294311d9f00d40eb1fa4f8f146f9.1661181174.git.gitgitgadget@gmail.com>
References: <7b45c06cc9e0294311d9f00d40eb1fa4f8f146f9.1661181174.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Derrick Stolee <derrickstolee@github.com> writes:

>  int fetch_bundle_uri(struct repository *r, const char *uri)
>  {
> -	return fetch_bundle_uri_internal(r, uri, 0);
> +	int result;
> +	struct bundle_list list;
> +	struct remote_bundle_info bundle = {
> +		.uri = xstrdup(uri),
> +		.id = xstrdup("<root>"),

Very readable code, thank you very much.

I'm a little curious why we use the "<root>" as the init value of
".id"?

Thanks.
