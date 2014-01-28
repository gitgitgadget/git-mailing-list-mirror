From: David Sharp <dhsharp@google.com>
Subject: [PATCH v2] rev-parse: Check argc before using argv[i+1]
Date: Tue, 28 Jan 2014 13:21:00 -0800
Message-ID: <1390944060-783-1-git-send-email-dhsharp@google.com>
References: <CAJL_ekuMJByFDVLMCYD4fo9EQy3LKdohsw25WfHqJv9M=3S9Kw@mail.gmail.com>
Cc: David Sharp <dhsharp@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 28 22:21:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8G5v-0001Ki-1m
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 22:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbaA1VVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 16:21:13 -0500
Received: from mail-ie0-f201.google.com ([209.85.223.201]:65212 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539AbaA1VVL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 16:21:11 -0500
Received: by mail-ie0-f201.google.com with SMTP id tp5so200624ieb.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 13:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u8afgcLzkj+qJIBgI5AIV+NY/NyqFvCpMtDT5zKRGdk=;
        b=XMKUVt31Oj3gbP58mCprq9Ucp6FSDko3SU9RP3iPNb2dXIh9ty+h6f0U0MqSPTkg63
         yDzqeMnfvjGHKDyOZ64AHgiuZG+h03bU6lYloVS9/cmbS6nNwmuJRv/tzQO8uHGyXAna
         PbB74pR0udnalf6AKpBbU2/ECRRl6Ug+afkhz/Le9qZl6++zNpXcfG9dYKaoYGwrfeX0
         GiXhOlruWYog55+TuaRvqieR/fh04O7IxQ96Roy7pT7MrLUXm9hIQWuVWcPepInbLywI
         1nV9Nia9t5pEbREQDLXpL/BgZ/C4q7yhAeDx1nMz3AEhJNDwFvtG0e1slq9NtrEMyABW
         nLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u8afgcLzkj+qJIBgI5AIV+NY/NyqFvCpMtDT5zKRGdk=;
        b=R1L5DI+cm7ich102nc7vCqod0P0QKTSfMS1pSajXLKSvvofceO0eZGrnARBLNi9OEA
         rmiBbUU+dkbTxoRR5h61Ki90oGGPYtHRVIT+B80K1/S+jDLta67w1JS3ghq7a2vdJ/W/
         UX2kmysKRxY3iJDcpftB/CGlMndRGbr5WfU4o1srT2kWprWpW62JmUeKhnI3Q6pwJip6
         hnQ3q7hGt2/m5OHE8167qEffOgstZ3QOyV1ijllBt7y5iWzz2qxPb4bTxnAEansPb/4d
         xCq+7jj5jG62Ilf9yMDcjXGrZbt8/+rWe4ef6RsJLVu1WTXZyonbGWgfySZlAPdXUXMH
         iwzg==
X-Gm-Message-State: ALoCoQmsASWUm+O72Xo0Q1FpVRGJVOX2CZW4KSvubFRh6Ja5DzaJyGUyJ5tod9FIxid0caNWx3g5OQAeQ7CvGJ67ITtMDY+qa2nANMnvj+JEYGDMhZ65ID+pAsnDbmsvrjonSa7ucAxBP62pW4kRBRJ30IWqACN2LaayXMzei+/n2T2EcKhEd0JSSa1wAqQZvTtewS7ElpYU
X-Received: by 10.42.70.142 with SMTP id f14mr1226203icj.6.1390944071010;
        Tue, 28 Jan 2014 13:21:11 -0800 (PST)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i24si868756yhe.6.2014.01.28.13.21.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2014 13:21:10 -0800 (PST)
Received: from celeritas2.mtv.corp.google.com (celeritas2.mtv.corp.google.com [172.17.130.39])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CD32E31C1AD;
	Tue, 28 Jan 2014 13:21:10 -0800 (PST)
Received: by celeritas2.mtv.corp.google.com (Postfix, from userid 59422)
	id 70A541E048C; Tue, 28 Jan 2014 13:21:10 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <CAJL_ekuMJByFDVLMCYD4fo9EQy3LKdohsw25WfHqJv9M=3S9Kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241192>

Without this patch, git-rev-parse --prefix, --default, or
--resolve-git-dir, without a value argument, would result in a segfault.
Instead, die() with a message.

Signed-off-by: David Sharp <dhsharp@google.com>
---
 builtin/rev-parse.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index aaeb611..45901df 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -547,15 +547,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--default")) {
-				def = argv[i+1];
-				i++;
+				def = argv[++i];
+				if (!def)
+					die("--default requires an argument");
 				continue;
 			}
 			if (!strcmp(arg, "--prefix")) {
-				prefix = argv[i+1];
+				prefix = argv[++i];
+				if (!prefix)
+					die("--prefix requires an argument");
 				startup_info->prefix = prefix;
 				output_prefix = 1;
-				i++;
 				continue;
 			}
 			if (!strcmp(arg, "--revs-only")) {
@@ -738,9 +740,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
-				const char *gitdir = resolve_gitdir(argv[i+1]);
+				const char *gitdir = argv[++i];
 				if (!gitdir)
-					die("not a gitdir '%s'", argv[i+1]);
+					die("--resolve-git-dir requires an argument");
+				gitdir = resolve_gitdir(gitdir);
+				if (!gitdir)
+					die("not a gitdir '%s'", argv[i]);
 				puts(gitdir);
 				continue;
 			}
-- 
1.8.5.3
