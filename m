Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A29B17BCE
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167393; cv=none; b=Kz3nPMcgS0cDLwE/VYQzlUWXuQzq4xwVTmrBVpsA1JE2f8pKjzy3rxCsexf1ZrnL4gTQ22fIVTnWbcZxKnqT5WFg1B1bKoYn+bM22e6aWrO71HyZzop8x8nTsUTWasbMiCRYYgm8YDnr6CC5sftQj012nKGmUUopbJFNHKGSmJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167393; c=relaxed/simple;
	bh=r4O02mBdzysCiIngeNva5g0/9QOJfdGJIz+NeFEr4R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hx6Lel9h/+Tansg7eHt0076jtCTrCi2h7tYJsZ6y86xLcdUVTWu3J78QNIoxBoESA17FwBWpq6CF/UA44lMK0Ei6bYHVbq/w9/KuWvgcbsLZwbMhX+AdoNe9E5OvuKGBl8CoBw43f+hhOi3xlmDEjnk/HrYcAgJmT7Q4q5ikE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=mu+bOsK9; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="mu+bOsK9"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 75DFA4280C8
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 14:01:04 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:78a9:d95e:29cc:b1a9])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id DB66C5FFB4;
	Fri, 28 Mar 2025 14:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1743166857;
	bh=r4O02mBdzysCiIngeNva5g0/9QOJfdGJIz+NeFEr4R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mu+bOsK9zSVTU4xaF64r+ob6U1lGTjiAPbqeXTtsWSXYpoXZhrqSlbExSWB4X4eDa
	 snNmOj0QSBAu70VuE3RfoPb7GHUSVR4XSHVSR5+GyXqW/eNlHIaXBk2u3YRaVeDUIv
	 qJNC9LjnflfLmagq0TeEmlHeDYzhK/fTNbsgMTm94wVeR5yUdgWm822i/3A3FRFy81
	 q6axqIa+nDV5qvldOipTKp0Z+bJPy5iYj/t9o2jfVl+mRcmfENEhKdxTk2m6eosTW8
	 ztJOue1DanLtoRp5BN9bRAyT9gGx3lIL3rVUdmGSvQhiw0u7TFpIWDjDPiH+iBrvrS
	 q0TAXknYv8BQw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com,
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
Subject:
 Re: [PATCH v5 8/8] update-ref: add --batch-updates flag for stdin mode
Date: Fri, 28 Mar 2025 14:00:49 +0100
Message-ID: <6141866.lOV4Wx5bFT@cayenne>
In-Reply-To:
 <20250327-245-partially-atomic-ref-updates-v5-8-4db2a3e34404@gmail.com>
References:
 <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
 <20250327-245-partially-atomic-ref-updates-v5-8-4db2a3e34404@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 27 March 2025 12:13:32 CET Karthik Nayak wrote:
> When updating multiple references through stdin, Git's update-ref
> command normally aborts the entire transaction if any single update
> fails. This atomic behavior prevents partial updates. Introduce a new
> batch update system, where the updates the performed together similar
> but individual updates are allowed to fail.
> 
> Add a new `--batch-updates` flag that allows the transaction to continue
> even when individual reference updates fail. This flag can only be used
> in `--stdin` mode and builds upon the batch update support added to the
> refs subsystem in the previous commits. When enabled, failed updates are
> reported in the following format:
> 
>   rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP
> <rejection-reason> LF
> 
> Update the documentation to reflect this change and also tests to cover
> different scenarios where an update could be rejected.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-update-ref.adoc |  14 ++-
>  builtin/update-ref.c              |  66 ++++++++++-
>  t/t1400-update-ref.sh             | 233
> ++++++++++++++++++++++++++++++++++++++ 3 files changed, 306 insertions(+), 7
> deletions(-)
> 
> diff --git a/Documentation/git-update-ref.adoc
> b/Documentation/git-update-ref.adoc index 9e6935d38d..5be2c16776 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -7,8 +7,10 @@ git-update-ref - Update the object name stored in a ref
> safely
> 
>  SYNOPSIS
>  --------
> -[verse]
> -'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] |
> [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z]) +[synopsis]
> +git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
> +	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid>
> [<old-oid>] +               [-m <reason>] [--no-deref] --stdin [-z]
> [--batch-updates]

In the case of expressing alternative command line invocations, you need to 
repeat the "git update-ref" command on each line. Otherwise, it means that 
this is the continuation of possible options of one command



> 
>  DESCRIPTION
>  -----------



