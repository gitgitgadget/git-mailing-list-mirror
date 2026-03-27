Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990133CCFB5
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597913; cv=none; b=WesfPEkhGKtsLB64Tfy2kHglwCMiuaL5gD++GBpLD05526v6Qs7Z/Qu2+fZ23LQV7a/hrXUf5v/9qKGmJPseaNs52MP2CZkFxslnJEtatVlrKBsPwizPARv4SFz7Q8SJI7UCURpHZ6rOWH2Pa42a3sa2EoZNBqg7YHYVhg+4RMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597913; c=relaxed/simple;
	bh=N+zDqVScBOY+tKkRmpGbuTJv0NYcOMP4l+fFAcZK6lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=EC9QLFIHp/6cXnhZO3mmroVwLQCF+EG7DxJQ51RGoTAw4Aw+9OKZFsCqtydYfOwaRFcUaIm00pQ001pdazbMp1aP3Jn+cmoYOV4cMEC9NRYB+gTMH8aTTp49chuf5gW9R+O6ozkrBa3TwKXQashCPR/GBTM6iaLsxOAx6VDMrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fhtBY4Jm0zRpKs;
	Fri, 27 Mar 2026 08:51:32 +0100 (CET)
Message-ID: <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org>
Date: Fri, 27 Mar 2026 08:51:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
To: Wesley Schwengle <wesleys@opperschaap.net>
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20260326233739.2911354-1-wesleys@opperschaap.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.03.26 um 00:37 schrieb Wesley Schwengle:
> * `remote.*.sshIdentityFile' and `remote.*.sshOpts'
> 
> Configuration set on owner/path style. This is to support `includeIf`
> configuration management. For example, a git-forge that host both
> employer/client repo's. Eg, `git@gitlab.com/waterkip/git.git' and
> `git@gitlab.com/corp/git.git' would have something configured as:
> 
> * `core.sshIdentityFile.*', eg
> 
>     [core "sshIdentityFile"]
>       waterkip = ~/.ssh/id_ed25519_me
>       corp     = ~/.ssh/id_ed25519_corporate

This can be solved without a changing Git today. You configure the two
remotes with different fake host names:

[remote "waterkip"]
  url = git@waterkip.gitlab/waterkip/git.git
[remote "corp"]
  url = git@corp.gitlab/corp/git.git

And set up the real host name and identity file in ~/.ssh/config:

Host waterkip.gitlab
  IdentityFile ~/.ssh/id_ed25519_me
  HostName gitlab.com

Host corp.gitlab
  IdentityFile ~/.ssh/id_ed25519_corporate
  HostName gitlab.com


For this reason, I see little incentive to add complexity to Git that
achieves the same.

-- Hannes

