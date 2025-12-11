Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DC31AAA5
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765475825; cv=none; b=FYtPtquMTbWtsnZXht2TuItKI+b5fq03blQYBrQbwzl3MqLFFXHu1mdXWPlBXOQcpbpk0DKb9xMzqQKNEn9CIsNaBY8MHHsuJJsVdvoSgUoQyYD0oaUb8oh1Aonyse3xWFBViU7heXB0IIGfFzOk8j6Lt4rCACyKiyST9MMu68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765475825; c=relaxed/simple;
	bh=+Oxwc+tzkkWpuAmg2D135IYVDsmNjbHPTiH1s9toq0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g60bXIFwSMaBska+Uy+p2kKj4wdNeFrMHky9XFdrLAz6pObc3Vaf25joWDIQGedAYPVmJt2BVeumLArSuVY82wKCfdHqkQQqQ20WcaixkUrfotq3vFJXTjjjDjqYSvKFMfrBOaQbEQs/1Vn68Sv4jkHlKy40yu9Kw5cT7PFSpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=p4SvbF+L; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="p4SvbF+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765475815; x=1766080615; i=l.s.r@web.de;
	bh=1+JODOPvpg/bR7fIfVkorfhTzGIkXePgHqr9RkJkRD8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p4SvbF+LiPD+eeLFNkEOigHFSJ6WXjMUtFCCPMwNXm3iS8P33+2sYsWSWnoY6Tbv
	 YnOQhSPuMnJ/xhy/cdjp5cH7YSO253f6fnEptpEDRqVpBwHD/kjm+/p5+bO4dzwtE
	 mF932TfCzB+kw9FjLcOa2qnqdfzWBtKqBNxwC+RGhQs85LRCMUsxFVpjY6SmU75MH
	 LQN6fK4PzTWWbDmm4Ixr0x9B6RktGVC4efEHHMFVyZ+fGu0+Mvh6jy36j//vq1BMH
	 vcCu8ngL7FwRj6C1zAZlV6EdF0BpprFzvUz+tk6vSPUBNrBAvTts98ew8wIej0rHs
	 1FapLXUj7acq4NmREA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qqv-1wHC8Q0vGH-018ERM; Thu, 11
 Dec 2025 18:56:55 +0100
Message-ID: <9db2b913-b5d6-4617-b079-b4612eaa2b97@web.de>
Date: Thu, 11 Dec 2025 18:56:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] replay: move onto NULL check before first use
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>
References: <3d83161b-ec34-404a-bb0e-bf4da7ac1db5@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <3d83161b-ec34-404a-bb0e-bf4da7ac1db5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sZHkrgO5qAwkRBKLefB38pKL28BVYxa76WkPklW36nrukCNx+8T
 zm0RjnzmQdXXvYAQD53bAOCmLCWgxwGFi6NvW3lK4XX7+roPj93hgkE9SGUIyH+xc6Vtm3y
 OyE+zyqA76LlfQxFP9r6GtPdQueS/l8ZReH6WuEAgGR4lXkXxkgNoThUp9p2NY/deGMaVKE
 OAK5BsWDzNAGsSqm4TGaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HnP6co1Rcns=;m+28z9CC2Ao9pO5u8cNX3r7H8N3
 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

cmd_replay() aborts if the pointer "onto" is NULL after argument
parsing, e.g. when specifying a non-existing commit with --onto.
15cd4ef1f4 (replay: make atomic ref updates the default behavior,
2025-11-06) added code that dereferences this pointer before the check.
Switch their places to avoid a segmentation fault.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 507b909df7..64ad2f0f04 100644
=2D-- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -454,6 +454,9 @@ int cmd_replay(int argc,
 	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
 			      &onto, &update_refs);
=20
+	if (!onto) /* FIXME: Should handle replaying down to root commit */
+		die("Replaying down to root commit is not supported yet!");
+
 	/* Build reflog message */
 	if (advance_name_opt)
 		strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);
@@ -472,9 +475,6 @@ int cmd_replay(int argc,
 		}
 	}
=20
-	if (!onto) /* FIXME: Should handle replaying down to root commit */
-		die("Replaying down to root commit is not supported yet!");
-
 	if (prepare_revision_walk(&revs) < 0) {
 		ret =3D error(_("error preparing revisions"));
 		goto cleanup;
=2D-=20
2.52.0
