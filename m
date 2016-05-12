From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 01/20] read-cache.c: fix constness of verify_hdr()
Date: Thu, 12 May 2016 16:19:56 -0400
Message-ID: <1463084415-19826-2-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x7J-000657-Rn
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbcELUVo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 16:21:44 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35302 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbcELUUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:23 -0400
Received: by mail-io0-f171.google.com with SMTP id d62so109277690iof.2
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=DQabWpSZhtK55Kwx+veyDNqnJOnzSY8GItDB8fdnYOhxVjY1XBDNTiVb/lkNJtcAdQ
         gBuj01CJDG7z+jZLnXGPCNZZXIAETLuOVz/aKZ90XM3fUY2wRRDvpoZ8pAceZFMxAc7g
         uJn7wftR61jV0W2okXDe53smCBfKEiA2fWCJs3Rsx7uZTddn8JpQFzYDtQGYEGHikCc/
         +6kr5oj3zet35uEESJgkPJctMQLcd2Dbx4FkGoNFVxHL29471C0HpLYXr+FY8uWVp6wf
         I43R17yM6sJflih2kx8yreJKgNlYXCXj86RPaEPU14sUC33rzySVxaCv2qDDnwpxNDtB
         mNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=lLi8L2VdNet1rZbZJg0TjPAW7bm+Ze74cJaRP8puhcNq+JjQbTxLgxjIB6SXIhduTM
         9TmVc0iirGPRVDPApW+9RJIMkr3LTXBgSJ2GGuej+yRWJR6zmvqKxx6OWJtjdygXoNYJ
         i9DZWThXbhO9AHK03vIEgL8YLfsajXwDw7zqW8oD3TbWnklZSDxicJuwez1CiHNmYY0A
         wx+rdgTZcAyBJ4lbqQuOAvKL1M6JrO5zRrwh7geV9I0qrfvEHiA+lfjGhD/vzXcIQBCN
         6oK36xMfiaih8DCGBKBA1n3QEHYIpXrWSIs8vkilqZqb28ZiTUzdOmXvGLcrwfArq9/P
         i56Q==
X-Gm-Message-State: AOPr4FVc1HS1yjgbEK3+hKLh+3o+3rz+QlaJrmSFh+n/8VVRepKVgtU+rL+cbMGQP8oMkQ==
X-Received: by 10.107.151.206 with SMTP id z197mr8982642iod.191.1463084422514;
        Thu, 12 May 2016 13:20:22 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294471>

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
