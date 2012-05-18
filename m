From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: simplify refname handling
Date: Fri, 18 May 2012 11:27:32 -0700
Message-ID: <xmqqwr492vl7.fsf@junio.mtv.corp.google.com>
References: <4FB5DAE5.6020307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 18 20:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVRtt-00013E-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 20:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959Ab2ERS1g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 14:27:36 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:49925 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab2ERS1f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 14:27:35 -0400
Received: by eaao13 with SMTP id o13so191673eaa.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 11:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=tbDR2fabTZVMAuPMiPr5Kndaolhtl1hGFM6hPqMF4DU=;
        b=WM3gwf2R1jIv3QxlFeYJjnL4vKkY73PTXCCi2R/AHcrHNBnEhGflRzqfr1d3u9kTXD
         uUB3RVaiGw+XxCN65Msd/3b/VCkg1vDYkOLrBpGUIHsyfzi0hnDELkKWPt/S2kjGG4Cp
         9JfgSwZyZ+JUuyxd2VmXCMdHSRrBRc8XyM82nYKX3X/qhrBrj9H54g3Vq8QDl53VO1Dl
         35ls7QBgCTbYTd9CDX1W7xyAZ8TUGoVd0mdVZg0prd0iEpL9kvzkuGVctni5ZVU4H8kb
         sfJzuBvcxS2COcgkImZVjOHASIt49BDWZVKY4S8PNirzGz40YXLsdFyrhU1++Um1sM4i
         6Sxw==
Received: by 10.14.53.12 with SMTP id f12mr2547245eec.4.1337365653963;
        Fri, 18 May 2012 11:27:33 -0700 (PDT)
Received: by 10.14.53.12 with SMTP id f12mr2547237eec.4.1337365653880;
        Fri, 18 May 2012 11:27:33 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b16si9414781eeg.3.2012.05.18.11.27.33
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 11:27:33 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id ABA7520004E;
	Fri, 18 May 2012 11:27:33 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id CB2A7E1772; Fri, 18 May 2012 11:27:32 -0700 (PDT)
In-Reply-To: <4FB5DAE5.6020307@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Fri, 18 May 2012 07:15:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkxt3AsEmc+p9hDrTC5rc/e18Xy8HGtF3f9GjWobVx+WvHEkYvN0tDXB3puXWsHR14BJhG3NoBe5616bTl5/pa4RIbQaiuK/2fdf+wEl+wIITnpL09XLjgDkKUM1pc1JMohWo3VAj0WEd+vF+Ee/Ke654Lw4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197965>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> +		const char *colon =3D strchr(name, ':');
> +		size_t refnamelen =3D colon ? colon - name : strlen(name);
> +
> +		if (!dwim_ref(name, refnamelen, sha1, &ref))
> +			die("no such ref: %.*s", refnamelen, name);
>  		free(ref);
>  	}

Both dwim_ref()'s second parameter the vararg that corresponds to the
length part of "%.*s" in die(), expect "int", not "size_t", so I needed
this to get it compile.

 archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 081ecb5..1e7156d 100644
--- a/archive.c
+++ b/archive.c
@@ -261,7 +261,7 @@ static void parse_treeish_arg(const char **argv,
 	if (remote) {
 		char *ref =3D NULL;
 		const char *colon =3D strchr(name, ':');
-		size_t refnamelen =3D colon ? colon - name : strlen(name);
+		int refnamelen =3D colon ? colon - name : strlen(name);
=20
 		if (!dwim_ref(name, refnamelen, sha1, &ref))
 			die("no such ref: %.*s", refnamelen, name);
