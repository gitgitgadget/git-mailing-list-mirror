From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH/RFC] Always auto-gc after calling a fast-import transport
Date: Thu, 15 May 2014 07:37:22 +0200
Organization: <)><
Message-ID: <20140515053722.GB12133@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
        msysGit <msysgit@googlegroups.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBFFF2GNQKGQEPT67HNY@googlegroups.com Thu May 15 07:37:29 2014
Return-path: <msysgit+bncBCU63DXMWULRBFFF2GNQKGQEPT67HNY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBFFF2GNQKGQEPT67HNY@googlegroups.com>)
	id 1WkoM9-0005DJ-KV
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 07:37:25 +0200
Received: by mail-wg0-f57.google.com with SMTP id l18sf267404wgh.22
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=7pSXWFiu/8CVnMBCCcwHwWpv2wq8RPM/GyZkbKpxYLs=;
        b=TuvDSGWa4eyPXFZugiez4JplO3M+RszjYSLqP5SjYSunzS3yEE7LZ+zMRQ11K2wRw8
         b2HZXluazAW62PVsmEWmS8+JahIS6jNRw6jtJXRZVBHhiyyNXPsGY7J71Fj+OKCXAD/B
         pqhmhXFl0ZN4wPM1iggm6vqubhHnHYSlwIQPdjf8GQntAL3gG/X7Bq46c9QpgD44rFVs
         yDX+Uk2cfRGRXMdUhyGTKoKLNkXbGsseCpJPrmxjNbUYvzjLJ5aZhOLHrDvO3jChvctb
         8e89ZH9y1XtDCMcfAQdTHB5SreQzVT6hHayXGSflCpWxqRj2LU4QKqHD02N/ltOXTzTn
         o+Tg==
X-Received: by 10.180.87.194 with SMTP id ba2mr42884wib.5.1400132245372;
        Wed, 14 May 2014 22:37:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.73.115 with SMTP id k19ls42940wiv.18.gmail; Wed, 14 May
 2014 22:37:23 -0700 (PDT)
X-Received: by 10.180.206.33 with SMTP id ll1mr3286464wic.5.1400132243880;
        Wed, 14 May 2014 22:37:23 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si1320243eep.0.2014.05.14.22.37.23
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 22:37:23 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 8D76F1C00E2;
	Thu, 15 May 2014 07:37:23 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4F5bN2A012304;
	Thu, 15 May 2014 07:37:23 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4F5bMHA012303;
	Thu, 15 May 2014 07:37:23 +0200
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249060>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 9 Apr 2012 13:04:35 -0500

After importing anything with fast-import, we should always let the
garbage collector do its job, since the objects are written to disk
inefficiently.

This brings down an initial import of http://selenic.com/hg from about
230 megabytes to about 14.

In the future, we may want to make this configurable on a per-remote
basis, or maybe teach fast-import about it in the first place.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hello,
another patch that waited in msysgit for 2 years.
Could anyone on the list try to reproduce the performance problem
that triggered this?

Thanks,
  Stepan

 transport-helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index a01ea47..956b800 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -14,6 +14,8 @@
 #include "refs.h"
 
 static int debug;
+/* TODO: put somewhere sensible, e.g. git_transport_options? */
+static int auto_gc = 1;
 
 struct helper_data {
 	const char *name;
@@ -519,6 +521,12 @@ static int fetch_with_import(struct transport *transport,
 		}
 	}
 	strbuf_release(&buf);
+	if (auto_gc) {
+		const char *argv_gc_auto[] = {
+			"gc", "--auto", "--quiet", NULL,
+		};
+		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	}
 	return 0;
 }
 
-- 
1.9.2.msysgit.0.335.gd2a461f

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
