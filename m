From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 00/49] libify apply and use lib in am, part 1
Date: Tue, 24 May 2016 10:10:37 +0200
Message-ID: <20160524081126.16973-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:12:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Rc-0000fN-1U
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcEXILz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 04:11:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32883 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbcEXILs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so3637058wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5L4aa6XfOuwwahpvAwaQuYoVSj5bgCBccdNB4GwPPrM=;
        b=Kvh3M3Dgr+NpmxRs7CpRvzXmIXvBEEJgFuqji3h6HSCXbru+zxvUws9fSf4oWidcKg
         CTNnK2ooseeyYDeVeYUbjkzp7UB2G7qvSDX0MpxsOlCE3Uqf9jGbTLMQdcNqrrGR5h4x
         vFozd71HXfZEGImneJOS3SyfXszEaSMH0o34VTUh8YhOlIP54Pqg0zvQf5Hs8tlgJxwc
         O33dcRWugB64xD37/4UTxQTmr5Hk9z1DO8oe+Owxk+YMP+t2opdIWSdzSZeRO5Yx/rwJ
         UPRO4y+Wqpc7P9fkyv7FJHZF2jD6SnzeOcJ29lA1D/dO0fQ8DrN/lpaALMIqW2KZNaSP
         f9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5L4aa6XfOuwwahpvAwaQuYoVSj5bgCBccdNB4GwPPrM=;
        b=UqgWNeWU3/WWFQeCWTI/Mxt5pVQrEqX87nr9xUk24XyKFITz7eAOackR/vN7Te0AA8
         vjaik4ermoCD++r7XZ1suNKfRhcWvQ8CQsKplfNOldA2WbyiM6iDdrDZfhdoBBz0+ieg
         4rGRwP8avNGBZYhBOrsoeQlgKxqUTeVNHsLp5tu8NyceJp+cooZRqvQQe65fdk8AkQGC
         HIcUPXg4FaN7OfI5pc6t4PVJI6GpCkRK9tlaVjs4O/Gx7e2m4W37ZNYTEyi5Rra/LdQW
         aj88wYvctK8SMbaFD/GAQcEM1VeqkNixR83rQFoNDgVrZT9wDeEzDwFqwgpheW26w8bU
         oa4Q==
X-Gm-Message-State: AOPr4FVelh4eSctBghUq3tM6mXal/XkAt9JQwecf2WlZnna5BROtXGgASXNtmmAPWGCwlQ==
X-Received: by 10.28.153.80 with SMTP id b77mr21572826wme.71.1464077505827;
        Tue, 24 May 2016 01:11:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:44 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295429>

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

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This new patch series is built on top of the above previous work.

It contains only patches 01/94 to 50/94 from v2, as v2 contains too
many patches and it was decided to split it.

The changes since v2 are the following:

    - Patch 48/94 (builtin/apply: rename 'prefix_' parameter to
      'prefix') was squashed into 09/94 (builtin/apply: move 'state'
      init into init_apply_state()), as suggested by Junio.

    - Fields in 'struct apply_state' have been reorganized, as
      suggested by Junio.

    - clear_apply_state() has been added to free 'struct apply_state'
      resources.

General comments
~~~~~~~~~~~~~~~~

Sorry if this patch series is still long despite being splitted.

I will send a diff between this version and the 50 first patches of v2
soon as a reply to this email.

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

v3: https://github.com/chriscool/git/commits/libify-apply61
v2: https://github.com/chriscool/git/commits/libify-apply-use-in-am54
v1: https://github.com/chriscool/git/commits/libify-apply-use-in-am25=20

Performance numbers
~~~~~~~~~~~~~~~~~~~

=46or now only tests on Linux have been performed on v1 around mid
April. It could be interesting to test on other platforms especially
Windows and perhaps OSX too.

  - =C3=86var did a huge many-hundred commit rebase on the kernel with
    untracked cache.

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

=C3=86var used his Debian laptop with SSD.

  - I tested rebasing 13 commits in Booking.com's monorepo on a Red
    Hat 6.5 server with split-index and GIT_TRACE_PERFORMANCE=3D1.

With Git v2.8.0, the rebase took 6.375888383 s, with the git am
command launched by the rebase command taking 3.705677431 s.

With this series on top of next, the rebase took 3.044529494 s, with
the git am command launched by the rebase command taking 0.583521168
s.


Christian Couder (49):
  builtin/apply: make gitdiff_verify_name() return void
  builtin/apply: avoid parameter shadowing 'p_value' global
  builtin/apply: avoid parameter shadowing 'linenr' global
  builtin/apply: avoid local variable shadowing 'len' parameter
  builtin/apply: extract line_by_line_fuzzy_match() from
    match_fragment()
  builtin/apply: move 'options' variable into cmd_apply()
  builtin/apply: move 'read_stdin' global into cmd_apply()
  builtin/apply: introduce 'struct apply_state' to start libifying
  builtin/apply: move 'state' init into init_apply_state()
  builtin/apply: move 'unidiff_zero' global into 'struct apply_state'
  builtin/apply: move 'check' global into 'struct apply_state'
  builtin/apply: move 'check_index' global into 'struct apply_state'
  builtin/apply: move 'apply_in_reverse' global into 'struct
    apply_state'
  builtin/apply: move 'apply_with_reject' global into 'struct
    apply_state'
  builtin/apply: move 'apply_verbosely' global into 'struct apply_state=
'
  builtin/apply: move 'update_index' global into 'struct apply_state'
  builtin/apply: move 'allow_overlap' global into 'struct apply_state'
  builtin/apply: move 'cached' global into 'struct apply_state'
  builtin/apply: move 'diffstat' global into 'struct apply_state'
  builtin/apply: move 'numstat' global into 'struct apply_state'
  builtin/apply: move 'summary' global into 'struct apply_state'
  builtin/apply: move 'threeway' global into 'struct apply_state'
  builtin/apply: move 'no_add' global into 'struct apply_state'
  builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
  builtin/apply: move 'line_termination' global into 'struct
    apply_state'
  builtin/apply: move 'fake_ancestor' global into 'struct apply_state'
  builtin/apply: move 'p_context' global into 'struct apply_state'
  builtin/apply: move 'apply' global into 'struct apply_state'
  builtin/apply: move 'patch_input_file' global into 'struct
    apply_state'
  builtin/apply: move 'limit_by_name' global into 'struct apply_state'
  builtin/apply: move 'has_include' global into 'struct apply_state'
  builtin/apply: move 'p_value' global into 'struct apply_state'
  builtin/apply: move 'p_value_known' global into 'struct apply_state'
  builtin/apply: move 'root' global into 'struct apply_state'
  builtin/apply: move 'whitespace_error' global into 'struct
    apply_state'
  builtin/apply: move 'whitespace_option' into 'struct apply_state'
  builtin/apply: remove whitespace_option arg from
    set_default_whitespace_mode()
  builtin/apply: move 'squelch_whitespace_errors' into 'struct
    apply_state'
  builtin/apply: move 'applied_after_fixing_ws' into 'struct
    apply_state'
  builtin/apply: move 'ws_error_action' into 'struct apply_state'
  builtin/apply: move 'ws_ignore_action' into 'struct apply_state'
  builtin/apply: move 'max_change' and 'max_len' into 'struct
    apply_state'
  builtin/apply: move 'state_linenr' global into 'struct apply_state'
  builtin/apply: move 'fn_table' global into 'struct apply_state'
  builtin/apply: move 'symlink_changes' global into 'struct apply_state=
'
  builtin/apply: move 'state' check into check_apply_state()
  builtin/apply: move applying patches into apply_all_patches()
  builtin/apply: move 'lock_file' global into 'struct apply_state'
  builtin/apply: move 'newfd' global into 'struct apply_state'

 builtin/apply.c | 1432 +++++++++++++++++++++++++++++++----------------=
--------
 1 file changed, 821 insertions(+), 611 deletions(-)

--=20
2.8.3.443.gaeee61e
