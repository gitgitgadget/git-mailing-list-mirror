Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99223243969
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203032; cv=none; b=JEH3msOJnUcHvaBoPGFmdhMFyGV8JpnCMQ50ZjPXeLWW1iUBgQjRGF3LFnVkWLaxxlX+reAxHxnCZ4NjH84dmEJE3E0dBbtQZRejB6Su43lZw9uOP33GCLu4rAAa7h+AaZzUfiIgje7a8FEfIAYtfM2uBriJd2V1JP833tdxONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203032; c=relaxed/simple;
	bh=dyEKb7MQ4j+S3D32ZYZJUujzK2IN8kwoIe62urwn/Wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L0OK2fG+p/qEFoHH47WzuFw0inlsDUu7ocM+J+LL0PDqVksqfBJY1JBLDcYT6PipAzxGoegO2pPQG8UQ5/6HFGh9SN7zkB6RDIfDbFpqjeOZDujw+8tg9RpX0Vhp5O2BX0sTXGhqqhjpruLZ40iuYPScTnJU8NIKV9EQ8kNwhjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U4ZRYETY; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U4ZRYETY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739203030; x=1770739030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dyEKb7MQ4j+S3D32ZYZJUujzK2IN8kwoIe62urwn/Wo=;
  b=U4ZRYETYwubP3fQJ6kiirpvcgoH9XMl8O726vULb6z4xopx87K8yiRYu
   J7LO/B6uyeaGtz8H16P4y+skrfm0xDJ3uek5sr5//5P0Dfere2uSJ841i
   gha7Gm1jkV3gQytIXyPJpgaIFNs3ezHiX+sbxVlrFW7wUuw1klyC/gXKM
   M=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732579200"; 
   d="scan'208";a="21328624"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 15:57:09 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.44.209:62697]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.84.69:2525] with esmtp (Farcaster)
 id fcdbc578-8889-43e2-9ce8-b0a1f0655269; Mon, 10 Feb 2025 15:57:08 +0000 (UTC)
X-Farcaster-Flow-ID: fcdbc578-8889-43e2-9ce8-b0a1f0655269
Received: from EX19D019UEA004.ant.amazon.com (10.252.134.157) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 15:56:59 +0000
Received: from EX19D015UEA003.ant.amazon.com (10.252.134.165) by
 EX19D019UEA004.ant.amazon.com (10.252.134.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 15:56:59 +0000
Received: from EX19D015UEA003.ant.amazon.com ([fe80::3d79:8155:d567:e8af]) by
 EX19D015UEA003.ant.amazon.com ([fe80::3d79:8155:d567:e8af%3]) with mapi id
 15.02.1544.014; Mon, 10 Feb 2025 15:56:59 +0000
From: "Maloney, Bryan" <bryanhm@amazon.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: "Perry, Daniel" <dtperry@amazon.com>, "Das, Satabdi"
	<dsatabdi@amazon.com>, "Damojipurapu, Deepika" <deedam@amazon.com>
Subject: [Bug] Git ReadOnly Temp Packfile Causes "Bad file descriptor" And -13
 Access Error With NFSv4
Thread-Topic: [Bug] Git ReadOnly Temp Packfile Causes "Bad file descriptor"
 And -13 Access Error With NFSv4
Thread-Index: AQHbeaziEc9Mb7DhokeWWpTWYBUxk7NAYagA
Date: Mon, 10 Feb 2025 15:56:59 +0000
Message-ID: <17DE42DF-D2A3-4E25-9198-5AF3CA516E35@amazon.com>
References: <18589D54-5E7F-434D-A890-B39102ECB293@amazon.com>
In-Reply-To: <18589D54-5E7F-434D-A890-B39102ECB293@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <03C848AAF5DCE949909551A8E6BDF50C@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

IyMjIEVycm9yDQpLZXJuZWwgbG9nczoNCmBgYA0KTkZTdjQ6IHN0YXRlIHJlY292ZXJ5IGZhaWxl
ZCBmb3Igb3BlbiBmaWxlIHBhY2svdG1wX3BhY2tfYVIwTXUzLCBlcnJvciA9IC0xMw0KYGBgDQpH
aXQgY2xvbmUgb3V0cHV0Og0KYGBgDQpmYXRhbDogd3JpdGUgZXJyb3I6IEJhZCBmaWxlIGRlc2Ny
aXB0b3IsIDEzNy4zMSBNaUIgfCA0NS43NyBNaUIvcw0KZmF0YWw6IGZldGNoLXBhY2s6IGludmFs
aWQgaW5kZXgtcGFjayBvdXRwdXQNCmBgYA0KDQoNCiMjIyBDb250ZXh0DQoNClRoZSBmb2xsb3dp
bmcgZXJyb3IgaXMgc2VlbiB3aGVuIHJ1bm5pbmcgZ2l0IGNsb25lIG92ZXIgTkZTdjQgYW5kIGEg
ZmFpbG92ZXIsIG9yIHNlcnZlciByZXN0YXJ0LCBvY2N1cnM6DQpgYGANCk5GU3Y0OiBzdGF0ZSBy
ZWNvdmVyeSBmYWlsZWQgZm9yIG9wZW4gZmlsZSBwYWNrL3RtcF9wYWNrX2FSME11MywgZXJyb3Ig
PSAtMTMNCmBgYA0KVGhpcyBlcnJvciBpcyBhbiBhY2Nlc3MgZGVuaWVkIGVycm9yIHRoYXQgaGFw
cGVucyB3aGVuIHlvdSB0cnkgdG8gb3BlbiBhIGZpbGUgd2l0aCBpbnN1ZmZpY2llbnQgcGVybWlz
c2lvbnMuIEluIHRoaXMgY2FzZSB0aGUgZmlsZSBiZWluZyBvcGVuZWQgaXMgYSByZWFkIG9ubHkg
ZmlsZSBhbmQgaXQgaXMgYXR0ZW1wdGVkIHRvIGJlIG9wZW5lZCB3aXRoIHdyaXRlIGFjY2Vzcy4N
Cg0KR2l0IG9wZW5zL2NyZWF0ZXMgdGhpcyBmaWxlIHdpdGggdGhlIE9fUkRXUiBmbGFnIGJ1dCB0
aGVuIGFwcGxpZXMgcmVhZCBvbmx5IHBlcm1pc3Npb25zIHRvIGl0LCAwNDQ0LiBTaW5jZSB0aGUg
cGVybWlzc2lvbnMgYXJlIGNoYW5nZWQgYWZ0ZXIgdGhlIGZpbGUgaXMgb3BlbmVkLCB0aGUgZmls
ZSBoYW5kbGUgd29ya3MgZmluZS4gSG93ZXZlciBpZiB0aGUgZmlsZSB3YXMgYXR0ZW1wdGVkIHRv
IGJlIHJlLW9wZW5lZCB3aXRoIHRoYXQgc2FtZSBmaWxlIGhhbmRsZSB3ZSB3b3VsZCBzZWUgYSAt
MTMgZXJyb3IuIFRoaXMgaXMgd2hhdCB3ZSBzZWUgZm9sbG93aW5nIGEgZmFpbG92ZXIgaW4gTkZT
djQuIFdoZW4gY2xpZW50cyByZWNsYWltIHRoZWlyIG9wZW4gZmlsZXMsIHRoZSBORlMgc2VydmVy
IHJlLWV2YWx1YXRlcyB0aGUgZmlsZSBhY2Nlc3MuDQoNCmBgYA0KwqDCoMKgIGludCBtb2RlID0g
MDQ0NDsNCsKgwqDCoCBnaXRfcGF0aF9idWYodGVtcF9maWxlbmFtZSwgIm9iamVjdHMvJXMiLCBw
YXR0ZXJuKTsNCsKgwqDCoCBmZCA9IGdpdF9ta3N0ZW1wX21vZGUodGVtcF9maWxlbmFtZS0+YnVm
LCBtb2RlKTsNCmBgYA0KLSBodHRwczovL2dpdGh1Yi5jb20vZ2l0L2dpdC9ibG9iL21hc3Rlci9v
YmplY3QtZmlsZS5jI0w0NzgNCg0KYGBgDQrCoMKgwqDCoMKgwqDCoCBmZCA9IG9wZW4ocGF0dGVy
biwgT19DUkVBVCB8IE9fRVhDTCB8IE9fUkRXUiwgbW9kZSk7DQpgYGANCi0gaHR0cHM6Ly9naXRo
dWIuY29tL2dpdC9naXQvYmxvYi9tYXN0ZXIvd3JhcHBlci5jI0w0OTENCg0KVGhpcyBpcyBhbiBp
c3N1ZSBmb3IgYWN0aXZlL3Bhc3NpdmUgSEEgZmlsZSBzZXJ2ZXJzLiBTaW5jZSBORlN2NCBldmFs
dWF0ZXMgZmlsZSBwZXJtaXNzaW9ucyBhdCB0aGUgdGltZSBvZiBvcGVuaW5nIGEgZmlsZSwgdGhp
cyBGRCB3aWxsIGFsd2F5cyBnZXQgYW4gYWNjZXNzIGRlbmllZCBlcnJvciBpZiBhIGZhaWxvdmVy
IG9jY3VycyBkdXJpbmcgZ2l0IGNsb25lLg0KDQojIyMgUmVwcm9kdWNlcg0KDQpPbiB0aGUgY2xp
ZW50LCBtb3VudCB0aGUgTkZTIHNoYXJlIHdpdGggTkZTdjQgYW5kIHJ1biBnaXQgY2xvbmUgdXNp
bmcgdGhlIE5GUyBtb3VudCBhcyB0aGUgdGFyZ2V0IGRpcmVjdG9yeS4NCmBgYA0Kcm9vdEBpcC0x
MC0wLTg1LTI0MTovaG9tZS91YnVudHUjIG1vdW50IC10IG5mcyAtbyBuZnN2ZXJzPTQuMixuY29u
bmVjdD0xNiAxMC4wLjY2LjU4Oi9zaGFyZSAvbmZzbW50DQpyb290QGlwLTEwLTAtODUtMjQxOi9o
b21lL3VidW50dSMgbWtkaXIgLXAgL25mc21udC9yZWFjdA0KDQpyb290QGlwLTEwLTAtODUtMjQx
Oi9ob21lL3VidW50dSMgZ2l0IGNsb25lIC12IGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9vay9y
ZWFjdC5naXQgL25mc21udC9yZWFjdA0KQ2xvbmluZyBpbnRvICcvbmZzbW50L3JlYWN0Jy4uLg0K
cmVtb3RlOiBFbnVtZXJhdGluZyBvYmplY3RzOiAzNTY4NjgsIGRvbmUuDQpyZW1vdGU6IENvdW50
aW5nIG9iamVjdHM6IDEwMCUgKDU0My81NDMpLCBkb25lLg0KcmVtb3RlOiBDb21wcmVzc2luZyBv
YmplY3RzOiAxMDAlICgyNTYvMjU2KSwgZG9uZS4NCmZhdGFsOiB3cml0ZSBlcnJvcjogQmFkIGZp
bGUgZGVzY3JpcHRvciwgMTM3LjMxIE1pQiB8IDQ1Ljc3IE1pQi9zDQpmYXRhbDogZmV0Y2gtcGFj
azogaW52YWxpZCBpbmRleC1wYWNrIG91dHB1dA0KDQpyb290QGlwLTEwLTAtODUtMjQxOi9ob21l
L3VidW50dSMgZ3JlcCBORlMgL3Zhci9sb2cva2Vybi5sb2cgMjAyNS0wMi0wN1QyMTo1NDo0Mi41
NjI3MjUrMDA6MDAgaXAtMTAtMC04NS0yNDEga2VybmVsOiBORlN2NDogc3RhdGUgcmVjb3Zlcnkg
ZmFpbGVkIGZvciBvcGVuIGZpbGUgcGFjay90bXBfcGFja19Ma2JyS2EsIGVycm9yID0gLTEzDQpg
YGANCg0KT24gdGhlIHNlcnZlciwgcmVzdGFydCBORlMgc2VydmVyIGNsaWVudCBpcyBvbiB0aGUg
4oCcUmVjZWl2aW5nIG9iamVjdHPigJ0gc3RlcCBvZiBnaXQgY2xvbmUuDQpgYGANCiMgc3lzdGVt
Y3RsIHJlc3RhcnQgbmZzLXNlcnZlci5zZXJ2aWNlwqANCmBgYA0KDQo=
