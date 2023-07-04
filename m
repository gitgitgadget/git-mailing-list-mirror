Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444EAEB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 19:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjGDTse (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 15:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDTsd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 15:48:33 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824810CF
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 12:48:32 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-564e4656fecso3787042eaf.0
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 12:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688500111; x=1691092111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUQxKeljEC8FC8Cxc8ms3uAKa8M8nPCN1Xo6Qv/z1SM=;
        b=orOlidAuDtCgB07feaJz/EJv9+ZQOchCw3+mBzjgQJvrPYChc5k88uZwhrhfQ+hO7H
         CdZFcjuTFe4T8aRgJQ7JSqsApVR+GbuPHMQmXOuF7PN8PrLD+d8w+nI4gKdgJzHZRhzC
         o+NWyVLy/44U9MwMXQib5Lu2zRIxcktyAj8VHof2h72jbgbYwg2IQNcLUt6jz7Z6Ec0I
         dk2fPdXIiPbWK5I/12HBsfsqdLlxgF4weC/5XoNBg4jLBkPjeFiUCzwkLwvzLOiEAjFX
         3uFELCJDoOvn9iiUQYKKHyJBPPAEm7a/qh7RsKHoL0iIztfl1ingpPj3ZIuzCV17x+ti
         o/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688500111; x=1691092111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUQxKeljEC8FC8Cxc8ms3uAKa8M8nPCN1Xo6Qv/z1SM=;
        b=hNsnZ0Whs8wwCS7qIynvsmMAQ0dm7oMzkMWlFJuZ1igdXKnlIjasxQyjCHsvfFX/A7
         9Ul3PHfTm2k1Nzg/IYiiYfn0NY2wQk8Tcn+tN/+qmz8sT/k5b6nphH1P0bU4ozzybSYQ
         rZn7tp4V8ku737D0+JFPfyVFYuXgunl+yvDKaKesO8ocHbT6a9LP58TdxVYMkeBvWLTx
         ZvtjYhQznGuw+FbHUAHYhzLKW4/r/UAw+YWIMBD4r2yQol5ArG0tHBxnHe96yvNeTABh
         U/MHkBvjqKpUVoElb/ME9W1HNkQX7cd9T0ZjhxCTTxi3q6v3B/HytUz8FupqDjUkH1HJ
         1T+A==
X-Gm-Message-State: AC+VfDztj+bjk9ZnLZI3uc6NFF9VoLn66ruZJ8CLLkThL5Ii4Ee4wSCg
        WcxwCx0KGNtpOekbBkuNrGqzCVTX0Mmskg==
X-Google-Smtp-Source: ACHHUZ4SsKZ0fNFbEXgqVHc2bEel40UWmDiCxEAND+eHr+F/UWLyeahDkCXeHwkVH4UKWIR40pijgA==
X-Received: by 2002:a05:6808:140d:b0:3a1:aef1:bbf3 with SMTP id w13-20020a056808140d00b003a1aef1bbf3mr15908684oiv.23.1688500110848;
        Tue, 04 Jul 2023 12:48:30 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b006579b062d5dsm9952938pfb.21.2023.07.04.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 12:48:30 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 0/2] advise about force-pushing as an alternative to reconciliation
Date:   Tue,  4 Jul 2023 13:47:45 -0600
Message-ID: <20230704194756.166111-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702200818.1038494-1-alexhenrie24@gmail.com>
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many times now, I have seen novices do the following:

1. Start work on their own personal topic branch
2. Push the branch to origin
3. Rebase the branch onto origin/master
4. Try to push again, but Git says they need to pull
5. Pull and make a mess trying to reconcile the older topic branch with
   the rebased topic branch

Help avoid this mistake by giving advice that mentions force-pushing,
rather than assuming that the user always wants to do reconciliation.

Changes from v1:
- Recommend --force-with-lease instead of plain --force
- Consistently wrap messages to 72 characters

Alex Henrie (2):
  remote: advise about force-pushing as an alternative to reconciliation
  push: advise about force-pushing as an alternative to reconciliation

 builtin/push.c | 29 +++++++++++++++++------------
 remote.c       |  4 +++-
 2 files changed, 20 insertions(+), 13 deletions(-)

Range-diff against v1:
1:  48a9f6b1fa ! 1:  d0cb607225 remote: advise about force-pushing as an alternative to reconciliation
    @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      			strbuf_addstr(sb,
     -				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
     +				_("  (use \"git pull\" to reconcile your local branch with the remote branch,\n"
    -+				  "  or \"git push --force\" to overwrite the remote branch with your local branch)\n"));
    ++				  "  or \"git push --force-with-lease\" to overwrite the remote branch with\n"
    ++				  "  your local branch)\n"));
      	}
      	free(base);
      	return 1;
2:  0d47c23320 < -:  ---------- push: advise about force-pushing as an alternative to reconciliation
-:  ---------- > 2:  3295f0bb2b push: advise about force-pushing as an alternative to reconciliation
-- 
2.41.0

