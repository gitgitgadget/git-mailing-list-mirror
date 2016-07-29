Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A03F1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 14:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbcG2Otj (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 10:49:39 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34506 "EHLO
	mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbcG2Oti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 10:49:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id c52so4740767qte.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 07:49:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=l1O8WoY576Ineo5Xbx9XDmKFNMatXaxUL4VhuDJMFx4=;
        b=L7A6QSDYGmt1kb53JIoDxdM12Bhy+A83hgvmyyqwzPmR43JjYP498IFxJ2SfKHDnOc
         cY9O7FNToMVx0DgvZZavLAOTFKbiK85WIhoM7PvY5pf2Vkx+3FQvnoiHBI1IwmR3cf+c
         CkUCfYs1YdTgAvXEOE9hhBMs9e/QSfLjfgwOlgZ96Ay/5HerEDfR12nA7vO894oivsyz
         ++W7qJC7/nZAjEzIc8aCtn3fC4lrbbPd0G2If4hlSd8snH+hcKDCrWSOi+JzOFZl3Cri
         6VXC0zuWMuxAtAbpsy7bpZfDtUQNTQmjpPyuV3PAPZ9UJwOjVW7qI9n7uxlaTcJi+G3I
         5vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l1O8WoY576Ineo5Xbx9XDmKFNMatXaxUL4VhuDJMFx4=;
        b=JjqHbm3hufX/rtevbeR03H3xbndCJ8DjuZib9h/467kothEfFMarcA3/N1kVLMpXrk
         6kmgYw6tGSOtYdGarpiLP6q20glll24hK9nQeJX1H+bvBrswsFrIjpUMqgNe4jsvfPdY
         o8JMJ3NIG3F2ShBGKkgUYWQBVGUcwWyjrG3k/1+9N9fxFPwAk19U0tO96O3TdnOwiffe
         32MWy2ZOfg90JPclbQLalWIC80u9PyQIJ3l3q17PNavs3MXCVHO2kolPzAUr0eBYwwIL
         HgC8OD78FCTl0oo5MoVGIMY1g05efAQ8C2TDq2k62NkYD3sHHHUCxA3cAusOLXinJzY2
         cpWQ==
X-Gm-Message-State: AEkoousVD9p89Sn45Mf4Lo+MJyD+XBx0cVL/miDqqA3KrAnWfCkdRZOhuMH92hSv5eqAR5VZafnoVvNbTI2pZg==
X-Received: by 10.237.36.38 with SMTP id r35mr68224069qtc.3.1469803777741;
 Fri, 29 Jul 2016 07:49:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.192.18 with HTTP; Fri, 29 Jul 2016 07:49:37 -0700 (PDT)
X-Originating-IP: [212.243.229.186]
From:	Andreas Brauchli <a.brauchli@elementarea.net>
Date:	Fri, 29 Jul 2016 16:49:37 +0200
Message-ID: <CABnoAVcUbmvZbu7ZiEUWtq_2P6RQLVnJx1a-PiLW-r8uWQ+5vw@mail.gmail.com>
Subject: [PATCH] gitweb: escape link body in format_ref_marker
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Fix a case where an html link can be generated from unescaped input
resulting in invalid strict xhtml or potentially injected code.

An overview of a repo with a tag "1.0.0&0.0.1" would previously result
in an unescaped amperstand in the link body.

Signed-off-by: Andreas Brauchli <a.brauchli@elementarea.net>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2fddf75..33d701d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2090,7 +2090,7 @@ sub format_ref_marker {
                                -href => href(
                                        action=>$dest_action,
                                        hash=>$dest
-                               )}, $name);
+                               )}, esc_html($name));

                        $markers .= " <span
class=\"".esc_attr($class)."\" title=\"".esc_attr($ref)."\">" .
                                $link . "</span>";
-- 
2.7.4
