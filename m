Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C121F453
	for <e@80x24.org>; Sun, 28 Oct 2018 00:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeJ1I7E (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 04:59:04 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:60844
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728697AbeJ1I7E (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Oct 2018 04:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1540685775;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Ks0YZxEorztvs7K9O+HP5iHojax0a8yY1BTRa05Lyws=;
        b=eEL8RMEu6cakgWjcg5Bu8cvnYJ9XPG3/Rhem1ARL1b0ICobJy6Q8gP0tvEkQPoVL
        T3SOD2xAg6Lgx5hZSD8OH0sIxhvQHqLF+exY8aD+2dsk2x8zidl0V/qY1kdQMjVWk5v
        YtVLvqdkrtFUVGuwEVw4GfbGGJYCvWMWvxuAgDtQ=
From:   Glenn Strauss <gstrauss@gluelogic.com>
To:     git@vger.kernel.org
Message-ID: <01020166b80743cd-0b220d55-a283-456b-a3c3-bdea8aafed8a-000000@eu-west-1.amazonses.com>
Subject: [PATCH] update git-http-backend doc for lighttpd
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 28 Oct 2018 00:16:15 +0000
X-SES-Outgoing: 2018.10.28-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

use "GIT_HTTP_EXPORT_ALL" => "1" with a value for best compatiblity.
lighttpd 1.4.51 setenv.add-environment does add vars with empty value.
lighttpd setenv.set-environment does, but was only introduced in 1.4.46

git-http-backend may be found at /usr/libexec/git-core/git-http-backend

scope lighttpd config directives for git-http-backend under "^/git"

Signed-off-by: Glenn Strauss <gstrauss@gluelogic.com>
---
 Documentation/git-http-backend.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index bb0db195cebd6..905aa1056d26f 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -192,16 +192,16 @@ ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 
 Lighttpd::
 	Ensure that `mod_cgi`, `mod_alias`, `mod_auth`, `mod_setenv` are
-	loaded, then set `GIT_PROJECT_ROOT` appropriately and redirect
-	all requests to the CGI:
+	loaded, then set path to git-http-backend, set `GIT_PROJECT_ROOT`
+	appropriately, and redirect all requests to the CGI:
 +
 ----------------------------------------------------------------
-alias.url += ( "/git" => "/usr/lib/git-core/git-http-backend" )
 $HTTP["url"] =~ "^/git" {
+	alias.url += ("/git" => "/usr/libexec/git-core/git-http-backend")
 	cgi.assign = ("" => "")
 	setenv.add-environment = (
 		"GIT_PROJECT_ROOT" => "/var/www/git",
-		"GIT_HTTP_EXPORT_ALL" => ""
+		"GIT_HTTP_EXPORT_ALL" => "1"
 	)
 }
 ----------------------------------------------------------------

--
https://github.com/git/git/pull/546
