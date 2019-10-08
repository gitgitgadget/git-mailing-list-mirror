Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B101F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 17:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJHRit (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 13:38:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46587 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHRit (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 13:38:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so20357545wrv.13
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nYCjhgETESZl2C8wJWVeOP+sm0m+1DLlWjE5MNbNb+k=;
        b=RgTJN/ahmoF+pyv8Ihss4fjr/5Y5eAmCiB9xeeXHhu37YWxTXHFJQntXH6jViF9R8+
         Z/fCS9qsh7rnBH210Q7GB0WY5CVbOppQ0urWKOlmtmfRCS/ZojrXCkeuM5qk6dRttN12
         sHclM0WURuFzye/NHkG15TXu10+HHy+2F16s8Cousdc5Jll5GhvFPejZvwnBG12IvjUM
         wrC4OGvJTX5ME/RCKkVQJRBmiXRN6MKMGStuErR+ap721UDYDZGlAveHGJPWFFkHl5a2
         sCeyBphbY564WXcyjo6dIZdKmsmRxz7qyDtuUHBkg2WltUb+uKJMtJzE5rNRL/S7Wujl
         TJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nYCjhgETESZl2C8wJWVeOP+sm0m+1DLlWjE5MNbNb+k=;
        b=EegQbMcwaBgq4b4Dijg7iLFJsBjV+ZpwYVRg4BK8vgxLslkm27anpgQPHV/IrKywME
         Ev6afqoqf4cwNp2sY9PdREDPFctLN+J5HXc9LCbJCWHOMSZASx0zzI2C7+IXZMIWhua/
         yv3Jzqg8e9utHhr79OxPe5PdpEB4m5+NojkYGjKuv9up7FsY+cVT7pMd33Jq0MmHQzn5
         q4S49HZ0ONnDqX96W2U8uUNa0H+aA+Ox7QgTTe7EHP990h6dM5VZ9LsaqS5xYSm+wEwE
         F4dajOV7+fQMJq79aintuFIq2RFsqs1KcrR0xaBouXgFPBzfTDom7S5b4zlQgKnf3e0R
         oRFg==
X-Gm-Message-State: APjAAAWp98rzlQTMKIntEpZpCrg8+rbYiZ/21op7RXz4nyN2Z1hXHxN6
        Y9ZdRn5/tBWCEpswhNDFzf3mCwB8
X-Google-Smtp-Source: APXvYqyLAbyK8vKX8KMLzSBPrKCdXBkpTvcy9meMM0f1IeIsvCp3F9c71DdibXRsk/W1YcgX+5A+Ig==
X-Received: by 2002:a5d:51ca:: with SMTP id n10mr17519091wrv.377.1570556325791;
        Tue, 08 Oct 2019 10:38:45 -0700 (PDT)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id y19sm7524219wmi.13.2019.10.08.10.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 10:38:44 -0700 (PDT)
Date:   Tue, 8 Oct 2019 18:38:43 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        entwicklung@pengutronix.de
Subject: [PATCH v2] range-diff: don't segfault with mode-only changes
Message-ID: <20191008173843.GC74671@cat>
References: <20191007110645.7eljju2h6g7ts7lf@pengutronix.de>
 <20191007134831.GA74671@cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191007134831.GA74671@cat>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ef283b3699 ("apply: make parse_git_diff_header public", 2019-07-11)
the 'parse_git_diff_header' function was made public and useable by
callers outside of apply.c.

However it was missed that its (then) only caller, 'find_header' did
some error handling, and completing 'struct patch' appropriately.

range-diff then started using this function, and tried to handle this
appropriately itself, but fell short in some cases.  This in turn
would lead to range-diff segfaulting when there are mode-only changes
in a range.

Move the error handling and completing of the struct into the
'parse_git_diff_header' function, so other callers can take advantage
of it.  This fixes the segfault in 'git range-diff'.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Thanks Junio and Dscho for your reviews.  I decided to lift the whole
error handling behaviour from find_header into parse_git_diff_header,
instead of just filling the two names with xstrdup(def_name) if
(!old_name && !new_name && !!def_name).  I think the additional
information presented there can be useful.  For example we would have
gotten some "error: git diff header lacks filename information"
instead of a segfault for the problem described in
https://public-inbox.org/git/20191002141615.GB17916@kitsune.suse.cz/T/#me576615d7a151cf2ed46186c482fbd88f9959914.

Dscho, I didn't re-use your test case here as I had already written
one, and think what I have is slightly nicer in that it follows what
most other range-diff tests do in using the fast-exported history.  It
also expands the test coverage slightly, as we currently don't have
any coverage of the mode-change header, but will with this test.

The downside is of course that the fast export script is harder to
understand than the test you had, at least for me, but I think the
tradeoff of having the additional test coverage, and having it similar
to the rest of the test script is worth it.  If you strongly prefer
your test though I'm not going to be unhappy to use that :)

 apply.c                | 43 +++++++++++++++++++++---------------------
 t/t3206-range-diff.sh  | 40 +++++++++++++++++++++++++++++++++++++++
 t/t3206/history.export | 31 +++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 22 deletions(-)

diff --git a/apply.c b/apply.c
index 57a61f2881..f8a046a6a5 100644
--- a/apply.c
+++ b/apply.c
@@ -1361,11 +1361,32 @@ int parse_git_diff_header(struct strbuf *root,
 			if (check_header_line(*linenr, patch))
 				return -1;
 			if (res > 0)
-				return offset;
+				goto done;
 			break;
 		}
 	}
 
+done:
+	if (!patch->old_name && !patch->new_name) {
+		if (!patch->def_name) {
+			error(Q_("git diff header lacks filename information when removing "
+				 "%d leading pathname component (line %d)",
+				 "git diff header lacks filename information when removing "
+				 "%d leading pathname components (line %d)",
+				 parse_hdr_state.p_value),
+			      parse_hdr_state.p_value, *linenr);
+			return -128;
+		}
+		patch->old_name = xstrdup(patch->def_name);
+		patch->new_name = xstrdup(patch->def_name);
+	}
+	if ((!patch->new_name && !patch->is_delete) ||
+	    (!patch->old_name && !patch->is_new)) {
+		error(_("git diff header lacks filename information "
+			"(line %d)"), *linenr);
+		return -128;
+	}
+	patch->is_toplevel_relative = 1;
 	return offset;
 }
 
@@ -1546,26 +1567,6 @@ static int find_header(struct apply_state *state,
 				return -128;
 			if (git_hdr_len <= len)
 				continue;
-			if (!patch->old_name && !patch->new_name) {
-				if (!patch->def_name) {
-					error(Q_("git diff header lacks filename information when removing "
-							"%d leading pathname component (line %d)",
-							"git diff header lacks filename information when removing "
-							"%d leading pathname components (line %d)",
-							state->p_value),
-						     state->p_value, state->linenr);
-					return -128;
-				}
-				patch->old_name = xstrdup(patch->def_name);
-				patch->new_name = xstrdup(patch->def_name);
-			}
-			if ((!patch->new_name && !patch->is_delete) ||
-			    (!patch->old_name && !patch->is_new)) {
-				error(_("git diff header lacks filename information "
-					     "(line %d)"), state->linenr);
-				return -128;
-			}
-			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
 		}
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ec548654ce..5b87fead2e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -226,6 +226,46 @@ test_expect_success 'renamed file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'file with mode only change' '
+	git range-diff --no-color --submodule=log topic...mode-only-change >actual &&
+	sed s/Z/\ /g >expected <<-EOF &&
+	1:  fccce22 ! 1:  4d39cb3 s/4/A/
+	    @@ Metadata
+	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
+	    Z
+	    Z ## Commit message ##
+	    -    s/4/A/
+	    +    s/4/A/ + add other-file
+	    Z
+	    Z ## file ##
+	    Z@@
+	    @@ file
+	    Z A
+	    Z 6
+	    Z 7
+	    +
+	    + ## other-file (new) ##
+	2:  147e64e ! 2:  26c107f s/11/B/
+	    @@ Metadata
+	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
+	    Z
+	    Z ## Commit message ##
+	    -    s/11/B/
+	    +    s/11/B/ + mode change other-file
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	    @@ file: A
+	    Z 12
+	    Z 13
+	    Z 14
+	    +
+	    + ## other-file (mode change 100644 => 100755) ##
+	3:  a63e992 = 3:  4c1e0f5 s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'file added and later removed' '
 	git range-diff --no-color --submodule=log topic...added-removed >actual &&
 	sed s/Z/\ /g >expected <<-EOF &&
diff --git a/t/t3206/history.export b/t/t3206/history.export
index 7bb3814962..4c808e5b3b 100644
--- a/t/t3206/history.export
+++ b/t/t3206/history.export
@@ -55,7 +55,7 @@ A
 19
 20
 
-commit refs/heads/topic
+commit refs/heads/mode-only-change
 mark :4
 author Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
 committer Thomas Rast <trast@inf.ethz.ch> 1374485014 +0200
@@ -678,3 +678,32 @@ s/12/B/
 from :55
 M 100644 :9 renamed-file
 
+commit refs/heads/mode-only-change
+mark :57
+author Thomas Rast <trast@inf.ethz.ch> 1374485024 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1570473767 +0100
+data 24
+s/4/A/ + add other-file
+from :4
+M 100644 :5 file
+M 100644 :49 other-file
+
+commit refs/heads/mode-only-change
+mark :58
+author Thomas Rast <trast@inf.ethz.ch> 1374485036 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1570473768 +0100
+data 33
+s/11/B/ + mode change other-file
+from :57
+M 100644 :7 file
+M 100755 :49 other-file
+
+commit refs/heads/mode-only-change
+mark :59
+author Thomas Rast <trast@inf.ethz.ch> 1374485044 +0200
+committer Thomas Gummerer <t.gummerer@gmail.com> 1570473768 +0100
+data 8
+s/12/B/
+from :58
+M 100644 :9 file
+
-- 
2.23.0.501.gb744c3af07

