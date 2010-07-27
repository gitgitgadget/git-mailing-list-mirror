From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
 available repositories
Date: Tue, 27 Jul 2010 12:41:05 -0500
Message-ID: <20100727174105.GA5578@burratino>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
 <20100726232855.GA3157@burratino>
 <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com>
 <201007270916.59210.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Brockman <gdb@mit.edu>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:42:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdoAg-0002RT-MD
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab0G0RmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 13:42:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36618 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab0G0RmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 13:42:24 -0400
Received: by eya25 with SMTP id 25so789567eya.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S+N+hH55+IK8qHBsJdIrjQ8YEFdsi6v8O2oEaZ5ApJY=;
        b=fQs+V/Aop88Qi9LIox9DagYKv5aCADTcqQg6I5wrTCSgrSoPZ/1kZqiOfYaj8jLViD
         s0TW5T1bs7aKSqNUM2jQlHV97wvHC8/zvYDJCdKtwmgLlEgztodo3O/ooFnr2IkJqPTF
         fvbuzJNiPKmjN8iDdw0keH9pGUpHCU/IA1C/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=SBWpthACpVDjIeAHGH2Pkdrl2+nA6Odh39SXXTquHJiP2GHa+vFFfr++02++JDQOWX
         URC6IQtpb+EBlIplulD/hfe1YHjoLkm5Pevm1kkA3OtUZPNmq76hLeDUXKGbz5DZrT+l
         pSawYAJeDRg+VtWzEh7LuNj20QnsbrhG2fOeE=
Received: by 10.213.26.13 with SMTP id b13mr5011803ebc.91.1280252541795;
        Tue, 27 Jul 2010 10:42:21 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v8sm7923928eeh.20.2010.07.27.10.42.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 10:42:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007270916.59210.j.sixt@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151965>

Johannes Sixt wrote:

> Windows does have execv. The patch is OK in this regard.

Thanks, that=E2=80=99s a comfort.  Sorry to spread misinformation.
---
diff --git a/compat/mingw.c b/compat/mingw.c
index 9a8e336..9212a12 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -854,6 +854,11 @@ static void mingw_execve(const char *cmd, char *co=
nst *argv, char *const *env)
 	}
 }
=20
+void mingw_execv(const char *cmd, char *const *argv)
+{
+	mingw_execve(cmd, argv, environ);
+}
+
 void mingw_execvp(const char *cmd, char *const *argv)
 {
 	char **path =3D get_path_split();
diff --git a/compat/mingw.h b/compat/mingw.h
index 3b2477b..d81b2f3 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -237,6 +237,9 @@ pid_t mingw_spawnvpe(const char *cmd, const char **=
argv, char **env,
 void mingw_execvp(const char *cmd, char *const *argv);
 #define execvp mingw_execvp
=20
+void mingw_execv(const char *cmd, char *const *argv);
+#define execv mingw_execv
+
 static inline unsigned int git_ntohl(unsigned int x)
 { return (unsigned int)ntohl(x); }
 #define ntohl git_ntohl
--=20
