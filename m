From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 27/26] mailinfo: close patchfile
Date: Tue, 13 Oct 2015 18:37:52 -0700
Message-ID: <xmqq4mhu9qmn.fsf_-_@gitster.mtv.corp.google.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444778207-859-20-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 03:38:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmB1R-00036b-S4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 03:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbbJNBhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 21:37:55 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34706 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbbJNBhy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 21:37:54 -0400
Received: by pabws5 with SMTP id ws5so6745466pab.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 18:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hDuyqgIxewOHGNM4rj9e5izuPoTxobxMKhvuOMIJlpU=;
        b=qjRswe6SwRFLb29ijz+Gv42/b0pluvop71zXAl0IPOaMdDl25GXmC5czTsFhyuJutp
         KpaHn6OjXj2Ln/F8hgDmH9MxOAKJrkxjyTopCXZpJ4EC3OY8X+fFkbwQn9/sUmAVQ30S
         rwXr2jQT+oM/ZMNSc7fM9Psdx39j9IQL8g/kDU+JbMHXxBasdLmQRBokCt+VPsyc8axS
         O9PDzWQ+I0fr7vubZQnapGyy35b3uLdPACLKeETiHHulk8MKmltxzrj3cDjQ7Ir52SO5
         hTroccvbfuQpJOJ0fahOtDsOlUJYqoGslgaoXDKWnH2hSU9lIgWC2FH9thHyZSYQyV4C
         nHpw==
X-Received: by 10.67.12.196 with SMTP id es4mr636447pad.83.1444786674299;
        Tue, 13 Oct 2015 18:37:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id qn5sm6185607pac.41.2015.10.13.18.37.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 18:37:53 -0700 (PDT)
In-Reply-To: <1444778207-859-20-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Tue, 13 Oct 2015 16:16:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279559>

"git mailinfo" itself did not need this, as open file handles are
flushed and closed upon process exit, but the libified version needs
to clean up after itself when it is done.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailinfo.c b/mailinfo.c
index ca40030..00e2ea4 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1013,7 +1013,7 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
 	}
 	fclose(cmitmsg);
-
+	fclose(mi->patchfile);
 	return mi->input_error;
 }
 
-- 
2.6.1-320-g86a1181
