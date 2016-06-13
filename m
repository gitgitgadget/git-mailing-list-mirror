From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 00/40] libify apply and use lib in am, part 2
Date: Mon, 13 Jun 2016 18:09:02 +0200
Message-ID: <20160613160942.1806-1-chriscool@tuxfamily.org>
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
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURB-0003KT-1y
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424705AbcFMQJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 12:09:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36714 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424288AbcFMQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:09:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so15996471wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON4X0Xmu1S6netD/+CfsPMk3deHJAOYu8C0J9Cs8K5I=;
        b=CKKVk8kyeZa6wDUsmIVhBf4i/KVY37QaYATxrV+xgDjAFpIhpLtIP/gGt+5c1zr/cK
         vO0pQk6iRkSVIw0sW0wvkk4mAVyLTomDMOhYokJVY5nzInrsixIgiUZAnbl6Q9mmYoZn
         tY61LsH51Ou47xBpfgiTzp/4zItKQizM3G3FETSSYvA9rTxdj7LWsbBCpUsNHifyAI97
         Fs/mrfSv1HIMNEuhjKDnDL4bBOrzLffJyoJj2Hl7onpuYSv3USgWhDHVSomiStJuRwVn
         xo10O7u96lBa97QTRKGDNaejrsfxLrZH5vvhgxBNcXvT++BJCF/31zXdOTC5rsvLO4Zy
         vFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ON4X0Xmu1S6netD/+CfsPMk3deHJAOYu8C0J9Cs8K5I=;
        b=kR75/Rlnc3QshTFigIYTH/WZgjG0jDDeeX+4z0ry/8v0wAujfV4VakHE01jyqKsy0J
         2JqenTBHHqmf9mJ3KTsuGARrrVB4MDguwIpTqM5jAeLDLe28UgGnsDJLNHm1gwmP9gvF
         Nfgppdjdy3EcB7fx3CR5REtXWMbpJfkOeOOXfeV4N7MqctvWY8Ymn2dYPAIPjXf9hXKH
         ADdxoTl5W9Kp0ntMIKDX1BmOTNlPUvmsQA59hCgtcysy5dB27X6/oXk6zUXArIaTdcv2
         UHQCc/HURfFY+WKWcdIlBjurstDoawfxx96EXloHB5tTOnSaAIKOwjmU7Tu4BEu7cbq+
         ZeTA==
X-Gm-Message-State: ALyK8tJR2dL5wjdLmqFT1cbCWES6JdcGYGHjPKLB3lbNMHrhafChYp6IspgtWEvdkukmjw==
X-Received: by 10.194.112.6 with SMTP id im6mr2188951wjb.48.1465834196603;
        Mon, 13 Jun 2016 09:09:56 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:09:55 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297193>

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
v6: http://thread.gmane.org/gmane.comp.version-control.git/297024/

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This new patch series is built on top of the above previous work.

More precisely, this is "part 2" of the full patch series which is
built on top of the "part 1" of the full patch series. And as the
"part 1" is now in "next", this "part 2" is built on top of "next".

  - Patches 01/40 to 31/40 were in v1, v2 and v6.

They finish libifying the apply functionality that was in
builtin/apply.c and move it into apply.{c,h}.

The libified functionality is not yet used in `git am` in those
patches, as the patch that does that (previously 33/44 and now 39/40)
has been been moved towards the end of the series (see below).

The only other change in those patches is that the patch that was
making dup_devnull() non static (previously 31/44) has been
removed. It was reverted anyway towards the end of v6.

  - Patches 32/40 to 38/40 were in v2 and v6.

They implement a way to make the libified apply silent by adding a new
'be_silent' flag into 'struct apply_state'. It is a new feature in the
libified apply functionality.

This could be in a separate series, but unfortunately using the
libified apply in "git am" unmasks the fact that "git am", since it
was a shell script, has been silencing the apply functionality by
redirecting file descriptors to /dev/null and it looks like this is
not acceptable in C.

The patch which reverted the patch that made dup_devnull() non static
has been removed too, as the patch it reverted has been removed.

The patch that made `git am` use the 'be_silent' new feature
(previously 41/44) has been squashed into a following patch (see
below).

The patch (previously 43/44) that added --silent to `git apply` has
been removed too as already planned in v6.=20

Other than that some commit messages have been improved.

  - Patch 39/40 was in v1, v2 and v6.

This patch (which was 33/44 in v6) makes `git am` use the libified
functionality. It has been been moved towards the end of the series
following many reviewers' suggestion to avoid temporarily using
dup_devnull() to silence the libified apply functionality.

The patch that made `git am` use the 'be_silent' new feature
(previously 41/44) has been squashed into this patch.

Also a call to clear_apply_state() has been added into this patch to
avoid memory leaks.

  - Patch 44/44 was new in v6.

It replaces some calls to error() with calls to error_errno().
One line has been changed to fix a warning.

General comments
~~~~~~~~~~~~~~~~

Sorry if this patch series is still long. I can split it into two or
more series if it is prefered.

I will send a diff between this version and the previous one, as a
reply to this email.

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

https://github.com/chriscool/git/commits/libify-apply-use-in-am

The previous versions are available there:

v1: https://github.com/chriscool/git/commits/libify-apply-use-in-am25=20
v2: https://github.com/chriscool/git/commits/libify-apply-use-in-am54
v6: https://github.com/chriscool/git/commits/libify-apply-use-in-am65

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

Christian Couder (40):
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
  environment: add set_index_file()
  write_or_die: use warning() instead of fprintf(stderr, ...)
  apply: add 'be_silent' variable to 'struct apply_state'
  apply: make 'be_silent' incompatible with 'apply_verbosely'
  apply: don't print on stdout when be_silent is set
  usage: add set_warn_routine()
  usage: add get_error_routine() and get_warn_routine()
  apply: change error_routine when be_silent is set
  builtin/am: use apply api in run_apply()
  apply: use error_errno() where possible

 Makefile               |    1 +
 apply.c                | 4868 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 apply.h                |  133 ++
 builtin/am.c           |   91 +-
 builtin/apply.c        | 4813 +---------------------------------------=
-------
 cache.h                |    1 +
 environment.c          |   10 +
 git-compat-util.h      |    3 +
 t/t4012-diff-binary.sh |    4 +-
 t/t4254-am-corrupt.sh  |    2 +-
 usage.c                |   15 +
 write_or_die.c         |    6 +-
 12 files changed, 5129 insertions(+), 4818 deletions(-)
 create mode 100644 apply.c
 create mode 100644 apply.h

--=20
2.9.0.rc2.411.g3e2ca28
