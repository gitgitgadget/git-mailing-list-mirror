Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D062882D7
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079807; cv=none; b=YoekbsiUjNGJXCwI3KoiuHmaA6iqeRBZfR8Yu+DciqbAVUiwkoir3kq8CFcySoc8zoJaSZ0sUuPyFlZa7u7tU6E+7imVen2LG4buIwLIclUNkfiSMdg3eBTavniPf/0WpOj6FIGAL1ly6cGigjqQuRlcSNHyivk2VFybeKnC310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079807; c=relaxed/simple;
	bh=97JVEBOhy1D013yuaMCWgmaNE3yGg0BouTw8kp1MpGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dnLuJIcNnBrJYl19CJ5+vKsCy9lGe51+yFcuKVNvb4wS5y3kHuXrJ/yRlUxnVfbSB1mjSHFkM8RirWwf6UAfZAkDx4JT6PdocQIuw8KmZgyJyLZjH8jdlhGysJc7ZoX+Ibx1xLOikbjeo9VQ9vf4etFlYDeLr12BGCpK4eYNXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uuWin-0006X2-Tv; Fri, 05 Sep 2025 15:43:21 +0200
Message-ID: <9928e25d-f20c-41c1-9a33-5214f54fb11c@pengutronix.de>
Date: Fri, 5 Sep 2025 15:43:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] GIT-VERSION-GEN: Use standard versioning suffix
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, kernel@pengutronix.de
References: <20250905-semver-v1-1-3f6dd32f71a3@pengutronix.de>
 <aLrVQLZpAf-WqFvY@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <aLrVQLZpAf-WqFvY@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

On 2025-09-05 14:19, brian m. carlson wrote:
> Git doesn't follow SemVer.  We make breaking and incompatible changes
> without bumping the major version all the time, so it doesn't make sense
> to say that we should follow SemVer for version numbers.

I meant the lexical format of semver, rather than its semantics, and the
way that snapshot-version suffixes are separated in particular. The
output of git-describe already aligns with the semver syntax so it seems
reasonable to expect that `git version` of a snapshot build would follow
the same syntax, which has become quite common, and for which parsers
are ubiquitous.

The change in 2006 (commit 5c7d3c9507f7) aimed to make versions
monotonic for RPM packaging but the resulting format doesn't seem to
conform to a known version string format, and not to today's
RPM-packaging guidelines either looking at [1].

> I would say that since Git has had this version number format for a long
> time, b4, which is much newer and should be designed to work with Git,
> should gracefully handle the Git version number rather than have Git
> conform to b4.

Is this really Git's version format, or just how git-version happens to
print in snapshot builds? Is this format used or depended on anywhere
else?

I agree that b4 must follow what git-version outputs and I sent a patch
for b4 [2] but each tool having to implement custom parsing for only the
specifics of the git-version output (as opposed to git-describe which
follows a common format) makes integration needlessly difficult.

Regards, Jonas

[1]: https://docs.fedoraproject.org/en-US/packaging-guidelines/Versioning/
[2]: https://lore.kernel.org/tools/20250905-versionparse-v1-1-48d926da9c10@pengutronix.de
