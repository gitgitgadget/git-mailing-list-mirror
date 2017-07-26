Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89272047F
	for <e@80x24.org>; Wed, 26 Jul 2017 19:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdGZTIl (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 15:08:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38222 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdGZTIk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 15:08:40 -0400
Received: by mail-it0-f68.google.com with SMTP id h199so7125385ith.5
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jDKmGQfNUcHtQ7gS4mVyCIZ2CAaBiyeEzch+xzRp2bM=;
        b=VNZhVKVE+2UUylj58PZFKiuwlQgKZnpOpU72tESvTH0Ag4quznE5vq6Yyi8RrvkvW6
         2j432xh0zfvT9OvHszYgc6KyRU1MGxRodV52EArq1L+SNMUY3iqQ9LIFXIpkICAhnUh2
         8KDrt72fvd7zQ3PshLJwTa1X5vrEVm+HDCKHrkdUnd7hPBEgAbkl/fDPh/gvDyTsef8m
         eN2IBKgK5pFksKK4v5iYTqVcurVGa0IIYjHCVgs2AvZHh7jmFjj52Nkz12XmvD42dShj
         P6T8KBF0zolsf83I5jyS/S1LEqmhZUr7kuUu1dh/3JZSjHpPjJSsZ6BgpTXVzhG/tKcI
         xJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jDKmGQfNUcHtQ7gS4mVyCIZ2CAaBiyeEzch+xzRp2bM=;
        b=Vc2X1N2SFnectsdTJm1rjr7c6PbTwsT+4MfssobFJVyvj/Ua5gNm0PIqxUw5Dbjvrs
         bFl2zj6nOVcWW9g92Yn4TZKL4zxqj1ehQma9CzmI/UatVCATqm/W2kvp50Y2l0NPYrCs
         zXGJHdE+6DFu1mQz4dtFztRT57mrLFHDOyU5FPtT52ERhPaBKbv0XS4n3f5EB0tJeFpT
         ATpEIwWV1HHO2wGqfGanglDyUIokWDNPLPVFKRZDQabqSNoxHtM9zQmAn4X6QrFaSeFo
         PSfb3+iOtArqRGISXoYSUZhuMfKao4/A8WK6RiEN4X7awpEqzeqhGgLyzJMrGvHYhx3c
         7sJg==
X-Gm-Message-State: AIVw112dbZN8xfSAzT/o4NDn34uk2VrKBVnKkCNC52IPoSG/6MdmDoW/
        23GJXVq20cALMCh9ibM=
X-Received: by 10.36.125.81 with SMTP id b78mr2127711itc.26.1501096119337;
        Wed, 26 Jul 2017 12:08:39 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-81-207.home.cgocable.net. [24.150.81.207])
        by smtp.googlemail.com with ESMTPSA id q133sm8504974ioe.58.2017.07.26.12.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jul 2017 12:08:38 -0700 (PDT)
Subject: [PATCH v3] contrib/rerere-train: optionally overwrite existing
 resolutions
To:     Junio C Hamano <gitster@pobox.com>
References: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
 <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
 <ae4d9b77-c47e-199b-d40f-ad5b49c5dd60@gmail.com>
 <xmqqmv7rrs45.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Raman Gupta <rocketraman@gmail.com>
Message-ID: <3a11f2f2-9fa1-bd7b-44dc-141c7fff8127@gmail.com>
Date:   Wed, 26 Jul 2017 15:08:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqmv7rrs45.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide the user an option to overwrite existing resolutions using an
`--overwrite` flag. This might be used, for example, if the user knows
that they already have an entry in their rerere cache for a conflict,
but wish to drop it and retrain based on the merge commit(s) passed to
the rerere-train script.

Signed-off-by: Raman Gupta <rocketraman@gmail.com>
---
 contrib/rerere-train.sh | 54 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 52ad9e4..eeee45d 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -3,10 +3,56 @@
 # Prime rerere database from existing merge commits
 
 me=rerere-train
-USAGE="$me rev-list-args"
+USAGE=$(cat <<-EOF
+usage: $me [--overwrite] <rev-list-args>
+
+    -h, --help            show the help
+    -o, --overwrite       overwrite any existing rerere cache
+EOF
+)
 
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+
+overwrite=0
+
+while test $# -gt 0
+do
+	opt="$1"
+	case "$opt" in
+	-h|--help)
+		echo "$USAGE"
+		exit 0
+		;;
+	-o|--overwrite)
+		overwrite=1
+		shift
+		break
+		;;
+	--)
+		shift
+		break
+		;;
+	*)
+		break
+		;;
+	esac
+done
+
+# Overwrite or help options are not valid except as first arg
+for opt in "$@"
+do
+	case "$opt" in
+	-h|--help)
+		echo "$USAGE"
+		exit 0
+		;;
+	-o|--overwrite)
+		echo "$USAGE"
+		exit 0
+		;;
+	esac
+done
+
 . "$(git --exec-path)/git-sh-setup"
 require_work_tree
 cd_to_toplevel
@@ -34,6 +80,10 @@ do
 		# Cleanly merges
 		continue
 	fi
+	if test $overwrite = 1
+	then
+		git rerere forget .
+	fi
 	if test -s "$GIT_DIR/MERGE_RR"
 	then
 		git show -s --pretty=format:"Learning from %h %s" "$commit"
-- 
2.9.4


