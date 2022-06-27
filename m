Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA7C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbiF0Sev (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbiF0Se3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:34:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0853313F8B
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:29:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so4043760pjj.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYPdL8nQ+tQXdnqpxhyJ7oA8IVIB9hoiwY2PvWjLTPs=;
        b=YeOyTC4LK6LYzMxYAzjwEACJgibWXY3MjuxK2xdk1d5gNbXv0czxAjI5fRo3GRYUIx
         8lWlkJTOyQRIckf5SUnuA3VBwU893AXzGj8+GxP+ctZXlSZAnwwRGGw7WuJX3yymOEtb
         78sEbPoE3iTZoKCwZpLphooqNQVR0CkYWowI9Bgq+cJQcGLC3h0LI2eRY1fSdmzLHlho
         In/w7sJgJdPY+5MMUnJhS90bPZ+vVTOG/2l+3TIttOA/s7klH3M4Id0F6amcGqcBLtD8
         ei3NyJFiUKZJyLEwjPDKNxEv5ODiBeoC6TD5YMwNGV6jvd3+23ATIBJmo6QVHKWAJJhC
         TdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYPdL8nQ+tQXdnqpxhyJ7oA8IVIB9hoiwY2PvWjLTPs=;
        b=MWA66DCn+1hXwXSAYivgljcuBn9Ybcmv+/Gpxvm8ereqlnIB3CSI26/OEmWFDqxjrZ
         xHYhhdieTcGb/LUMdfXdA63gqeZ5UypswdkJ/0DLoUTvXXbzA8oW53x45Y80cdbLTkjQ
         +lDzSoI5nHAvkC4v07A8zesIa4yIZVCERc+gQyJzofH4iMs8+03SsgjJZpbds2BPVlyJ
         FqKLdt556Hcnzr0+/XJJPIxwoRAaDEI1vvGmeoYEeh/3h2UmJTSMAMt0jle48Qp3ii1P
         yjWQIqR4yqJxf9mkXrPHjGPxNhEK/lsXxl242V45cy8JQlawqFj7c7gvcCfDw8Rnrf/N
         eH6Q==
X-Gm-Message-State: AJIora+9Bx2Dm6hNDXtrcQTMBF/Wx9XR3p/YbxNWk2u6CHbHDK94QaGe
        5rzCnruCMVMFTJkYo6MfuHc=
X-Google-Smtp-Source: AGRyM1v6n7iO6PlD9dLty93c3nB/zYpdgmC74H3uMVCeu/RX9UOdQKeh6XCV4B7Si0D8bC/BkpssTw==
X-Received: by 2002:a17:90a:1588:b0:1e0:a45c:5c1 with SMTP id m8-20020a17090a158800b001e0a45c05c1mr17399963pja.65.1656354592720;
        Mon, 27 Jun 2022 11:29:52 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.81])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a050800b001ecfea03d85sm9816115pjh.37.2022.06.27.11.29.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 11:29:52 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/6] pack-bitmap-write.c: write lookup table extension
Date:   Mon, 27 Jun 2022 23:59:30 +0530
Message-Id: <20220627182930.16347-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrnVRLvbG4TK8pXY@nand.local>
References: <YrnVRLvbG4TK8pXY@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> We should probably leave this as a pointer to an off_t, since that is a
> more appropriate type for keeping track of an offset within a file (and
> indeed it is the return type of hashfile_total()).
> 
> But since it's platform-dependent, we should make sure to cast it to a
> uint64_t before writing it as part of the lookup table.

Hmm, will make the necessary changes.

> That at least removes a side-effect from the implementation of
> write_selected_commits_v1() and brings the creation of the
> commit_positions array closer to where it's being used, while still
> maintaining the constant-time lookups. So that may be a good
> alternative, but I'm curious of your thoughts.

Sounds good to me :)

> I think the construction of table and table_inv could definitely benefit
> from a comment here indicating what they're used for and what they
> contain (e.g., "table maps abc to xyz").

Yeah, true. Will add comments.

Thanks for the other suggestions also :)
