Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50790335BA8
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052011; cv=none; b=pv07F2N2QDQSQI1Ua1BIRugxddWBNi+vzQ9TH5jQ/JqM3JH35T05STgdI/MNTQTmzsm6tOZ/iqhG/bOOFglnjHJbMFQR6MzonENP8Ra9dcnBUcF2a39bdSgnSB/TQzZCuQsGGcyRl+2Uas62dMEtvf3qBUpaAGfhzUQw261i+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052011; c=relaxed/simple;
	bh=juIE81gLHdzbFHdJ+UdARgokgJb8IQrykukivg5A0rM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiLS7gm/1CrZXJvjjXJEaID9JUQNInRNuGsbLJStP3j/r+dYmSAboUmSWlnAwTRfcrBvaFni5QThYF/pJCyF3PZJ2IDUzrjjkvPYp7SOhMtoe4WJYM6LElfZofatqBMVesMaMikHkWpfCHOnDYorI40xCqmytBwBUbTr3+WAYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HVMp41Cv; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HVMp41Cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784052007; x=1784656807; i=l.s.r@web.de;
	bh=85qs2xMysC5ZUZf20N2mpHKf0a2YMkWktAcMPNAOCaA=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HVMp41Cv+Jv1tZytFHX527cNVvxLknhiXwT5uld6+a8H2tnGHj4msul37hmfsSzM
	 MBmA/BwfrnFVVDkAjE664sf7D3k+e9PB/EvElvdEdlGAPcKFIt5Ijed2nCQ3vU6zF
	 gSv+NJ8wTa7CWRzukVXG5LDhZrq3lruAFsVGMUmTJ9TBgA8D277APySN6dqgWs8Um
	 CJ67thIoJXmUfafh0eNF5zDcHW+3ZbllOw9UNZGp256PhpbT/Uy6nn6UD7x95VXEy
	 2dvcH1emV/sUnpMpLMKeaa6JWnBxAk8TQrYN6jv/J4gIQpHPdc1thc/aBHw0aBD89
	 BYXtCRxHZRFPYm2VAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3oz4-1xA8IB19eK-010tSG for
 <git@vger.kernel.org>; Tue, 14 Jul 2026 20:00:07 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 4/5] tempfile: stop using the_repository
Date: Tue, 14 Jul 2026 19:59:55 +0200
Message-ID: <20260714175956.54601-5-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714175956.54601-1-l.s.r@web.de>
References: <20260714175956.54601-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gc0BGJKI4uEaD9koRU32sVEVGgbexVUYf3UUr5RqVCWhaVVzlJp
 k32k6yQillv4F5y8JLTOBFD5VAwh2mGfJwqh0AUP3HVH9ziJ/wjrMKaUp58DKwOGH2rsCFl
 GbdZHz+HTs+pG4/QUxTg0bB3i0fKPOzECTA4Rb4RR6FGvi7wLljc8HXW7Ol84HoTvdiGql/
 pITakFGcY5zmB9hIX9R1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J712cdKk4ZE=;dX0qCKW1UeaRA8vAlqAow7ouT+w
 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

Remove the compatibility wrappers create_tempfile_mode() and
create_tempfile() that have become unused.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tempfile.c | 7 -------
 tempfile.h | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 3132eb4371..dc9ca4e645 100644
=2D-- a/tempfile.c
+++ b/tempfile.c
@@ -42,8 +42,6 @@
  * file created by its parent.
  */
=20
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "path.h"
@@ -134,11 +132,6 @@ static void deactivate_tempfile(struct tempfile *temp=
file)
 }
=20
 /* Make sure errno contains a meaningful value on error */
-struct tempfile *create_tempfile_mode(const char *path, int mode)
-{
-	return repo_create_tempfile_mode(the_repository, path, mode);
-}
-
 struct tempfile *repo_create_tempfile_mode(struct repository *r,
 					   const char *path, int mode)
 {
diff --git a/tempfile.h b/tempfile.h
index 2d17e4dad3..f571f3c609 100644
=2D-- a/tempfile.h
+++ b/tempfile.h
@@ -94,16 +94,9 @@ struct tempfile {
  * `core.sharedRepository`, so it is not guaranteed to have the given
  * mode.
  */
-struct tempfile *create_tempfile_mode(const char *path, int mode);
-
 struct tempfile *repo_create_tempfile_mode(struct repository *r,
 					   const char *path, int mode);
=20
-static inline struct tempfile *create_tempfile(const char *path)
-{
-	return create_tempfile_mode(path, 0666);
-}
-
 static inline struct tempfile *repo_create_tempfile(struct repository *r,
 						    const char *path)
 {
=2D-=20
2.55.0

