From: Adam Spiers <git@adamspiers.org>
Subject: =?UTF-8?q?=5BPATCH=20v2=2000/14=5D=20new=20git=20check-ignore=20sub-command?=
Date: Thu, 20 Sep 2012 20:46:09 +0100
Message-ID: <1348170383-15751-1-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:46:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmhz-0000NV-3b
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab2ITTq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 15:46:29 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46169 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab2ITTq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:27 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 7FB742E5D3;
	Thu, 20 Sep 2012 20:46:24 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206074>

This is a re-vamp of my original check-ignore series, which aims to
address all the feedback which was raised in the first round of
reviews.  The most notable changes are the CLI options and output
formats as suggested by Junio and Nguy=E1=BB=85n; now there are three l=
evels
of verbosity: --quiet, default, and --verbose.  -z also now affects
the output and so is now compatible with the --stdin optin.

Some commits have been broken into smaller pieces to facilitate easier
reviews, and based on an earlier discussion, three exclude functions
have been given an 'is_' prefix to clarify their boolean nature.  The
helper functions extracted from these three now have more meaningful
names rather than just a '_1' suffix.

Other minor issues, such as inconsistent coding style, have been
fixed, and the modification to the output text in add.c has been
scrapped.

It has been rebased on the latest master, and passed a full test run.

Adam Spiers (14):
  Update directory listing API doc to match code
  Improve documentation and comments regarding directory traversal API
  Rename cryptic 'which' variable to more consistent name
  Rename path_excluded() to is_path_excluded()
  Rename excluded_from_list() to is_excluded_from_list()
  Rename excluded() to is_excluded()
  Refactor is_excluded_from_list()
  Refactor is_excluded()
  Refactor is_path_excluded()
  For each exclude pattern, store information about where it came from
  Refactor treat_gitlinks()
  Extract some useful pathspec handling code from builtin/add.c into a
    library
  Provide free_directory() for reclaiming dir_struct memory
  Add git-check-ignore sub-command

 .gitignore                                        |   1 +
 Documentation/git-check-ignore.txt                |  85 ++++
 Documentation/gitignore.txt                       |   6 +-
 Documentation/technical/api-directory-listing.txt |  23 +-
 Makefile                                          |   3 +
 attr.c                                            |   2 +-
 builtin.h                                         |   1 +
 builtin/add.c                                     |  84 +---
 builtin/check-ignore.c                            | 167 ++++++
 builtin/clean.c                                   |   2 +-
 builtin/ls-files.c                                |   5 +-
 command-list.txt                                  |   1 +
 contrib/completion/git-completion.bash            |   1 +
 dir.c                                             | 191 +++++--
 dir.h                                             |  47 +-
 git.c                                             |   1 +
 pathspec.c                                        |  97 ++++
 pathspec.h                                        |   6 +
 t/t0007-ignores.sh                                | 587 ++++++++++++++=
++++++++
 t/t9902-completion.sh                             |  24 +-
 unpack-trees.c                                    |  10 +-
 21 files changed, 1182 insertions(+), 162 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h
 create mode 100755 t/t0007-ignores.sh

--=20
1.7.12.147.g6d168f4
