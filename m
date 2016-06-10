From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 00/44] libify apply and use lib in am, part 2
Date: Fri, 10 Jun 2016 22:10:34 +0200
Message-ID: <20160610201118.13813-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmR-0002zI-G8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbcFJULn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:11:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33172 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbcFJULl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so1066684wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4zDDwM9mHM7goP4xoBO482zowxGWSHaMYlAuRr5VbI=;
        b=C3cmDy9LIbxnnQ5pSuONkk0QJ3mC6oKDfKOnV8ZqhmSGG81jT93UzF6GZ9keByLTav
         cWDAB9Imxhp/o2KNUCnoiBRLE7BQbw1uIGYcrdjFRxWgnSVXa/86KfDGiQJFc+BnRN8j
         UEFm6O5c2ERaZnhbMeanxD97khTEyLCeye2n6mtg+nqvYQBUX1jR3DkPH+nH8OHlBAOj
         KQkkJkLjSydKx0oZ/tSl9s7zzB+qGg0T20SeZni6QZc9oga1Z53MqDSO83Y20MIKAIJq
         jiRyQrmvVW0eXg/1bChKG4UYW0S0KhoAXECzZmR3PQb/2pCcltUEKnREpTP9BmUow9/U
         oEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4zDDwM9mHM7goP4xoBO482zowxGWSHaMYlAuRr5VbI=;
        b=miZ5jxAqjMuDp81j50nDsEUWPTOhq7pNLA3cobs9/pZy43Gy7CBPKmSImfDEIqJfxJ
         RwNi96JCjGZWx2LxHGoIPiBY3k9It4BvGBzx8+9ANRp08aXWii4MNt8GxMcFI+xQPhy4
         kAPcK4980UfKhDOLdc1Px0Q5f7iOWRAuJtLyTW3Y9yxeihiGptQPoEIFt5mjCogTPuh+
         R4TuR82PEEZB5hOb3QaYfpgMcpr2ij1/02KbSlagAFT6CEMWZPvhOdqRjSQNzylTh+7P
         boxseWUej6gf/IjwkMXyG4wVRnVeEra3oVSmava0Iex+CAbRib+OTOirAYSYS+7j53yO
         dtJQ==
X-Gm-Message-State: ALyK8tLr6hzI03wHI3bILiK+z9l5RJgVLdguHn5PFnzTQjZsfRUUa5J/v4zZObFO+Rv+2w==
X-Received: by 10.195.12.229 with SMTP id et5mr4162141wjd.22.1465589499535;
        Fri, 10 Jun 2016 13:11:39 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:38 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297024>

Goal
~~~~

This is a patch series about libifying `git apply` functionality, and
using this libified functionality in `git am`, so that no 'git apply'
process is spawn anymore. This makes `git am` significantly faster, so
`git rebase`, when it uses the am backend, is also significantly
faster.

Previous discussions and patches series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This has initially been discussed in the following thread:

  http://thread.gmane.org/gmane.comp.version-control.git/287236/

Then the following patch series were sent:

RFC: http://thread.gmane.org/gmane.comp.version-control.git/288489/
v1: http://thread.gmane.org/gmane.comp.version-control.git/292324/
v2: http://thread.gmane.org/gmane.comp.version-control.git/294248/
v3: http://thread.gmane.org/gmane.comp.version-control.git/295429/
v4: http://thread.gmane.org/gmane.comp.version-control.git/296350/
v5: http://thread.gmane.org/gmane.comp.version-control.git/296490/

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This new patch series is built on top of the above previous work.

More precisely, this is "part 2" of the full patch series which is
built on top of the "part 1" of the full patch series. And as the
"part 1" is now in "next", this "part 2" is built on top of "next".

  - Patches 01/44 to 33/44 were in v1 and v2.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}. And they use this
libified functionality in git am so that it doesn't launch git apply
processes any more.

=46ollowing great suggestions from Eric and Junio, there are some
changes in these patches to improve on v2:

      - Many commit messages for patches that make a function return
        -1 were simplified by removing "by using error()".

      - 'struct lockfile' instance should be managed properly, as
        rollback_lock_file() should be called in all error paths.

      - The patch that added calls to rollback_lock_file() has been
        squashed into the patch that make apply_all_patches() return
        -1 on error. The resulting patch is 13/44.

      - 'struct apply_state' is now moved to apply.h at the beginning
        of this series.

      - Some useless braces were removed and the commit message was
        fixed in patch 05/44.

      - error_errno() is now used instead of error() in patch 03/44.

  - Patches 34/44 to 43/44 were new in v2.

They implement a way to make the libified apply silent. It is a new
feature in the libified apply functionality.

This could be in a separate series, but unfortunately using the
libified apply in "git am" unmasks the fact that "git am", since it
was a shell script, has been silencing the apply functionality by
redirecting file descriptors to /dev/null and it looks like this is
not acceptable in C.

I am not yet sure that "be_silent" is a good name for the new
variable added by these patches.

Path 43/44 that adds --silent to `git apply` should probably be
discarded. I plan to do it in the next version.

I had planned to perhaps add tests for this new feature, but if 43/44
is discarded it may not be needed anymore.

  - Patch 44/44 is new.

It replaces some calls to error() with calls to error_errno().

General comments
~~~~~~~~~~~~~~~~

Sorry if this patch series is still long. I can split it into two or
more series if it is prefered.

I can also send diffs between this version and the previous one, but
for now I'd rather not send them in this email, as it would make it
very long.

The benefits are not just related to not creating new processes. When
`git am` launched a `git apply` process, this new process had to read
the index from disk. Then after the `git apply`process had terminated,
`git am` dropped its index and read the index from disk to get the
index that had been modified by the `git apply`process. This was
inefficient and also prevented the split-index mechanism to provide
many performance benefits.

Using this series as rebase material, Duy explains it like this:

 > Without the series, the picture is not so surprising. We run git-app=
ly
 > 80+ times, each consists of this sequence
 >
 > read index
 > write index (cache tree updates only)
 > read index again
 > optionally initialize name hash (when new entries are added, I guess=
)
 > read packed-refs
 > write index
 >
 > With this series, we run a single git-apply which does
 >
 > read index (and sharedindex too if in split-index mode)
 > initialize name hash
 > write index 80+ times

(See: http://thread.gmane.org/gmane.comp.version-control.git/292324/foc=
us=3D292460)

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/libify-apply-use-in-am65

The previous versions are available there:

v1: https://github.com/chriscool/git/commits/libify-apply-use-in-am25=20
v2: https://github.com/chriscool/git/commits/libify-apply-use-in-am54

Performance numbers
~~~~~~~~~~~~~~~~~~~

Only tests on Linux have been performed using a very early version of
this series. It could be interesting to test on other platforms
especially Windows and perhaps OSX too.

  - Around mid April =C3=86var did a huge many-hundred commit rebase on=
 the
    kernel with untracked cache.

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

=C3=86var used his Debian laptop with SSD.

  - Around mid April I tested rebasing 13 commits in Booking.com's
    monorepo on a Red Hat 6.5 server with split-index and
    GIT_TRACE_PERFORMANCE=3D1.

With Git v2.8.0, the rebase took 6.375888383 s, with the git am
command launched by the rebase command taking 3.705677431 s.

With this series on top of next, the rebase took 3.044529494 s, with
the git am command launched by the rebase command taking 0.583521168
s.

Christian Couder (44):
  apply: move 'struct apply_state' to apply.h
  builtin/apply: make apply_patch() return -1 instead of die()ing
  builtin/apply: read_patch_file() return -1 instead of die()ing
  builtin/apply: make find_header() return -1 instead of die()ing
  builtin/apply: make parse_chunk() return a negative integer on error
  builtin/apply: make parse_single_patch() return -1 on error
  builtin/apply: make parse_whitespace_option() return -1 instead of
    die()ing
  builtin/apply: make parse_ignorewhitespace_option() return -1 instead
    of die()ing
  builtin/apply: move init_apply_state() to apply.c
  apply: make init_apply_state() return -1 instead of exit()ing
  builtin/apply: make check_apply_state() return -1 instead of die()ing
  builtin/apply: move check_apply_state() to apply.c
  builtin/apply: make apply_all_patches() return -1 on error
  builtin/apply: make parse_traditional_patch() return -1 on error
  builtin/apply: make gitdiff_*() return 1 at end of header
  builtin/apply: make gitdiff_*() return -1 on error
  builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
  builtin/apply: make build_fake_ancestor() return -1 on error
  builtin/apply: make remove_file() return -1 on error
  builtin/apply: make add_conflicted_stages_file() return -1 on error
  builtin/apply: make add_index_file() return -1 on error
  builtin/apply: make create_file() return -1 on error
  builtin/apply: make write_out_one_result() return -1 on error
  builtin/apply: make write_out_results() return -1 on error
  builtin/apply: make try_create_file() return -1 on error
  builtin/apply: make create_one_file() return -1 on error
  builtin/apply: rename option parsing functions
  apply: rename and move opt constants to apply.h
  Move libified code from builtin/apply.c to apply.{c,h}
  apply: make some parsing functions static again
  run-command: make dup_devnull() non static
  environment: add set_index_file()
  builtin/am: use apply api in run_apply()
  write_or_die: use warning() instead of fprintf(stderr, ...)
  apply: add 'be_silent' variable to 'struct apply_state'
  apply: make 'be_silent' incompatible with 'apply_verbosely'
  apply: don't print on stdout when be_silent is set
  usage: add set_warn_routine()
  usage: add get_error_routine() and get_warn_routine()
  apply: change error_routine when be_silent is set
  am: use be_silent in 'struct apply_state' to shut up applying patches
  run-command: make dup_devnull() static again
  builtin/apply: add a cli option for be_silent
  apply: use error_errno() where possible

 Makefile               |    1 +
 apply.c                | 4868 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 apply.h                |  133 ++
 builtin/am.c           |   91 +-
 builtin/apply.c        | 4815 +---------------------------------------=
-------
 cache.h                |    1 +
 environment.c          |   10 +
 git-compat-util.h      |    3 +
 run-command.c          |    2 +-
 t/t4012-diff-binary.sh |    4 +-
 t/t4254-am-corrupt.sh  |    2 +-
 usage.c                |   15 +
 write_or_die.c         |    6 +-
 13 files changed, 5132 insertions(+), 4819 deletions(-)
 create mode 100644 apply.c
 create mode 100644 apply.h

--=20
2.9.0.rc2.362.g3cd93d0
