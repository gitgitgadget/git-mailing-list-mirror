Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCB3D6475
	for <git@vger.kernel.org>; Sat, 16 May 2026 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931449; cv=none; b=QEBBvnKGH7GzhBEN/9iN4jRW0EREhfbtkqyYhMby97K6K3ptW40g+PSNLaUXL8MuB03N1Ybk3/8XTKgJztHczFgaPhhY9PMDTFNUbe2bp/2kFoH7mYWc6sMyop6TDuOVa17vxnHCqWc/1JfB8vRZARn4opOnzsDwymoVOciHEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931449; c=relaxed/simple;
	bh=ld93BdeoxF5iPGaysmau53Fr1v09WXOFfVSNcHP3o+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlZ0LbTKliQwn7fPm07a2KtEgfS4hLZT7M7EhPyLagBTVfSMGA2F8k6BEwaIxtLPcL06polzkuHw62tn2f4ZalB3ZEBWWFAsvmnZIzdeaOQNbN7Vw7iS9HFXAi1iYKJuKufUMSFCXJKHucxVp4XP5adLBuTs/4ZrpnC0514J2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=g+eEhZ+Q; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="g+eEhZ+Q"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 64GBbGo2010160-64GBbGo4010160
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 14:37:16 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wODKW-00Amln-1v;
	Sat, 16 May 2026 14:37:16 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 14:37:15 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id e410582c;
	Sat, 16 May 2026 11:37:15 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v2] approxidate: make "today" wrap to midnight
Date: Sat, 16 May 2026 14:36:22 +0300
Message-ID: <20260516113622.23902-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260515205803.26211-1-taahol@utu.fi>
References: <20260515205803.26211-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-02.utu.fi (130.232.247.42) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=MsmbvxxCnDq22nZIt9StMPr2VQn5H1q/lqNJ8EQHMcU=;
 b=g+eEhZ+QZvTOy417sww7CASC+w2HkzkwQEmfguSICGsq910bmwfhWDie9gGcvlnVBJjAkYAVu+wU
	a99YI1rPuTiPKgEP5/a1rGuAQfL+tEzoQzKE/6q9R6d5IVXgFnFGKKFcb8EPwRtZ7LC2xvFc6fzZ
	ZBkrPPL9txPeIDzS6QpoKEp9CkAGD1ykM37yrEI57y6S8g6i1sm0ykG8fRVih+vzW/Tk5HIyPO8a
	dEGOFHb2vmaDp0sl2jZ2KXTVAM5DfBWWipJdqRY/FYtxmUbgJQRaOdM38RM+FBIhMvdpD4WJHYUz
	soi5EtyLL/Uhx/TAsqNbe/4WhTiK8K+RrSPA+Q==

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
Intervall-diff mot v1:
1:  849f058baf ! 1:  86bcb70ac2 approxidate: make "today" wrap to midnight
    @@ Commit message
         Oftentimes that is a perfectly good compromise to handle silly
         requests, but it isn't without rough edges.
     
    -    Let's consider what "git log --since=today" should yield.
    -    As it happens that "today" isn't actually a valid approxidate
    -    format, the command currently tries to list commits with
    -    *future* timestamps.  Perhaps it would make more sense if
    -    it returned the commits made since midnight---that is,
    -    during the current day.
    +    Because of the silent acceptance, it is easy to forget that
    +    "today" isn't actually a valid approxidate format.  That is
    +    a bit awkward because while the fallback logic of using the
    +    current time does make some sense, there is no deliberative
    +    decision behind such behavior of "today".  Indeed, whatever
    +    (non-)action "today" currently has, is just an accidental
    +    side effect.
    +
    +    That means "git log --since=today" is currently unlikely to
    +    print anything at all as it tries to list commits dated with
    +    *future* timestamps.  Arguably it would be more useful to
    +    list the commits of the current day---i.e. those made since
    +    midnight.
    +
    +    On the other hand, "git log --until=today" doesn't really
    +    filter commits at all.  Changing the definition of "today"
    +    would make it return the commits made before the current day.
    +    That isn't without problems though---running "git log
    +    --until=today" in the late afternoon could reasonably include
    +    the work done earlier that day (as the command currently
    +    does do).
    +
    +    Still the utility of no-op "--until=today" is debatable and
    +    perhaps outweighed by the pros of having "--since=today" to
    +    mean "--since=midnight".  The thing is that the approxidate
    +    machinery doesn't know about its consumers, so the meaning
    +    of "today" has to be the same for "--since" and "--until".
    +
    +    In fact, "git log --until=" is documented as
    +
    +            `--until=<date>`::
    +            `--before=<date>`::
    +                    Show commits older than _<date>_,
    +
    +    so excluding commits made today would actually match the
    +    documentation more closely.
     
         Moreover, a revision parameter "@{today}" is currently outright
         rejected.  Making "today" a valid approxidate time format could
    @@ Commit message
         special.  Make it return the last midnight if no specific time
         is given; i.e. retain the old behavior of "noon today" and such.
     
    +    Document the new behavior of "git log --since=today" in
    +    rev-list-options.adoc.
    +
         Signed-off-by: Tuomas Ahola <taahol@utu.fi>
     
    + ## Documentation/rev-list-options.adoc ##
    +@@ Documentation/rev-list-options.adoc: ordering and formatting options, such as `--reverse`.
    + 
    + `--since=<date>`::
    + `--after=<date>`::
    +-	Show commits more recent than _<date>_.
    ++	Show commits more recent than _<date>_.  As a special case,
    ++	'today' means the last midnight.
    + 
    + `--since-as-filter=<date>`::
    + 	Show all commits more recent than _<date>_. This visits
    +
      ## date.c ##
     @@ date.c: static void date_never(struct tm *tm, struct tm *now UNUSED, int *num)
      	*num = 0;

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

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.30.2

