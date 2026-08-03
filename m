Received: from dd18010.kasserver.com (dd18010.kasserver.com [85.13.161.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F131B672
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.161.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744178; cv=none; b=aiCqrG43s8iveomS9u5oKVYuAXj7aXecFR/ia12Tu8c4QfcDsK1P2QMKIMkL4kA4sykiE3sgaCHGVS5irZ9A9VRpvc4gCL3FqT9gwkp0muFVHpkDbtnFvCGQyk5w3mQ8+4JP/eRTbjiYCCJ/JmKQAHE9//6iJ3UgaW03E9UoCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744178; c=relaxed/simple;
	bh=6ooUXT6R7fxpsRkb5SnGZH52VoktIKK8i8jWBHb9Dsk=;
	h=Subject:To:References:From:MIME-Version:In-Reply-To:Content-Type:
	 Message-Id:Date; b=ojdPKqQY5LVR8Uv2CXopwwkxL4Y2LRsrzoDouiASQU42qIhZkBIAsg6tDCn9TIJPY/bZmvytEuOorSgnxaatNO/BgB0L4vL/MTOX8vJYOe1edx5MKFWYKAiXin3Hzz6N8aakq2o4WeF3D2wy6WIePU+nCxOtA/jW/ZaY0YvgGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evolution515.net; spf=pass smtp.mailfrom=evolution515.net; dkim=pass (2048-bit key) header.d=evolution515.net header.i=@evolution515.net header.b=CEB5xBiN; arc=none smtp.client-ip=85.13.161.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evolution515.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=evolution515.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=evolution515.net header.i=@evolution515.net header.b="CEB5xBiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=evolution515.net;
	s=kas202607300014; t=1785744174;
	bh=WWmbdouhRnvUrdzioudBGkD8wNWwLRyOL1oaVTt1WK8=;
	h=Subject:To:From:Reply-To:In-Reply-To:Date:From;
	b=CEB5xBiN+liFdrEz8Ul7tOU3H1HBuVzrBifKLxkqbIFPrIajwicpXOMoYqNoL74q7
	 il5SE/uJAZM/GUnmD9k27oXqoPMWTX0nNHye/67l4sBqLRQQlxLs23itbaawgPmPk8
	 ajzlQL08w5sZpe2mVW3gB4IsG9f5WWA2LfievDWGodRItdLy+8Gi1Cjhs7oDMEm3ZU
	 DQduGs1sY+fnkEAqrWR/bAeNpw17tU+pVwVwQ+m2Bp3I/rlTYkiDNKoEp/zou9yg5s
	 wtJnyVes0fM542l29UVbh4PQ2llFWZTL0HbI6IXIWsQeexvAyp1mo92SGWQikqL4pr
	 6ToU146r5Lkkg==
Received: from dd18010.kasserver.com (dd0802.kasserver.com [85.13.143.1])
	by dd18010.kasserver.com (Postfix) with ESMTPSA id 38A0459466E8;
	Mon,  3 Aug 2026 10:02:54 +0200 (CEST)
Subject: Re: git rebase writes worktree "Ref ... checked out at ..." todo
 comments with a hardcoded '#', breaking parsing when core.commentChar is not
 '#'.
To: git@vger.kernel.org, mg@evolution515.net
References: <20260803094639.0B7DB5946343@dd18010.kasserver.com>
From: "Markus Geiger" <mgeiger@evolution515.net>
Reply-To: mg@evolution515.net
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 77.2.123.233
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260803094639.0B7DB5946343@dd18010.kasserver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20260803080254.38A0459466E8@dd18010.kasserver.com>
Date: Mon,  3 Aug 2026 10:02:54 +0200 (CEST)
X-Spamd-Bar: ----

Ok, you can close it. I couldn't reproduce it in newer versions. 

Sorry, for taking up your time.


The bug reproduces on your 2.43.0 but is gone in the newest git (2.55.0). It also doesn't reproduce on 2.39.5, which means this was a regression introduced somewhere in the 2.40–2.43 range and later fixed upstream — not a longstanding bug.


┌─────────────────┬─────────────────┬────────────────┐
│   git version   │     Source      │     Result     │
├─────────────────┼─────────────────┼────────────────┤
│ 2.39.5          │ debian bookworm │ ✅ not present │
├─────────────────┼─────────────────┼────────────────┤
│ 2.43.0          │ your host       │ ❌ BUG PRESENT │
├─────────────────┼─────────────────┼────────────────┤
│ 2.55.0 (newest) │ alpine edge     │ ✅ FIXED       │
└─────────────────┴─────────────────┴────────────────┘

Greetings,
Markus

---

Test Script:

#!/bin/sh
echo "=== git version under test ==="
git --version

T=$(mktemp -d); export HOME="$T"
git config --global user.email t@t.t
git config --global user.name t
git config --global init.defaultBranch main
git config --global core.commentChar ';'          # the trigger

cd "$T"; git init -q super && cd super
echo o > o && git add o && git commit -qm O        # O  (common base)

git checkout -q -b feat
echo a > a && git add a && git commit -qm A         # feat: O->A
echo b > b && git add b && git commit -qm B         # feat: O->A->B

git branch mid feat~1                               # 'mid' -> A (a commit inside feat's range)
git worktree add -q ../midwt mid                    # 'mid' checked out in another worktree (the trigger)

git checkout -q main
echo u > u && git add u && git commit -qm U          # main: O->U  (divergence -> no fast-forward)

git checkout -q feat
echo
echo "=== test: NON-interactive 'git rebase main'  (must replay A,B; commentChar=';') ==="
if git rebase main 2>test.err; then
  echo "RESULT: OK exit=0  --> BUG FIXED"
else
  echo "RESULT: FAIL exit=$?  --> BUG STILL PRESENT"
  echo "--- stderr ---"; cat test.err
  echo "--- generated todo (git-rebase-todo, first 8 lines) ---"
  GD=$(git rev-parse --git-path rebase-merge 2>/dev/null)
  sed -n '1,8p' "$GD/git-rebase-todo" 2>/dev/null || echo "(no todo)"
fi
git rebase --abort 2>/dev/null || true




Markus Geiger schrieb am 03.08.2026 09:46 (GMT +02:00):

> When core.commentChar is set to a non-'#' value (e.g. ';') AND a branch that
> falls within the rebased commit range is checked out in another worktree,
> `git rebase` generates a todo list in which the informational
> "Ref ... checked out at ..." lines are prefixed with a hardcoded '#' instead of
> the configured comment character. Git's own sequencer then re-reads that todo,
> does not recognize '#' as a comment, and aborts with `error: invalid command
> '#'`.
> 
> Minimal, self-contained reproduction:
> 
>     T=$(mktemp -d); export HOME="$T"
>     git config --global user.email t@t.t
>     git config --global user.name t
>     git config --global init.defaultBranch main
> 
>     cd "$T"; git init -q super && cd super
>     echo a > f && git add f && git commit -qm base   # upstream (ancestor)
>     echo b >> f && git commit -qam A
>     echo c >> f && git commit -qam B
>     git branch feat
>     git checkout -q feat                             # primary
> worktree on 'feat'
>     git worktree add -q ../mainwt main               # 'main' (in
> range) checked out elsewhere
> 
>     git config core.commentChar ';'                  # <-- the
> trigger
>     git rebase main~2                                # replay
> A, B onto 'base'
> 
> What did you expect to happen? (Expected behavior)
> 
> Rebase succeeds, exactly as it does with the default core.commentChar='#'.
> The "Ref ... checked out at ..." advisory lines are informational comments and
> should be ignored by the sequencer.
> 
> What happened instead? (Actual behavior)
> 
>     error: invalid command '#'
>     error: invalid line 3: # Ref refs/heads/main checked out at '.../mainwt'
>     error: invalid command '#'
>     error: invalid line 5: # Ref refs/heads/feat checked out at '.../super'
>     You can fix this with 'git rebase --edit-todo' and then run 'git rebase
> --continue'.
> 
> Exit code 1, with a half-initialized rebase left in progress.
> 
> What's different between what you expected and what actually happened?
> 
> The generated rebase-merge/git-rebase-todo mixes two comment characters, which
> shows one code path respects core.commentChar while another hardcodes '#':
> 
>     pick 2fbb49f A
>     pick 15691cb B
>     # Ref refs/heads/main checked out at '.../mainwt'    <-- hardcoded '#'
>  (BUG)
>     # Ref refs/heads/feat checked out at '.../super'     <-- hardcoded '#'
>  (BUG)
>     ; Rebase a0b3bf8..15691cb onto a0b3bf8 (2 commands)  <-- correct ';'  
> (respects config)
> 
> On re-read, todo_list_parse_insn_buffer() treats any line not starting with the
> configured comment char as an instruction, so '#' is parsed as a command.
> 
> Anything else you want to add:
> 
> Root cause: the sequencer code (sequencer.c) that appends the
> "Ref <ref> checked out at <path>" advisory lines when a ref in the rebased
> range
> is checked out in another worktree prepends a literal '#' rather than the
> resolved comment_line_char. Suggested fix: use comment_line_char for those
> lines,
> as the surrounding template lines already do.
> 
> Trigger conditions (both required):
>   1. core.commentChar set to a value other than '#' (also affects 'auto' when
> it
>      resolves to a non-'#' character).
>   2. A branch within the rebased range is checked out in another worktree.
> 
> Impact: `git rebase` is unusable from the CLI for users who set a custom
> core.commentChar (common for teams that begin commit-message lines with '#123'
> issue refs) as soon as they use worktrees.
> 
> Workarounds:
>   - git -c core.commentChar='#' rebase ...
>   - set core.commentChar='#' globally
>   - git rebase --edit-todo and delete the offending '#' lines by hand
> 
> Reproduced on git version 2.43.0 (details below). Not yet checked against
> master.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.43.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 7.0.0-28-generic #28~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jul
>  1 15:50:57 UTC 2 x86_64
> compiler info: gnuc: 13.3
> libc info: glibc: 2.39
> $SHELL (typically, interactive shell): /usr/bin/zsh
> 
> 
> [Enabled Hooks]
> 
