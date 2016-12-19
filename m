Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC471FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933580AbcLSQqW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:22 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53426 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933438AbcLSQpc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:32 -0500
X-AuditID: 1207440c-e3bff700000009a1-01-58580eaa6c9a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 40.17.02465.AAE08585; Mon, 19 Dec 2016 11:45:31 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKR1011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:29 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/13] gitk: only change the color of the "remote" part of remote refs
Date:   Mon, 19 Dec 2016 17:45:07 +0100
Message-Id: <3d99aed51a9a03ad50cfd612f3f67f61a338b316.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsUixO6iqLuaLyLCYPllFYuuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvjw/E3TAUnuSp2vXvO2sC4
        hKOLkZNDQsBEYuv8FSxdjFwcQgKXGSWe9ayEck4xSfTtb2EBqWIT0JVY1NPM1MXIwSEioCqx
        /oIQSJhZwEFi8+dGRhBbWCBMYvePL2wgNgtQyaNjB8BaeQWiJHY3/WaGWCYncWnbFzCbU8BC
        4ub8K+wgtpCAucSGZ79ZJjDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6iXm1mil5pS
        uokREhI8Oxi/rZM5xCjAwajEwyv5NixCiDWxrLgy9xCjJAeTkijvfp6ICCG+pPyUyozE4oz4
        otKc1OJDjBIczEoivHt5gXK8KYmVValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4O
        JQnecJBGwaLU9NSKtMycEoQ0EwcnyHAeoOHpYMOLCxJzizPTIfKnGBWlxHkdQRICIImM0jy4
        XljMvmIUB3pFmPcMSBUPMN7hul8BDWYCGrywOxxkcEkiQkqqgbHQLqeX6/QZW9VqZcfp21e9
        ddxa9m635jKpXfWqfgXmi5Wm+Cg5P+G7IbKWyeumqZ9/a+7yWoOOSTFXPkg8k+rZ8D24LIpd
        Kk05qX513XSZ9T+TV7QdSveYu1dM129pxb+i/9rhMY8niXzQevv/N1P8V6FJYm8u9a5n0n6c
        xvlD/vUZpp6J8UosxRmJhlrMRcWJALw2PCy0AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a remote-tracking reference has the form

    refs/remotes/origin/foo/bar

, then the part of the reference that tells which remote it comes from
is `refs/remotes/origin`. So display such a reference as

    remotes/origin/foo/bar
    ^^^^^^^^^^^^^^^

, where the indicated part is displayed in `$remotebgcolor`. The old
code always split the reference name at its last slash, thus rendering
the above remote-tracking reference as

    remotes/origin/foo/bar
    ^^^^^^^^^^^^^^^^^^^

, which makes no sense at all.

Note that this commit doesn't change the rendering of remote-tracking
references with only two slashes (e.g., `refs/remotes/foo`). Such
references were created by `git-svn` when using its old naming scheme.
They are still rendered like

    remotes/foo
    ^^^^^^^^

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 51ebaf5..c146a15 100755
--- a/gitk
+++ b/gitk
@@ -6558,7 +6558,7 @@ proc remotereftext {head textName prefixName} {
     upvar $textName text
     upvar $prefixName prefix
 
-    if {[regexp {^((remotes/(.*/|)).*)} $head match text prefix]} {
+    if {[regexp {^((remotes/([^/]+/|)).*)} $head match text prefix]} {
 	return 1
     } else {
 	set text $head
-- 
2.9.3

