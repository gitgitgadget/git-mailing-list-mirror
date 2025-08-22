Received: from mail.reprendre.net (mail.reprendre.net [193.23.30.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB91226165
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.23.30.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875823; cv=none; b=cxZ1nfw8TTKJUlnlsFJMkhXB9fAKv0CQUxupnNNqJVEzD9geE4f2G1aofT8nxykuQ5DGXVtcr58/EttbeXcZkQgEjyKh+fVhPm0+4iANU80WgMYy1VSeaufwLFPvehYUQFFdrmI5JffwZtSokvrugX+ll3Qoi3NyCvhNOq4rZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875823; c=relaxed/simple;
	bh=2VNEkM1frcIOX4hhD+i3aMOfIdFrcacS8dSbfAJgaLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WhwScOrNDnSapJejh6Cjkh5mC4Wm+qly1BEuIoIXIblABqmGfIZwy6J1b8zVfMBJBgLGaeuHBaUAjCeKYHg8P19l842jkRJUT2LLm2+OnozuSTvp5Yd3zUajC/z+OW4p0v5bL01b5H+A9326TNsGic4NnhBje0sDA5zlKYTC+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cassou.me; spf=pass smtp.mailfrom=cassou.me; dkim=pass (2048-bit key) header.d=cassou.me header.i=@cassou.me header.b=k6LNUT6y; arc=none smtp.client-ip=193.23.30.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cassou.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cassou.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cassou.me header.i=@cassou.me header.b="k6LNUT6y"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 452642CD3CC
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cassou.me; s=dkim;
	t=1755875450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=G5YDZZ4mBe6SWQEx3PZ0K9HhHB6WjD1SvPCxCZ5D/bM=;
	b=k6LNUT6yb/RHT0/sFaoZs+PzqZdtouGdrb7ggWnb4ECp35ZWZ3eLI3Tq8GhV/FR258n5BG
	rCfVlko/NmGa4pG/IsmPtjq1p54OK5PLt3C1yqsRPTUofXWFFCJCJp9cYulBGUV2Oo8lrD
	VE81QF/HqsdbsB7n9FzGKKodQbRojlWsNG99TzlKx7YPP06eCUQvFvtNWopAN0SmoXDDv7
	jHqIHW2rhvLT7z75mKSkF/han5UMEmkvJECSS4wLT1qPrd0/Jp2d0uBihK1Xu42EoTxyaR
	jpoyH1MBpxGnX4qClEDCAJGta76OrFFeMu761VgOep94NY062fZJ0tFGPK7zCQ==
From: Damien Cassou <damien@cassou.me>
To: git@vger.kernel.org
Subject: git status shows a different result depending on how fast a file is
 changed
Date: Fri, 22 Aug 2025 17:10:48 +0200
Message-ID: <m0o6s7xuh3.fsf@cassou.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Last-TLS-Session-Version: TLSv1.3

--=-=-=
Content-Type: text/plain

Hi,

The attached script has a commented "sleep 1s" line in the middle. If it
is commented, "git status" at the end will not list your last changes to
foo.txt (which I find a weird behavior). If you uncomment the line, "git
status" will see your changes.

My global Git configuration file ~/.config/git/config only contains
settings for user.name and user.email. I can reproduce both on macOS and
GNU/Linux. My Git version is 2.50.1.

I realize that if the date of foo.txt at the end of the script is
changed then "git status" will always detect the change. I also realize
that if the size of foo.txt changes then "git status" will always
detect the change.

Can somebody explain me how the "delay 1s" command can change the
behavior of "git status"? If you know where in the C code this behavior
is implemented, I'm interested as well.

Thank you very much

-- 
Damien Cassou

"Success is the ability to go from one failure to another without
losing enthusiasm." --Winston Churchill

--=-=-=
Content-Type: application/x-sh
Content-Disposition: attachment; filename=git-use-cases.sh
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgYmFzaAoKc2V0IC1lCgpybSAtcmYgL3RtcC9teS10ZXN0LXJlcG8KbWtk
aXIgLXAgL3RtcC9teS10ZXN0LXJlcG8KY2QgL3RtcC9teS10ZXN0LXJlcG8KZ2l0IGluaXQgLS1v
YmplY3QtZm9ybWF0PXNoYTEgLS1pbml0aWFsLWJyYW5jaD1tYWluCgpnaXQgY29uZmlnIGNvbW1p
dC5ncGdTaWduIGZhbHNlCmdpdCBjb25maWcgY29yZS5mc21vbml0b3IgZmFsc2UKZ2l0IGNvbmZp
ZyBjb3JlLnVudHJhY2tlZGNhY2hlIGZhbHNlCmdpdCBjb25maWcgY29yZS5wcmVsb2FkaW5kZXgg
ZmFsc2UKCmVjaG8gIi0tLS0gQ3JlYXRpbmcgZm9vLnR4dCIKZWNobyAiRnJvbSBjb21taXQgMSIg
PiBmb28udHh0CnRvdWNoIC0tZGF0ZT0nQDEyMzQ1Njc4OTAnIGZvby50eHQKZ2l0IGFkZCAtLXZl
cmJvc2UgZm9vLnR4dAoKZWNobyAiLS0tLSBDb21taXR0aW5nIgpnaXQgY29tbWl0IC0tbWVzc2Fn
ZT0iQWRkaW5nIGZvby50eHQiCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIENvbW1lbnQvdW5jb21tZW50IHRoZSBm
b2xsb3dpbmcgbGluZSB0byBzZWUgYSBkaWZmZXJlbnQgcmVzdWx0IGZvcgojIHRoZSAiZ2l0IHN0
YXR1cyIgYXQgdGhlIGVuZDoKCnNsZWVwIDFzCgojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKZWNobyAiLS0tLSBNb2Rp
ZnlpbmcgdGhlIGNvbnRlbnQgb2YgZm9vLnR4dCIKZWNobyAiRnJvbSBjb21taXQgMiIgPiBmb28u
dHh0CnRvdWNoIC0tZGF0ZT0nQDEyMzQ1Njc4OTAnIGZvby50eHQKCmVjaG8gIi0tLS0gU2hvd2lu
ZyB0aGUgc3RhdHVzIgpnaXQgc3RhdHVzCg==
--=-=-=--
