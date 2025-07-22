Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BA2576
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211423; cv=none; b=E/01BkJrXKEgaTSCCyitx6zgiVHP410w/8hoKtnfNiZgOtqpL4Su8drsVFCITj6w94LhEcZbJK3nHONDmKcNxY1usoFCmFtdANc/w10XL2UjykhuNzbSvljV0iTmx6217in3PHhDdkeOBVDb6rsnovJM9DCnaAtp9kQ3hk2m3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211423; c=relaxed/simple;
	bh=X0UqhqQ7VCNlqf5L2q+0wSJX7lrXfASW1uBjEg28li4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sw9RrN0DbEVPJG6KsqzzPTSTkVxhCeboaN9Rg+10lbFWIeqsN4d6yr5JU5tn+0oN/0YmZhP63HXE29xCkPycbeENQMtjZd1x1Pj+oTnFFiU/B8Sr3BwBHYY/0JapI3iMgL45WjS7ILV3Wros7Sv+BQzI/9btqwetolpxdwBlZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b=iiZxerjB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b="iiZxerjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1753211419; x=1753816219;
	i=jonas.brandstoetter@gmx.at;
	bh=rEPmSsIHlhE3m35W+D5x9eKeXnRCMagHUkcBTgSo8G0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iiZxerjBLnLWrVpUwkJb5yc4Ocs8dSLaV8v7WFo99J3636X8zfOl3zPIKMTkDSBf
	 gUAHUMZQ8cg6ufKGQLZzPZLInbS8OM+Aggd4a18v0ypBuIV/YaURJKSTvqv0OpQqY
	 w8r91ukknR9zCs1EPvwV5kJ9yN1VBUnwDi9PoKrb4gBlz/n9L/DjU1FCamFLF7dX3
	 2sTvleskdtNyjTzWwNBZgjBWM/ytT7TmlEl8l3RId7nPQwghLg1dYo8qBNxti4A7P
	 pJF/HBk9Q+AkF3jJy3g5WwXIi3FAflID+5GvfH16XI3jumX/GLwnKnwcySoUIXOqi
	 PDrGgctWEX0uSYLfyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from fedora.fritz.box ([185.89.163.201]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1udk983ukM-005QIw; Tue, 22
 Jul 2025 21:10:19 +0200
From: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
Subject: [PATCH v2 1/2] gpg-interface: expand gpg.program as a path
Date: Tue, 22 Jul 2025 21:09:21 +0200
Message-ID: <20250722190922.51183-2-jonas.brandstoetter@gmx.at>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+IeSprSHBPU2rKUiRQh8rCtiDPer2vMnteMOgN5HNzZGWXL8Xp7
 BcwKmU/7SWHUfkoW3ryyzvxriYcPqDSXdp7DoCodSs1QaWo+1uO4c4BMlM1XcueBzfVPzqB
 0t9ZUmCAgDBIA3hSilsZOFayiGUs4CLtu0zQS3LCJX3bxY+ldBxASoBUFPa390lwMN7yKG2
 Tkk+mRzYkjhTG62nsweog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H8xwNI7kdKM=;ztedWnpPF0AZnL8Jb0G10LcgJ2j
 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
 FN0BvXe3OLsy9aNkP0qA==

This allows using a custom gpg program under the user's home directory
by specifying a path starting with '~'

[gpg]
        program =3D "~/.local/bin/mygpg"

Signed-off-by: Jonas Brandst=C3=B6tter <jonas.brandstoetter@gmx.at>
=2D--
 Documentation/config/gpg.adoc | 2 +-
 gpg-interface.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
index 5cf32b179d..240e46c050 100644
=2D-- a/Documentation/config/gpg.adoc
+++ b/Documentation/config/gpg.adoc
@@ -1,5 +1,5 @@
 gpg.program::
-	Use this custom program instead of "`gpg`" found on `$PATH` when
+	Pathname of the program to use instead of "`gpg`" when
 	making or verifying a PGP signature. The program must support the
 	same command-line interface as GPG, namely, to verify a detached
 	signature, "`gpg --verify $signature - <$file`" is run, and the
diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..3dfbc45385 100644
=2D-- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -783,7 +783,7 @@ static int git_gpg_config(const char *var, const char =
*value,
=20
 	if (fmtname) {
 		fmt =3D get_format_by_name(fmtname);
-		return git_config_string((char **) &fmt->program, var, value);
+		return git_config_pathname((char **) &fmt->program, var, value);
 	}
=20
 	return 0;
=2D-=20
2.50.1

