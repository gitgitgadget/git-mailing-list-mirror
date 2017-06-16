Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD4120D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 17:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdFPRjF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 13:39:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32973 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbdFPRjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 13:39:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so7262136wrb.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2P+RqXbDusNoMr8BmUn1G/OokvXsn1+LMBHRswNeaY=;
        b=kf0BAp0iUdF+3PIau4clC2pawrC1xEixGZaU87PorOHUw0580hPpwNfoEnbGs1vUYJ
         zTzy10td4qRMx16Dr7cqyV0eMBlOi9uPOVvHulQXYxqdX46BiA6kpwch6CmESSd6I80U
         ynxE0RkBqW5XRCXm64pU+Ukzha9Ir0NTkT+Yqs1o4Gibe+K5zsO+sX98wYh6NmwJLilL
         cbVdBmOZvXwxv0QbTgXsAwYkJOEMv87J2nTsF81RNdwjp7Pdx4AE8Lpurkesq2eQAZSf
         gDEG0M14I3FgtymPHIiM/sALMwzyHXBybA33m4kmXlflX7fapy56t9tS6GABoUALNsFt
         IRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2P+RqXbDusNoMr8BmUn1G/OokvXsn1+LMBHRswNeaY=;
        b=qo1V/etGWB+ia1cOdY7HIJ/RaoGKvNznDQ1JXbViNicCDVNwGcewGqIITP+gT+TiLg
         SNbp2FBL/izJxDs7bhAAb7d9X/AgbDbdgCkoOU4T9fl4p7MNsdZHbpWZtfyMsS6CK0l1
         qmGk4NMx4l65UVoochkktwso8RtNDLrgWED1yMDxR72E5SnVqX1VnlUhDIW0XuTbmttK
         0AUqs79HduxST9LMsqKaQxaTQV1Sg86uBLsxdBLVIWr1G6iBggFynW48aZqWtGR/jdwu
         8Yc4Qp1N546sTNEAVdHZvf331k2yyVCI0G/L/u5pIFeqoi8nVytNCGFxyChmInK+9s3s
         8bLw==
X-Gm-Message-State: AKS2vOwx2jglI3Tc3STzA2YiLF3L+oPk/SExmQqT7JZJeVT2f61oVGuE
        EH30eBE55Cqba8pV
X-Received: by 10.223.161.154 with SMTP id u26mr7988411wru.191.1497634741624;
        Fri, 16 Jun 2017 10:39:01 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id e14sm3785438wmi.16.2017.06.16.10.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 10:39:01 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv5 0/2] clone: respect additional configured fetch refspecs during initial fetch
Date:   Fri, 16 Jun 2017 19:38:47 +0200
Message-Id: <20170616173849.8071-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.505.g7cc9fcafb
In-Reply-To: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Only small, straightforward adjustments, mostly based on Jonathan's
comments.

The one exception is passing the default refspec using
strbuf_detach(), because add_fetch_refspec() doesn't make a copy of it
internally.  It doesn't make any difference in practice, because
strbuf default_refspec remains unaltered til the very end, but this is
the right thing to do.

SZEDER Gábor (2):
  clone: respect additional configured fetch refspecs during initial
    fetch
  Documentation/clone: document ignored configuration variables

 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             | 36 ++++++++++++++++++----------------
 remote.c                    | 13 +++++++++++++
 remote.h                    |  1 +
 t/t5611-clone-config.sh     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.13.1.505.g7cc9fcafb



diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4f1e7d4ba..5ceccb258 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -186,10 +186,11 @@ objects from the source repository into a pack in the cloned repository.
 	values are given for the same key, each value will be written to
 	the config file. This makes it safe, for example, to add
 	additional fetch refspecs to the origin remote.
-	Note that due to limitations of the current implementation some
-	configuration variables don't take effect during the initial
-	fetch and checkout.  Configuration variables known to not take
-	effect are: `remote.<name>.mirror` and `remote.<name>.tagOpt`.
++
+Due to limitations if the current implementation, some configuration
+variables do not take effect until after the initial fetch and checkout.
+Configuration variables known to not take effect are:
+`remote.<name>.mirror` and `remote.<name>.tagOpt`.
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
diff --git a/builtin/clone.c b/builtin/clone.c
index 4157922d8..8a7edd4e5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -853,7 +853,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, default_refspec = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT;
+	struct strbuf default_refspec = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
@@ -987,7 +988,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	remote = remote_get(option_origin);
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
 		    branch_top.buf);
-	add_and_parse_fetch_refspec(remote, default_refspec.buf);
+	add_and_parse_fetch_refspec(remote,
+				    strbuf_detach(&default_refspec, NULL));
 
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 114b53920..f240b22cc 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -43,7 +43,8 @@ test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
 	git update-ref refs/leave/out refs/heads/master &&
 	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
 	git -C child for-each-ref --format="%(refname)" >actual &&
-	cat >expect <<-EOF &&
+
+	cat >expect <<-\EOF &&
 	refs/grab/it
 	refs/heads/master
 	refs/remotes/origin/HEAD
@@ -56,7 +57,8 @@ test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
 	rm -rf child &&
 	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
 	git -C child for-each-ref --format="%(refname)" >actual &&
-	cat >expect <<-EOF &&
+
+	cat >expect <<-\EOF &&
 	refs/grab/it
 	refs/heads/master
 	refs/remotes/origin/HEAD
@@ -72,7 +74,8 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 		-c "remote.origin.fetch=+refs/leave/*:refs/leave/*" \
 		. child &&
 	git -C child for-each-ref --format="%(refname)" >actual &&
-	cat >expect <<-EOF &&
+
+	cat >expect <<-\EOF &&
 	refs/grab/it
 	refs/heads/master
 	refs/remotes/upstream/HEAD
