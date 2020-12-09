Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD30C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9875423B84
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgLIG4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgLIG4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:56:20 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E83C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 22:55:40 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i6so401563otr.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 22:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NX87CK946GgAK0AFf2ks5Ggi6NXlV85LIONLm8Qdxo4=;
        b=QDAKm9zh7hPdBJAHfLoyU6yrikFak1wDPsSpfmGrzZwMx7SvcAMBT2WOYFUYd8lXeM
         ihzds2nK+FXt+X+bTzUysZvq29GB8LAmtZzQ1Z8nSkZei0YUF4/yCltbzBbdnxjS+Par
         b0dHDk5HLPn4JNh4zMEYLBlsd8KI9Q0hz6mCS6a0V9RcQesb/RZzknUgDcyYdM7B8AIW
         fUh8qp3L1AEmRfTZLmQR0rrxQAI7QMpEs8uxUaSNycylsHG3W4mB/I+n/Ng5Y8ZDLy1j
         cy1pYSGgFPm8fA6ZuTVPTkstuQNHrpUEYA9F+L4ssnXrzQgwXCjWRe5mEZyK1Da5luKp
         M3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NX87CK946GgAK0AFf2ks5Ggi6NXlV85LIONLm8Qdxo4=;
        b=Ungv0NhoBVDo6HrMr6P+tDFl0lDD8shUa6xdo4tymAiJSsUz3VeLW4bL1SPZZDamMc
         aKeNawjevm6jWZXH9EpdMndYOPY1NL4PZ1ERWLPAFXg/UE6YqzqR5QODkf/vCIDvvgIB
         E+yE5XczYnE607mmMX2TQzRhCUmQC9WZ5MwU2PaB6mRU/IqRA3eOJ1+MtIds1fzNHFpd
         EqJ7rXwf0r0VGwCXbPeI3p3uFw54XMURrLSXxWHXjJsJLYRYGs6lmwECxvZoz/SrS8Y0
         s/JW0EEiPoMZxovrr2hR1OcyBqpAT/bYc76VyecTlc0zqo1D8voBCfzrXftZjoDYZ08O
         cvoA==
X-Gm-Message-State: AOAM531GXzLqD01SMXDAN4LP5LWi/i9TwHRwmUaLbTD3Z/DD2/b1OVZK
        KmHPyqjsCZuWQ/5Np0rDeXeN5ot5/fgevQ==
X-Google-Smtp-Source: ABdhPJxVqbiJpGf2i0YxFZ3L1A2aKmrVl/bPfVNNaBhkmiTTJMSNKq0mm5Ma8yjZitqb76NizKg7rA==
X-Received: by 2002:a05:6830:1e22:: with SMTP id t2mr582909otr.85.1607496939201;
        Tue, 08 Dec 2020 22:55:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s9sm215932otb.6.2020.12.08.22.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 22:55:38 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] vim: configuration and sharness syntax
Date:   Wed,  9 Dec 2020 00:55:35 -0600
Message-Id: <20201209065537.48802-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After investigating alternatives for exrc I found too many, doing a wide
range of irrelevant stuff, many unmaintained, others requiring multiple
dependencies, and some loaded the configuration too late.

The only one that seemed to fit the bill is vim-addon-local-vimrc, which
does work straightofrwardly, but hasn't been updated since 2015.

Instead I chose to simply vim-addon-local-vimrc, and take advantage of
git ('git rev-parse --show-toplevel' saves us a lot of the complexity of
these loaders).

The result is a very simple loader which is also secure, since it cannot
do anything unless you manually whitelist the project(s) you want load
.vimrc files from.

And since I already created some files in 'contrib/vim' I decided to put
the sharness syntax file there too.


Felipe Contreras (2):
  Add project-wide .vimrc configuration
  contrib: vim: add sharness syntax file

 .vimrc                          | 23 ++++++++++++++++++++++
 contrib/vim/plugin/gitvimrc.vim | 21 ++++++++++++++++++++
 contrib/vim/syntax/sharness.vim | 34 +++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 .vimrc
 create mode 100644 contrib/vim/plugin/gitvimrc.vim
 create mode 100644 contrib/vim/syntax/sharness.vim

-- 
2.29.2

