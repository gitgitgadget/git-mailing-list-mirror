From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Add missing inside_work_tree setting in
	setup_git_directory_gently
Date: Sat, 3 Nov 2007 20:18:06 +0700
Message-ID: <20071103131806.GA25109@laptop>
References: <20071103100323.GA25305@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 14:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoItZ-0002fq-3w
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbXKCNSS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 09:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbXKCNSS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:18:18 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:41654 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbXKCNSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:18:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1051578rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=iFVZWjUJG9Byh3O1vE8AHsPEXtRPiTCxVYnLcNaHkHA=;
        b=Pb9t9NIPNPEM+18py4aZeNOHNvcXIvnMTn3/Ga4MlGkRldakaGrD/3SFysTmpw+DHON9zU+TgxfotNrbAuUjt97iSG3EhLGJM/HfXDtQFrMs/XeebTqwu/HIv2Fr4l5YILAFRsLT4DXpvwlemnIR2H3qbRIiXAxWAphYJicePcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=r4FD7RXPEZWjuDEUKFe+JyOAgBrXUuROBK+3nEANgACxFTGpVivnQ05DsUP61YxnsNkGaDtDvlEQCCa86CbeXSnr5W7y8SVUbLY59DV2t+YxNJl59qAo3u7MCcmiHKkNSgHyNnkbXfX0ly/xAjhgPLTv/zvCm2LrVQopVL0Pjfo=
Received: by 10.141.88.3 with SMTP id q3mr1436412rvl.1194095896180;
        Sat, 03 Nov 2007 06:18:16 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.0.14])
        by mx.google.com with ESMTPS id c3sm7657561rvf.2007.11.03.06.18.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 06:18:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat,  3 Nov 2007 20:18:06 +0700
Content-Disposition: inline
In-Reply-To: <20071103100323.GA25305@laptop>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63265>

When both GIT_DIR and GIT_WORK_TREE are set, and
setup_git_directory_gently() changes the current working
directory accordingly, it should also set inside_work_tree =3D 1.

Without this, work_tree handling code in setup_git_directory()
will be activated. If you stay in root work tree (no prefix),
it does not harm. It does if you work from a subdirectory though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Updated commit message accordingly

 setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 145eca5..6f8f769 100644
--- a/setup.c
+++ b/setup.c
@@ -240,6 +240,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (chdir(work_tree_env) < 0)
 				die ("Could not chdir to %s", work_tree_env);
 			strcat(buffer, "/");
+			inside_work_tree =3D 1;
 			return retval;
 		}
 		if (nongit_ok) {
--=20
1.5.3.rc4.3.gab089
