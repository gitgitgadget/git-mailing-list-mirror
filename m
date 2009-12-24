From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 6/6] transport-helper.c::push_refs(): emit "no refs"
 error message
Date: Thu, 24 Dec 2009 15:45:30 +0800
Message-ID: <20091224154530.7fbdff2e.rctay89@gmail.com>
References: <20091224154445.ad4b7a01.rctay89@gmail.com>,
 <20091224154352.ecefd242.rctay89@gmail.com>,
 <20091224154258.08b4fe44.rctay89@gmail.com>,
 <20091224154158.15ba580f.rctay89@gmail.com>,
 <20091224154057.33611ae7.rctay89@gmail.com>,
 <20091224154005.a642c8ec.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 08:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiOF-0007hf-Kj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbZLXHpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756885AbZLXHpj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:45:39 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36294 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881AbZLXHpi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:45:38 -0500
Received: by yxe17 with SMTP id 17so7445343yxe.33
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=P3TQOa5IRm7R3bnDZY1OdzgthyC9WxiyXrC9fi5NEU8=;
        b=ccdhZPt1ucV3w+5T3sTuFnPV81+5Dyv69qwR+A6PRx1dWw3Hq2+Lm+Js2BEqcP7t7Q
         lgYdUwB0c+TfX6lyAHV+evluYapHCIRrc50GFKC59VSr+UD+bRncLRQwD85peLSlMZzN
         vZireWZHsIYN+YWn9KaEFjeaUfskdo5lLqWDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=e9C0Q+qkgso//yaxl6NQvy6gZGvFGlS9ETRqlpEdkZgH7Z+LpOiNwLMRdTOKcntO6p
         Egise2kfAIqbuZASswpJfyMRr+MS/iieJlOTPiPjOtVPLI6gmZUEy/DW5lviKqUqazr3
         4GlHxoensYXS7DO2A9zha9TKxrZJqjoG8rXMc=
Received: by 10.90.8.13 with SMTP id 13mr2206674agh.89.1261640738150;
        Wed, 23 Dec 2009 23:45:38 -0800 (PST)
Received: from your-cukc5e3z5n (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 13sm4187203gxk.5.2009.12.23.23.45.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 23:45:36 -0800 (PST)
In-Reply-To: <20091224154445.ad4b7a01.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135649>

Emit an error message when remote_refs is not set.

This behaviour is consistent with that of builtin-send-pack.c and
http-push.c.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed nothing from v2.

 transport-helper.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index bdfa07e..5910384 100644
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
1.6.6.rc1.249.g048b3
