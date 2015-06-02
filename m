From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 10/16] transport: connect_setup appends protocol version number
Date: Mon,  1 Jun 2015 17:02:12 -0700
Message-ID: <1433203338-27493-11-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfn-0000kR-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbbFBADI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:03:08 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36985 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbbFBACq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:46 -0400
Received: by igbsb11 with SMTP id sb11so74954569igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5WnOZLyVUxry2FB/0okyMiRxJ9EtZBIj1bHAoXYNkBQ=;
        b=EyeeBb2cOrW0Cf62WaLlUP8cvLDfZX6jb5QCctWMBI/INI5oSn/Dc3XUZr8LacL/YA
         a+Yfcs+l1kZ8bRU+fwKhEhv1wfkz9+WUSrAu3XQy5bsd0cv4uIDXGtSrXOW8VB7Bav0e
         msbNYIPiLVYZL8tDG+4kH1eDc5qk2igjDSl5QZagqWtuMKQidZRxv2+WiDg8TSCr20QK
         7FoWNSsogBFWZgjMy0XU5Rk//Et124BbuSm2ivAdnjbo+XMvQD/FAw1NSdErX+4tEE6C
         L78Facma5OrxMwX7c8627nevSGdGzLuD26xVbW5A/UJJUIgLu1WttwdjhhiyLigD6H8t
         9p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5WnOZLyVUxry2FB/0okyMiRxJ9EtZBIj1bHAoXYNkBQ=;
        b=kFN+wEItQrs79UGT+S9K8ntK+Yk1mEBtLo161vqgifIc7/ZuJHV/rIjMQa/v9Lej9F
         36v3h+u8a+r0W1HFslvCSWOzwXSJbTuuIDPKM4rv9zkWFLc59ixfbKfYiIskBigIIzXY
         Y8+5j+oqsutKOBi07Ru7B9w1LbRNIf4+qZ6uREhmqmIAul/O4UE6obVpJ9D62KaCmGKQ
         A4iePv61+qHEMn7IHB2Bs2FZ8IM5hQ8hk544D5V4CsHTK2vpOXJjhuB0dsZhlyhthKa2
         6Eat+tAdZrQUivApBhy3DdZumbmfOw8LkoXCGMz1p+9bFBpDRejXlvSUp7JbcrzM1yaO
         jHjA==
X-Gm-Message-State: ALoCoQkMG4IL8uaBj+urcxdkc8qysStettpyzhz+yn8Ue9YkbA85AyJjPDUaUnApqTOF3XbURG8i
X-Received: by 10.107.164.228 with SMTP id d97mr30125197ioj.78.1433203365381;
        Mon, 01 Jun 2015 17:02:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id g32sm11485065ioj.20.2015.06.01.17.02.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270491>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    name it to_free

 transport.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 651f0ac..b49fc60 100644
--- a/transport.c
+++ b/transport.c
@@ -496,15 +496,28 @@ static int set_git_option(struct git_transport_options *opts,
 static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
+	const char *remote_program;
+	char *to_free = 0;
 
 	if (data->conn)
 		return 0;
 
+	remote_program = (for_push ? data->options.receivepack
+				   : data->options.uploadpack);
+
+	if (transport->smart_options->transport_version >= 2) {
+		to_free = xmalloc(strlen(remote_program) + 12);
+		sprintf(to_free, "%s-%d", remote_program,
+			transport->smart_options->transport_version);
+		remote_program = to_free;
+	}
+
 	data->conn = git_connect(data->fd, transport->url,
-				 for_push ? data->options.receivepack :
-				 data->options.uploadpack,
+				 remote_program,
 				 verbose ? CONNECT_VERBOSE : 0);
 
+	free(to_free);
+
 	return 0;
 }
 
-- 
2.4.1.345.gab207b6.dirty
