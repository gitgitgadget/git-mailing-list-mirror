Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6Meq3lb"
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BCCBC
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 20:05:14 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58a01a9fad0so219762eaf.1
        for <git@vger.kernel.org>; Tue, 21 Nov 2023 20:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700625914; x=1701230714; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHk0MFSRdlJSUX7WAzOiT/wUeyHggpVYqzLtNjIU058=;
        b=M6Meq3lbyh9vrzeGWJFvHqnZXhjBC2t83bZ6XArSI/AFP8gfYg0VT5zzRNIZCWyj85
         gWTYYr+RCFCJiDzSfxCUU3ytHn2FUadv0RCrL7TnkQ2f91HqYNZiBTOvrdBPb/0ZgIk7
         4eS5Am5unneO/EyioKe/Nl7kdlDEj+Vn4ITxePJQFVQZQIiiQvIiJDLO9ZESSZehHuAF
         iUkAPaWj9wGjQZVykPtFgBPK0ahUMgM6tWPzkFmZWqKv8LKeGC7OEd3vEQcUTAh2hoFT
         BGqcRE8110WP6it5M0YfO4PU/5kxKs8bootIP3diEKqYbCeHVDiEYAJEKC1UABGpnlFx
         Hnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700625914; x=1701230714;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHk0MFSRdlJSUX7WAzOiT/wUeyHggpVYqzLtNjIU058=;
        b=BILQ+dbSQ6OGfrzqGFf+uY74mgbJM8u6paTOOpmoBxLPIVJKP0vYKgbn15EypaXj4T
         q9RpIP7KWwvKhFLjDXuI+I4EolAzArEgr8LvONJ96vwN4pPdhr0hCpNo8Jr0tarE+iKv
         Wxdf3yPS0bejp8+RxAF5TvT0kIbp7DF0koSUGnBGPwmR7dQS/cPuuHzaCJzmShgZUbdu
         ZVsCFOg5OaqmmDWmFkhADOvUuhXZmQRukzk2s+PztgmtFRjlzKpT8E+lrJKu6v/J49JK
         FKR7kyt/Hs18/F61TYXCQ/KIwJ0iYTjWHtV2jdkYNzF6jW/aUbQ5jmeCnl1T38QrIcH7
         afSw==
X-Gm-Message-State: AOJu0Yyk0Tgb93vgyQ/4wNEy0soV1oY02Wpm5M77+s+AFGNHyTlv9Xm+
	AAxClNQz0Svn6Uk8nJ1ELCYUk+JZ5/64jKVDmu17csrcT0Y=
X-Google-Smtp-Source: AGHT+IGdLGUPTYhKGF9KpOAyHZTAo30caDD+yUsR825/Z88TRmFOTWdB9uYC2FloZ2yRT1F0vJs/ydfa5rkDHbsSt5Q=
X-Received: by 2002:a05:6820:1ca8:b0:589:dc3c:5773 with SMTP id
 ct40-20020a0568201ca800b00589dc3c5773mr698232oob.0.1700625913974; Tue, 21 Nov
 2023 20:05:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ryenus <ryenus@gmail.com>
Date: Wed, 22 Nov 2023 12:05:02 +0800
Message-ID: <CAKkAvayLrYS1GQ_-Z7kWM=k4pCnNv1Q=NvYcvT8+wqYPkePVcw@mail.gmail.com>
Subject: [commit-graph] v2.43.0 segfault with fetch.writeCommitGraph enabled
 when fetch
To: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The issue appeared after updating to git v2.43.0, now git fetch would cause
segmentation fault when commit graph is enabled. Though I only observed this
issue in a repo with two submodules, regardless of whether the submodules are
checked out or not. Meanwhile most other repos without submodules worked fine.

> 15:57:10.660377 run-command.c:726                 child_start[2] git maintenance run --auto --no-quiet
> 15:57:10.665870 common-main.c:55                  version 2.43.0
> 15:57:10.666265 common-main.c:56                  start /opt/homebrew/opt/git/libexec/git-core/git maintenance run --auto --no-quiet
> 15:57:10.666469 repository.c:143                  worktree /path/to/repo/sub/module2
> 15:57:10.666649 git.c:464                         cmd_name maintenance (_run_dashed_/_run_git_alias_/pull/fetch/fetch/maintenance)
> 15:57:10.668232 git.c:723                         exit elapsed:0.003405 code:0
> 15:57:10.668241 trace2/tr2_tgt_normal.c:127       atexit elapsed:0.003415 code:0
> 15:57:10.668611 run-command.c:979                 child_exit[2] pid:46018 code:0 elapsed:0.008227
> 15:57:10.668635 git.c:723                         exit elapsed:1.837179 code:0
> 15:57:10.668639 trace2/tr2_tgt_normal.c:127       atexit elapsed:1.837182 code:0
> 15:57:10.669007 run-command.c:979                 child_exit[3] pid:46006 code:0 elapsed:1.843739
> 15:57:10.671522 usage.c:80                        error fetch died of signal 11
> error: fetch died of signal 11
> 15:57:10.671645 run-command.c:979                 child_exit[1] pid:45980 code:139 elapsed:5.292927
> 15:57:10.671658 git.c:723                         exit elapsed:5.337363 code:1
> 15:57:10.671663 trace2/tr2_tgt_normal.c:127       atexit elapsed:5.337368 code:1
> 15:57:10.672048 run-command.c:979                 child_exit[1] pid:45978 code:1 elapsed:5.345050
> 15:57:10.672099 git.c:819                         exit elapsed:5.355644 code:1
> 15:57:10.672105 trace2/tr2_tgt_normal.c:127       atexit elapsed:5.355649 code:1


Subsequent `git fetch` would then fail due to the left over lock file:

> 15:57:19.059375 run-command.c:726                 child_start[2] git maintenance run --auto --no-quiet
> 15:57:19.065689 common-main.c:55                  version 2.43.0
> 15:57:19.066027 common-main.c:56                  start /opt/homebrew/opt/git/libexec/git-core/git maintenance run --auto --no-quiet
> 15:57:19.066206 repository.c:143                  worktree /path/to/repo/sub/module2
> 15:57:19.066387 git.c:464                         cmd_name maintenance (_run_dashed_/_run_git_alias_/pull/fetch/fetch/maintenance)
> 15:57:19.067888 git.c:723                         exit elapsed:0.003122 code:0
> 15:57:19.067896 trace2/tr2_tgt_normal.c:127       atexit elapsed:0.003131 code:0
> 15:57:19.068239 run-command.c:979                 child_exit[2] pid:46076 code:0 elapsed:0.008852
> 15:57:19.068276 git.c:723                         exit elapsed:1.661854 code:0
> 15:57:19.068281 trace2/tr2_tgt_normal.c:127       atexit elapsed:1.661858 code:0
> 15:57:19.068714 run-command.c:979                 child_exit[3] pid:46065 code:0 elapsed:1.667321
> 15:57:19.069327 usage.c:61                        error Unable to create '/path/to/repo/.git/objects/info/commit-graphs/commit-graph-chain.lock': File exists.
>
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue.
> fatal: Unable to create '/path/to/repo/.git/objects/info/commit-graphs/commit-graph-chain.lock': File exists.

As a workaround, I disabled fetch.writeCommitGraph to get fetch work again.
