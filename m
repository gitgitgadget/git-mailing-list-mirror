Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29BEA1FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 22:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeCPWhS (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:37:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56132 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPWhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:37:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id q83so5754714wme.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 15:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bAsj8s7FzacUVQxtJzSA86hC51dvj0NcgIpnQaJ9PMI=;
        b=E9rhIHDFkmpE5X0tjhOIAyoyMBcnk0tuRVEzsPTTGBgRqNoHHVbYljMp3LgQldyr5V
         OP47+UGvQpeQgb3H982rwmcdAmvRBdofRUfd6HV69Uyz649ZRn9R4jsjHtiTACw9Cu2f
         Kwe78MCl0xOUMvnK2lfSmET2kyRA681M3jddC4VujDezlRbG1Pm2Ovc26h4DCutI5mCr
         EFmKncDgz1D5WZN8RbvRWB/aHznVLCI7VqUUj7w4ZN24nenLJoeRexFpvTBW6QKkChNH
         8hdFZFQkpGUlU3Edq36VihcDECL05NUVYo8TNl/dlxaHn56Iw6BKkdfDbOFBfXj+Yat+
         NW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bAsj8s7FzacUVQxtJzSA86hC51dvj0NcgIpnQaJ9PMI=;
        b=j6hiktltudbbKvaYdGgys2+oktSn322n7fTlUVkbifjn5fjGH6vWxQErd7uqonPVNf
         kawjYG6S2ppqkkakvPTj2KSE5fuy7wAID2IeCDq9MEOkQ8aRbSeB4WdSLTjE16eVX2/d
         aBqmFeeXDiC7gBOKICuoJ+snawcNaPYA1yewGOK9NWyfa87rPCqNtbr6JD9/DfO5rX9x
         BLTm1csPUJ/BlhBMSylu2RXgtpbNBwfekXoLn697LcTvOe+4fHzbBwM4NRdh/c4SvjXW
         nN50xAMsHNOFyXoi4h9QtKoWFSX2g4oB6im6wmEOWJrJMUNB1FNUZNgHEEWwX4S2hagk
         FUyg==
X-Gm-Message-State: AElRT7G6zilb7mchKrs5MUAgWQOq8Xsh+51SjBmDcR9P1WIFHMkgievl
        j+8/PxKMKua6Csbh+URHq+WSoRaw
X-Google-Smtp-Source: AG47ELtEsAKlSjm8I/hS3DeNeORahKO+h8VjhOnLTzy9hj2v2TY07ICH6P1pP8E2jP2tqfnQOIy6Lw==
X-Received: by 10.28.149.197 with SMTP id x188mr2734339wmd.87.1521239836124;
        Fri, 16 Mar 2018 15:37:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c1sm8020854wre.27.2018.03.16.15.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 15:37:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/3] stash push -u -- <pathspec> fixes
Date:   Fri, 16 Mar 2018 15:37:12 -0700
Message-Id: <20180316223715.108044-1-gitster@pobox.com>
X-Mailer: git-send-email 2.17.0-rc0
In-Reply-To: <20180316204306.862-1-t.gummerer@gmail.com>
References: <20180316204306.862-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a preliminary fix for an earlier copy-pasto, plus two
patches from your v3.

I tried to reduce the nesting level by swapping the order of if/elif
chain; please double check the logic to ensure I didn't make stupid
mistakes while doing so.

Junio C Hamano (1):
  stash: fix nonsense pipeline

Thomas Gummerer (2):
  stash push: avoid printing errors
  stash push -u: don't create empty stash

 git-stash.sh     | 13 +++++++------
 t/t3903-stash.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.17.0-rc0

