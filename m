Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7E2BB17
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459875; cv=none; b=h48W5mkNWZZKtZAF76J2jcCLrCF04pYIWGXFQYrekk2ldKGOp4FMXjG+nQSIGIduqBAxhxPLyi7d6eyMfdtQk8ovtYQ01Vr5LpMwX3cBNoRdOGMsDyU9wrj43ghmixs6AriI/IZKuXjMuu6Z94rdAKT8OmGo6ohuvHoU5ciSvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459875; c=relaxed/simple;
	bh=bNi+K1XdTjgSvtF67TJgRE8oTd3hnOJtPIP9UPIpr7M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J9uw6DcGcoGCzxhj6aDJFcmAED9pIHXqHiBBgn2iovc1/QbJ9cLCh21Z5qoWgQxlAHpowlpyAxAbHjQ3XZytvVSsW0tke4HJuSjDkpZwxw8v0bO7kk+f1qtbIWgIE2UjRdgPge9JAH4E7cmHP63XCFYcZKFybww30Q2VcbgCL9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lxpodOxx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lxpodOxx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6h7TLbcHZtGebz/ov0Owp25CydAjX8Xrl8vKD8G+vVg=; b=lxpodOxxKz7j0Vhk8iOLZUvClP
	h0mVRoJUzpu6aHANFlvq9UkhAag3tvJ5nrnQ7MH0q14/w7Fn8fa7VLGFHZjKy/fpI7wPMS8nRy7oy
	UffFIYEtvBG4lh3IK4xar5CAIsexEA41oYM/J3lD/W49VXqL8sHg0IOK3iu6wOCFlCj9lO5nDEkjU
	NKpf65O8gGI4LfmWx/SFKk3PFkNWz83mNX3bgu4Fkxf0eKhOUM7jyqxjO8kz6bqOLzzdxRLpHcX+n
	lpurbsnqcMwN0pe7zZZMPIxTDjIxspgcXxKEU6wgFBTBJKLPBXMNIRR2DexEOFle5iYyNPAHZgogR
	an2N0Opg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41446)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ufL0i-00050V-0R
	for git@vger.kernel.org;
	Fri, 25 Jul 2025 17:11:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ufL0h-0001u2-0D
	for git@vger.kernel.org;
	Fri, 25 Jul 2025 17:11:03 +0100
Date: Fri, 25 Jul 2025 17:11:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: git@vger.kernel.org
Subject: [BUG?] git-daemon 2.49.0 in F40 no longer exports user directories
Message-ID: <aIOslkzu-x8K9o_C@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

While I've been away on holiday over the last three weeks, my co-admin
updated ZenIV to Fedora 40, and now I find that git-daemon no longer
exports my "public_git" directory. My attempts at debugging this have
failed - I tried adding strace to the git@.service but I get nothing.
This is a regression.

Having spent quite a while trying to get to the bottom of this and
failing, I'm reaching out for some help - especially given the
proximity of the kernel merge window opening this weekend.

The log indicates:

Jul 25 16:56:55 ZenIV git-daemon[4046439]: [4046439] Extended attribute "host": git.armlinux.org.uk
Jul 25 16:56:55 ZenIV git-daemon[4046439]: [4046439] Extended attribute "protocol": version=2
Jul 25 16:56:55 ZenIV git-daemon[4046439]: [4046439] Request upload-pack for '~rmk/linux-arm.git/'
Jul 25 16:56:55 ZenIV git-daemon[4046439]: [4046439] userpath <public_git>, request <~rmk/linux-arm.git/>, namlen 4, restlen 15, slash </linux-arm.git/>
Jul 25 16:56:55 ZenIV git-daemon[4046439]: [4046439] '~rmk/public_git/linux-arm.git': not in directory list

It seems to detect that it's a user path, and adds the "public_git"
--user-path to it, but it seems to fail to translate ~rmk into
/home/rmk.

/etc/gitconfig contains:

[safe]
        directory = /var/lib/git/git.armlinux.org.uk/*
        directory = /home/rmk/public_git/*

and /lib/systemd/system/git@.service contains:

[Unit]
Description=Git Repositories Server Daemon
Documentation=man:git-daemon(1)

[Service]
User=nobody
ExecStart=-/usr/libexec/git-core/git-daemon --base-path=/var/lib/git --export-all \
          --user-path=public_git --inetd --log-destination=stderr --verbose
StandardInput=socket
StandardError=journal

Any ideas what is necessary to fix it?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
