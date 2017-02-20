Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEA7201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 11:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdBTLp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 06:45:59 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34460 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdBTLp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 06:45:57 -0500
Received: by mail-lf0-f68.google.com with SMTP id h67so592970lfg.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 03:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tup+z4OGUWgJ7WRSulUrH1RA+Gt6ecWL3obMdlwtPgM=;
        b=DBMnRGIxNbDOri2SFJs7+KH7LADfprUb52xjjb23UAcB8ZAenAeqI8MgxsDms9w+kR
         p9FaK6KTgMjoxe3eMBT1b6v+1sgb90El3LpomNYQMLTye4hxGCmxZBghKiTJBVIHVcYr
         IYO1d9Y2i5wEzPyJ0XbbdYJSEAnVzgw0eXkNhNe0DeR0daqtqGZeE2EoQFKDgyOp0vEy
         vCbjM1tmC0Jbgh9K8vzhQEXIM+DzunHvsxitQkptpe1tP27e6qwX+CubXRRd0BQ4vPNQ
         2DNYzV9QFvUnFn/SLTsLyY/2innLkHh6LQR0wlN4EvXNffM93guwnjOkIgw2uYUkIYMc
         TTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Tup+z4OGUWgJ7WRSulUrH1RA+Gt6ecWL3obMdlwtPgM=;
        b=Q0GdNuGirDbrmRSNpogtxOfxeCbV/wW1VkzkOf8paErEDHG7Eul992NJkGtNVE2LMJ
         YWv1UB+fbnF6fdyIXyMK0oU2uZaxPeKdgw+ca5RqW3IVmZzUEoqaiq73wGgukz//DVjP
         +OmDpWsMiuQJfCHSdWRbTA3lUOC5Nyzj53NGEQkBr4X98GJFlby4jg1NUrhhBo9Qpc1d
         KNmpwaSguOygBpAccD4+RXKtfKnW6V/PwUAnG1OOCIFUBA+qbAOwCPiq0u/E2eHvQCrw
         CPFn7IHh1eSMWmp4CvEv/Hlp+3zG8lQNkRQRrGD8VM4hL1jGuBBa/YwkA025jlsunqo8
         mnoQ==
X-Gm-Message-State: AMke39klsJy96Zn0GPDTFAgmzLoNIXDWhAIx8uYzsQKcHszoET9limR5yfX8IMrtrR7aDw==
X-Received: by 10.25.29.211 with SMTP id d202mr2425889lfd.152.1487591126201;
        Mon, 20 Feb 2017 03:45:26 -0800 (PST)
Received: from xi.terra ([84.216.234.102])
        by smtp.gmail.com with ESMTPSA id y21sm5206550lfj.19.2017.02.20.03.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2017 03:45:25 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.88)
        (envelope-from <johan@xi.terra>)
        id 1cfmPB-00054E-VE; Mon, 20 Feb 2017 12:45:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>, git@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] send-email: only allow one address per body tag
Date:   Mon, 20 Feb 2017 12:44:06 +0100
Message-Id: <20170220114406.19436-1-johan@kernel.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <xmqqbmu0pgg6.fsf@gitster.mtv.corp.google.com>
References: <xmqqbmu0pgg6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding comments after a tag in the body is a common practise (e.g. in
the Linux kernel) and git-send-email has been supporting this for years
by removing any trailing cruft after the address.

After some recent changes, any trailing comment is now instead appended
to the recipient name (with some random white space inserted) resulting
in undesirable noise in the headers, for example:

CC: "# 3 . 3 . x : 1b9508f : sched : Rate-limit newidle" <stable@vger.kernel.org>

Revert to the earlier behaviour of discarding anything after the (first)
address in a tag while parsing the body.

Note that multiple addresses after are still allowed after a command
line switch (and in a CC header field).

Also note that --suppress-cc=self was never honoured when using multiple
addresses in a tag.

Fixes: b1c8a11c8024 ("send-email: allow multiple emails using --cc, --to
and --bcc")
Fixes: e3fdbcc8e164 ("parse_mailboxes: accept extra text after <...>
address")
Signed-off-by: Johan Hovold <johan@kernel.org>
---

v2:
 - update the cc-trailer test
 - amend commit message and mention the broken --suppress-cc=self


 git-send-email.perl   | 2 +-
 t/t9001-send-email.sh | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 068d60b3e698..eea0a517f71b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1563,7 +1563,7 @@ foreach my $t (@files) {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^(Signed-off-by|Cc): (.*)$/i) {
+		if (/^(Signed-off-by|Cc): ([^>]*>?)/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0f398dd1603d..60a80f60b268 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -148,7 +148,6 @@ cat >expected-cc <<\EOF
 !two@example.com!
 !three@example.com!
 !four@example.com!
-!five@example.com!
 EOF
 "
 
@@ -159,9 +158,9 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	Test Cc: trailers.
 
 	Cc: one@example.com
-	Cc: <two@example.com> # this is part of the name
-	Cc: <three@example.com>, <four@example.com> # not.five@example.com
-	Cc: "Some # Body" <five@example.com> [part.of.name.too]
+	Cc: <two@example.com> # trailing comments are ignored
+	Cc: <three@example.com>, <not.four@example.com> one address per line
+	Cc: "Some # Body" <four@example.com> [ <also.a.comment> ]
 	EOF
 	clean_fake_sendmail &&
 	git send-email -1 --to=recipient@example.com \
-- 
2.11.1

