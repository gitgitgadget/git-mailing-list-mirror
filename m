Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365913BAF1
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742723606; cv=none; b=aKTf55HZaA/qjq4KdOGaFTuD3a8kGmb5c8ewDEB3sOqGqmUAXhcw+sw+3EcXItKm6q/+UMiRdptQd/nMxKTEFID7eWP3fFJ4egQuigPZoaoXGn0fpD4NnhG2sGsaT6nW7sBwYgqBB3SY87T/YZzBcSaG1S1Rph+vOWKQt1LnCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742723606; c=relaxed/simple;
	bh=ehMIgw1AAoj9786knN6jDFTUT61JH9pzfJr3C7740Ck=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nWeTD/oAR5BWDEkZjLivwpmRjLExpD+AUDxbEIkeOj8BK3PCy1kbWT3OwfmIFJriIwHLI1bhac+b1COvmRvsWwlmoD/JWBKKzobBv0I7A/WSY7at+R9s/NukS35RymId77q6zmimovFxE4A19G/oYVcqV6A0Od1o37Ty8Ly9/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=p9+1N0EE; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="p9+1N0EE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742723601; x=1743328401; i=l.s.r@web.de;
	bh=pGOhSFhoQWc36nh3TN5CyL2sdhO4qhThjkXaur2vW4w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p9+1N0EEtwN5+hs6Y+ag96TUUZhc3a4uXckAJufhjdw9xyBi4TCNuUY8z7J4eAbH
	 XLdid4/Iq38KYtXTPUFCGiHAkm6KxtfjFj9WeaLOlQNtiloaLEKkDdvL4id4YWBW8
	 PiGydFnjibRsaPaBWfPbepglXKnP/5Btbe6auounHI5KKu+wv8EJuJWetS4hTVsg/
	 lBWH29nGpYkZRzgNNS1qSNbvhaZIny3EYEiDPzcL14c53d43EkChZKuDeqie6Kgkn
	 7ut+Am0f5UtPdmEFZ+RtnmkWCe2X8b3MWPaCDKcyICGNCNKd2SVIafyavBy8bCUcj
	 lCOXDtGPDd71U9ws1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.23]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mae3c-1tKC7935li-00cQKO for
 <git@vger.kernel.org>; Sun, 23 Mar 2025 10:53:21 +0100
Message-ID: <80bfd7a9-904c-49d8-a367-ca268c096a9f@web.de>
Date: Sun, 23 Mar 2025 10:53:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: move clear_commit_marks_many() loop body to
 clear_commit_marks()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bcl9SeqQYu/TXErJVqP3aqglMfqLIaoSbuoc2MMr5K8ODFdVaXn
 rdcQZ98JdzSDQkT7mjlWm1raDrunpYInbhWVU/IAy+xcIt9V67VZU5UyG5pZ1FplJJdz/T7
 uFHbEalpiwzlwFpwy9BQ83FSjw6uxPefUxr79UhjjQ6LpAZK4N6dAp18MrN0hgy3dXof4Qr
 JuWNYFKkdXttVsjlM0lRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yaD3KhOrOpg=;4sIBupMu7Yc7FRfI9DXyN+b7Iqy
 KFqJ/MGn5pzMYsaeZVOQzh3iqBw+iNn1DZiwix82xQHLnf2nfZhXS4p/vPcClUMxYRwQjI3Dz
 tbtDlPGAz5TbxW0EQmgrwDui/hFw9rHBHh2GTtNUWONQyv18HBBE9pbb07mnlc5AqjyYnzPds
 itf5nEHT3BMEUhSeEsZ7vc6QQiu51EMss/o86Pr35aJaI7/IMObkP32q8KfgiguChd5uSAe40
 sf25xG7m5DSqjfR7k7X2ZqDEgGNrSzcgjUnGIDT7d7aCd6vkDiqIO7I0MROi1NPAD/BEglZwM
 qLo/LiXGL0u2XzPNNZIVvQL4UAOuYdXakcunrHv/H2BA2rIGDVYsSxjtUl6XPtBU8fDOGI0EH
 8T+o7DzNUP93udX2G8Qy/gfyDV8mVJIdeC8w9LBZ1FXRPaYsf3HX0JwnpkXaGw6GtXjoo56CT
 pxFAjHeEOMNj1IpGaik40tKtGSoPv7J8cRTNlPytEUxtiwVUsOlorEPjSasKObUJTPG6h3XcF
 aEdAa5FvaNmOPlpcu4bz/eAC7vjTWKZVXuq3ST3b8SZlGx3oACvIbA1VKkJAA5FkMK4lG9OZo
 w3UxwsyV/CowFvtplALcC6R4oQNuhaPdARGALHwHlmCiL9PFPeH55MfOqEt6IrrrgWsBXQBwu
 hKTJGeIJsndJvjhO4PdODqY567tEmCIX0tKRpjOL0o2a3Brs8xjn6ljomDV1iHjNKXJj3Irzp
 LMp3737XBK8pHhvDF0/2EezXCPB4H39ZnehebDJAMvLQ16y/Pq4j3Pt9/4CkEK0DTdCKHlWI1
 7HVS+KD8d+j2eMO2GtoS4bZlZUddt68DOWdkSuRsNR+9lIKCQJkVO55xDt+TYLPVvZqDNgbPX
 wRkAURjWaW8Y+r6xEsbbXmGYgT3GWYFHt/Iqy8TznOaH/fWyTQkfsOZipDI5J3LAPRtCYjl3+
 O6G3UYebT8XYDjDS+DhioU0tMMKTORFja43M/0nhXJZCms6QJXIDdEi7//TSVwbg5MKEJJof7
 aVZJJ2mfMx3RM0CroWUZEvWBwF6J4tEqMKN4VMG4Vm2Zq23oLBFA8Vo4QcQ7pjOgL13wvWRui
 0raoAW45FL1WVmOOXBHSyOCI8OkRYbxqxYCJzZfDdUR9MgRo+YWmR79esCmA5hvlLoWx4dtna
 oaaFVAfGvhFIkekAquraflyfBs9LIBIwhLuvYbgfYz7cVfCWEnF55V2y5eU7ui+wGJiBsNwW+
 tZLCkYUMLkFPz+Yav5kvu8NUBah13tMzEG6EcK3oirDlQADRgQGI7NRzHaj+VW41NUfKqjezL
 8dAxDVK4uVty168B2WVS2etBZiYi+OnsslaPw0v1OujVw0ellabnfRcD5fvhYVlkxAikNVzuk
 Wv+/7MfRpOC1dBYvJetT+RaJ6Q5RsMz0oT6/OV1eNySGgNQp+jNHlPSWHMLGlMVxhxPbDZE6u
 Q9unEGw==

clear_commit_marks_many() clears multiple commits one by one.  Move the
code for handling a single commit to clear_commit_marks() and call it
instead of the other way around, to simplify the code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/commit.c b/commit.c
index 6efdb03997..425503bb9f 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -780,19 +780,17 @@ static void clear_commit_marks_1(struct commit_list =
**plist,

 void clear_commit_marks_many(size_t nr, struct commit **commit, unsigned =
int mark)
 {
-	for (size_t i =3D 0; i < nr; i++) {
-		struct commit_list *list =3D NULL;
-
-		clear_commit_marks_1(&list, *commit, mark);
-		while (list)
-			clear_commit_marks_1(&list, pop_commit(&list), mark);
-		commit++;
-	}
+	for (size_t i =3D 0; i < nr; i++)
+		clear_commit_marks(commit[i], mark);
 }

 void clear_commit_marks(struct commit *commit, unsigned int mark)
 {
-	clear_commit_marks_many(1, &commit, mark);
+	struct commit_list *list =3D NULL;
+
+	clear_commit_marks_1(&list, commit, mark);
+	while (list)
+		clear_commit_marks_1(&list, pop_commit(&list), mark);
 }

 struct commit *pop_commit(struct commit_list **stack)
=2D-
2.49.0
