Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A1154425
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183021; cv=none; b=noArG4I7OwBWc8R2tyNXrA+uSp3JPsNBTWnNdVOTpfQk3WUL4vx8v8zmT8LwaKcO6XuaPcH1u1+tJD/MdQZql35PylJ2yvQ0CONOJHO3i0l9cxfSNh52U3TAEBMlvahtVeyLQ7GSum5OP9ptxSVvnsxAS8+EC6w+8HDYuefGZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183021; c=relaxed/simple;
	bh=FsjQwlbwK9va1sndZfLKKX9/e10SGBCpg+kF+zwJZEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QT88Nrxhg/nGIfVY7cjsvF1pyrL6kujLVpIfqsm4TW1CXa34YkagjGTNzf+fjJgFKwumYpU748RR3iwIiB9OR7AJc2djgI2u+PdgGdouks3EP7HWJ94rGqaAO94VUmD/96n9Pj9Qw4eqe3Ho3pbhvcGXeIrwW6zZzMSz+J0BJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZPSGD06YCzRpKx;
	Fri, 28 Mar 2025 18:30:11 +0100 (CET)
Message-ID: <7b4149e1-44f8-44d4-89f8-647734f9e674@kdbg.org>
Date: Fri, 28 Mar 2025 18:30:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git v2.49.0 - gitk regression on Cygwin
To: Mark Levedahl <mlevedahl@gmail.com>, johannes.schindelin@gmx.de
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <23088b7d-ed98-4b78-bb9a-c3674da1117d@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <23088b7d-ed98-4b78-bb9a-c3674da1117d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 28.03.25 um 13:34 schrieb Mark Levedahl:
> gitk no longer works on Cygwin. This commit is in Junio's tree as part
> of release v2.49.0, but I didn't trace to the specific merge commit.
> 
> The proximal issue is an endless loop caused by routine _which invoking
> exec, which is now a wrapper that invokes _which, while the builtin exec
> is renamed to real_exec.  This results in stack exhaustion.

Not good. Thanks for the report.

> However, the above leaves code in place affecting path search on all
> platforms without justification. The commit message references the TCL
> man page for "exec", listing a number of directories (including the
> current working directory) and file suffixes searched on the Windows
> platform that could be problematic. However, that man page does not list
> any such issues for other platforms. So, it appears the patch does not
> address a known issue on Unix platforms, which includes Cygwin.
> 
> I believe the correct fix to 4cbe9e0e2 is limiting the override of exec
> and open to Windows, and I also have a patch to do that rather than what
> I show above. Let me know.

Indeed, it seems that this override is only needed on Windows. Dscho, is
there a non-obvious reason that 'exec' and 'open' are overridden on all
platforms?

-- Hannes

