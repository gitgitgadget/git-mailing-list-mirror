Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EEDC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 22:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBIW06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjBIW05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 17:26:57 -0500
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEB31167F
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 14:26:53 -0800 (PST)
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by abrecht.li (Postfix) with ESMTPSA id 4F23F2E61330;
        Thu,  9 Feb 2023 22:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li 4F23F2E61330
MIME-Version: 1.0
Date:   Thu, 09 Feb 2023 23:26:48 +0100
From:   Daniel Abrecht <git-git@nodmarc.danielabrecht.ch>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] gitweb: fix base url set if PATH_INFO is used, add a / at
 the end
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <585496b18c853140144c3e7ae13c0124@abrecht.li>
X-Sender: git-git@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Message-ID: <20230209222648.z-sqdvWiK7xa-NLagt3B_X_4bFQJBsA8cA06YvgXqWQ@z>

In HTML, if there is a base tag like `<base href="/a/b">`, a relative 
URL like
`c/d` will be resolved by the browser as `a/c/d` and not as `a/b/c/d`. 
But with
a base tag like `<base href="/a/b/">` it will result in `a/b/c/d`.

Signed-off-by: Daniel Abrecht <public@danielabrecht.ch>
---
  gitweb/gitweb.perl | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..edcee1652c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -74,6 +74,11 @@ sub evaluate_uri {
  		}
  	}

+	# $base_url is later used in the <base> tag as a URL, if it doesn't 
end in a /
+	# the browser will strip away the last component for relative URLs.
+	# Add the / if it's missing.
+	$base_url .= '/' if not $base_url =~ /\/$/;
+
  	# target of the home link on top of all pages
  	our $home_link = $my_uri || "/";
  }
-- 
2.39.1
