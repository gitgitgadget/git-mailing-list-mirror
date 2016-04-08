From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 01/18] Remove duplicate code
Date: Thu,  7 Apr 2016 23:58:29 -0700
Message-ID: <1460098726-5958-2-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQPK-0003Tu-05
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194AbcDHHAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 03:00:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35964 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553AbcDHG7A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id q129so8827903pfb.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NG3gPlgiz7GWjCrvqzCZjj8JBheoNJqtW50r2XQy2Gg=;
        b=hmJBQCheRVc+H9uMoNn2IUTGCS8LJlv9hGsDmbK+HhHmb/JkXnPmcVu4salekx8NOW
         r1XxsXyJeQ1McDf/O1WJOcMp/RlZ6TeQ+UlwOlIGZrzlE0YpkUk6kuVY2xIc878rCGSY
         CG12HS2mek7xNrcTJT+UVok70LouuMu4bxHKzei/2EAirGak881fndCxE4V2bLMOieAV
         WiZnDCprHo97H63CKOsLoqBBmozxad/upiLPdcDJM4Qa0uUehT5dloIrk1i04jjyR2w0
         Otv4k60o0zcWgCRr15KbXNNJA5I0vUwY9qwtfo1/d/F7jWyFCMyBheQ8d37J19EG/67V
         4eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NG3gPlgiz7GWjCrvqzCZjj8JBheoNJqtW50r2XQy2Gg=;
        b=byv/vMOOUOHDFGdKwNFshcuiyzyoHC00MqW/MvAaL7Eshs9PVzL67jSxgooBx0QwMb
         h5orugiUFMBXfzNvooOUvlDi09dlNXFlTZ/qvOauDVP4cJev1TS7DlvzvmwJqnsvlHTf
         o3gyxsvqw44ao/tHOLBLSwQUIsgDM2IKa4bRGAPRmuuoIo6lwOmPo6fQWM/pTMUO4OEa
         y1IphkjYwDckBMXx4SnsAf/H09YBmVq1aQiXsblS0qI1Va3JyWyMf8IyMjcIt4eIPIIu
         InMdiMfGim5R4X4MfjlcaaSF6HReAQ+XXsdbp6QbbmBgCw/0woitVEwvDZsLDj/e/ZCD
         54rQ==
X-Gm-Message-State: AD7BkJIpq6HeKRSITaicGIMgOnPZaUFY7OjzeFe5aTu/lwcgeGgNgqllkULR5JYEx6jzhw==
X-Received: by 10.98.80.206 with SMTP id g75mr10457719pfj.127.1460098739329;
        Thu, 07 Apr 2016 23:58:59 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:58:58 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291018>

In commit 51931bf (merge-recursive: Improve handling of rename target vs.
directory addition, 2011-08-11) I apparently added two lines of code that
were immediately duplicated a few lines later.  No idea why, other than
it seems pretty clear this was a mistake: there is no need to remove the
same file twice; removing it once is sufficient...especially since the
intervening line was working with a different file entirely.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b880ae5..d4292de 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1773,8 +1773,6 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			if (o->call_depth)
-				remove_file_from_cache(path);
 			update_file(o, 0, sha, mode, new_path);
 			if (o->call_depth)
 				remove_file_from_cache(path);
-- 
2.8.0.18.gc685494
