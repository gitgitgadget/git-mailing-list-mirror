Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F5841F404
	for <e@80x24.org>; Sat, 31 Mar 2018 12:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeCaMvJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 08:51:09 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33689 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbeCaMvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 08:51:08 -0400
Received: by mail-wm0-f45.google.com with SMTP id o23so5134142wmf.0
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APzzMkuEzCTPXPpVOi7kEUAlrxuUSrJ2uX9QhNH2OGc=;
        b=QNeQNwDfceVX+cHOqCsEkrl5ZUssuiJROq+FJ+YN75URC6MX4ML2dn1VDpSqRguIzz
         DQ3UOBnS27PZZmd1lFHl2K02glpIyinkF9IWNzWnpLURHZmuhE7QjtYP0k9PZxzsz6Hp
         d7Igf6CGv3K6Yl1oAsma7H529jA4mNAGP+xTCM0Pti8M5zVhuwcQ+33XjOXU2dgMuvfe
         CRrdkG4YS7NIUMN/rWi/dyYvyuRY0iwAPzDuhOaQbqbtPCHNRmXmVKPbIO0fxmudPK88
         Mff34ayaNkniweQbvifkEhh2huZsqN/oX2qbUYd0grqtWiFErx+9tBnm+h2VLWyVTb5R
         m58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APzzMkuEzCTPXPpVOi7kEUAlrxuUSrJ2uX9QhNH2OGc=;
        b=R0HFQ78fgLDe0Sq5lY5v2/DPv2qDfJquXKfvQemaEtIl64sAZ/iIt1SZiSP92cpVT8
         5ZhJc5QHrKazw2wyKb1DCGWwXbI26bWLxNoBbnzC58eWn+vFRgIyARfq9JmlXeOeQ1SR
         PHQ4mBHIz/iSswdywuOpgIfR1Opc+z+sdsjXmlUxkzExV8IlbRgtN8uiwr5mU7XIKzQm
         2+t3IWFf2YSiIW7NPcdlgwnl2K3JvIAt2Fa4iBeGGbZuf6/ODGpyJPkApU+twsrccWyg
         Rt2SpPCwBqbhc01jLpz4YsL+U+fiL2N09sBDh7CBeueiNg8iuwrYaSMcP65mxjMHtW88
         ewKQ==
X-Gm-Message-State: AElRT7HG4VAwkVDjtc2egw9u15zjResIaU7/S1V7wltK0RAT+6wCkn8Z
        sj18Ryi1cDBIz8p5fk1Jv624e5wz
X-Google-Smtp-Source: AIpwx49YUzMbprIAGSEKv5iNbEwB0+Dlbaqy16zNutoYexyu54+FryNYtSZLg0CyrygYDwB4BEDC/g==
X-Received: by 10.28.138.69 with SMTP id m66mr5044576wmd.117.1522500666834;
        Sat, 31 Mar 2018 05:51:06 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b40sm26901817wrb.88.2018.03.31.05.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 05:51:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] add -p: fix 2.17.0-rc* regression due to moved code
Date:   Sat, 31 Mar 2018 12:50:58 +0000
Message-Id: <20180331125058.4506-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565
In-Reply-To: <20180331123605.30076-1-avarab@gmail.com>
References: <20180331123605.30076-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 88f6ffc1c2 ("add -p: only bind search key if
there's more than one hunk", 2018-02-13) which is present in
2.17.0-rc*, but not 2.16.0.

In Perl, regex variables like $1 always refer to the last regex
match. When the aforementioned change added a new regex match between
the old match and the corresponding code that was expecting $1, the $1
variable would always be undef, since the newly inserted regex match
doesn't have any captures.

As a result the "/" feature to search for a string in a hunk by regex
completely broke, on git.git:

    $ perl -pi -e 's/Git/Tig/g' README.md
    $ ./git --exec-path=$PWD add -p
    [..]
    Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? s
    Split into 4 hunks.
    [...]
    Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? /Many
    Use of uninitialized value $1 in string eq at /home/avar/g/git/git-add--interactive line 1568, <STDIN> line 1.
    search for regex? Many

I.e. the initial "/regex" command wouldn't work, and would always emit
a warning and ask again for a regex, now it works as intended again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Of course I just noticed the grammar errors in the commit message
after sending. Here's a v2 with that fixed, also genreated the patch
with -U6 to make it clear what's going on.

 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d190469cd8..c1f52e457f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1561,13 +1561,13 @@ sub patch_update_file {
 			elsif ($line =~ m|^/(.*)|) {
 				my $regex = $1;
 				unless ($other =~ m|/|) {
 					error_msg __("No other hunks to search\n");
 					next;
 				}
-				if ($1 eq "") {
+				if ($regex eq "") {
 					print colored $prompt_color, __("search for regex? ");
 					$regex = <STDIN>;
 					if (defined $regex) {
 						chomp $regex;
 					}
 				}
-- 
2.17.0.rc1.321.gba9d0f2565

