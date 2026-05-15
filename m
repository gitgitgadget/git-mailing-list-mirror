Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7D3F99EA
	for <git@vger.kernel.org>; Fri, 15 May 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869020; cv=none; b=BkQa0byvNwsFI+AUqGiM7puscI+Ig5qs8ism8mbpHVHdFHZ/FzHARxK/n8lqbVUmGKnzrcnsI9vefiuyZSrZRCKOwxyDn/qZPLNwch/8aHXN06LM8VJgcaEoH6ZXMN6npp3MlE3biyJ5zQZQei2R+NHzz7nwAGyolTCMPm3e0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869020; c=relaxed/simple;
	bh=gGhq9kiJ72aYlcKZIv7obco1G4WlEdxRE0MQDU5LIOM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=axFFFeitDh06/itsVe5eQZMxbAwwteUl1JGnAfJjs1Kn34+6mm7cQSJCjUt3V+RdWJaDrl+TeHFVzLwDzQzr7CGRNWCUjAdztIa1OiMQqmjQ5UXLOW1tc1C9JP/LwrJKxeUNpI19lIQ5NIyYJtjijygqb1t2+o7DbTABt+i4Aao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=rgXwhys3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rgXwhys3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778869010; x=1779473810; i=l.s.r@web.de;
	bh=1Dn4On29D9YzoG4EjtYPcY/5oPWmQ7ygqa3FhYIiol0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rgXwhys36bnnREN2J5pluN9EMHUKrZxd2x4ZpaGFTQEJmtGOg/4okg99ECZxqdKq
	 neZyYv0zlg/u0eyFvFMLB7Rf32Bym0C9OS90KYRVv7I4TWQsCl0webgXVe89PpYLp
	 g6t0VlaJwtrpdLpONxltGAUQsJoAoJimxAidYfs7zAh/ahWVwfqbjtuqG+kORzg9J
	 DZt8EKM5KYc3jCEA/IOxZ8bTZ3iMQ0T6MWjlnaSxFm3N2j3WOL5HdHNEgnS4osROy
	 nUVgKJxosgX2fHFoNfyutzLx+WQDXfkhGOl7ILJz6SYFPKSMDPiWK0+tsHlsAn2EY
	 axEdpCndvrltAI9Nqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Po-1wQim42yDG-00E4O9; Fri, 15
 May 2026 20:16:50 +0200
Message-ID: <323f5677-301b-4d7a-b552-6606597c2b1f@web.de>
Date: Fri, 15 May 2026 20:16:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] evaluate the second argument of ALLOC_GROW only once
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cPnT9PUazuSSo1GWo+i/irD4jQhgLAsTC3ce6gFLpakLmy92cHP
 mt7kJnvRPsRyaameelyqP+E2yBcIIHYgUOZZU5t7P0FC3gC7mefZqG3GuQVFWUt0ZeyHEOv
 Vi8Sx10Q3v4i95ENFxhrLBKcs8TdfAa9f3xKZ0PArjs1QTiOXXVKTT1+Te/j/6B8op/TXN4
 eoqAWm1HN+sAwWAgIRckQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nBNiKN2ONyE=;VnG2kqWBz0z4ZLpUVGTBXbO6Lk3
 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
 ckAEahcsxXynmMtF/MJVmySg==

Allow the new element count passed to ALLOC_GROW to be a complex
expression with side-effects by evaluating it only once, as a parameter
to a new helper function.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..2bc1f43f48 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -812,6 +812,16 @@ static inline void move_array(void *dst, const void *=
src, size_t n, size_t size)
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
+static inline bool st_alloc_nr(size_t nr, size_t alloc, size_t *outp)
+{
+	if (nr > alloc) {
+		size_t out =3D alloc_nr(alloc);
+		*outp =3D out < nr ? nr : out;
+		return true;
+	}
+	return false;
+}
+
 /**
  * Dynamically growing an array using realloc() is error prone and boring=
.
  *
@@ -857,12 +867,10 @@ static inline void move_array(void *dst, const void =
*src, size_t n, size_t size)
  */
 #define ALLOC_GROW(x, nr, alloc) \
 	do { \
-		if ((nr) > alloc) { \
-			if (alloc_nr(alloc) < (nr)) \
-				alloc =3D (nr); \
-			else \
-				alloc =3D alloc_nr(alloc); \
-			REALLOC_ARRAY(x, alloc); \
+		size_t alloc_grow_new_alloc_; \
+		if (st_alloc_nr((nr), (alloc), &alloc_grow_new_alloc_)) { \
+			alloc =3D alloc_grow_new_alloc_; \
+			REALLOC_ARRAY(x, alloc_grow_new_alloc_); \
 		} \
 	} while (0)
=20
=2D-=20
2.54.0
