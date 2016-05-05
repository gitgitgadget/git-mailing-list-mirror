From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 01/19] read-cache.c: fix constness of verify_hdr()
Date: Thu,  5 May 2016 17:46:53 -0400
Message-ID: <1462484831-13643-2-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:47:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7K-0007jd-3k
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752AbcEEVr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 17:47:27 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34919 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbcEEVr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:26 -0400
Received: by mail-qg0-f44.google.com with SMTP id f74so47439951qge.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=oHXG+d75lw75BL0bSDbd4dwoOlzNtZj2rvHyo6AbnWv1UTPXmp/n/2o7y4Wdx9u4/f
         apxkQo7vqhozFsujb1zSX83W1Eh1EtL+zCshCF/Xt4k7h8DFsJY3PBIPpncjleLA/yli
         JT0MwCGSIEscfNltgdZ/5L3Hi0kFZeic6oGMCpL1DJcOTMLfrMGhRf5F1H5yQwD3xI/S
         QEjdjmwtZNnU3VJC7eZpXHqBPO2Pcfn3ODf9ZRj7NJYn5kDE9j/Gdd1vFJEzmAELhZQg
         eSqZMNKIfE4eSeStVMX0tBGAOa5J2TrNYahy+vnHiQcK2ZavDPBdFaLiRDjaoqje8457
         wEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=du64yQR+sT1DXHfmj6ezQVXecJHepF90nCcKZcpD/5e9AFv9O4yLUiNQ3p/fWy4m20
         6b3oTmzXdBpARoSDw1GEyeL4wa0/hDUI3CpMMhVCJ2QVdE8889U2hu7vz2Zs3wTd2CEa
         aer3lU7Z4oofIxLCzM6VJ6ghRIrwO57k3mvSOOS/lNpNKvil+PL9p4qwAzvRtCnZQHxW
         1VVSyEQTOner/79CaAeIygvA5fud7REyMTcp6AIUI3J4pi80NAYJhcoZZVBugJinstMb
         CJD2yFudo6XEelTSs34JUmWZV47i+i/hWfk7OUOB6KWxR+SlCZuXSObt1AsMpfAj8y+n
         zzEg==
X-Gm-Message-State: AOPr4FUpyP9u+Brbaj6+nAhcPyMupc9lHgMcsrHdfubwmt7wE73CHoN7Fes6Lx9bYccdTQ==
X-Received: by 10.140.205.68 with SMTP id a65mr17514017qhb.6.1462484845694;
        Thu, 05 May 2016 14:47:25 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293686>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index d9fb78b..16cc487 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1345,7 +1345,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long si=
ze)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
--=20
2.4.2.767.g62658d5-twtrsrc
