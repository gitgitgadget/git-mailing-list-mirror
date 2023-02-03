Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD18C63797
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 21:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjBCVvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBCVvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 16:51:52 -0500
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 13:51:26 PST
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217251A976
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 13:51:26 -0800 (PST)
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by abrecht.li (Postfix) with ESMTPSA id ED7AC2FA7A48;
        Fri,  3 Feb 2023 21:42:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li ED7AC2FA7A48
MIME-Version: 1.0
Date:   Fri, 03 Feb 2023 22:42:13 +0100
From:   Daniel Abrecht <git-git@nodmarc.danielabrecht.ch>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitweb: fix base url set if PATH_INFO is used, add a / at the
  end.
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <585496b18c853140144c3e7ae13c0124@abrecht.li>
X-Sender: git-git@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In HTML, if there is a base tag like `<base href="/a/b">`,
a relative URL like `c/d` will be resolved by the browser as
`a/c/d` and not as `a/b/c/d`. But with a base tag like
`<base href="/a/b/">` it will result in `a/b/c/d`. So by
adding a slash there, the browser should now search the
files at the correct location.

Signed-off-by: Daniel Abrecht <public@danielabrecht.ch>
---
  gitweb/gitweb.perl | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..acb2cce5f6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4217,7 +4217,7 @@ sub git_header_html {
  	# the stylesheet, favicon etc urls won't work correctly with path_info
  	# unless we set the appropriate base URL
  	if ($ENV{'PATH_INFO'}) {
-		print "<base href=\"".esc_url($base_url)."\" />\n";
+		print "<base href=\"".esc_url($base_url)."/\" />\n";
  	}
  	print_header_links($status);

-- 
2.39.0

