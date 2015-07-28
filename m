From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.7
Date: Tue, 28 Jul 2015 10:11:25 -0700
Message-ID: <xmqqd1zcfbr6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jul 28 19:11:43 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1ZK8Pj-0002ek-BC
	for glk-linux-kernel-3@plane.gmane.org; Tue, 28 Jul 2015 19:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbbG1RL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 28 Jul 2015 13:11:29 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35929 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbG1RL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jul 2015 13:11:28 -0400
Received: by pachj5 with SMTP id hj5so72729555pac.3;
        Tue, 28 Jul 2015 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=s452kK2ZG3wYXGgN2slJrE7VDbHoMddl6Xk7llrSaWc=;
        b=vfX/aTsJv1dHsSjLGed+ogHOyyH1yhEQM6d8V6zt4CtrHpXV92c8y4eVqn8815tYLZ
         TIVNkv4eG2uqxEU/E/EuYDRnBzRPRd47l1soqa+0KTtcoqHAmSUZ9w/jId0MhvjayJqx
         33OFOK5nW0FDyo6KmB+wlZ5dQLddc5XUYZTDleMU/NRb7kObw2rgWuoPb8/PeihIR50V
         2MTfPMnyUOdpLfrDt6QB7ELpXR8mX7e4wHthOYNd9vQEZRjXMZWhSuqmgc6uO+ZuMdeD
         D1UnXI7phJmHdi1/PggbahD99opxQfGtNqXAo8FxZRGGd985Uu1QojKCBE0ssibjx15c
         ICOA==
X-Received: by 10.66.146.100 with SMTP id tb4mr83415526pab.70.1438103487628;
        Tue, 28 Jul 2015 10:11:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id cz1sm36209457pdb.44.2015.07.28.10.11.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 10:11:26 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274793>

The latest maintenance release Git v2.4.7 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.4.7'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.4.7 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.4.6
------------------

 * A minor regression to "git fsck" in v2.2 era was fixed; it
   complained about a body-less tag object when it lacked a
   separator empty line after its header to separate it with a
   non-existent body.

 * We used to ask libCURL to use the most secure authentication method
   available when talking to an HTTP proxy only when we were told to
   talk to one via configuration variables.  We now ask libCURL to
   always use the most secure authentication method, because the user
   can tell libCURL to use an HTTP proxy via an environment variable
   without using configuration variables.

 * When you say "!<ENTER>" while running say "git log", you'd confuse
   yourself in the resulting shell, that may look as if you took
   control back to the original shell you spawned "git log" from but
   that isn't what is happening.  To that new shell, we leaked
   GIT_PAGER_IN_USE environment variable that was meant as a local
   communication between the original "Git" and subprocesses that was
   spawned by it after we launched the pager, which caused many
   "interesting" things to happen, e.g. "git diff | cat" still paints
   its output in color by default.

   Stop leaking that environment variable to the pager's half of the
   fork; we only need it on "Git" side when we spawn the pager.

 * Avoid possible ssize_t to int truncation.

 * "git config" failed to update the configuration file when the
   underlying filesystem is incapable of renaming a file that is still
   open.

 * A minor bugfix when pack bitmap is used with "rev-list --count".

 * An ancient test framework enhancement to allow color was not
   entirely correct; this makes it work even when tput needs to read
   from the ~/.terminfo under the user's real HOME directory.

 * Fix a small bug in our use of umask() return value.

 * "git rebase" did not exit with failure when format-patch it invoked
   failed for whatever reason.

 * Disable "have we lost a race with competing repack?" check while
   receiving a huge object transfer that runs index-pack.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.4.6 are as follows:

Clemens Buchacher (1):
      rebase: return non-zero error code if format-patch fails

Enrique Tobis (1):
      http: always use any proxy auth method available

Jeff King (4):
      index-pack: avoid excessive re-reading of pack directory
      docs: clarify that --encoding can produce invalid sequences
      rev-list: disable --use-bitmap-index when pruning commits
      check_and_freshen_file: fix reversed success-check

Junio C Hamano (3):
      fsck: it is OK for a tag and a commit to lack the body
      pager: do not leak "GIT_PAGER_IN_USE" to the pager
      Git 2.4.7

Karsten Blees (1):
      config.c: fix writing config files on Windows network shares

Lawrence Siebert (1):
      rev-list: add --count to usage guide

Matthieu Moy (2):
      Documentation/branch: document -d --force and -m --force
      Documentation/branch: document -M and -D in terms of --force

Michael Haggerty (1):
      strbuf: strbuf_read_file() should return ssize_t

Richard Hansen (2):
      Revert "test-lib.sh: do tests for color support after changing HO=
ME"
      test-lib.sh: fix color support when tput needs ~/.terminfo

Torsten B=C3=B6gershausen (1):
      git-checkout.txt: document "git checkout <pathspec>" better
