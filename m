Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41BC2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A9123B6B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgLRPfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgLRPfn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 10:35:43 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDCCC0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:35:03 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w3so2204498otp.13
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=I+GIhOFqSBKmqsYnMrpVQ1uXi00YrBZWMRbNw7eUiAM=;
        b=JtDNEQEkg7DiiwacctrnN2qYjQP9ilwGPS46WEpgdWlVfiRJy7YG02GwyFUztKTJ9W
         xR72SVml3WIBzj5VI4X5K32zNMkIaLbCRjVvMecBk0Y0bUqbd/GH/SYxYnkEkhociV2r
         IPkSrNdNcVAfBc9tfFCrAENLQ0Za8qGcyumo4Ec3yJq9F1GaEpG+VKOi0EbIL3+4+1e+
         zzRJZR/aYZMdGhx3C28Wh3pqdDR3ABtGgcGsWtRQrwDQEn5clc0PEJ7ya5gAWgv/247L
         v8yLzqMjsRE6Xmx/+n+6cXRkfom5gM9XyXXq9BYzlDmKHOU+BqDXXjZMIZ2MZYwFaH6E
         cdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=I+GIhOFqSBKmqsYnMrpVQ1uXi00YrBZWMRbNw7eUiAM=;
        b=NB4Su7rdCEX3xuEJ1Ff1cggQwvD6hC1Whb1sONJ8n0DDfIcAGAagXQA/8CU3U49vhT
         AQ0+20dPdO4mBqQU/XE3Ph8kRAR8nwUEXofKuQg8oKd6TUXtArkDWDYtVHx5YN4lMNbB
         Td/RiMBV6pic0uGpohegO4B79MtiO846EYUQT0EC1MbwYs83kg1ZAyJuQ7ZrThRyjykQ
         yXM/wch92rovTevWlbLzZlpwbdo4XZVpURLUiAKN0ma8RF3mI2GEigvAoW1CQU/+5LW0
         yh8neV8lE7ZrMQJygvz6lsHFwr0Uk99p7rS7xsBApdB7sjazhXJE8IJbFUFtD931R8TY
         U2/Q==
X-Gm-Message-State: AOAM532tfnzoTBXue+A/4q7QWDmKm+Kisv1HLq9Vs5jtYUZrkRiAeExJ
        QjhTt2bS0ewB5nPO9/VlSe9B53EqJ7xdSg==
X-Google-Smtp-Source: ABdhPJyt/zmznZPB9d8UBiHUUve1tW1jkZQVWj9uqAqu4z/mv8iCybig1T7xtFUapLqyWO+lUgk6WQ==
X-Received: by 2002:a05:6830:1308:: with SMTP id p8mr3175044otq.330.1608305702884;
        Fri, 18 Dec 2020 07:35:02 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m18sm1976191ooa.24.2020.12.18.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 07:35:02 -0800 (PST)
Date:   Fri, 18 Dec 2020 09:35:01 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Ed Avis <ed.avis@qmaw.com>, git@vger.kernel.org
Message-ID: <5fdccc25255b7_1273af2086c@natae.notmuch>
In-Reply-To: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
References: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
Subject: RE: Feature request: 'git bisect run' option to redundantly check
 start and end commits
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Avis wrote:
> When kicking off a 'git bisect run', I have manually chosen good and
> bad commits, but I would like to double check that the command given
> to run really does succeed for the good commit and fail for the bad
> one.  Of course I can switch to those commits and run it manually, but
> mistakes can happen.  It's frustrating to set up a bisection and then
> find at the end that the first bad commit is the one immediately after
> 'good', because the command string just failed every time.  An
> optional startup check of the two endpoints would only be a small
> slowdown in most cases, but could save a lot of time.

I like this idea.

I for one have to think twice if I should do the extra check manually or
not, and the biggest reason why I usually don't is because it would not
be automated.

With an option like that I would have no excuse.

Here's a quick patch to implement such feature (it doesn't apply
directly, it's mostly for human eyes).

diff --git a/git-bisect.sh b/git-bisect.sh
index 1f3f6e9fc5..e8adeab008 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -109,13 +109,7 @@ bisect_replay () {
 	git bisect--helper --bisect-auto-next || exit
 }
 
-bisect_run () {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
-
-	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
-
-	while true
-	do
+run_command () {
 	command="$@"
 	eval_gettextln "running \$command"
 	"$@"
@@ -140,6 +134,41 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 	else
 		state="$TERM_GOOD"
 	fi
+}
+
+run_check () {
+	rev=$1
+	term=$2
+	shift 2
+	git checkout $rev
+	run_command "$@"
+	echo "# recheck $term ($state): $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
+	[[ "$state" != "$term" ]] &&
+	die "$(eval_gettext "check failed, expected \$rev to be \$term")"
+}
+
+bisect_run () {
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
+
+	if [ "$1" = "--recheck" ]
+	then
+		shift
+		test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
+
+		rev=$(git show-ref --hash --verify refs/bisect/$TERM_BAD)
+		run_check $rev "$TERM_BAD" "$@"
+
+		rev=$(git for-each-ref --format="%(objectname)" "refs/bisect/$TERM_GOOD-*")
+		run_check $rev "$TERM_GOOD" "$@"
+
+		git bisect--helper --bisect-next || exit
+	else
+		test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
+	fi
+
+	while true
+	do
+		run_command "$@"
 
 		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
 		res=$?

-- 
Felipe Contreras
