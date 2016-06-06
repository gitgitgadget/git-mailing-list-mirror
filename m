From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] commit: don't count i-t-a entries when checking if the new commit is empty
Date: Mon,  6 Jun 2016 18:16:42 +0700
Message-ID: <20160606111643.7122-4-pclouds@gmail.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas.braun@virtuell-zuhause.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 13:17:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9sWv-0008F2-Co
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 13:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbcFFLRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 07:17:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33266 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbcFFLRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 07:17:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id u67so1661133pfu.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnaDa+VQSWcQmeqZp+Lfvd1ZCMxQqwfb7yLvacElkjU=;
        b=GB//uIA1r01aGUiAR2dd1PgQY1SjluhnpA9chXbydFB3tDLO9T+eGPbnvOA8Vi5G0g
         uNch/QkKi0QIF4WEafZuhXu2juwB2XYGgj7/ap96Z5FVC3XRvfZ+vWcyZ4ugd2OpBM5S
         ifJlehbBfluVMbZ7cEb5J1c0miQD5BdwvCaHQNzStZcVrBQCQMalrHZHAZe1qjOlCVcR
         TomsnAfjQGnqJrs0FMnw5uNdFth8tEPZGFFnCZNDjnYcwkbUI0w0M/PUGfZK6phfFdti
         g3xqtlKRGloobfUM8O2+lu8U6zj4ZI2/EXwXslnxaO+Kf5zHD/hbanCuBrw1ANgizh9u
         AYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vnaDa+VQSWcQmeqZp+Lfvd1ZCMxQqwfb7yLvacElkjU=;
        b=FnZLkaNBfDbsPUGiJfHzkeu38m69O08VVhcqA3rExkXxX8trNcxljpJx9BKAg+LFV/
         U/IseeTOXdi/q1FvzXhD3MiVNJr1M7fXNR2Is+kIcTQbY1cTU7+Uk4ghLe0jmtMy9JM5
         C1Wkz7y2TQFTOToy5NA4XqUa7Q6dTzE+BbD480fyQFp79Gnpvdcx7QskqrxMZVQIlRVq
         2Uqkxd1XgSs8b6ChjcDeyRMGjebY+OCsZ+guqfAp2DFHUNlrieG75fO9yJlpGk3ItZEl
         TPHlSBo5UcNh7u6cOQYxmA4j3+aOMoTrl7J7/8PfRhh0BD+6GCGp4BSj5hRbji2kjWEj
         IuPQ==
X-Gm-Message-State: ALyK8tKxHQXBe21XIae7CZ1s2xJZqvfpcz//FEap7Cn0AZ2kQlmDTf7t3G3CUZ0ggw23/Q==
X-Received: by 10.98.6.193 with SMTP id 184mr25083480pfg.109.1465211825752;
        Mon, 06 Jun 2016 04:17:05 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id m187sm10757626pfc.57.2016.06.06.04.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 04:17:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 06 Jun 2016 18:17:01 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160606111643.7122-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296499>

i-t-a entries are excluded from tree building. Relying solely on active=
_nr
(or diff without --shift-ita) may lead to empty commits sometimes, when
i-t-a entries are the only ones "changed" in the index.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fcfaa2b..e98ca8a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -894,9 +894,14 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
 		if (amend)
 			parent =3D "HEAD^1";
=20
-		if (get_sha1(parent, sha1))
-			commitable =3D !!active_nr;
-		else {
+		if (get_sha1(parent, sha1)) {
+			int i, ita_nr =3D 0;
+
+			for (i =3D 0; i < active_nr; i++)
+				if (ce_intent_to_add(active_cache[i]))
+					ita_nr++;
+			commitable =3D active_nr - ita_nr =3D=3D 0;
+		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
 			 * ignore mode by passing a command line option we do
@@ -910,6 +915,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				diff_flags |=3D DIFF_OPT_IGNORE_SUBMODULES;
+			diff_flags |=3D DIFF_OPT_SHIFT_INTENT_TO_ADD;
 			commitable =3D index_differs_from(parent, diff_flags);
 		}
 	}
--=20
2.8.2.524.g6ff3d78
