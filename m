From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Mon, 17 Nov 2014 18:53:59 -0800
Message-ID: <20141118025359.GI4336@google.com>
References: <20141118003426.GA6528@glandium.org>
 <20141118022137.GA8418@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Nov 18 03:54:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqYva-0000bp-QH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbaKRCx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:53:59 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41210 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbaKRCx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:53:58 -0500
Received: by mail-ie0-f177.google.com with SMTP id tr6so4239204ieb.22
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 18:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ir3RfhrlMdakNNvvWsIvLICaxqAduzKuy3N7EBqglYA=;
        b=kAfE41g58UHMdc2ekayE+XyMuhggKG7awrDV+fuS+qyscX/rzVJ+rEP4CWWTQB4+pH
         uRk8sl7kLKeop3alfBhrsF75pm2neyOfrhnAl1uEKS96nU1kaV4lyGx/26QWR7zFgL4+
         CrvN7+mcjqBXq3tkz5kZCZttF7lNK07sZrYDOgDU2o4NZvV0rX0a32p3kJaqM5pnp24i
         kKAOmXnuDq1ZURKqnbpTKFdOjVJtMuzwSXWsAR84cUYanCPyxcqtIuOZnwtyjMe8yf/F
         66/xVSm0piMaYacFJ0huCtUz43mtVRuwlZg618+S5D5hw6WCB/ghV30x7OfXql3Tmacb
         CVxw==
X-Received: by 10.107.15.15 with SMTP id x15mr1799826ioi.61.1416279238033;
        Mon, 17 Nov 2014 18:53:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id hz2sm6566962igb.15.2014.11.17.18.53.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 18:53:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118022137.GA8418@glandium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey wrote:

> BTW, if it so happens that all the operations that were done end up
> creating objects that already existed for some reason, checkpoint
> doesn't do anything, which is fine for the pack and tags, but not
> necessarily so for export-marks.

Does something like this help?

Do you have a short script that can demonstrate the failure?

Lazily,
Jonathan

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/fast-import.c w/fast-import.c
index d0bd285..c3d53c8 100644
--- i/fast-import.c
+++ w/fast-import.c
@@ -3088,12 +3088,11 @@ static void parse_ls(const char *p, struct branch *b)
 static void checkpoint(void)
 {
 	checkpoint_requested = 0;
-	if (object_count) {
+	if (object_count)
 		cycle_packfile();
-		dump_branches();
-		dump_tags();
-		dump_marks();
-	}
+	dump_branches();
+	dump_tags();
+	dump_marks();
 }
 
 static void parse_checkpoint(void)
