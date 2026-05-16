Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28B23C8A0
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944553; cv=none; b=IbFl86l9jaEvXIjCxNzhpJEiZy/BFh+cy88mAxw34ayx39SclFDIOI0jXgs88yg+uM71fkZXPZWjKI+U98WGkqIC0JDOqsgNkJ0yeDoI7oQM+dONALqgKcTZOn6IFU+iaCBZpx45t1qlu+GFjyTv1lGQcDEla9THEtSQkCARJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944553; c=relaxed/simple;
	bh=qIlWtI+WcK7uD/kKyOEuFy0dD16Ky+d8ocyEoWIZ2ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t23FEsW557MnDFIEolsZ5MMjnYmk+ulaAl2+L01wY6siNpV9dI0P7tL3XS3RyRgBl9iznca98YGoKIsvmWHN9D+s6xCFzewhKoVMKtA9KvXCfGwvd6uRIwSTsRhBmjmQQB1iS0S5VwKWfqulZVG79ExwJm3OAtJbhD6kzi6eaqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=nzAdM9l+; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="nzAdM9l+"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64GFFgZa019462-64GFFgZc019462
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 18:15:42 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wOGju-00BJr7-PZ;
	Sat, 16 May 2026 18:15:42 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 18:15:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 080a350c;
	Sat, 16 May 2026 15:15:42 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 1/4] approxidate: make "today" wrap to midnight
Date: Sat, 16 May 2026 18:15:37 +0300
Message-ID: <20260516151540.9611-2-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260516151540.9611-1-taahol@utu.fi>
References: <20260514115520.6660-1-taahol@utu.fi>
 <20260516151540.9611-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=U0sM+0RYb26CtHVApmbNur4ZydAv4DlSFLgEG79hy4o=;
 b=nzAdM9l+hp5sQEGmpdMvo/PX9MCpfk2cuUZXS3GR91zJ9W5Oa97mV5CdE94Nv17arpYx+HWYR5lI
	Ap9YEmEvSFxsP6fNej+LCyL/5NuiYW5PrnwLBfuHMWpzUu+vh16Tvwkzp71SSAs2LZoWhk2m0hhl
	IKyTUc8/bdAieTz1IDgIjqzEC4kiFGjcHQQy29fJ0/rUcC8XHGKcGSqLpFCC9gl/ikRNNJj/nmd5
	CGSxJQOQK3Lap2pcr6DazXS1UHQXOk2ixDrqkWKczsSB5RYsaQMwlGAvB6XeebBBjphi9EgtRNY1
	1gYBbj1FBPqWwG2YyDq2UY/vpebvljQhKSUVzg==

Although some commands do reject invalid approxidate expressions,
in other cases those are simply evaluated as the current time.
Oftentimes that is a perfectly good compromise to handle silly
requests, but it isn't without rough edges.

Because of the silent acceptance, it is easy to forget that
"today" isn't actually a valid approxidate format.  That is
a bit awkward because while the fallback logic of using the
current time does make some sense, there is no deliberative
decision behind such behavior of "today".  Indeed, whatever
(non-)action "today" currently has, is just an accidental
side effect.

That means "git log --since=today" is currently unlikely to
print anything at all as it tries to list commits dated with
*future* timestamps.  Arguably it would be more useful to
list the commits of the current day---i.e. those made since
midnight.

On the other hand, "git log --until=today" doesn't really
filter commits at all.  Changing the definition of "today"
would make it return the commits made before the current day.
That isn't without problems though---running "git log
--until=today" in the late afternoon could reasonably include
the work done earlier that day (as the command currently
does do).

Still the utility of no-op "--until=today" is debatable and
perhaps outweighed by the pros of having "--since=today" to
mean "--since=midnight".  The thing is that the approxidate
machinery doesn't know about its consumers, so the meaning
of "today" has to be the same for "--since" and "--until".

In fact, "git log --until=" is documented as

	`--until=<date>`::
	`--before=<date>`::
		Show commits older than _<date>_,

so excluding commits made today would actually match the
documentation more closely.

Moreover, a revision parameter "@{today}" is currently outright
rejected.  Making "today" a valid approxidate time format could
make a natural way to specify the state of the ref at the start
of the current day.

Bind "today" to new function `date_today()` as an approxidate
special.  Make it return the last midnight if no specific time
is given; i.e. retain the old behavior of "noon today" and such.

Document the new behavior of "git log --since=today" in
rev-list-options.adoc.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/rev-list-options.adoc |  3 ++-
 date.c                              | 10 ++++++++++
 t/t0006-date.sh                     |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..a5abadf689 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -23,7 +23,8 @@ ordering and formatting options, such as `--reverse`.
 
 `--since=<date>`::
 `--after=<date>`::
-	Show commits more recent than _<date>_.
+	Show commits more recent than _<date>_.  As a special case,
+	'today' means the last midnight.
 
 `--since-as-filter=<date>`::
 	Show all commits more recent than _<date>_. This visits
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
-- 
2.30.2

