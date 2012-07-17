From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH] Add explanatory comment for transport-helpers refs mapping.
Date: Tue, 17 Jul 2012 11:56:56 +0200
Message-ID: <13702454.DmcNg44yyH@flobuntu>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <11883284.WI8IR4K6qp@flobuntu> <20120717032725.GC3071@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 11:57:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr4Wi-0002xp-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 11:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab2GQJ5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 05:57:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64199 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab2GQJ5B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 05:57:01 -0400
Received: by bkwj10 with SMTP id j10so157820bkw.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=dYqNq2JRDTMv/7yDchCxxrzTJ/KL9a2Hfibql/4H8Y8=;
        b=OioZZhAxRf2Vc+tYUXgDSRYtrSBDbf9X0Qbs5BJeS1Hcx9Vn3INqlAgQ1BBDrxDVZ+
         xQzYyc7TrFv3bw4VgbPKI1ZnR7ejEURv5b1N7J6rfJhz7OLmAdFhbKIVDV0gNNOojEK4
         0XiyKtVP2wHVbF/oXC++tPSsyVwlHOj7qwoCiioe6hrNF+kXMKydHgEjUq8a2uyL0alW
         OTxEO+Av6fMwzUwoSTVAOUsIjw74z2V638HrFtxn4CBAw1R1AGiIyp5YJd314UaN5V4r
         OQChDhis3oyPhkT3tAuLbRYBwXZEtaQ1yRts2a1CULcuh5bwIFlRVEb+QjTZXDG8pLlK
         d1jA==
Received: by 10.205.122.147 with SMTP id gg19mr684681bkc.73.1342519020383;
        Tue, 17 Jul 2012 02:57:00 -0700 (PDT)
Received: from flobuntu.localnet (91-115-94-188.adsl.highway.telekom.at. [91.115.94.188])
        by mx.google.com with ESMTPS id hs2sm9532411bkc.1.2012.07.17.02.56.57
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 02:56:58 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120717032725.GC3071@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201598>

transport-helpers can advertise the 'refspec' capability,
if not a default refspec *:* is assumed. This could be helpful
information for the reader.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index d6daad5..4a763a7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -484,8 +484,18 @@ static int fetch_with_import(struct transport *transport,
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
 		if (data->refspecs)
+			/*
+			 * If the remote-helper advertised the refpec capability, we
+			 * retrieve the local, private ref from it. The imported data is
+			 * expected there. (see Documentation/git-remote-helpers.*).
+			 */
 			private = apply_refspecs(data->refspecs, data->refspec_nr, posn-
>name);
 		else
+			/*
+			 * else, the default refspec *:* is implied. The remote-helper has
+			 * to import the remote heads directly to the local heads.
+			 * remote-helpers using 'import' should have the refspec capability.
+			 */
 			private = xstrdup(posn->name);
 		if (private) {
 			read_ref(private, posn->old_sha1);
-- 
1.7.9.5
