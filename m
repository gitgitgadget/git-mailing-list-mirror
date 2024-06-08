Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8F20B3E
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717871885; cv=none; b=GG8Du1FHrxL0yudZfI0olTpZ8n8NO2QT1sdSDBV3swmp3tYe1x+V3Q8+JhW/gg39q+Q4p2xZtcV/wV60AE0fiyhM2Iyg7aHhVEt4xjfx4i8+zRuXBYW+uWnJEBpsX5G8UXDenKk6bJsYbqkNMoSciXBVeUEup/oemqlAjB1dlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717871885; c=relaxed/simple;
	bh=XvRZIBdceofUvcMn6XOO4psWr8m2EK0JROr01LjShlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv0l0/BdvisDM2F3oxRCfJ3K7BZ4CgXAnXwtC5HTvE3BvbLQ/zgag8e5hRDo5/TfvSQqfLqN46sGJUcefVKMozKYiLLt6sAuDhBBgyTzOTVe5nGoLgcpMOTfv71Pr9qSXshafn9jM/HrZjnk4tC7TMNeU9Hdr6TwXa2NS9fceIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CnBtjevd; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CnBtjevd"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B060A1FCC9;
	Sat,  8 Jun 2024 14:37:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=XvRZIBdceofUvcMn6XOO4psWr
	8m2EK0JROr01LjShlQ=; b=CnBtjevdNRE3o/lWYYh5YyK4ol5SiixaD8E7n4zt7
	O5YpVlCWHSQYaYMc4vkIoKtFWBXQkZZlSjjEgSIAJpzj04/e4iFj0otpQC3x94Hq
	I4uMrU/SMRAomzz7l30yYx5UabABl3b5JJ7py90VvZCFpUh7rP1uEJqau75IhrHZ
	yE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A95BA1FCC8;
	Sat,  8 Jun 2024 14:37:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 629AE1FCC7;
	Sat,  8 Jun 2024 14:37:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] __attribute__: mark some functions with LAST_ARG_MUST_BE_NULL
Date: Sat,  8 Jun 2024 11:37:46 -0700
Message-ID: <20240608183747.2084294-4-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-445-g1b76f06508
In-Reply-To: <20240608183747.2084294-1-gitster@pobox.com>
References: <20240608183747.2084294-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 388B32BE-25C6-11EF-9799-8F8B087618E4-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Some varargs functions that use NULL-terminated parameter list were
missing __attributes__ ((sentinel)) aka LAST_ARG_MUST_BE_NULL.

Add them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-patch.c | 1 +
 attr.h      | 2 ++
 hook.h      | 1 +
 scalar.c    | 1 +
 4 files changed, 5 insertions(+)

diff --git a/add-patch.c b/add-patch.c
index 814de57c4a..d8ea05ff10 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -299,6 +299,7 @@ static void err(struct add_p_state *s, const char *fm=
t, ...)
 	va_end(args);
 }
=20
+LAST_ARG_MUST_BE_NULL
 static void setup_child_process(struct add_p_state *s,
 				struct child_process *cp, ...)
 {
diff --git a/attr.h b/attr.h
index e7cc318b0c..bb33b60880 100644
--- a/attr.h
+++ b/attr.h
@@ -190,6 +190,8 @@ struct attr_check {
 };
=20
 struct attr_check *attr_check_alloc(void);
+
+LAST_ARG_MUST_BE_NULL
 struct attr_check *attr_check_initl(const char *, ...);
 struct attr_check *attr_check_dup(const struct attr_check *check);
=20
diff --git a/hook.h b/hook.h
index 19ab9a5806..6511525aeb 100644
--- a/hook.h
+++ b/hook.h
@@ -86,5 +86,6 @@ int run_hooks(const char *hook_name);
  * argument. These things will be used as positional arguments to the
  * hook. This function behaves like the old run_hook_le() API.
  */
+LAST_ARG_MUST_BE_NULL
 int run_hooks_l(const char *hook_name, ...);
 #endif
diff --git a/scalar.c b/scalar.c
index 331b91dbdb..62dd77aaec 100644
--- a/scalar.c
+++ b/scalar.c
@@ -70,6 +70,7 @@ static void setup_enlistment_directory(int argc, const =
char **argv,
 	strbuf_release(&path);
 }
=20
+LAST_ARG_MUST_BE_NULL
 static int run_git(const char *arg, ...)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
--=20
2.45.2-445-g1b76f06508

