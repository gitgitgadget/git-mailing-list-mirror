Received: from smtp-out-02.rz.uni-jena.de (smtp-out-02.rz.uni-jena.de [141.35.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83F313E2E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.35.105.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355092; cv=none; b=T341jliMOzh5RAovw5I7oMHjsCJf/PbM23ckJsUk5KvE2MHnaXugkq+6Urs8n3jNIrmMLWQnxJFhOBRp1zPztmBbcxofdKpHoSH0iYrUppN0A0zOCt/5QgZW3VmOD6Xp0sRiFgqwzovN9Q3P7Ex8cJaGjAT79TqwmtfevGWsQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355092; c=relaxed/simple;
	bh=A97mAVcHiJ2IQT09so7KjU9e09lSbLUDqD4ZPxpkBpI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=JWYNI8F1jNKH2RxO1LEjb1C6NjAfUXFyl2bODUEp2y6wAocIXwHSZBQs5vhlwhXRCbjyQ/dtYjEZYBQlVrYlkCGRU1H2LkNaoBoi/QsUvo2vlmJXsUKVZjF9MBH2NmZQARrzs+rh5yLtRR6b9AIekAodOBaL5T3S+KhYD++E/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-jena.de; spf=pass smtp.mailfrom=uni-jena.de; dkim=pass (2048-bit key) header.d=uni-jena.de header.i=@uni-jena.de header.b=g4bzzZud; arc=none smtp.client-ip=141.35.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-jena.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-jena.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-jena.de header.i=@uni-jena.de header.b="g4bzzZud"
Received: from smtp-intra-03.rz.uni-jena.de (smtp-intra-03.rz.uni-jena.de [10.138.192.41])
	by smtp-out-02.rz.uni-jena.de (Postfix) with ESMTPS id 4cLFCg35jnzGq0K
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 20:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uni-jena.de;
	s=opendkim-2020; t=1757354543;
	bh=A97mAVcHiJ2IQT09so7KjU9e09lSbLUDqD4ZPxpkBpI=;
	h=Date:From:Subject:To:From;
	b=g4bzzZud0y9QFV95VG78+IzDh5E9kUIDCD7DVakazNyhbW4309XK++43FfOIIQbhO
	 l/c1XHIpsjp7KjVeYjXBdluQx+mN7eCj9jGtIIRMY4hRzbnwr9kgPyVqcCINj+RRzt
	 NxeDL+rVw7WEl45xFIKf0bVgh+tOpOgBhkNmFwN1e95ShlxLeI+IhL+aujKs/jDKSL
	 7Hj0/VKzrZR6Rgu4E6S1F7i9vMt/L1m3CF70boPZcwPdgBhHt+Anz3BPZ1n79H7a27
	 xWWw/fgnTN6Q31JkJwGZQFmem/PvWaCtLPRpvtp0uLxnYBFdFVPDe1zr5fLSnuexKU
	 Zjz2nrxkDMtLw==
Received: from [10.148.27.224] (unknown [10.148.27.224])
	by smtp-intra-03.rz.uni-jena.de (Postfix) with ESMTPSA id 4cLFCg26gYzyJC
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 20:02:23 +0200 (CEST)
Message-ID: <7123c20f-04c6-47db-a034-a2871721e58f@uni-jena.de>
Date: Mon, 8 Sep 2025 20:02:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Lino Haupt <linojossfidel.haupt@uni-jena.de>
Subject: [UX] git restore -p: confusing prompt after failed hunk edit
To: git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Git developers,

I'd like to report a small UX issue in the interactive patch editor
used by 'git restore -p' (and, to a lesser extent, 'git add -p').

Short description:
If a manual hunk edit fails, Git currently prints:
   Your edited hunk does not apply. Edit again (saying "no"
   discards!) [y/n]?

The word "discard" here is confusingly close to the normal prompt of
`git restore -p`:
   (2/10) Discard this hunk from worktree [y,n,q,a,d,K,j,J,g,/,e,p,?]?

Environment:
- git version: 2.50.1 (NixOS)

Reproduction:
1. Run 'git restore -p' in a repository with unstaged changes.
2. When shown a hunk, type 'e' to edit the hunk manually.
3. Make an edit that causes the patch not to apply (e.g., remove
    required context), then save and exit.

Actual behavior:
Git prints:
   Your edited hunk does not apply. Edit again (saying "no"
   discards!) [y/n]?

The normal 'restore -p' prompt uses the same word "discard" for the
hunk itself, e.g.:
   (2/10) Discard this hunk from worktree [y,n,...]?

Why this is confusing:
In the failure prompt, "discard" refers to discarding the edit, while
in the normal prompt it refers to discarding the hunk. This made me
hesitate about whether answering 'n' would discard my edit (keeping the
original hunk) or discard the hunk itself.

'git add -p' shows the same failure prompt. Its normal prompt says
   Stage this hunk [y,n,...]?
So the ambiguity is weaker but still present.

Suggestion:
Consider clarifying the failure prompt.
Any of the following would remove the ambiguity:

A (minimal change):
   Your edited hunk does not apply. Edit again (saying "no" discards
   the edit!) [y/n]?

B (explicit menu-style):
   Your edited hunk does not apply. y: edit again; n: discard the edit
   [y/n]?

C (shortest, avoids "discard" altogether):
   Your edited hunk does not apply. y: edit again; n: cancel edit [y/n]?

Rationale:
Point out what exactly is discarded (or cancelled).
This makes it explicit what 'n' does and avoids collision with the
normal "Discard this hunk..." wording in 'git restore -p'. It should
help users who quickly scan prompts.

Thanks for all the great work on Git!

Best regards,
Lino Haupt




