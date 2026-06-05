Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CE3644DB
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677098; cv=none; b=sNNivVEOUajAxehy0jiUGSVqebIjcEwyK1v0/BLclYJy/uHNb2kYv6jhsOu4quGnX610tdWY0T+oQWNsRjw2ny1QtgpcvCIFsC95z6Oh6boC1h71A+buOerObL19vdL9atrT8BrGGoLXkYW4eg1JZjNv0ITE5isFfmnt2S8BjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677098; c=relaxed/simple;
	bh=CieUT0CtSxgKtKTGNFTGUr2qCFIt1UrcVslMeQNWi+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From; b=ReGuvuIv4he534xfLr1L+ROqd+G0iNqYvzmTVmuvt/mnXKjX9caL519O9zgNvWmZTm7ppKwO7a4IgRIUbKwT4054EqALOWYotbUDi2q11S5JjyTJmtEoOPzfYW9JfbAjkOLt6K+C4gibYuEKYioVoojkQSwAWWkc26vz8nu8u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=bpnLylLL; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="bpnLylLL"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id B45F560007;
	Fri,  5 Jun 2026 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1780677090; bh=CieUT0CtSxgKtKTGNFTGUr2qCFIt1UrcVslMeQNWi+w=;
	h=Date:Subject:Cc:To:From:From;
	b=bpnLylLL+Y66R4132eiZU56K6GxXG6xg9Soh/gCh3uBwx0QDqEuYdEi4l4zbaiOan
	 nWmL2mDWzNu+WtTtXMK4zJ8ujzPwoorfOB10aIdJ1r5vcdYXImeQIpNZPT2WyAJ0kf
	 7Ccng2dHUeuLfXb2g2liu+VP1BGOuTnwdmnGaz04=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 12:31:30 -0400
Message-Id: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
Subject: followRemoteHEAD management question
Cc: "Bence Ferdinandy" <bence@ferdinandy.com>
To: <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2

Hello git list,

In the past, I've preferred to run 'git remote set-head <name> -d' when
setting up a new repository, since I generally have an awareness of what
the remote default branch is, and I don't like seeing them in branch
listings or git-log annotations.  They are especially noisy to me if I
have multiple remotes.  It's possible this config is ill-advised - I
would love to be educated if so...

However, since b7f7d16562c3 (fetch: add configuration for set_head
behaviour), these changes are undone by every 'git fetch'.

The topic mentioned above (merged in a1f34d595503) adds a new
configuration key 'remote.<name>.followRemoteHEAD'.  I'm assuming that
the intended use for followRemoteHEAD is really only in local /
per-repository config, since trying to apply it to my personal
.gitconfig has some odd behavior.

The <name> in the key template does not accept a wildcard, so I must
list out each of the common remote names I use across different
repositories.  Since many of my repos don't actually have remotes
established for all of these names, they pick up a kind of half-baked
definition for each of them as git performs its config parsing.  For
instance, a name will appear under 'git remote -v', but it won't
have any actual properties configured.

I'd like to add a line to my config somewhere that can globally restore
the old behavior in this context, eg:

    git config --global remote.*.followRemoteHEAD never

instead of adding individual entries to each project's .git/config.

Is there another solution in place I've missed?  If not, would there be
any opposition to a new key like 'remote.followRemoteHEAD' which serves
to provide a default value for any remote that doesn't have its own
'remote.<name>.followRemoteHEAD' key?

I've started scouting out changes to make for such a patch.  It's not
ready yet, but I figured I would throw this question out in case an easy
answer can save the effort.

Thanks
