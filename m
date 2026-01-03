Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1828CF5F
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767472191; cv=none; b=m+kKDNRsdQtXX6yURiYjicBqnusx8sNqTY4ckf6LH2FD6k5b6p4MoxZrGA8OJ64rSs8sIQ0YYEV+TnTBOU2KTwiQ/r8vrcfVoOK2m8TCaKKTrhFJBxm00iEFAGFs8LiEuOVHQx+W/ol+Gah2P7jcSZuzAjX39xqQUIGBMzGDoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767472191; c=relaxed/simple;
	bh=seiY989IJQQ0YV72nla539iks4UziAd2GNhwCQNKJuU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W4qLJ1bigICafK9CftB0W0i78Wl5IQTG/U7/Uj9sA+cHBOAjz/SiTKccsWElDIFh2m+zqhZ5Gn3TdmaqlwipFjtcBLIq9zqfLnbb9ysY02JQ6+nP+KT/ox3Gv2NO4pzvHw5tLqSsFl+cg8JLvpKOUrTeUe+59WJnYkrNgCPBo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=YqXSMLHu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="YqXSMLHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767472187; x=1768076987;
	i=johannes.schindelin@gmx.de;
	bh=seiY989IJQQ0YV72nla539iks4UziAd2GNhwCQNKJuU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YqXSMLHubdmObfDjdFMlUbXlc2Bhw9lLuYZUh4TRMcLXdxyuGAnkXBt4FQSCUGc5
	 5CJ2ZWB88gUiED+kKLOyU6RJJxTYfC9ql5DDfs66VkMBC7O1zAK5j8Gy7hiMbJmwA
	 TyB+xsEHLZAr6+D+5dP5sDdCRyaI30az0vBcNhO4u+lMiBnZNKp7r71X740/nJMcf
	 diY/DqU0QYcVCVimTkQR4HlHjyAO1HbQwJe+O+2PXFFcK4OAPMUutiAVUZiSD+Dpy
	 eNB0THlFgsT6BLs8sSKQrQ4ztTDbXYHMs6wSQBFcocz0a74WY3x81EkUoooOl+JWq
	 iponca5Ulqj6GdY+MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1vyQWG16OJ-012OFe; Sat, 03
 Jan 2026 21:29:47 +0100
Date: Sat, 3 Jan 2026 21:29:45 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paul Tarjan <paul@paultarjan.com>
cc: phillip.wood@dunelm.org.uk, 
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
    Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v2] t7800: fix racy "difftool --dir-diff syncs worktree"
 test
In-Reply-To: <CALvWuB79v3i3zU_g1swqQVS-fH1f-U8Ptr9Z9ObAUgeFJHx++A@mail.gmail.com>
Message-ID: <1e39f5d3-6b4a-f832-8328-f82ece12deff@gmx.de>
References: <pull.2149.git.git.1767219599334.gitgitgadget@gmail.com> <pull.2149.v2.git.git.1767292068036.gitgitgadget@gmail.com> <02749b7d-e9a4-4894-a50c-91a7c1a22d84@gmail.com> <CALvWuB79v3i3zU_g1swqQVS-fH1f-U8Ptr9Z9ObAUgeFJHx++A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jy7nJeylZ3kPIefKQwqUhL8kE0oYwmn9Xd8rhsF0LHnB13PIp50
 O3Zd47Tbr9dOGXm83aurVXZfivpoq1o9OdtOd7iOR8uWZulcv/lOukUyxHEQ23oZeqoOMSy
 sUW7ZEqSoVLDVS7gyf7SyVT/8TT8nnzGVaLCmZz1w6BsFCOnIuFehLMqQrc652vdmbSqDSn
 nD11q9gSCuE3883ct41aQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uEw3y1CZbWw=;OZM1+laBgYJ7PyOCUXpWw7hH90n
 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

Hi Paul,

On Sat, 3 Jan 2026, Paul Tarjan wrote:

> I've updated the commit and PR summary for your comments. Should I
> re-run /submit to send a no-op patch or leave it as is until code
> changes are needed?

I believe that the change you intended for v2 (adding the "Reviewed-by"
trailer) accidentally made it to the cover letter only, not to the commit
message where it wants to live.

Also, I would like to suggest to replace the non-URL
"git-for-windows/git#5132" with the actual URL:
https://github.com/git-for-windows/git/issues/5132. Remember: Commit
messages are not usually read on GitHub (and some very vocal Git
contributors actually refuse to use GitHub for their contributions).

Ciao,
Johannes
