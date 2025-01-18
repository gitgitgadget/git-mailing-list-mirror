Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220742070
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220327; cv=none; b=Wf4wtv5cJxISS5RnIrJsspDtAgMgadDVM/x1iKkyU+iA7Ym2UkbP1jL/Oo6n+G7BeAjTa/ioy+DmSivNzYY8a3fNLKL19YLYRbjI4lHgEfVXLE0RGTCNVrsihXoj5ml4T+NA+Gflc9gVMkvUIuPMI75MsD87/rgbLiSU4X/9vjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220327; c=relaxed/simple;
	bh=szR+2kRRP6GvjThnJdAvyd0PGlDou2os6qtb7uBSSAY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qz4R8FpkWzrM3pC53l5F4wdi5GrhlVFn49mVl7umQ0t0B9rwz3QAxjjkZbfad5wdhPsx8Z+myzG6qox8grjsr7HqYVsBGLxXxhLwFLFjCyKtMO2eAi8r9F2OI9kY16k8eGJWoIGFZkh2z3c4J6QLuGssS8pXwjjLSbvd32fK7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=pQqE8cll; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="pQqE8cll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737220319; x=1737825119; i=l.s.r@web.de;
	bh=Vt9T8oOfPzHdAL1BAx6WmmFvns+vE3XrGNvE9XNqmWw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pQqE8cllLNXpx04ZsQqc4YsHwcxKRxwJZQS+skDCtTEvrVbjr5V7V2dedK/a0FPu
	 ymZ4T7E0om2pY70CL8stOy/gRDoZpRt+t3zMU/yjN98Lo71XE78/K3NmgRMCsmesH
	 7Xa40pgr8iywxUZEeWA5Xjk2BWFCmv20lC+8wdg4VMVe1B+mMyJv3UhvMv4FRHBAb
	 +UPEcDYbBon3Jg5shRyzLraywAMCnJNgyhcRFGDZnBfFg4bPyGNq6G8p/iZid1eId
	 QBwU9yHt61SN2GhmqtJJo3JrYlNHN1mkDptNBp2zH7fUkGZyT8Y46eY9c2wWHP+Is
	 Gk164kdKqM3sOlTlag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1tD2pb2FIe-00l3Vj; Sat, 18
 Jan 2025 18:11:59 +0100
Message-ID: <bd53e91c-f33d-43cd-b650-2ed93e0b963b@web.de>
Date: Sat, 18 Jan 2025 18:11:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] ref-filter: remove ref_format_clear()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Ross Goldberg <ross.goldberg@gmail.com>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
Content-Language: en-US
In-Reply-To: <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eLUdl8Kis36Kc9XVrqW3CqYyO5DLJ412CRfN9Rol9PDmmfCCqCu
 n+gdEVyHWD7OE5CsSDk/SRBvfXO8MPKLGL+3nqaiiN1khm8dDKc/gTj7C8bneHRcSBVmrCR
 iCxOoJ5KspR3bv+GSs71sZF0eg2EycLce1iBInC1abuZs5jbsWJzDWoS6vI3qXAV4QnAAtP
 YC/tJa1sL4iv+xB1lRS7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7mdO6ayoZXk=;0od1are+C6eeyNrxuwE6fxGKFfp
 CoOKBNfxiTJSTlDTeYFLVFtspoz4MXZRb59A5UPm/Pg068/BuY5HzEmf9Zxd4yuQJiBKoTe9O
 vSC9v9Nla17ByXFDYOCeOcqXMATmP9kHhE4Qc617fEQEqPVH5tMz7i/uzRr1Ux8CHUzAWEGT9
 55QVhnaTpHFT1srbDuFuGuBTuGTZchYoiiLiT2HloF+iC0ojw3/VsEIE7I1CJgXEPXx/KndRh
 VptPqSFu85WUjm0t9wljA/zkOsfDEZw26u2bQfccLpVlxUJh958WwP/O2GJGFedc07nLczvpC
 4awZqhiPdG5Um9Qh5wU5YNA9P4AX1UoFAagV2GmS2ClneyRLHISl3PK4BXo3mKYWajb4M1VQM
 D70I8PtDnyfZhVoZbp7e2PG9bU4Ha3bOiIdtBU8+A/t2G2+PXrHanccgWPpbd4Jo36DJU8xpn
 glLuR6M2tHiZDYG6uSLNMluIAIpYCdCZKyZ4HO3ELVaA0LJYgH1S2BkOtIV+fbvdQ7oKjqZbi
 re12EmF4ZCC+gk7p6Slevo07VOcuAq8Jj+z3Pv/+U94d+12qbNJoTFA74dSBjgNtjk2ZeTyXc
 w5EfScY5YbxbUY7t/WTIMDTYRzgeezRr4FUZfyh2I7qEivtsq7J04+/9Lkaz1rladuHN3INCi
 eyTrYAp693cDnawb1cjyqDfkiYLqIeoUYhxPLRV47Mh5B8MY+SMfxZuHQZ31yYCrAgNBK3BtY
 dsj6h+Cq5Uh/6v08RLG3J4DPaFidDcGAO4lcAcoKoBWIybqT9f2ZkZ7mvRcQgOBuBvIvOsYB3
 9DXy/n4oZWGJ4NLONuGKfgqVuosFzUR7btEJ6ueSWoHF/g5zUAaRLFEgJ1tk4EU+RogclgdUt
 nkWv3hk487o0vjtVuTZ/mqRnDhwQNKGmaTvWQtc2ezDKA7GvtMSCYh993KPAHmeJy5KddGcr5
 W1zIh8MTcfLAUdpqT7RmUDg6FoVafq1WHEZgc5KYsFUssLtbOz1Bui88oIEfCUJ31ilOn10Ck
 KOcro1m6ZM07pBxK/6Kb/9Pg6LE9Aa9o/ANpqGvvZ7AAmuy3dCEzztBvanl5B3WZcBVEqvnnz
 6Arb4WAC2KvUmmzthEtSR42a8a7ZkrK7X1vakmU7A9iLNshC2VRLOn9EyJsfldpkbiyHhT5jG
 4Fd9g3iySRULRBqMr8BODrIjnlLg0BCVEs+AjeUjfMQ==

Now that ref_format_clear() no longer releases any memory we don't need
it anymore.  Remove it and its counterpart, ref_format_init().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/branch.c       |  1 -
 builtin/for-each-ref.c |  1 -
 builtin/tag.c          |  1 -
 builtin/verify-tag.c   |  1 -
 ref-filter.c           | 11 -----------
 ref-filter.h           |  3 ---
 6 files changed, 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index fbb9536282..9a29de5bf1 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -884,7 +884,6 @@ int cmd_branch(int argc,
 		string_list_clear(&output, 0);
 		ref_sorting_release(sorting);
 		ref_filter_clear(&filter);
-		ref_format_clear(&format);

 		ret =3D 0;
 		goto out;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 715745a262..8085ebd8fe 100644
=2D-- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -108,7 +108,6 @@ int cmd_for_each_ref(int argc,
 	filter_and_format_refs(&filter, flags, sorting, &format);

 	ref_filter_clear(&filter);
-	ref_format_clear(&format);
 	ref_sorting_release(sorting);
 	strvec_clear(&vec);
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index c4bd145831..e8a344b926 100644
=2D-- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -698,7 +698,6 @@ int cmd_tag(int argc,
 cleanup:
 	ref_sorting_release(sorting);
 	ref_filter_clear(&filter);
-	ref_format_clear(&format);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	strbuf_release(&reflog_msg);
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index a7f20618ff..f6b97048a5 100644
=2D-- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -69,6 +69,5 @@ int cmd_verify_tag(int argc,
 		if (format.format)
 			pretty_print_ref(name, &oid, &format);
 	}
-	ref_format_clear(&format);
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 9a4b2d4cea..6da8d4c03b 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -3660,14 +3660,3 @@ void ref_filter_clear(struct ref_filter *filter)
 	free_commit_list(filter->unreachable_from);
 	ref_filter_init(filter);
 }
-
-void ref_format_init(struct ref_format *format)
-{
-	struct ref_format blank =3D REF_FORMAT_INIT;
-	memcpy(format, &blank, sizeof(blank));
-}
-
-void ref_format_clear(struct ref_format *format)
-{
-	ref_format_init(format);
-}
diff --git a/ref-filter.h b/ref-filter.h
index 0ba94df651..013d4cfa64 100644
=2D-- a/ref-filter.h
+++ b/ref-filter.h
@@ -211,7 +211,4 @@ void filter_is_base(struct repository *r,
 void ref_filter_init(struct ref_filter *filter);
 void ref_filter_clear(struct ref_filter *filter);

-void ref_format_init(struct ref_format *format);
-void ref_format_clear(struct ref_format *format);
-
 #endif /*  REF_FILTER_H  */
=2D-
2.48.1
