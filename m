From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 12:44:33 -0400
Message-ID: <32541b130807240944s6b4abd60j4ff95eccf7017770@mail.gmail.com>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
	 <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807230203350.8986@racer>
	 <alpine.DEB.1.00.0807230229410.8986@racer>
	 <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de>
	 <20080723114022.GP2925@dpotapov.dyndns.org>
	 <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de>
	 <20080724140959.GU2925@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.0807241537000.8986@racer>
	 <465DE5CD-DA13-42B4-B0D8-961F3D118F59@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM3wd-0002xF-NS
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbYGXQog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYGXQof
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:44:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:53058 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYGXQof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:44:35 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2765373wxd.4
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uWjPnSTpF35SqKufqEighiHR5nSbn/49DElIaoTeOxY=;
        b=vWMviZHEF66GNQDpBnHpRURPL5B4G8HK8b44ULLWoHsFEJV+uLVK8sA9H6PBeTMjpE
         WX8/bInyhPuPUZMTUSN+lLIIWqiEW5nDij5jZL7YYfhLNy2jyxN79UtwUvXfa/rxtA6C
         LD1KWVUBQQtnnBiEkzhpAPBhsfi5rZ6WIzInI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ce2XYkjfMB4JoCDAiRZkNKSlmHqs4+MgMgqX+qfKpbGpQ2wwXp0hkUVl8QSMVAVy8F
         xU0EfqB6F00tKFap3wVPlcuUHVHi40epBsMh1ORPRtMmrZn+D+JL4+JZGCPgr4MoazaU
         LEaGrTbEShVYYlesx9NmG3hiNhbwBVY/xz0UA=
Received: by 10.100.41.15 with SMTP id o15mr886832ano.48.1216917873144;
        Thu, 24 Jul 2008 09:44:33 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 24 Jul 2008 09:44:33 -0700 (PDT)
In-Reply-To: <465DE5CD-DA13-42B4-B0D8-961F3D118F59@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89904>

On 7/24/08, Steffen Prohaska <prohaska@zib.de> wrote:
>  Why is it unset?  Since 1.5.5, our installer sets core.autocrlf=true
>  on Windows.  So we *do* set a sane default for Windows users.

Well, if you've been following the thread, not everyone uses msysGit,
and cygwin Git doesn't set autocrlf by default, and changing such
things behind people's backs can be really nasty.

So I can't decide if I mean the following as a joke or not ;)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 38b4fcb..91b79dd 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -314,10 +314,19 @@ int init_db(const char *template_dir, unsigned int flags)
 	}

 	if (!(flags & INIT_DB_QUIET))
+	{
 		printf("%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
 		       get_git_dir());
+#ifdef _WIN32
+		if (!auto_crlf)
+			printf("WARNING: You're using Windows but core.autocrlf is not set!\n");
+#else
+		if (auto_crlf)
+			printf("WARNING: You're not using Windows but core.autocrlf is set!\n");
+#endif
+	}

 	return 0;
 }
