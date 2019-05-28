Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7324C1F462
	for <e@80x24.org>; Tue, 28 May 2019 10:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfE1KPu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 06:15:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40856 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE1KPt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 06:15:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so2173053wmg.5
        for <git@vger.kernel.org>; Tue, 28 May 2019 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIilD2h+rJxC1cEUBaYeomm8wkJL8izBxnYEbDXFHAE=;
        b=AWaUsI+yl2B1aaMx77N55qOWslxa+9VEHl8Z/RJ3FH5lU3I1KUCLc++0MMm8MkUMlD
         VMjj5TMspo/XxhC1L+iEPR5MuZFD4adQYxz6ZFwMWVn7vKYZkby2ehYT3ZNHCZp5gwEN
         h5Nkl9+qYRxUbhrhPazwXrCX5UkSFhjTz2O/vuzzWqG7xZvAFNfjLgtUTUfV9z+Npq65
         yALBn52Wakq0YJGJDR0JLqXEegfrn2SgM9OFKpHbjOHo4jbIJKvGIsElkSKvqvr7lhdx
         jhPmrtcsyyruV3MJU6+7CUBxeCc1rO51E7X+wWpDwL/kdwx5ahvcDVjh+qgMkW41qiQZ
         nAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eIilD2h+rJxC1cEUBaYeomm8wkJL8izBxnYEbDXFHAE=;
        b=bM8aall2uzV/A0cAE4IReZzp8ioe0r77jmjmhii8aUjKQOPvr13kvJrTnw65bPqd7s
         /SsDxZLbRPIgDtZLDwzreMU9WtzLWrFCvTQoVfumAQ43+hRZ8olhcqhbSWX5DqrJT2dh
         u8yJ2IOVtv4E0UPRhgE2uvMXHoUJp8tiVrRygni5th6rKA7VrKZkyKpJoZeo7Xe2n3dk
         aI74AuaJQhIM64W0rOHHVgjx59QPH5aKkX1XKRm7EIly/ivEsBZQyMwiNgguIF7iFHdm
         Su5caB+xOFHpcB8QjRxDXz58mT1Efcd3erEGM2rgMY1A48W7/0ptsWtqfk9sTX5fRzsJ
         Sa5Q==
X-Gm-Message-State: APjAAAWPVReYLsO9So8X/2sPpNLbOf4muCyr2aAsfd9eLo/BWl9Kx9sp
        SGYVvBHQw5wi7DVjS+Fgl8nrhgnz
X-Google-Smtp-Source: APXvYqzyBz6+YA2FHdycTBV431gGaq3wLH9i2uKFCi2sCg4ErVW76jkSvm3A/WcraHWxWTR6+1MVXQ==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr2736358wmj.64.1559038547845;
        Tue, 28 May 2019 03:15:47 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:c43e:46a8:e962:cee8])
        by smtp.gmail.com with ESMTPSA id d9sm12339721wro.26.2019.05.28.03.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 03:15:46 -0700 (PDT)
From:   Paolo Bonzini <bonzini@gnu.org>
To:     git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] request-pull: quote regex metacharacters in local ref
Date:   Tue, 28 May 2019 12:15:42 +0200
Message-Id: <20190528101543.16094-2-bonzini@gnu.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528101543.16094-1-bonzini@gnu.org>
References: <20190528101543.16094-1-bonzini@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

The local part of the third argument of git-request-pull is used in
a regular expression without quoting it.  Use qr{} and \Q\E to ensure
that e.g. a period in a tag name does not match any character on the
remote side.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 git-request-pull.sh     |  5 ++---
 t/t5150-request-pull.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 13c172bd94..0d128be7fd 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -83,19 +83,18 @@ die "fatal: No commits in common between $base and $head"
 # Otherwise find a random ref that matches $headrev.
 find_matching_ref='
 	my ($head,$headrev) = (@ARGV);
+	my $pattern = qr{/\Q$head\E$};
 	my ($found);
 
 	while (<STDIN>) {
 		chomp;
 		my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
-		my ($pattern);
 		next unless ($sha1 eq $headrev);
 
-		$pattern="/$head\$";
 		if ($ref eq $head) {
 			$found = $ref;
 		}
-		if ($ref =~ /$pattern/) {
+		if ($ref =~ $pattern) {
 			$found = $ref;
 		}
 		if ($sha1 eq $head) {
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index fca001eb9b..c1a821a549 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -246,4 +246,22 @@ test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
 
 '
 
+test_expect_success 'request-pull quotes regex metacharacters properly' '
+
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git tag -mrelease v2.0 &&
+		git push origin refs/tags/v2.0:refs/tags/v2-0 &&
+		test_must_fail git request-pull initial "$downstream_url" tags/v2.0 \
+			2>../err
+	) &&
+	grep "No match for commit .*" err &&
+	grep "Are you sure you pushed" err
+
+'
+
 test_done
-- 
2.21.0


