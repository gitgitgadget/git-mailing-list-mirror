Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9081F428
	for <e@80x24.org>; Sat, 23 Dec 2017 02:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757161AbdLWCmh (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 21:42:37 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:45727 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756885AbdLWCmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 21:42:37 -0500
Received: by mail-pl0-f46.google.com with SMTP id o2so13869954plk.12
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 18:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:subject:message-id:user-agent:mime-version;
        bh=Mw9BYiwEU3dVQfo8cC6IXx6uvAHj0LTxG0jT2tgFrho=;
        b=Oe4ylO0JLNI1kHBsKyiFkKgk168RKAYLNuYjLmOuJI1yiUDbGpfGdyxTq0NbJBcPh7
         j7b77Zf/7Sw+3TRQ+Pxt38g0mEE0uY5wb8lJmYl2EDeTDT/LBRIg3N/eqNzVrj5Bn1rN
         cRZWEadN/jOOMvSFXuPA3kJzUxPzLpjn9vve8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:user-agent
         :mime-version;
        bh=Mw9BYiwEU3dVQfo8cC6IXx6uvAHj0LTxG0jT2tgFrho=;
        b=DJHQuI3QwmVBsrNAb5p8ku5hA9onws2FMki1kK00whSCKoUIdTcLdvQVvpvYYJkS8z
         QNGAbfzMg8UyDNUJjd69twhvtfMr0hyd07a/uAHK6xsGiT1ADcKrAABG3Ddu6PLEaKe6
         DCmsZJukmI/VXWEaIwsd1y9yYPqFicXM6kbKsU5YlHP4+8pBngbuZyiS5notCMOFQHKQ
         IAYBx4X3bQUBpud8QjNTUbOJX0FN+f9/tpo0ZBI6aPTA+NYb1QR+N+qEPK4wownZhPcL
         GBWDCvZzwrZaKaYBBQrSWQ59+LfUOK/FdWyEBvS9Damr97uZSU8rwE4kIxSeD/ASooq1
         9nvw==
X-Gm-Message-State: AKGB3mLU2yrO6pPFsm/oUfgYNVlvOVU+qxYwektw+TxWliG+lAyEYZAl
        Z5BgO2HfhE2g43lX0prl/yxphae3nMk=
X-Google-Smtp-Source: ACJfBovJYwZv/718sngYP/oQRbrP0dRgQnrL2IXmUjLYE5RRUusS6Q0Ka1QrLck+jFQPVSyRxFSaTA==
X-Received: by 10.84.130.98 with SMTP id 89mr16388637plc.199.1513996956154;
        Fri, 22 Dec 2017 18:42:36 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id t4sm52285020pfj.56.2017.12.22.18.42.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Dec 2017 18:42:35 -0800 (PST)
Date:   Fri, 22 Dec 2017 18:42:21 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [BUG] File move with `add -N` shows as rename to same name
Message-ID: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just stumbled across the following oddity:

    mv tracked-file new-path
    git add -N new-path
    git status

..shows:

    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)

            renamed:    tracked-file -> tracked-file

    no changes added to commit (use "git add" and/or "git commit -a")


Bisect points at 425a28e0a ("diff-lib: allow ita entries treated as
"not yet exist in index"", 2016-10-24), but I don't have enough
context to suggest the right fix.

Failing test is included below.
 - Alex

--------------------8<--------------------
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 1bdf38e80..97b6c0f05 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -150,5 +150,19 @@ test_expect_success 'commit: ita entries ignored in empty commit check' '
 	)
 '
 
+test_expect_success 'rename detection finds the right names' '
+	git init rename-detection &&
+	(
+		cd rename-detection &&
+		echo contents > original-file
+		git add original-file
+		git commit -m first-commit
+		mv original-file new-file
+		git add -N new-file
+		git status --porcelain > actual
+		grep new-file actual
+	)
+'
+
 test_done
 
--------------------8<--------------------
