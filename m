From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 5 Jun 2014 10:03:17 +0200
Organization: <)><
Message-ID: <20140605080317.GA28029@camelia.ucw.cz>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBR6IYCOAKGQEYP55X5A@googlegroups.com Thu Jun 05 10:03:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBR6IYCOAKGQEYP55X5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBR6IYCOAKGQEYP55X5A@googlegroups.com>)
	id 1WsSds-0003Xe-Ut
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 10:03:21 +0200
Received: by mail-wi0-f191.google.com with SMTP id r20sf193919wiv.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=dxZmui3/bDrri7XgSS9VT3A7wz3XDKvFL6v6gMYxqWA=;
        b=wCbJUNLwk4VrlvGtzs0B4vBAlTDVD1GjOMf6ENGME+foXuK9EHsMJKVcZ891ZHy8dn
         aQTiUfMco9hTLiAu0Yd5dwoCuQS9mmuoiqc7F1c4UrzOMaOcRrdzR2TtqnIhoCssH9hi
         x+lqTkcC6J1QnMAec6SVWU4gPwLQxlOnIih+heqi6kTZfAsTNctDI+HmbrkiU/t9twQE
         nWENh+cFj+Ut9/M3vvBJ2HPIo0uafOP6OXkmF/eIZKmFW+4iaUyFqRSiqJ4xK1D3edKG
         vgY/FUcIQbnJ2dRQ+PyXb6tbHi+mAMX7TiA4qHREvgUKaDT1ojpBcBblIuKv9bahh8PQ
         PZ9Q==
X-Received: by 10.152.42.225 with SMTP id r1mr42189lal.13.1401955400207;
        Thu, 05 Jun 2014 01:03:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.66 with SMTP id r2ls21717lag.29.gmail; Thu, 05 Jun 2014
 01:03:19 -0700 (PDT)
X-Received: by 10.152.6.97 with SMTP id z1mr6481191laz.0.1401955399200;
        Thu, 05 Jun 2014 01:03:19 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id se3si1432012wic.3.2014.06.05.01.03.19
        for <msysgit@googlegroups.com>;
        Thu, 05 Jun 2014 01:03:19 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id D7E151C009E;
	Thu,  5 Jun 2014 10:03:18 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s5583IvA028073;
	Thu, 5 Jun 2014 10:03:18 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s5583HVW028072;
	Thu, 5 Jun 2014 10:03:17 +0200
In-Reply-To: <538FCAF5.7030102@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250822>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 2 Jun 2010 00:41:33 +0200

If HOME is not set, use $HOMEDRIVE$HOMEPATH

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hello Karsten,
thanks for your explanation.  There are more things to be done, but
I hope you can ack this patch as a step forward.

Hello Dscho,
I hope you can ack this as well: it is basically equivalent with your
patch, tailored according to current upstream fashion,  ;-)

Stepan

 compat/mingw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index a0e13bc..e108388 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1181,6 +1181,11 @@ char *mingw_getenv(const char *name)
 		if (!result)
 			result = getenv_cs("TEMP");
 	}
+	if (!result && !strcmp(name, "HOME")) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "%s%s", getenv_cs("HOMEDRIVE"), getenv_cs("HOMEPATH"));
+		result = strbuf_detach(&buf, NULL);
+	}
 	return result;
 }
 
-- 
2.0.0.9635.g0be03cb

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
