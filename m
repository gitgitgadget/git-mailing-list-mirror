Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F166DC433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C5B60F6D
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 08:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhIMI5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbhIMI5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 04:57:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B2C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t35so7493666qtc.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMyhek/fTGQs+wl5RTI+We2GkrGLz4CosDAQhghXXS8=;
        b=kQ9SbFdVRESJiBHMbdX6E838VTSldC3dyOji72RmF2uWI6nNlFQL+DP9TX7B6VzZI+
         bJv2g3KFx8fmiVfSUciNrKcmspCN/NKmSfs1ROXIvT6zvlPL88SP6trMKTIxOLKvKY6a
         uOea+2HKW4SzkA3lLYgD3HpKVwn8KjnlwhGRHYA5mBEXl7h+bnnIhRMJ6GgnOJzQfC0P
         qH3id6iMvl4WT5YHdHraVWb5HqKCD3iPeT7ISwfxSthVIas0y2iGosC7L1jLgf+Htxgi
         wo6F+bmTgg4LPyEpZf8s2r0SLqX0CXBY5LPd08ToOZWDhb4d+0KJHr/QtFBhuQ0A5tgB
         JNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMyhek/fTGQs+wl5RTI+We2GkrGLz4CosDAQhghXXS8=;
        b=23IekoWJuBfZZS3sMKnQioHOJNkoOmK4kF9Vs/F0e8bVjXdPj6Y/4tBsr9Zeowe3vv
         QONZZUfig0l7GtUqc/1G0vh3Lo25SupymwpSQp3VdR7UtUuc1soTl/CSxerE+baj9vkg
         FL6PBdva0rawGpKRPpUgxIakwfXRjWUobT4sOon7lhDBgPO8a2rHNLAOtTZKW0PCJ1PG
         xzqqJXgRWanUjmj8vRfvbxT/mSj35QzSsaF1sTasUdGqykbsdUMei/DM5u+B7XfjoQ12
         y3YZOeBNt2EPY3gTtDIlTWJdOWW82ql26ZMjSR86npJA5Er+SCSTisIv5CPtv3QIQjae
         4Jng==
X-Gm-Message-State: AOAM532i6Bz0aFZTaRYLeb83Xr4M0+/8kfW8WlCjzOTsQfCwMiwriGa5
        JVUwgbJkkBFF47KhGI+CWIuP6rAsWuM=
X-Google-Smtp-Source: ABdhPJxdIkzIs07RreWf1+YEvynMZ2w6wMabeQDzr9ypsu8+4IeD6wuMxrOnaPNGNP/gDPILjKiZ0w==
X-Received: by 2002:ac8:4716:: with SMTP id f22mr8404557qtp.250.1631523388209;
        Mon, 13 Sep 2021 01:56:28 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q10sm4994321qke.108.2021.09.13.01.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Sep 2021 01:56:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 0/3] windows: allow building without NO_UNIX_SOCKETS
Date:   Mon, 13 Sep 2021 01:55:57 -0700
Message-Id: <20210913085600.35506-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210912202830.25720-1-carenas@gmail.com>
References: <20210912202830.25720-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventhough NO_UNIX_SOCKETS was specifically added to support Windows,
it might not be necessary in the future, because Windows added support
for Unix Sockets in late 2017.

The implementation of Unix Sockets, uses an internal NTFS mechanism
and is therefore not visible at the filesystem layer, like it is in
UNIX, but seems to be good enough to allow to build and run the
`git credential-cache` and its daemon; additional testing to confirm
trace2 (builds and doesn't fail any tests) is functional will be
needed.

V2 reuses the same third patch from V1, and applies all suggested
feedback on patches 1 and 2 and should apply cleanly as a reroll of
cb/unix-sockets-with-windows.

Carlo Marcelo Arenas Belón (3):
  t0301: fixes for windows compatibility
  credential-cache: check for windows specific errors
  git-compat-util: include declaration for unix sockets

 builtin/credential-cache.c  | 30 ++++++++++++++++++++++++++++--
 git-compat-util.h           |  3 +++
 t/t0301-credential-cache.sh | 32 ++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 10 deletions(-)

-- 
2.33.0.481.g26d3bed244

