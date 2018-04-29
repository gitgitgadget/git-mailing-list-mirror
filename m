Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253F51F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeD2WTG (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:19:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:34779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754164AbeD2WTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:19:05 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LvDpe-1eCs5e3Yd0-010LvO; Mon, 30 Apr 2018 00:19:00 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 4/6] run-command: use BUG() to report bugs, not die()
Date:   Mon, 30 Apr 2018 00:18:31 +0200
Message-Id: <89539a1af3d36c6660c6cc0c046f59393ca21b4e.1525040253.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525040253.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Zy0Bw6Hwhng0jmcM0KAY759Pfb0GBAfPvzDBAgIRDmanGouNQEn
 TClCo5bYq+/X3r+ssr0e1AW3u++TEYio9UvnVRWRKEs7PJNwmkaU2Y3EtfQAeb4vwkrEkYt
 IZV85Otcuc/v7l0wV89KNQGIYR13+eEosbbYS4QrH7CspZSHn2BhlRXewz951PLGMMfkocB
 6YtLdqXVtUo99EkYlL23g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L9RTK0t/YFE=:1ltmUN9HRmYIRdZ9NzfVhC
 S1dxIMKlsYU2KiOr8Pr+EwFdf9Q9OA2vY53tHXusc1n3lCPQoN/HI0cv6n2WxIfvfb+WHLcZ8
 msWXWydbjt6MStiVEBpiAfqbBi/epxDYfKL2oVuUGj69lF4Ja3EhSjgjpsYQA8qrGFOuP7z+7
 F+m3GFGP544qmSK5okAjRpoLUGr+hjhJr36UV5h2DmsK2WIljEtLnDtozPGF4rLA0NiufFjER
 dK0/PG9vKSObC+yC/+4aMSKMJnzp1pp7A6lV0KTVfnLLQJa1FXrC5KWPY/2qoV6cJ/ND6uZCw
 JQIYUDUoqOEs9MrNWcy5LhFNqvrq9DyyPgmGU62QVI8cmZDCkPwKKu3iaDScehKPDpZ4z8oUp
 h5N22gaMfcE9nW9olCZkOrWvgEpaWu6fPdvL/lEb03mOjSOvE2d1wrO8pnXAS6cDBIruZylzs
 D+2igUvcUCsx8LAmtvMBkVs5lfxX8Yj9Yt+bxgS8vq5tmLop95CEvg/BmM6yXXyMeldnvx1oE
 KAtkMy7KTU1iw2u+3jMO78hg7tf/2Yt2XztfzZUtDCSkTS5Tm6l+V8kQdD7QszKYZFtIAMGup
 8oKmLR0wap5UvTbdSSLCt3kGsJwLJwZDM+cvXVj8kpEJazjYLEo+UYf+Rijqsv1pwzSalW+z/
 pkn2wzjKIpKTDUmk1eHxHWPacWXNCXN1K2A+FoA2BySzLmzE/t3uwqM1buu0Lbo+0dlscYQSY
 1VcBlrAF2xGRkwbMLTaCYd/0z1AjtMF3ebcZ8/t8qjdMbgKMvY5JQB87J4wZXzxYQr3Wx9ABU
 WdkfAyx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The slightly misleading name die_bug() of the function intended to
report a bug is actually called always, and only reports a bug if the
passed-in parameter `err` is non-zero.

It uses die_errno() to report the bug, to helpfully include the error
message corresponding to `err`.

However, as these messages indicate bugs, we really should use BUG().
And as BUG() is a macro to be able to report the exact file and line
number, we need to convert die_bug() to a macro instead of only
replacing the die_errno() by a call to BUG().

While at it, use a name more indicative of the purpose: CHECK_BUG().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 12c94c1dbe5..0ad6f135d5a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -471,15 +471,12 @@ struct atfork_state {
 	sigset_t old;
 };
 
-#ifndef NO_PTHREADS
-static void bug_die(int err, const char *msg)
-{
-	if (err) {
-		errno = err;
-		die_errno("BUG: %s", msg);
-	}
-}
-#endif
+#define CHECK_BUG(err, msg) \
+	do { \
+		int e = (err); \
+		if (e) \
+			BUG("%s: %s", msg, strerror(e)); \
+	} while(0)
 
 static void atfork_prepare(struct atfork_state *as)
 {
@@ -491,9 +488,9 @@ static void atfork_prepare(struct atfork_state *as)
 	if (sigprocmask(SIG_SETMASK, &all, &as->old))
 		die_errno("sigprocmask");
 #else
-	bug_die(pthread_sigmask(SIG_SETMASK, &all, &as->old),
+	CHECK_BUG(pthread_sigmask(SIG_SETMASK, &all, &as->old),
 		"blocking all signals");
-	bug_die(pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &as->cs),
+	CHECK_BUG(pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &as->cs),
 		"disabling cancellation");
 #endif
 }
@@ -504,9 +501,9 @@ static void atfork_parent(struct atfork_state *as)
 	if (sigprocmask(SIG_SETMASK, &as->old, NULL))
 		die_errno("sigprocmask");
 #else
-	bug_die(pthread_setcancelstate(as->cs, NULL),
+	CHECK_BUG(pthread_setcancelstate(as->cs, NULL),
 		"re-enabling cancellation");
-	bug_die(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
+	CHECK_BUG(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
 		"restoring signal mask");
 #endif
 }
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


