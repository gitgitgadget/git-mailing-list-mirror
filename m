Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19277C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 10:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379978AbiAUKVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 05:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379980AbiAUKVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 05:21:16 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7DC061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 02:21:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e28so4024067pfj.5
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=485SJBXbPVHniZOEovBhW4aBJrwt+zF703GPtaoumkE=;
        b=YtDeSgtOoCw0x9MYuuEQLsWEko5y15SXVuErZ0KiKqZEdCv4q9M/pJBdYrp2juHjrd
         5+dUTHBIaKp8G5L6DOWRyCcCLV9ayZ3aLpcu+p9Lx46d4ML7SlwAzGjswIYfwUSp/3b2
         P5UpHpCp96y2rnTRJosm/6GOjSph5SZHTD6LJGTd7dstq/8hvPdim00utmjXVFCePHH/
         6QIyPpeNfLl3SCC21wcEQk3MN1R0GPven/mhOv0uIl+td/TatBcegZBY+CeqYeUyi38r
         HA5QNDjktxE5MG/JZXtbwKMwYVTkRckw5OWmp86UioQv0VZOifxuH8mn6uGI3fCQMdGk
         KsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=485SJBXbPVHniZOEovBhW4aBJrwt+zF703GPtaoumkE=;
        b=OKpIxvIUFwnya18M7vgBxN7NB1XS5Wn9OBNtdeAkZdic2vtJbWYcBFen4Kb9QPV3hq
         E66aCwp0Xcg756PGliC1AP2owEq2ER3XD2Hpm3QvR1GXB0dGsdOsbzhuPd/BMkRa7ZF4
         F9nVFougzaMLGKJhAkjXgGW90B2H/PmcPv0Jr1zl9wCD+aQXkBjcr3ac3iC6t4RJMNjF
         THnn9fxCHiU572PZb3WpPM7Ka/jY4CvRdtJ8+hIt2ZXRn7Qi9Hd213fu9G+hdLXU+26u
         5lTN0rtH6En1LAZ4v6jZOp1oL+1qkQWtqH2qYE5RWvS8eCWDlkEQz0o930h8WXu+hwsg
         bHzQ==
X-Gm-Message-State: AOAM530Ulv3dwQ8x1VD8HLgXTjDqv5kmdGQel30dL3pqKs1c/B5R3DW0
        008L7MHfD70FlgeREgRVzI5gJDkQGj8=
X-Google-Smtp-Source: ABdhPJzFaoGY+BBxRmeXUsRiC4r54WAgrDrl5E9nw4yZ9SBmRoAyiy0FRmIOYxf5EL3d8r4EDEdRqA==
X-Received: by 2002:a63:7c10:: with SMTP id x16mr2490851pgc.128.1642760474675;
        Fri, 21 Jan 2022 02:21:14 -0800 (PST)
Received: from ffyuanda.localdomain ([112.195.146.215])
        by smtp.gmail.com with ESMTPSA id t17sm6750168pfg.207.2022.01.21.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 02:21:14 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [GSoC] [PATCH 0/1] t0001: replace "test [-d|-f]" with test_path_is_* functions 
Date:   Fri, 21 Jan 2022 18:21:08 +0800
Message-Id: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a microproject, I found that the "test [-d|-f]" in t0001 test script
can be replaced by appropriate helper functions.

Shaoxuan Yuan (1):
  t0001-init.sh use test_path_is_* functions

 t/t0001-init.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

