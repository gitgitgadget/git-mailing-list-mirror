From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH (resend) 1/3] http.c: free preq when aborting
Date: Mon, 10 Aug 2009 23:55:48 +0800
Message-ID: <20090810235548.110c43a6.rctay89@gmail.com>
References: <be6fef0d0908100847h7e9b53a2ofdf318e9958be3b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff Lasslett <jeff.lasslett@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 10 17:56:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXEH-0002uq-96
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbZHJP4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbZHJPz7
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:55:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:23790 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbZHJPz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:55:59 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1029862rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=o5VGO6vOPHJRdDus1zwaOOH+H0qJcspav+zNqiSeW54=;
        b=eqyI8Q82opIxlOPJIIfL5pt+yTiFW/LD6VKBfJvv9vR8iFg/oeY8xfRtn3/tlCwufz
         HD3qldHN2DVbE2Jwd3/g8UZPwhg+06jRzx64ivsqCFi1aw3LHw193NtUnt7GH/bhK8Tu
         iyyncNP4xoQr+0DzXDPf3MIzL9s+CT0k4PonU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=Z6q7jiwejnRNXX8LFsOspttl5S6MYOszd1LCFnQL+8F0SToYyXVjUCUxDJLI9l5RqS
         VnF+V32+ofY271o7Wcc8Qup0UnZYRPg/tPkblmiB8gLu+MZognHsQ7kUwE31ZGbxkKp0
         9GoLUtQTT+i6MsD4oOaJvFNBu27T/GVPXehCs=
Received: by 10.140.125.1 with SMTP id x1mr671219rvc.261.1249919760348;
        Mon, 10 Aug 2009 08:56:00 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta152.maxonline.com.sg [116.87.152.189])
        by mx.google.com with ESMTPS id c20sm25645928rvf.51.2009.08.10.08.55.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 08:55:59 -0700 (PDT)
In-Reply-To: <be6fef0d0908100847h7e9b53a2ofdf318e9958be3b2@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125471>

Free preq in new_http_pack_request when aborting. preq was allocated
before jumping to the 'abort' label so this is safe.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index a2720d5..cfe32f5 100644
--- a/http.c
+++ b/http.c
@@ -1059,6 +1059,7 @@ struct http_pack_request *new_http_pack_request(

 abort:
 	free(filename);
+	free(preq);
 	return NULL;
 }

--
1.6.3.1
