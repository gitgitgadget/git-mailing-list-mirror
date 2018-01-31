Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8051F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeAaLGV (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34043 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:20 -0500
Received: by mail-pg0-f66.google.com with SMTP id r19so9769570pgn.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2JPo6kuh/ouvdQJcGrKATIJnp16XS68ridowqQHcQI=;
        b=JuNlDH/0I6zE5JFFDlRriorDGcTyzjBfSyJXheEnWlSz8ZFF3TFABMVQtEOlcMpryR
         5LPt31mZGdZ/XwHn/ZeE7QUJ5C0trtrq9oQD+EBGaE6a618X99rgq/c64IvXPVFZWrlA
         vieCA7+GSx9cC1746YoQ0tZQoyUfQXSAL3BWDYvWeRYyCqVUX+bXIgnxBXwh++EdMsTN
         GYbMWS9WhqjYGs63WonWCFGrNboPJ8VPS0PKsihqrne+hwFGMUG9cUvF7g8/79quBHF9
         bL7SJb5XyeZpG11UGOQOc7lFPjshkDJNFFe3/sZtrxaxakSBPTb1Pf5l/4ZAhgENvhxA
         ES0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2JPo6kuh/ouvdQJcGrKATIJnp16XS68ridowqQHcQI=;
        b=c3LumrTHVtClVHPOy271trqu4r54s29zdR7I4ndTmc23qDSb0/u8Bli1gkE4rM2cvw
         w/AFdCtDLg4XQM76CGWS7ga4CKyVTHZid5QRQMCheOoxVu3rD3AdmgK9TSPeH9G/T9tV
         y6J5R2u3dT/1NTnXfjBohHIYCsnOGRdfVucGzVuEpo0XY0QzYdmAW4lG24cqtwVDNFUc
         /KH3gISNACQBLZT3xj28GgPiivrUF7ElQXykpJP1f1LSXIdzjJMiT7+DKmFFY7oYm1tB
         1x6lJzSDTZk6P8qBrEH7PLDGYB/ZyPEnl98lSbB/r3TKP4qgdP01hgH0Slp02Nvx4QM7
         wI6Q==
X-Gm-Message-State: AKwxytf6LS3N//pwlhcR6TksXNDmdVr0ZayabI3YMsRwvuEWpNytpSYm
        zGBiI7zCTBO4GDIPA76MZO7aPA==
X-Google-Smtp-Source: AH8x224/YVf9zfSskrD7hJswWVftIpPpsr8y3foDNernR2cBUA1/58W6kwAjbdd4UmiAPF5UYr1Xjg==
X-Received: by 10.99.8.1 with SMTP id 1mr17221056pgi.321.1517396779792;
        Wed, 31 Jan 2018 03:06:19 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id b6sm46419527pfc.139.2018.01.31.03.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/41] git-completion.bash: introduce __gitcomp_builtin
Date:   Wed, 31 Jan 2018 18:05:10 +0700
Message-Id: <20180131110547.20577-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a __gitcomp wrapper that will execute

    git ... --git-completion-helper

to get the list of completable options. The call will be made only
once and cached to avoid performance issues, especially on Windows.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..2d8d3434c6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -280,6 +280,30 @@ __gitcomp ()
 	esac
 }
 
+# This function is equivalent to
+#
+#    __gitcomp "$(git xxx --git-completion-helper) ..."
+#
+# except that the value from $(git) is cached
+__gitcomp_builtin ()
+{
+	# spaces must be replaced with underscore for multi-word
+	# commands, e.g. "git remote add" becomes remote_add.
+	local cmd="$1"
+	shift
+
+	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local options
+	eval "options=\$$var"
+
+	if [ -z "$options" ]; then
+		declare -g "$var=$(__git ${cmd/_/ } --git-completion-helper)"
+		eval "options=\$$var"
+	fi
+
+	__gitcomp "$options $*"
+}
+
 # Variation of __gitcomp_nl () that appends to the existing list of
 # completion candidates, COMPREPLY.
 __gitcomp_nl_append ()
-- 
2.16.1.205.g271f633410

