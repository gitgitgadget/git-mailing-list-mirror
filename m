Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E11F1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 22:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750867AbdGYWsO (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 18:48:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32896 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdGYWsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 18:48:13 -0400
Received: by mail-it0-f65.google.com with SMTP id t6so10477121itb.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hvxJVRRNN4E6xWjhUDiad2I6y7W4qFHGnuh2+B8spCU=;
        b=buZi81kT+CxTGvb++VjwpRWl89CGIDzvPYMpXwPhfsdTdwv9LxYCzTfmzJoE1Yi3Rr
         Ps2djZ5XKN1KyUDoIXf/Z8jxWo+B0W0QRu2a2GbT4rSdz0xxe21ahLnrjuttP61ghtj+
         mxpVgiqrGT5X67csm+5CAwNhDo6/iK/ylbJBi24vQGyhDUzqYcRcQVS0lkqnobZuyyIL
         wz5t4MPSIweoHygGkkf0ZznunIvkpFNaMWV1YaANMWS1ArOMWiDVD7AOH2n4Ej1VzrKH
         YD8iw8U5dg4GhIZdtu0mhg7ujKnuK5lu96voc7pjScs7btAEYp49VsfWHNSzz9DZf4T1
         TnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hvxJVRRNN4E6xWjhUDiad2I6y7W4qFHGnuh2+B8spCU=;
        b=EVxW3oyVCu4GcYLKSYXPc9LHlKQum7q2NY4MrPn7+VZtXTi4CegS0lco9pQwAD902v
         o84b+Y4ktqzmxzMo1CMw77e6r9NyiE7NwnCqsHFNtAJHs/f3abYVSt+3xlUU73fUb7VK
         QssCmYwdzX7q4acMoxP6d3GSlH7ItNuI8WVKxZ1TwMwJxfgX26jpuEORy7ZQgN/ZAPbL
         kNcOKbXujGwKq8Ch8Qlo/Q9AQSAHRs0rIDzfhH9WYgbYiyJ11wKSANiUVl/NxkHNdTHD
         GPlxD60EaxDSQ2AE3TQke5DacvA0LffqjMQKmiseKhqRVsmOjaLLIDPFnhKPQ+x5GgsP
         +ihA==
X-Gm-Message-State: AIVw112ugGM3zDRF/YvJcYSoEqRBT3JnWD0vLH6PirlqQCWwgw7+Obao
        os2147hnEZ0SagGGxNk=
X-Received: by 10.36.130.68 with SMTP id t65mr12597229itd.56.1501022893143;
        Tue, 25 Jul 2017 15:48:13 -0700 (PDT)
Received: from [192.168.1.6] (d24-150-81-207.home.cgocable.net. [24.150.81.207])
        by smtp.googlemail.com with ESMTPSA id 77sm2961417itw.3.2017.07.25.15.48.12
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jul 2017 15:48:12 -0700 (PDT)
Subject: [PATCH v2] contrib/rerere-train: optionally overwrite existing
 resolutions
To:     git@vger.kernel.org
References: <1caa9bb1-9184-7335-a041-6abd2c8f616c@gmail.com>
 <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
From:   Raman Gupta <rocketraman@gmail.com>
Message-ID: <ae4d9b77-c47e-199b-d40f-ad5b49c5dd60@gmail.com>
Date:   Tue, 25 Jul 2017 18:48:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp6wtdu0.fsf@gitster.mtv.corp.google.com>
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
 contrib/rerere-train.sh | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
index 52ad9e4..e25bf8a 100755
--- a/contrib/rerere-train.sh
+++ b/contrib/rerere-train.sh
@@ -3,10 +3,38 @@
 # Prime rerere database from existing merge commits
 
 me=rerere-train
-USAGE="$me rev-list-args"
 
 SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
+OPTS_SPEC="\
+$me [--overwrite] <rev-list-args>
+--
+h,help        show the help
+o,overwrite   overwrite any existing rerere cache
+"
+eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
+
+overwrite=0
+
+while test $# -gt 0
+do
+	opt="$1"
+	case "$opt" in
+	-o)
+		overwrite=1
+		shift
+		shift
+		;;
+	--)
+		shift
+		break
+		;;
+	*)
+		break
+		exit 1
+		;;
+	esac
+done
+
 . "$(git --exec-path)/git-sh-setup"
 require_work_tree
 cd_to_toplevel
@@ -34,6 +62,10 @@ do
 		# Cleanly merges
 		continue
 	fi
+	if [ $overwrite == 1 ]
+	then
+		git rerere forget .
+	fi
 	if test -s "$GIT_DIR/MERGE_RR"
 	then
 		git show -s --pretty=format:"Learning from %h %s" "$commit"
-- 
2.9.4


