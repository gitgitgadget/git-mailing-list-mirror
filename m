From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 3/3] transport-helper.c::push_refs(): emit "no refs"
 error message
Date: Tue, 8 Dec 2009 22:37:33 +0800
Message-ID: <20091208223733.5528e781.rctay89@gmail.com>
References: <20091208223649.d9ff4fed.rctay89@gmail.com>,
 <20091208223543.c7f88afe.rctay89@gmail.com>,
 <20091208223413.98e99d3e.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Clemens Buchacher" <drizzd@aon.at>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 15:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1CE-0005mu-Sh
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbZLHOhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbZLHOhf
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:37:35 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58907 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966AbZLHOhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:37:34 -0500
Received: by yxe17 with SMTP id 17so4930833yxe.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=KV9bmKZsyY4kQn9l0Yg+TsazRlsu8pB1Hv3Sk+Uc5OI=;
        b=aNs1KCpbvZhcikMHWruEyTVWvM9F+neXacg8X5JIBXyMsqeG+BOYB9sCT2n95GJyW/
         RcFkhVilrj0nlFBESZsjXogv8rgrOoLE2bX/Q70yVNI6l6g9lKs/PoGxiE2KXvQtigTP
         AUiEWcnMxxT7q0emwTNEEZoOAV+I/vnxzQos0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=Tq7nuH+gunh/xWcf9k8wDd5DpPTuFrKBz0DZzhMMsycjvdp5483O2o2Vu+gpYuphZk
         BeGXK2pRu2ObA3xvITunAPwHIgPu42UGu+IlQ1RlFAJjFd5D0T0+iod2F2yrlFbpMxp2
         sx5kCPuPo8J3zPdOpNKRU90qWSaBwnRffx1sI=
Received: by 10.150.174.33 with SMTP id w33mr14128546ybe.2.1260283061042;
        Tue, 08 Dec 2009 06:37:41 -0800 (PST)
Received: from your-cukc5e3z5n (cm67.zeta153.maxonline.com.sg [116.87.153.67])
        by mx.google.com with ESMTPS id 14sm3356297gxk.6.2009.12.08.06.37.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 06:37:40 -0800 (PST)
In-Reply-To: <20091208223413.98e99d3e.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134881>

Emit an error message when remote_refs is not set.

This behaviour is consistent with that of builtin-send-pack.c and
http-push.c.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport-helper.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 6b1f778..96fc48b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -321,8 +321,11 @@ static int push_refs(struct transport *transport,
 	struct child_process *helper;
 	struct ref *ref;

-	if (!remote_refs)
+	if (!remote_refs) {
+		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
+			"Perhaps you should specify a branch such as 'master'.\n");
 		return 0;
+	}

 	helper = get_helper(transport);
 	if (!data->push)
--
1.6.4.4
