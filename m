Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B11C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE272068E
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWY5CYLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKTVSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40499 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so388275pfl.7
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b6LOaSWxTK1jOSeJo+C17Dxov4Wyr4HkbzrDMBMrjjU=;
        b=JWY5CYLZXZXnRQrirHCMPhAV3c6qxhpXKbgoeC7lRWpEQHEJ0QhJEQf+bx54ZYuL34
         qzyxyorroMx722ZtyEW53ZALZPjVuA6twCnzVMFmjJ03w2kqyPAkV8VPEQlQBEFEyEOO
         LxQtHClz5nWrHKAOJVNEaeYu5Jjm4K5ZctY3iYB49NuG+f0CM/XbOOch77yugh9vWqCI
         6FK2Zmw0orMv9X7PT/QHfVfLqva81Bqs3t9+zw8MR1JCXjl5xQxN42m6/EBrEvCtMWSe
         R7qT8qGa7b/gGx0UY1LWL/5m4ZaXkdZPovgHyvDnQHNjfdlbAYHN3dS+mp7mF3FbXgCE
         w6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b6LOaSWxTK1jOSeJo+C17Dxov4Wyr4HkbzrDMBMrjjU=;
        b=FC9EDVeHeursRMTrx0b4MVUBZbba7vZkwzZfiTCkFXA+SbGngWpkqOsDEci50arRml
         dDJA9KKJqOFIhXT9Vght2KHcbD+DIjZ3cxfjEd+ANdEvAYaYLZsT4ZWPsXv0C51+AYOP
         I4AfOScUbjRRfSRNaqXuKQYzOAjSyvBAqOi9h7MCgixQ/QY5KDcZg+8phPnOmmmdKTiE
         4tpqhaLSKny7jfS3/Edd5CN2HIpuN1bhU1GSXFf/xR8Xe0hn3W9NhGd8x++pXBlbgTiA
         Ip+ka5VQEKZEmWLzXl4+69DpCFhKDsNJ0Jib45m3KID0eQadGe+7i39TMTKAhTkq2usZ
         jahQ==
X-Gm-Message-State: APjAAAVl4xOE2pxJgsmEl6h6R6ZxqfmTlYJ2OcPWR48hgmAXFgIEoQYX
        Ppkevv4lV0tNik2Yl5n+CwDElWw/
X-Google-Smtp-Source: APXvYqxb0DH1hRwJvoWw3JWaKgdU0ZRkhghT5sEoCocFVYOW+jloAtSVQjCWUQFYHtfpqr5JcOGVrw==
X-Received: by 2002:a65:530d:: with SMTP id m13mr5415828pgq.172.1574284730012;
        Wed, 20 Nov 2019 13:18:50 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id v24sm318982pfn.53.2019.11.20.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:49 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:47 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 10/10] format-patch: pass notes configuration to range-diff
Message-ID: <86318b3fe7b53f5bad0f0094bc237afc74108ecc.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since format-patch accepts `--[no-]notes`, one would expect the
range-diff generated to also respect the setting. Unfortunately, the
range-diff we currently generate only uses the default option (which
always outputs default notes, even when notes are not being used
elsewhere).

Pass the notes configuration to range-diff so that it can honor it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c         |  24 +++++++++-
 t/t3206-range-diff.sh | 101 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 047ac4594d..e192f219d9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1111,6 +1111,25 @@ static void prepare_cover_text(struct pretty_print_context *pp,
 	strbuf_release(&subject_sb);
 }
 
+static int get_notes_refs(struct string_list_item *item, void *arg)
+{
+	argv_array_pushf(arg, "--notes=%s", item->string);
+	return 0;
+}
+
+static void get_notes_args(struct argv_array *arg, struct rev_info *rev)
+{
+	if (!rev->show_notes) {
+		argv_array_push(arg, "--no-notes");
+	} else if (rev->notes_opt.use_default_notes > 0 ||
+		   (rev->notes_opt.use_default_notes == -1 &&
+		    !rev->notes_opt.extra_notes_refs.nr)) {
+		argv_array_push(arg, "--notes");
+	} else {
+		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+	}
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1183,13 +1202,16 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		 * can be added later if deemed desirable.
 		 */
 		struct diff_options opts;
+		struct argv_array other_arg = ARGV_ARRAY_INIT;
 		diff_setup(&opts);
 		opts.file = rev->diffopt.file;
 		opts.use_color = rev->diffopt.use_color;
 		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
+		get_notes_args(&other_arg, rev);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, &opts, NULL);
+				rev->creation_factor, 1, &opts, &other_arg);
+		argv_array_clear(&other_arg);
 	}
 }
 
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 521b4a83ec..ec2b456dbb 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -576,7 +576,7 @@ test_expect_success 'range-diff with multiple --notes' '
 	test_cmp expect actual
 '
 
-test_expect_success 'format-patch --range-diff compares notes by default' '
+test_expect_success 'format-patch --range-diff does not compare notes by default' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
@@ -588,6 +588,40 @@ test_expect_success 'format-patch --range-diff compares notes by default' '
 	grep "= 1: .* s/5/A" 0000-* &&
 	grep "= 2: .* s/4/A" 0000-* &&
 	grep "= 3: .* s/11/B" 0000-* &&
+	grep "= 4: .* s/12/B" 0000-* &&
+	! grep "Notes" 0000-* &&
+	! grep "note" 0000-*
+'
+
+test_expect_success 'format-patch --range-diff with --no-notes' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git format-patch --no-notes --cover-letter --range-diff=$prev \
+		master..unmodified >actual &&
+	test_when_finished "rm 000?-*" &&
+	test_line_count = 5 actual &&
+	test_i18ngrep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
+	grep "= 4: .* s/12/B" 0000-* &&
+	! grep "Notes" 0000-* &&
+	! grep "note" 0000-*
+'
+
+test_expect_success 'format-patch --range-diff with --notes' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git format-patch --notes --cover-letter --range-diff=$prev \
+		master..unmodified >actual &&
+	test_when_finished "rm 000?-*" &&
+	test_line_count = 5 actual &&
+	test_i18ngrep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
 	grep "! 4: .* s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	    @@ Commit message
@@ -604,4 +638,69 @@ test_expect_success 'format-patch --range-diff compares notes by default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch --range-diff with --notes' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	test_config format.notes true &&
+	git format-patch --cover-letter --range-diff=$prev \
+		master..unmodified >actual &&
+	test_when_finished "rm 000?-*" &&
+	test_line_count = 5 actual &&
+	test_i18ngrep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
+	grep "! 4: .* s/12/B" 0000-* &&
+	sed s/Z/\ /g >expect <<-EOF &&
+	    @@ Commit message
+	    Z
+	    Z
+	    Z ## Notes ##
+	    -    topic note
+	    +    unmodified note
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	EOF
+	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format-patch --range-diff with multiple notes' '
+	git notes --ref=note1 add -m "topic note1" topic &&
+	git notes --ref=note1 add -m "unmodified note1" unmodified &&
+	test_when_finished git notes --ref=note1 remove topic unmodified &&
+	git notes --ref=note2 add -m "topic note2" topic &&
+	git notes --ref=note2 add -m "unmodified note2" unmodified &&
+	test_when_finished git notes --ref=note2 remove topic unmodified &&
+	git format-patch --notes=note1 --notes=note2 --cover-letter --range-diff=$prev \
+		master..unmodified >actual &&
+	test_when_finished "rm 000?-*" &&
+	test_line_count = 5 actual &&
+	test_i18ngrep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
+	grep "! 4: .* s/12/B" 0000-* &&
+	sed s/Z/\ /g >expect <<-EOF &&
+	    @@ Commit message
+	    Z
+	    Z
+	    Z ## Notes (note1) ##
+	    -    topic note1
+	    +    unmodified note1
+	    Z
+	    Z
+	    Z ## Notes (note2) ##
+	    -    topic note2
+	    +    unmodified note2
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	EOF
+	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.450.g7a9a4598a9

