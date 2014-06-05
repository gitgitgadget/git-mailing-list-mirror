From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v3] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 5 Jun 2014 12:23:46 +0200
Organization: <)><
Message-ID: <20140605102346.GA28309@camelia.ucw.cz>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info> <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com> <20140605080317.GA28029@camelia.ucw.cz> <53902B2C.7050807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Karsten Blees <karsten.blees@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        msysGit <msysgit@googlegroups.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCU63DXMWULRBNEKYGOAKGQEAHASR4Y@googlegroups.com Thu Jun 05 12:23:50 2014
Return-path: <msysgit+bncBCU63DXMWULRBNEKYGOAKGQEAHASR4Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBNEKYGOAKGQEAHASR4Y@googlegroups.com>)
	id 1WsUpp-0001EI-38
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 12:23:49 +0200
Received: by mail-wi0-f192.google.com with SMTP id z2sf233737wiv.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=u32N1ZCqetDTBytjI4jtgm1O/UOzMnPQTxcbbaDCgVY=;
        b=cYAOTnEe060uj21d7OT/yoDaHfbPgccVCGReJHrrvaQbriEdCgx7pHKzDDbSOwsCEq
         stB6+dL1Eg0ro/C+br4L9jsrmgw3jRTQsggxBDshUGwKE6wBT/Y/IFQ7zpHy4fMZ51xU
         y4I+vPo3zE+sx/zFdEvdFJMmuj2Fi4nd3LhpHPiDxnt72NaCv0ZGTRZu1LSq0cyW2Wa+
         SS2pgGFttyCtuNCC6xyo5CiiKBEnFPINElxjML+PfLWvGFDbO7QeFyrx9KorD1wtC7aE
         2ZDhIchYFqYvN9A5rHWcDdl38bsGZL+qvtWzolaLXmoxnncD+j3o7sSKkH 
X-Received: by 10.180.89.105 with SMTP id bn9mr7841wib.10.1401963828789;
        Thu, 05 Jun 2014 03:23:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.42 with SMTP id n10ls417497wiy.52.canary; Thu, 05 Jun
 2014 03:23:47 -0700 (PDT)
X-Received: by 10.180.182.17 with SMTP id ea17mr2148648wic.3.1401963827916;
        Thu, 05 Jun 2014 03:23:47 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si875389wib.0.2014.06.05.03.23.47
        for <msysgit@googlegroups.com>;
        Thu, 05 Jun 2014 03:23:47 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 9FCB31C009A;
	Thu,  5 Jun 2014 12:23:47 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s55ANlLu028562;
	Thu, 5 Jun 2014 12:23:47 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s55ANkcx028561;
	Thu, 5 Jun 2014 12:23:46 +0200
In-Reply-To: <53902B2C.7050807@web.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250829>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 2 Jun 2010 00:41:33 +0200

If HOME is not set, use $HOMEDRIVE$HOMEPATH

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

On Thu, Jun 05, 2014 at 10:32:44AM +0200, Torsten B=C3=B6gershausen wrote:
> > +		strbuf_addf(&buf, "%s%s", getenv_cs("HOMEDRIVE"), getenv_cs("HOMEPAT=
H"));
> should we have a NULL pointer check here?

You are right, of course.

> If HOMEDRIVE is set, but not HOMEPATH, we can fall back into the root of =
HOMEDRIVE:

Indeed, but it means setting homepath=3D"\\";

Updated according to your comments.  Thanks,
	Stepan

 compat/mingw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index a0e13bc..14af013 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1181,6 +1181,17 @@ char *mingw_getenv(const char *name)
 		if (!result)
 			result =3D getenv_cs("TEMP");
 	}
+	if (!result && !strcmp(name, "HOME")) {
+		const char *homedrive =3D getenv_cs("HOMEDRIVE");
+		const char *homepath =3D getenv_cs("HOMEPATH");
+		if (homedrive) {
+			struct strbuf buf =3D STRBUF_INIT;
+			if (!homepath)
+				homepath =3D "\\";
+			strbuf_addf(&buf, "%s%s", homedrive, homepath);
+			result =3D strbuf_detach(&buf, NULL);
+		}
+	}
 	return result;
 }
=20
--=20
2.0.0.9635.g0be03cb

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
