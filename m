From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/6] Only use CURLOPT_LOGIN_OPTIONS if it is actually
 available
Date: Mon, 26 Oct 2015 14:14:58 +0100 (CET)
Message-ID: <5693bb2d11ff096859d885d06b4ca860caf5e960.1445865176.git.johannes.schindelin@gmx.de>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:15:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqhcG-0000ke-J5
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 14:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbJZNPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 09:15:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:62377 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815AbbJZNPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 09:15:04 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0LwZtX-1aZiOb3BOR-018OEH;
 Mon, 26 Oct 2015 14:14:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445865176.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:mPEPWgHDcAy3yswMFg/oqO7tAWW2E9v+oTobXkmiQYRNsRI2kC5
 xw/7tYjsBRTXVhTvz4Da3PtyeYy7YfGsFsjDCaz3XpnQREtqZBrbZRTLU5RCHp7+JVQAwzw
 JIGmbbyI08gkVQgdXC5E4FNo6Gsd2M15so3XVA4fTQUWHIJQL2E6C+r83IV/qDV7X0594Hb
 v09tLlCmGDQdnLAserBWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sKIG9wTowPg=:MWNSkzxqu4hsNAfFKKcDBG
 ovgUOSgsZI6HmDXRA2fJOpNNkS/j6GClESA6R/Ycy3gPDFtk/YQpQEhX2y5I2dXshwGiOtByF
 xOwo0K6bt85VrF9YlxEMHQExjPyqRGJ9tPYv6p0+Rw2k5mCPUDB1uec6tb34S7G0/QvyvBEDm
 QdRrZ51nxOio62yTySh0BXQbtYL2n5yCdM/oDaG9dhJFv0Y0QwNOIgfbBQzg/CpE6CDsaOSVO
 Dsoirh5oINXwhlo0EDl97jWTrl0Xk4uDuMBfqZqgz2iTW7BOiAJmDON3j7yhBKugX8cNPz7JL
 gbtBwOiIujI6fIE6Z68CaugSs+/FzOUTkiqz18pPGA6RBeRGfZoM8fmY1mHmyoy7lcjaXgjzI
 iXJ5GQ9Oe8LndQ0cyj9X1Ieq1+I4j9SwK2sc8dXWhKrtibroQUxuiQ5I3aI/Nwp5LgNwab5ot
 qjlYfkMLf3mKTIYDqD8nKAzIA5w6r4TZHkKYB30BZBehhFQXRl0FvhWyvcbx4fvLooN5EmcQ1
 Ou/zb+n62/YNoZ5z/Nvcdv3pfm4jMpCXqzQDBB6DbK8ZcSiXjkn/bcJi5EYrmmtiR8oeoudHX
 sQUzeMXu8u9SV5iUY4ETcvpoMqpHuyuNcNfzWuMQnU87CehEtI1mjMTf5VqPnqJmmQ+T3AgTW
 IusICvsM+kgKzCaxrh8PANQK9l1yq0Asne+TV5JCLJhZqGOSUR0x3+ScACq1s/BBguAFMOSA9
 omQGMa95kM14ZLxMyZWRVgHfAK9bp/gvr514+2S5z5Xtb52srwRrpwI4iFWWeCPV3GVHyZrv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280189>

This fixes the compilation on an older Linux that was used to debug
test failures when upgrading Git for Windows to Git v2.3.0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 imap-send.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index e9faaea..4d3b773 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1421,11 +1421,15 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
 
 	if (server.auth_method) {
+#if LIBCURL_VERSION_NUM < 0x072200
+		warning("No LOGIN_OPTIONS support in this cURL version");
+#else
 		struct strbuf auth = STRBUF_INIT;
 		strbuf_addstr(&auth, "AUTH=");
 		strbuf_addstr(&auth, server.auth_method);
 		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
 		strbuf_release(&auth);
+#endif
 	}
 
 	if (!server.use_ssl)
-- 
2.1.4
