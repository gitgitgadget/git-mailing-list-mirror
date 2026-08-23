Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C0385D68
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481060; cv=none; b=fVa7PM9zooAjNg3l2Es+WOAzC9QsPU7IXpAXfDx7tgs5M5NGuQnnxYJgJ1CcXDtBy94TswiFdruwZrPcSYZVZJiO0i3Te/1t8kQUfTxYOXQwYG+nhP5B6Hr4GO2lT65JRkB9bJxuongvNX1uNNlJCu8p6uVbre62M63PW4HIp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481060; c=relaxed/simple;
	bh=a6zMdcBqTIK+qFB8KMVDjq7dsO2kGy1GrTfOXtN1sbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ocwSdyPjWW/X/eurtTWFd6IvjVH4+kSY6yukzfTpq3cM53UXKscodM5OgK2NLrUZLVTZquw8V83zIaHKhg8hSv2veVxBSw9GSRjYumP/n+G/GtAtRzmXtDX6s6o82yqFLXqJ2+yL4NXNgP0gIr/w2KFxNcUG2q1BycTisZVNC1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WDB5eWvU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WDB5eWvU"
Received: from [192.168.4.34] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 131BD20B7166;
	Sun, 23 Aug 2026 03:30:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 131BD20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787481018;
	bh=DJ/ZAC94sBFNg4Y32nKEiSOE8CFQTm4Z+WemhEm0uoc=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:From;
	b=WDB5eWvUWrzb90LJvdA3n72931sqpsrh4HwamJu6DBNrbmFy8yfB2/cbZcba/FlvN
	 TxyJGdJaCROPXk5TCz8yMHrk8j963q7damALz7uXxO8FHWmXIL75rpYRpCfCbyODuA
	 1e/eekd1P+JgGf/3IXnLn8J2/ByZrbLk5WVvhwjI=
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Subject: [PATCH v2 0/3] config: read both home and xdg files for --global
Date: Sun, 23 Aug 2026 20:28:25 +1000
Message-Id: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEvLimoC/5WPTQ6CMBBGr2K6dkjBv+LKexgWQxnKmEJJW4nGc
 HdbPIHJbF4y8775PiKQZwriuvsITwsHdlOCar8TesDJEHCXWFSyOkslFfT8Au2mng1YDhGMdS1
 aGNxIgFMHr85A3WpELesDlq1IptlTOttS7s2Pw7N9kI5ZnTd670aIgyfc0uantUVZH1RhOBbl5
 SzlSaljnTEPdobizYzIttBuzIYhPeP8eyuylDnpb0uzrusXkcVMzhEBAAA=
X-Change-ID: 20260808-fix-config-list-global-home-and-xdg-9bcaac093a1b
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
To: git@vger.kernel.org
Cc: Nils Fahldieck <nils@fahldieck.de>, Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Delilah Ashley Wu <delilahwu@microsoft.com>, 
 Derrick Stolee <stolee@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jade Lovelace <lists@jade.fyi>, Glen Choo <glencbz@gmail.com>
X-Mailer: b4 0.15.2

Hi all, thanks for your patience. Here's my reroll.

As reported in [1], `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config`
are both valid global configuration locations. However, when both files
exist, `git config list --global` only reads from the former location
whereas `git config list` (without `--global`) reads from both. The same
issue was reported for `git config get` in [2]. This inconsistency has
no good justification and contradicts the documented behaviour.

Suppose that `$HOME/.gitconfig` contains:
    [home]
        config = true

and `$XDG_CONFIG_HOME/git/config` contains:
    [xdg]
        config = true

Then, listing with `--global` shows only the home config:
    $ git config list --global --show-scope --show-origin
    global  file:/Users/delilah/.gitconfig    home.config=true

and getting the XDG configuration entry with `--global` will fail:
    $ git config get --global xdg.config; echo $?
    1

Git still reads the XDG config as part of its effective configuration,
as shown by listing the configuration without `--global`:
    $ git config list --show-scope --show-origin
    global  file:/Users/delilah/.config/git/config    xdg.config=true
    global  file:/Users/delilah/.gitconfig            home.config=true

The documentation, quoted in [1] and [2], states that `--global` should
read from both files, so its output should be the same as above. Here's
the relevant excerpt:

> OPTIONS
>     --global::
>         For writing options: write to global `~/.gitconfig` file
>         rather than the repository `.git/config`, write to
>         `$XDG_CONFIG_HOME/git/config` file if this file exists and the
>         `~/.gitconfig` file doesn't.
>
>         For reading options: read only from global `~/.gitconfig` and from
>         `$XDG_CONFIG_HOME/git/config` rather than from all available files.

To be consistent with the documentation and the behaviour without
`--global`, we should read both configuration files when `--global` is
passed. We do this in a few steps:

 - Patch 1 fixes slash normalisation on Windows paths. This is used for
   `--show-origin` assertions in patch 3 tests.
 - Patch 2 modifies error handling when reading configuration files.
   This is used to prevent a regression in patch 3.
 - Patch 3 reads both configuration files when `--global` is specified.

[1]: https://lore.kernel.org/git/CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com/

Thanks again for your time!
Delilah

---
Changes in v2:
 - Squash test-only patches into their corresponding implementation
   patches.
 - Reorder patches to prevent a regression from being introduced and
   then fixed in a later patch.
 - Narrow the scope of slash conversion to `xdg_config_home_for()` and
   avoid modifying `cleanup_path()`, which could've broken callers that
   do not expect normalised slashes.
 - Clarify that some tests only check the return code of a `git config`
   command; we do not care about the output.
 - Link to v1: https://patch.msgid.link/pull.1938.git.1760058849.gitgitgadget@gmail.com/

---
Delilah Ashley Wu (3):
      path: use forward slashes in XDG config on Windows
      config: let sequence require a successful file
      config: read global scope via config_sequence

 builtin/config.c     |  11 +++++
 config.c             |  76 +++++++++++++++++++++++-----------
 config.h             |   2 +
 path.c               |  16 ++++---
 t/t1300-config.sh    | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t1306-xdg-files.sh |   5 ++-
 6 files changed, 194 insertions(+), 31 deletions(-)

Range-diff versus v1:

1:  d9525d954e < -:  ---------- config: read both home and xdg files for --global
2:  c24ed49bac < -:  ---------- cleanup_path: force forward slashes on Windows
3:  51293ee827 < -:  ---------- config: test home and xdg files in `list --global`
4:  26f3c46598 < -:  ---------- config: read global scope via config_sequence
5:  b6ab7bfd67 < -:  ---------- config: keep bailing on unreadable global files
-:  ---------- > 1:  2fa37d8aa7 path: use forward slashes in XDG config on Windows
-:  ---------- > 2:  d90c9ae69f config: let sequence require a successful file
-:  ---------- > 3:  a3b5599c8d config: read global scope via config_sequence

---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260808-fix-config-list-global-home-and-xdg-9bcaac093a1b

