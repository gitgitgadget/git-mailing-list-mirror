Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273751CABA
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710623393; cv=none; b=nB4aBpmnRv7OQEpNd9AuRNZUUiyJq/heVC1Ss5YWUPVKerynSDRFAZ7QsorEk+J/8dYeZbAjsoNqttzoGcEZnwNEvQ5EQyrz28B5WY3ZtPnWYYfC7lH9FFhMfuU9mmaaJrAxUnWamVuwuflL5jv+rFrHRg2cYlaGQSPMf9CKcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710623393; c=relaxed/simple;
	bh=q/5Cwmi/X7gRyx5xcB9IwotPAYjjNQyqVOBDNk53x3U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XlbEEFRaWCWqrWRcyHStNZ3zUeFGIohprb48zW1eW1PqY9/FnBnGz1HBMzCChup5dvuaOp5ids4CSg1NCDqgmjtDKAziRy20xEX8FUlQMPFMa8D4jZ5CIgYqyGiNje78xN+6oV3Sc15WVmkUVRw9obB+JgFksmHB6aHLHabz8qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ckagsTrN; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ckagsTrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710623387; x=1711228187; i=l.s.r@web.de;
	bh=LFGWxwN2XEeAkgqfny+hehGlw8NDJl2VwTUAUbj+LI4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=ckagsTrNxcjfTRL2sU1xnTFcCu1RYeDlPGReSrGtMoQATIrEjYk+FR49Q2EbzBp4
	 w3+3oEx0fztZcgCdaS4Fns7x0T/xujqk57nrSG8Cb1gR2KGQPs6ZXjQnyMojJux54
	 2oyvstxBEgemeq3UFyKRjVRJUPUrKyoH4DOIuUMbMlWvjeg7SVxj7wje+runlL/v9
	 07iibcFtHZ5DWNZosmmMsg0P38S7SOUrpWCHFSrIMzuetyWPoWP8hIcDBza+ODBdy
	 pqCSqm8IslULk3NmdXG9dhq+x2rPqJj5jYM7OuSMpxEFLWu3qBu867y8RCtNSWx/z
	 qRkNf3FSQvjsGIIJfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXN7-1rHk6G1t2l-00Yu03; Sat, 16
 Mar 2024 22:09:47 +0100
Message-ID: <9bf36cc8-ff27-44df-b2fb-9f959c781269@web.de>
Date: Sat, 16 Mar 2024 22:09:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] t-prio-queue: check result array bounds
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>
References: <197f5ac9-7257-4caa-aa9e-041016c787f7@web.de>
In-Reply-To: <197f5ac9-7257-4caa-aa9e-041016c787f7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:voZjCS1pUVyXijRV0a4JtU8NbEtZtstnomS1JIIJC9JqXDe+Xxn
 5MT1ZuzrQL4hzHhCm3JyO5U1WKFoNC+81eKRpSBFodN2l+Va9ZuyloHToedcAa9aJ+hqV3Z
 rwAFYrrxJiJUDUm8yU1WRX6A2NtIQliaf0SvFR+j/nvMRYAWWr327vD3xEhKIEmB3LqdOoj
 TdkTs4pyNpKopFFpBPHvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vf8YaLgJjiI=;Y0drvrAxO3lgaD04AQMpwPnJ0U2
 a7u1otxyeIQJWPRHymLh9IX158ASv3uXkESsbVy8vKjKcO2V//euozkVRpql/7hPYJswXxJg8
 J1mfAM9seO2nY9JltzGR4pZmqmXSrYAN1oIBfDzRWVAqcZmormGlZn1dN+1lqg8YjoU6D0x08
 zo4RN6VZo1yBIHJ4blyE9JKZBNUMPk859D3CAyOk8TRUrkfRCvze5KlPXy/NRudi1Rgqtr0rZ
 JF1pg5Tnap9DZ41Ywym6jrvHhqIpqV+W6ukvgoXv/wgIw5pIzTII3gRtliFDcg52OhRBXH7H/
 zeoygga/NqiowDDcfxOx4p6XuyEdtO4MShXU3roTj1FBlcYjh4K//N3XYu9LaaUojtALDgBO+
 UCRc4ZWeh/QYNkVmOdhmweWnLz7imuJ32XhttZsGu6MBb2HFh9jFdVIzeV0mHO/m3HGjFWTee
 xfoszNOIVBJiQxAwdb1b0WvgRNETGbFf0JvbetPdWec1lejQwgWWHMl6xOlrNpmFrHwGh4+6Q
 Jwcus67u19LAyahnIeBci8fBp76MDVnZHKlNbZqxo8rPziN6yjlzrdmJI+6tfbxD1aHStDe/O
 gmsf5zQHDafE1XLF34J7ftT8EsCfD8A7oaPJAbEewccfkELzd9iTghN40ZXK8c7F8tbXhr9WC
 ZACsRU0tVyQpN9qNW3bdkE7r1Yb5Mt9t0GXE6BZo7nPV7R/a3H8zIQiwqB8EwcVVNuISEcuu+
 cfEiac/22NyjpUt4wTqbL1L17DCujRY6ysiCzood3ya7fNkPuQUgvjn+k1+zYDjPvywpT9gkR
 Ljm2ZHAPQt7dS+lWNly8cBg3AaJVoKD+Tp5cjLWDvv34I=

Avoid reading past the end of the "result" array, which could otherwise
happen if the prio-queue were to yield more items than were put into it
due to an implementation bug, or if the array has not enough entries due
to a test bug.

Also check at the end whether all "result" entries were consumed, which
would not be the case if the prio-queue forgot some entries or the test
definition contained too many.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/unit-tests/t-prio-queue.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
index 616d0fc86f..5358346361 100644
=2D-- a/t/unit-tests/t-prio-queue.c
+++ b/t/unit-tests/t-prio-queue.c
@@ -19,11 +19,13 @@ static int show(int *v)
 	return v ? *v : MISSING;
 }

-static void test_prio_queue(int *input, int *result, size_t input_size)
+static void test_prio_queue(int *input, size_t input_size,
+			    int *result, size_t result_size)
 {
 	struct prio_queue pq =3D { intcmp };
+	int j =3D 0;

-	for (int i =3D 0, j =3D 0; i < input_size; i++) {
+	for (int i =3D 0; i < input_size; i++) {
 		void *peek, *get;
 		switch(input[i]) {
 		case GET:
@@ -31,6 +33,8 @@ static void test_prio_queue(int *input, int *result, siz=
e_t input_size)
 			get =3D prio_queue_get(&pq);
 			if (!check(peek =3D=3D get))
 				return;
+			if (!check_uint(j, <, result_size))
+				break;
 			if (!check_int(result[j], =3D=3D, show(get)))
 				test_msg("      j: %d", j);
 			j++;
@@ -40,6 +44,8 @@ static void test_prio_queue(int *input, int *result, siz=
e_t input_size)
 				get =3D prio_queue_get(&pq);
 				if (!check(peek =3D=3D get))
 					return;
+				if (!check_uint(j, <, result_size))
+					break;
 				if (!check_int(result[j], =3D=3D, show(get)))
 					test_msg("      j: %d", j);
 				j++;
@@ -56,6 +62,7 @@ static void test_prio_queue(int *input, int *result, siz=
e_t input_size)
 			break;
 		}
 	}
+	check_uint(j, =3D=3D, result_size);
 	clear_prio_queue(&pq);
 }

@@ -79,7 +86,8 @@ static void test_prio_queue(int *input, int *result, siz=
e_t input_size)
 {								\
 	int input[] =3D {INPUT};					\
 	int result[] =3D {RESULT};				\
-	test_prio_queue(input, result, ARRAY_SIZE(input));	\
+	test_prio_queue(input, ARRAY_SIZE(input),		\
+			result, ARRAY_SIZE(result));		\
 }

 TEST_INPUT(BASIC_INPUT, BASIC_RESULT, basic)
=2D-
2.44.0
