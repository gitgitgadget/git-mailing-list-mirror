Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46513112A1
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220426; cv=none; b=JifttFcXf+h7qr3H4bzJgJxi05i8TgVahtb/j2e4JAAy2Ecpt4/I8gsshn8kONlBt9/XYIDjvaLpx4mS1G3V+ON47evuvRKT2sQuuEGM2dF1aTKcbZxIV8o1skiIJS9dvzj2fs5aSb2sMKZn8pfsoiRu+XhjCPfPzHedQRMeGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220426; c=relaxed/simple;
	bh=CTFXLeCijfX5OKXSV/iaoVvA1j+cyPnqYjekgI/Sc8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D4YM6hZDcEJ/7mRm+s/ixtAiG+PmOSAmw28Kpjc6Iyrt4NbUaUVoZHA9tMOxs9dDF1+Evp/DDjRD3RtVe9ZwiG6Tuxpw40Z5Gu7ZeGr7MR5rCN/jkLH9oWlBucS5+aDrsjsibOMUukOmTN8/UT6DyoJbwMDGDeIGx+jCv+EVWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wn8WhwFH; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wn8WhwFH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772220423; x=1772825223; i=l.s.r@web.de;
	bh=dzvhpW9gt2XHIbU92JV/CgDb7vU+EAeCS88T8wIYy6I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wn8WhwFH/7FyZScxrBEvMEu/s60C571QrcrZXLd8kf/JO0e29Y+xY6UL3eCA4ljg
	 DSwvwBP1YoiUkoN8DKoiIDrTAXySHP7D9BieKVlwPRGkxEs20UQ9s+ucWNZ2Vv8OP
	 LTKGceNfWIvwXHGk7nf4PQ6/zS+NLKsBg43UOsdqVSMlvewxpIONiZR8kcYeFy7Y1
	 pUpqYxvLgnTxgJLeIGQwa0O7I9I1xN0cbVkGGZ58DFhOJygVdQc+bTXYloxb+A5b0
	 wWBF37z512AaQzvsvLV5+9/C808cj8rFSfDBvM64pVq78EfVJPc5WwEa9WCobCroK
	 1Lo834nC2YdM4wc05Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gbY-1vaLsy47Sk-010XsQ; Fri, 27
 Feb 2026 20:27:03 +0100
Message-ID: <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
Date: Fri, 27 Feb 2026 20:27:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] parseopt: check for duplicate long names and numerical
 options
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5x7jujqb.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5x7jujqb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P8WnwPv/FESB9mAWEltQyTT/+AHrcZdYTWLoliKybLOEtCXwa3z
 EuAwAQvzRt5jTJLtx+vGSEXSx+TrHHDyty2v1yuWF0ycGoks5Ot+vZ2gTAXjDX4dqz0Oshn
 /vlVQFzpyLkDlKN5hAso13RPN7qwIH6JEl95Z//5htTPXXI884mCGP2usbD2NH/7zg81kWj
 82ucRu9hP3F38J8wdsQOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qxEGTCZzIr8=;50ODTjEgHF5H3qEZTfS7AXJECQg
 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

We already check for duplicate short names.  Check for and report
duplicate long names and numerical options as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
The check clearly has a cost, but I have a hard time measuring it.
We already do lots of (kinda cheap) checks.  Turning them on only
in DEVELOPER builds (and ideally demonstrating a speedup) left as
an exercise for interested readers (with stronger benchmark-fu)..

 parse-options.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index c9cafc21b9..51b72eee11 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "strmap.h"
 #include "utf8.h"
=20
 static int disallow_abbreviated_options;
@@ -641,6 +642,8 @@ static void check_typos(const char *arg, const struct =
option *options)
 static void parse_options_check(const struct option *opts)
 {
 	char short_opts[128];
+	struct strset long_names =3D STRSET_INIT;
+	bool saw_number_option =3D false;
 	void *subcommand_value =3D NULL;
=20
 	memset(short_opts, '\0', sizeof(short_opts));
@@ -655,6 +658,16 @@ static void parse_options_check(const struct option *=
opts)
 			else if (short_opts[opts->short_name]++)
 				optbug(opts, "short name already used");
 		}
+		if (opts->long_name) {
+			if (strset_contains(&long_names, opts->long_name))
+				optbug(opts, "long name already used");
+			strset_add(&long_names, opts->long_name);
+		}
+		if (opts->type =3D=3D OPTION_NUMBER) {
+			if (saw_number_option)
+				optbug(opts, "duplicate numerical option");
+			saw_number_option =3D true;
+		}
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
@@ -712,6 +725,7 @@ static void parse_options_check(const struct option *o=
pts)
 			optbug(opts, "multi-word argh should use dash to separate words");
 	}
 	BUG_if_bug("invalid 'struct option'");
+	strset_clear(&long_names);
 }
=20
 static int has_subcommands(const struct option *options)
=2D-=20
2.53.0
