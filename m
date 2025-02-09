Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB1243370
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097687; cv=none; b=XEs3y4cAOBMAFyvzfMe7cKha/wkjddxrg54qER5EZlYiST8klTtt47nqlvp190E8BSq6+JzTGpbf78SIJFMTs2CQP7RfwsQA1hMhVg9hyV+t5RjO6cz3g7Y/jK0qdIULMUH9Sa8oDXso9CXJ5suzolaSgrnqHWnRwqXPYfavTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097687; c=relaxed/simple;
	bh=VqA5cZaHKEqYrfmeZNfPXGCeICwWC9mWSpYtBgY6jWA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pSTogc3ODih/TvtPH6mXIHWbJkLONYbNKCIwGj+Cs7CeeWP0Zza/jdNeQ+oJH+Ruws3GC1lRXzDfcbb5XTQhwH93e7/wwlvkiBQmC2Il08E4zWhY9om5CjmFQtIgm+TClNzUtlTUwrK3UaRCzoF+WKxdTx+MuPBAc+R4HDW8gB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=P8E1Y15V; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="P8E1Y15V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739097676; x=1739702476; i=l.s.r@web.de;
	bh=86wD+x6DJAGgUe+r2MxCqzSTdr3wdlCEVe4L36uELkk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P8E1Y15Vo0VRiByfJBAEW+OGeXZBN1ZqqozyQzeoCLgN1d30otEa64ZoNJR2ZJHz
	 MwqH5iHIE83IMc5iGvq+3fvzCb3rtOne7fsG3TpUhZ9qD5YKxCiBCbvLtGq2XG2GA
	 GrG/ivm5eDmMnqS2M1FQOsO8b4LXFVC9QdT27cW5gMbWwfFIoSa/2lTNu29xXY7GC
	 OVXg23ckU4YY1OsbUV9hbSW1ipE25b03JoqqmQudcdr5xxg/DKDm/HUNZ2M2pCqp6
	 eSE0SlJI4ms5eKENHOke2ZYcSu+ABrcN4PzRjBPhePetyeyRA4mSiqSOoi0EF2hPz
	 wxB652HdqX142rLNTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.17.38]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1tQESF0AyJ-012rwU for
 <git@vger.kernel.org>; Sun, 09 Feb 2025 11:41:16 +0100
Message-ID: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>
Date: Sun, 9 Feb 2025 11:41:15 +0100
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
Subject: [PATCH] commit: avoid parent list buildup in
 clear_commit_marks_many()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Di6BrUdHaW2D25bHreCo4CVm8ns68jd+EXJNg1NgefUP5rR4I94
 YfNg/gxOeVB2Kd1WAp1gYckXY8bQS6Q5I1S3Ivge7KxyEAR4iJTM5Tfxxl6g6b/oXaY3Kv8
 rI4t2NFFB8PviqJ+JqKZpBlFwJ1dDuH/yMH/mD7EryuLE/gSnEXdkix9ISJZz5crmX3Kvri
 ko4DwrL8DUBs9sXIATi5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pvOV0x+BD6E=;VQY4NYS58rWqmnxmGiuA031XfgY
 VOIbDtbeXRH4OfEvEHXyxgcQpc/wvo4vpzG1GTjBeME1xi0kZggjhy6DWQ9dKnpQ3icAY3sJs
 9UDct/3ZokUw9YrA7bCNLyezqgY3CnKoetAsuC6jWGRLUDd2kmeVZORMcJoU20YS/dqoCsvGR
 AixsFVf1YUa/UR6MPGVuT1l3hP+1B2mh77oZ0wSxIC5wsNtHzbf5kJOYODjEy7OxunjPXPDRS
 FOZtuJfxwaDPlCEYoZgMEkkTOM/DiswvLUF7caO8fxv6kX6L1ky53cxDwfivyq54jahrSibxe
 yqalgYJTB6bXszZL2duY+nd8rq0UUV2H3ECAAylpnG9BAC6uBIVUin11ChwNR0pGwzyBSIjt4
 0IyRlnBMjgDJs7MF/MW7GARCDxFe//KPyFbOIbJh+KsdwhjkexBXjJ9X1FrrVa7dgEioYQXzJ
 WdjFUvLTRf3clB8GeGb3jpdqPdZVTe9GlHnH68BAP89X/azNpxVahcwI3qrinfg8jGHLaH1xj
 CJKXJ9iSbcNw1Hyu65Kz5G2c8vdtVNg0Gl1WEmvhtxrOY+7tCJ6GqmkHl+tez9SsdbroLWMtl
 D80Y4y7gC2+zS4sBWIxEAtQlV87GF3AignIUYAXiq32YBrbKC2opaRKHOvn3Ol465WeCebrDO
 NF15qxfE5FMrVYlO73gTupu8oOFIn2p4LrF0IOPUq/yk9LijM7LRWkGVPVRq9pbUYO2uT9G25
 4+ipBs0uFQK4BoWOsTXuieZXEBabAqlKmgtd4TVIbJ431j0dOZ8pwW8MVP0igEbzzfBJqg1Mf
 4X0ies5C+sRPdFJTgRZzij2vBkoHYyY1mPGJCOhNPPqly+5XL2066RzV7MpFQNMgj7bduW7M1
 7EnrI82cS08qRWDnsvvXosJ8Fce3gwHiS7EE0krcVP3kfo9qoohe9+81sLWdHss64RjgCueUv
 gAJUMjyGk0TB396m316hxSrC2qFqLHen/4+hpN0BbO/a43F7WaoQPrY3L79AV9OdCRq7YMDQR
 JK+Kblu/0YE1mUm10LS6jvzL+5yhMIH8+dgylzfXVnHrm15ZZ3IKMxX0Zo9/9EFff1ktZAR1j
 JDwxPtbBeuTu0MibKuUXiMDZVtsuMf2EujDFSihQD2ReOQXnI82/YnBPCqOgmnJjfRxjbRyBP
 PfZDHYby6MXUPHm62323YicuqGxdAew9ygEt2zTTEG23vROMg0rGrebHpNYts71pKNwqXGagf
 RuEX/xJSif8v4CQ7PbqGEME+5vvo1Eaz2Phs8I+oTRvRrbl8q5ywbjSaFAxOPGtBaQfqRe8ER
 xhC183O747XtJ5pdB1DzGy2qHI5Gso/JgDrEcas2EOhmz+nCs2k2LYDi3pCSgbca121WLpvoH
 e1FBrM23P9+M8EX4VCWTbEUa+e0D+YDNoB1yU=

clear_commit_marks_1() clears the marks of the first parent and its
first parent and so on, and saves the higher numbered parents in a list
for later.  There is no benefit in keeping that list growing with each
handled commit.  Clear it after each run to reduce peak memory usage.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 540660359d..6efdb03997 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -780,14 +780,14 @@ static void clear_commit_marks_1(struct commit_list =
**plist,

 void clear_commit_marks_many(size_t nr, struct commit **commit, unsigned =
int mark)
 {
-	struct commit_list *list =3D NULL;
-
 	for (size_t i =3D 0; i < nr; i++) {
+		struct commit_list *list =3D NULL;
+
 		clear_commit_marks_1(&list, *commit, mark);
+		while (list)
+			clear_commit_marks_1(&list, pop_commit(&list), mark);
 		commit++;
 	}
-	while (list)
-		clear_commit_marks_1(&list, pop_commit(&list), mark);
 }

 void clear_commit_marks(struct commit *commit, unsigned int mark)
=2D-
2.48.1
