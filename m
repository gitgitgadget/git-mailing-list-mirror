Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46361F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966691AbeCAJNY (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:13:24 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35385 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966675AbeCAJLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:10 -0500
Received: by mail-pg0-f67.google.com with SMTP id l131so2067095pga.2
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eEPD9ubVMlIRskmfdSgKVw0HZceoEkDG/GC0ZFREkQ=;
        b=k0aDfJ6ish20Jq0RVwQs2uxaaU2S67SVE5bRaBaYY5LFwnuydAvgs1A7og6o39WYbS
         7MKhzKWTFSf7v0J09dr+bBqaCsLpcIBLPfY/jhsFm4kxU7p+GDpjxFzA/dTxObt7UTSW
         +fI8YtzWsqGtIUeL3R+L1txdsR5nZ96Cmub9PF89happdaGeUrbcwTVFxSUI68P0Xv+0
         cYdp+JI54jggp6pyjYE67YAVo75F+3/A9sN+hE9m8/yMawMQC6yz4v281goHXpB6UrzF
         fZy05/yezt4tS6bRq03pmY+NKiMNDJhX8glAsdyRTsPabvqlgHkzCIrUkfJaOKFNdAYa
         OYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eEPD9ubVMlIRskmfdSgKVw0HZceoEkDG/GC0ZFREkQ=;
        b=ZHsHcqGlu2lb1rAIxmUbB+t2PRK6CuB0R6sRKOH/oVSnkx4NU1IQEJyvTKk+aXqiW7
         RlSfkeWmsdmeOybBmIcoEJoDwZas0fK3cEh6vn3owlswYFWmmuTdvYOcPBm+5sYmrfu/
         7HDujzpgJ8CghyQLcf13Lmh6jPvPtEV1Lk1P6DujoMvyUNXe/zEMQcouwqHL8O6zkgKr
         PUuHhKTwHdBWbSUAp/xPJZJYMskQixdTXOC2Xitgpa9gBAQMz42VClwlBZKGTeXMqQmt
         MbMW2ensbzamRlLMlc0Dhw93+7thIxoH+7wr8rSg5kBrvthl86sGTW68D67VS0/kj8Ez
         9tcQ==
X-Gm-Message-State: APf1xPAezwDi8ScO5DSwI2Iod9TAQAxU8nEwyUcIHk6y7C3N74zVfRuM
        7+p5feCy6I44zqItYLMSW/SDhg==
X-Google-Smtp-Source: AG47ELuadN3SqqB5CtrtvoE2U5Ketul1kQAO/kMoLFZRPor5ey/9OiW8Do0LmWZWW/SyP+1crffvOw==
X-Received: by 10.101.69.134 with SMTP id o6mr1003144pgq.340.1519895470174;
        Thu, 01 Mar 2018 01:11:10 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s68sm6143831pgb.43.2018.03.01.01.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/11] Reduce pack-objects memory footprint
Date:   Thu,  1 Mar 2018 16:10:41 +0700
Message-Id: <20180301091052.32267-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180228092722.GA25627@ash>
References: <20180228092722.GA25627@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The array of object_entry in pack-objects can take a lot of memory
when pack-objects is run in "pack everything" mode. On linux-2.6.git,
this array alone takes roughly 800MB.

This series reorders some fields and reduces field size... to keep
this struct smaller. Its size goes from 136 bytes to 96 bytes (29%) on
64-bit linux and saves 260MB on linux-2.6.git.

Now the bad side:

- the number of pack files pack-objects can handle is reduced to 4096
  (previously unlimited)
- max delta chain is also limited to 4096 (previously practically
  unlimited)
- some patches are quite invasive (e.g. replacing pointer with
  uint32_t) and reduces readability a bit.
- it may be tricker to add more data in object_entry in the future.

Nguyễn Thái Ngọc Duy (11):
  pack-objects: document holes in struct object_entry.h
  pack-objects: turn type and in_pack_type to bitfields
  pack-objects: use bitfield for object_entry::dfs_state
  pack-objects: use bitfield for object_entry::depth
  pack-objects: note about in_pack_header_size
  pack-objects: move in_pack_pos out of struct object_entry
  pack-objects: move in_pack out of struct object_entry
  pack-objects: faster reverse packed_git lookup
  pack-objects: refer to delta objects by index instead of pointer
  pack-objects: reorder 'hash' to pack struct object_entry
  pack-objects: increase pack file limit to 4096

 builtin/pack-objects.c | 189 ++++++++++++++++++++++++++---------------
 cache.h                |   3 +
 object.h               |   1 -
 pack-bitmap-write.c    |   8 +-
 pack-bitmap.c          |   2 +-
 pack-bitmap.h          |   4 +-
 pack-objects.h         |  70 ++++++++++-----
 7 files changed, 180 insertions(+), 97 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

