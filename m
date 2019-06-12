Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39341F462
	for <e@80x24.org>; Wed, 12 Jun 2019 08:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFLI4Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 04:56:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39405 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFLI4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 04:56:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so9257208pfe.6
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 01:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1UboooEWeaa+MA1fkCsY5z0jOmSdzqriIGCE16d31k=;
        b=Wm36G0NvWmsPoNbKRmHX/zg15rUxTCfGGZI6u12n7Tw9BUbsn+hzojTkXCGEt9APM5
         bY2Q6v9a3lYeUzXVunrdQTDB2a6QfThkwTaet61dd8vNMxKzXtZEtEr3CSy/ZtJMemEC
         vS2uFaruXfuCFGy+qp7FqkgZhIfvNUa1KGUaWUHyNbyrTiSFFJdhAkWx1dIsD70vkNps
         R5jqbu2qG/mzE+dhT7NscK07zRkcr3UtiWA+jEn2rx+SMDAbS0ZXtOPixyy1a9VsjaMH
         /3ZjriLS2m/2dU3BT6otvVUOBNLIcf6NjZLothK3GG/Wqw+LQop1PTx12f30viWHyTKW
         7OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1UboooEWeaa+MA1fkCsY5z0jOmSdzqriIGCE16d31k=;
        b=mYcsvaH/4KmlpUpfiJZPvbX+OVlJtBKDJdlkOMNbldUXiqZlVfm+bZJvKRSCe9OULf
         WbyPhP5Es2af4v+piVE3iCg8NteMZuRrz4Yo8uNUIk3GQZT2v+V4hvfmREwhSufhtSRf
         xNLK6XoMKFEOx82Bmmma5BFOfPKbxKKhSCso6LT/t8CsBvHePdHprWaY7Y/oQvEDXPHD
         1vlTjpe0XQG/nDA/7mf432gV5CHXTw+ARzd6vqp11KzHqn6C0mJyg1mmJ4o5xRte7wpm
         kSPl4h4RsAwhvSvpsboXhKjSxsZ4tKv2vD0Hb218DYn33ffLis1nYjei4KBFclSJdIm9
         gwAA==
X-Gm-Message-State: APjAAAUKcsLnARNCDa1+m79Ag9q3h5OxQvOh+y7Vs8rRQnOu4iiOSdub
        RYkyKR9N+C53h1/9K0UCpak=
X-Google-Smtp-Source: APXvYqyVKzLp+Q1PWgvBRJB21UB+nHXmZNLQogVWXnqreCpho034TQK6XYfIakXaOAaZbWj8xRCaJw==
X-Received: by 2002:a17:90a:a505:: with SMTP id a5mr32156047pjq.27.1560329775504;
        Wed, 12 Jun 2019 01:56:15 -0700 (PDT)
Received: from ash ([115.76.191.0])
        by smtp.gmail.com with ESMTPSA id g2sm37181615pfb.95.2019.06.12.01.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 01:56:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 12 Jun 2019 15:56:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v2] completion: do not cache if --git-completion-helper fails
Date:   Wed, 12 Jun 2019 15:56:06 +0700
Message-Id: <20190612085606.12144-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190607093034.816-1-pclouds@gmail.com>
References: <20190607093034.816-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git <cmd> --git-completion-helper" could fail if the command checks for
a repo before parse_options(). If the result is cached, later on when
the user moves to a worktree with repo, tab completion will still fail.

Avoid this by detecting errors and not cache the completion output. We
can try again and hopefully succeed next time (e.g. when a repo is
found).

Of course if --git-completion-helper fails permanently because of other
reasons (*), this will slow down completion. But I don't see any better
option to handle that case.

(*) one of those cases is if __gitcomp_builtin is called on a command
  that does not support --git-completion-helper. And we do have a
  generic call

    __git_complete_common "$command"

  but this case is protected with __git_support_parseopt_helper so we're
  good.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 simplifies the code. $nocache in v1 was overkill.

 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f71bcde96..8c6b610a24 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -400,7 +400,8 @@ __gitcomp_builtin ()
 	if [ -z "$options" ]; then
 		# leading and trailing spaces are significant to make
 		# option removal work correctly.
-		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) "
+		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) " || return
+
 		for i in $excl; do
 			options="${options/ $i / }"
 		done
-- 
2.22.0.rc0.322.g2b0371e29a

