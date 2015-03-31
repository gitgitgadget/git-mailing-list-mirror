From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 6/6] entry.c: fix a memleak
Date: Mon, 30 Mar 2015 18:22:11 -0700
Message-ID: <1427764931-27745-7-git-send-email-sbeller@google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
Cc: John Keeping <john@keeping.me.uk>, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycksy-0008LB-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbbCaBW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:22:29 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36139 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbbCaBWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:22:21 -0400
Received: by igbud6 with SMTP id ud6so5569200igb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zyh6QD+ljw65z/vmevoG5ZnOPZKIGwu+dxxHKlW6jvQ=;
        b=D06oa3jiCzIOOFfvQMyD/PW/LqOG10c0/vg4t79dHsSLTlI9+jI6ds0tF8Nu1QqjXw
         R/iec6INXnWsAd3skm2wER8KozGffPwadURgwI/V/wqqGdXkgUE8eDa3Bmd0wqAXahCn
         xM+neaDMOnNMouj2pmvxg5s5h2E97mwj2vyqFE/9AI1fIpPkjNqYuof4zLzMMmb84q/X
         GZLIbKq9uRECt2SXZEJ0ILb35eISUNgsvaOkw0GuGd3EmhRL80LOZHNhi9dPIpbu7SDl
         ug1TVYA8rzo6SBkZccXW/efk41DqqkRExTyke3t342zBsX5j6EPQbpNvG7u5s0cwzPCf
         AFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zyh6QD+ljw65z/vmevoG5ZnOPZKIGwu+dxxHKlW6jvQ=;
        b=CLuPyKCKK+4Xas0Tn+dGLGH5knV9U00kdOTiodcLwNRwcmPqca/S5O7vPya3ZTwiPM
         qnAMOd8au34Oc1a3MjSGYaojloN7iDBp+om5nMi2lyZkqVMa0zItZ/Cj4QSh/0ZH0eCe
         5KtM+X/Rwhols2gKSMT9Rqs5/ggy4XuOIa3OPmJ2qOSWeXyRW/bplA3uPTYGpfCslgE1
         fBT0yiqfJVsGCVDO6ALQjmWfLzu+DpzyS0+aSd9p6ysZq1BlPyW4i6ZxBsAY8A6Cgsls
         WX6SACecGtXv1Ch9ZycKE3QuC+VFxjnS480E0nTJzLMi4Ygay/hK5PytZrQIFb+jFkQ+
         fjug==
X-Gm-Message-State: ALoCoQlvSl5e4bc3DunsZbcL6UhSC4ATU+AGvMffW8b/xLuL/xJvaF5QF9qDbOwCPSxtPANewUrA
X-Received: by 10.107.136.165 with SMTP id s37mr25168186ioi.37.1427764940839;
        Mon, 30 Mar 2015 18:22:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3c88:d48a:4382:4b5])
        by mx.google.com with ESMTPSA id lo1sm8761602igb.1.2015.03.30.18.22.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:22:20 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427764931-27745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266497>

From: John Keeping <john@keeping.me.uk>

stream_blob_to_fd() always frees the filter now, so there is no memory
leak in entry.c:152 just before the `goto finish`.

Signed-off-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
 I added Johns signoff here tentatively, John can you confirm the sign off?
 
 streaming.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/streaming.c b/streaming.c
index 2ff036a..811fcc2 100644
--- a/streaming.c
+++ b/streaming.c
@@ -507,8 +507,11 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
 	int result = -1;
 
 	st = open_istream(sha1, &type, &sz, filter);
-	if (!st)
+	if (!st) {
+		if (filter)
+			free_stream_filter(filter);
 		return result;
+	}
 	if (type != OBJ_BLOB)
 		goto close_and_exit;
 	for (;;) {
-- 
2.3.0.81.gc37f363
