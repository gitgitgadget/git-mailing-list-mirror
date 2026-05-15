Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEDF37FF4C
	for <git@vger.kernel.org>; Fri, 15 May 2026 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878705; cv=none; b=qUVMH9q40DuenSeAII21ib8ngKf7cpVKNPjIQwLG3ge+gSe44FGdczFgoUt/aNWoljXW1vEV1lgmAG2VajDbXoqPITcww0XpCGRLziOHLlRdUAbtZ9jZvvIF2JsT0jUm3AEgp9sKhfQEM+o54wwNhJfEQrk6cIHljIo/nM4BZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878705; c=relaxed/simple;
	bh=g+0O3Rr5FBXoqNsgzOBc3/1ye0MyBz9lU52vFirsn1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dFE0sF1IAlKfDPqgdJb0JhVrcEffhNYZhUXZn8wj0oqxKi4yCjRPVdwDhRwd/zqihOq1m04IkFejsc/YncS2e1sG4GpXvQovRsjfEvqHvhdT6Bl2VTWMxB1XiKjoltR/J+eZNzyDYIkIvwd08mcP77otyqnEWATVzFwg2+khy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Uz6ro86b; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Uz6ro86b"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64FKw5uR030294-64FKw5uT030294
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 15 May 2026 23:58:05 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wNzbh-00A9n4-JN;
	Fri, 15 May 2026 23:58:05 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 23:58:05 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 1b81ec74;
	Fri, 15 May 2026 20:58:04 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [RFC PATCH] approxidate: make "today" wrap to midnight
Date: Fri, 15 May 2026 23:58:03 +0300
Message-ID: <20260515205803.26211-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-13.utu.fi (130.232.247.53) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=LCtLJA+s6ZuBQ/sgY9EL7qM+epwQm+zPoFGm96gsb3E=;
 b=Uz6ro86bzOT2Ys26ZvUhH8un1INtR2or/QsvTWWe9EzfWuwQCkcjHol1wL8Du16BhMVf7/f0Bild
	8FB30+SKrY+SGxaHJShGHFU26hKki1mTh1OP3PfxK15AOFlFv2HRruaNlR+rn4iTZt/6DAwx3ise
	NzViFHkT1yvk5Ua+SpS7u0dzEKQz8JNDuulESTDgNmIWhSjGU7sGihLSH7ifSvjSNyHa3ER6Uynb
	rJdlIoE/tx4XxB4rtBotLaWWGaLIew8OYLa44jabadKWnDK9Mnsp8czdsJ7v38THi0EzYZGw6qxC
	AtBwaeL6UGgzTlx7m5hGPOLNhDM8TqAAasIWGQ==

Although some commands do reject invalid approxidate expressions,
in other cases those are simply evaluated as the current time.
Oftentimes that is a perfectly good compromise to handle silly
requests, but it isn't without rough edges.

Let's consider what "git log --since=today" should yield.
As it happens that "today" isn't actually a valid approxidate
format, the command currently tries to list commits with
*future* timestamps.  Perhaps it would make more sense if
it returned the commits made since midnight---that is,
during the current day.

Moreover, a revision parameter "@{today}" is currently outright
rejected.  Making "today" a valid approxidate time format could
make a natural way to specify the state of the ref at the start
of the current day.

Bind "today" to new function `date_today()` as an approxidate
special.  Make it return the last midnight if no specific time
is given; i.e. retain the old behavior of "noon today" and such.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    The "Jan 5 today" test is adapted from
    
      c27cc94fad (approxidate: handle pending number for "specials", 2018-11-02):
    
    > (saying "Jan 5 yesterday" should not respect the number at all).

 date.c          | 10 ++++++++++
 t/t0006-date.sh |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/date.c b/date.c
index 17a95077cf..343d6aab6f 100644
--- a/date.c
+++ b/date.c
@@ -1192,6 +1192,15 @@ static void date_never(struct tm *tm, struct tm *now UNUSED, int *num)
 	*num = 0;
 }
 
+static void date_today(struct tm *tm, struct tm *now, int *num UNUSED)
+{
+	if (tm->tm_hour == now->tm_hour &&
+	    tm->tm_min == now->tm_min &&
+	    tm->tm_sec == now->tm_sec)
+		date_time(tm, now, 0);
+	update_tm(tm, now, 0);
+}
+
 static const struct special {
 	const char *name;
 	void (*fn)(struct tm *, struct tm *, int *);
@@ -1204,6 +1213,7 @@ static const struct special {
 	{ "AM", date_am },
 	{ "never", date_never },
 	{ "now", date_now },
+	{ "today", date_today },
 	{ NULL }
 };
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 53ced36df4..07bf6115ab 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -164,6 +164,7 @@ check_approxidate() {
 }
 
 check_approxidate now '2009-08-30 19:20:00'
+check_approxidate today '2009-08-30 00:00:00'
 check_approxidate '5 seconds ago' '2009-08-30 19:19:55'
 check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
 check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
@@ -187,6 +188,7 @@ check_approxidate 'last tuesday' '2009-08-25 19:20:00'
 check_approxidate 'July 5th' '2009-07-05 19:20:00'
 check_approxidate '06/05/2009' '2009-06-05 19:20:00'
 check_approxidate '06.05.2009' '2009-05-06 19:20:00'
+check_approxidate 'Jan 5 today' '2009-01-30 00:00:00'
 
 check_approxidate 'Jun 6, 5AM' '2009-06-06 05:00:00'
 check_approxidate '5AM Jun 6' '2009-06-06 05:00:00'

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.30.2

