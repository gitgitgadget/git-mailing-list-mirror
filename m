Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76E311597
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619727; cv=none; b=i1cjq9MpCdz3enJ1IIxxpx4YJ6DRL5/oD5lAd3F/hHW38CV1qnOKfnYNqrqA8CLly2I+82jhvVpnXwkowabQx5sG6tDWYJMOMmGwG/M2LPGo4TY28QHpYjlmEsoY9OeWaitcpMdr8ZmIYjA6pk/A0kyXjBgcTEjQY59FoTsSS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619727; c=relaxed/simple;
	bh=8rP21hO7RmPTBSYz813w3IPyvyxh4aI6vSULRSEnYqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAbVk6mBIQH+CuAZp/DrJ9RCiUFiGA+K45aQfS3teKBKyfwTqU7j8x4i6pJNodsBAFx+fGvYu1IyOWMw67VW59kLEBcIFP23/gqvOPqDU8fG+DBL8aiVJdFvKaEcM2lBBY3IkqB/cY5C5pWU66LQzFriyNPnl2/vAoDXoGfqx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4f1T8S5ztHzRnlK;
	Wed, 28 Jan 2026 18:02:00 +0100 (CET)
Message-ID: <547d261c-a716-4c57-8b93-09cf7d8fb176@kdbg.org>
Date: Wed, 28 Jan 2026 18:02:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC v3] diff.tcl: made alignment of tabs in git-gui diff
 consistent with gitk
Content-Language: en-US
To: Chris Idema <github_chris_idema@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>,
 Chris Idema via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
 <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.01.26 um 11:20 schrieb Chris Idema via GitGitGadget:
> From: Chris Idema <github_chris_idema@proton.me>
> 
> Tab stop width was not properly rendered in TK regardless of
> tab width setting. The + or minus character at start of line made
> tabs align incorrectly.

This is a patch for Git GUI. Please use the subject prefix "git-gui:".
The file name need not be mentioned.

Please have a look at existing commits and mimic the style of the commit
subject and body text. In particular:

- Use present tense to describe the current state. Elaborate what the
problem is. Assume that readers haven't looked at the code for some time
and guide them to the problem point (i.e., provide some context).

- Use imperative mood to describe the change as if you instruct someone
to make the change.

I suggest this subject:

git-gui: shift tabstops to account for the first column of context diffs

> 
> Signed-off-by: Chris Idema <github_chris_idema@proton.me>
> ---
>     diff.tcl: made alignment of tabs in git-gui diff consistent with gitk
>     
>     cc: Johannes Sixt j6t@kdbg.org

Just FYI, this message didn't arrive in my mailbox despite this line.

> diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
> index 442737ba4f..7da6e5ccae 100644
> --- a/git-gui/lib/diff.tcl
> +++ b/git-gui/lib/diff.tcl
> @@ -495,6 +495,7 @@ proc read_diff {fd conflict_size cont_info} {
>  			}
>  		}
>  		set mark [$ui_diff index "end - 1 line linestart"]
> +		apply_tab_size 1
>  		$ui_diff insert end $line $tags
>  		if {[string index $line end] eq "\r"} {
>  			$ui_diff tag add d_cr {end - 2c}

If you look at commit a43c5f51a4b1, you will notice that it intended to
apply "magic" tabstops only to 3-way-diffs. It did not intend to "fix"
regular patch text. Without the change, 3-way-diffs would become even
more misaligned, because these have two initial positions instead of
just one. To fix the additional misalignment, it applies the offset 1 to
the tabstops. But this does not fix the original misalignment.

You now want to fix the original misalignment. Therefore, you have to
apply the offset 1 for regular patch text, but offset 2 to 3-way-diffs.
And, in addition, no offset if file contents are displayed.

-- Hannes

