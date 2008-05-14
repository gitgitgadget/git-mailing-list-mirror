From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] Fix two pet peeves of mine
Date: Wed, 14 May 2008 18:46:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141844580.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 14 19:47:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwL44-0002Ae-Vb
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbYENRqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbYENRqE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:46:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:43466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751684AbYENRqC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:46:02 -0400
Received: (qmail invoked by alias); 14 May 2008 17:46:00 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp006) with SMTP; 14 May 2008 19:46:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q1P4cFy/qmOrwQYPDsp6eou4hbzvK3RsqC7ChFT
	N9VlEVEiv7C2Ke
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82117>


Both of these patches can be considered cleanups: path_list is finally
renamed to string_list (since it is not special to paths), and
providing git_config() with a callback parameter.

The latter change is only the beginning: existing callers are not fixed.

These cleanup patches are rather large, so I though it would be best to 
provide them just at the end of the merge window.

Johannes Schindelin (2):
  Rename path_list to string_list
  Provide git_config with a callback-data parameter

 Documentation/CodingGuidelines              |    5 +-
 Documentation/technical/api-path-list.txt   |    9 --
 Documentation/technical/api-string-list.txt |   10 ++
 Makefile                                    |    4 +-
 alias.c                                     |    5 +-
 archive-tar.c                               |    6 +-
 builtin-add.c                               |    6 +-
 builtin-apply.c                             |    6 +-
 builtin-blame.c                             |   10 +-
 builtin-branch.c                            |    6 +-
 builtin-cat-file.c                          |    2 +-
 builtin-checkout-index.c                    |    2 +-
 builtin-checkout.c                          |    2 +-
 builtin-clean.c                             |    6 +-
 builtin-clone.c                             |    2 +-
 builtin-commit-tree.c                       |    2 +-
 builtin-commit.c                            |   28 +++---
 builtin-config.c                            |   26 +++---
 builtin-diff-files.c                        |    2 +-
 builtin-diff-index.c                        |    2 +-
 builtin-diff-tree.c                         |    2 +-
 builtin-diff.c                              |    2 +-
 builtin-fast-export.c                       |   16 ++--
 builtin-fetch-pack.c                        |    6 +-
 builtin-fetch.c                             |   20 ++--
 builtin-fmt-merge-msg.c                     |    4 +-
 builtin-gc.c                                |    6 +-
 builtin-http-fetch.c                        |    2 +-
 builtin-init-db.c                           |    4 +-
 builtin-log.c                               |   18 ++--
 builtin-ls-files.c                          |    2 +-
 builtin-ls-tree.c                           |    2 +-
 builtin-mailinfo.c                          |    2 +-
 builtin-mailsplit.c                         |   12 +-
 builtin-merge-base.c                        |    2 +-
 builtin-merge-recursive.c                   |  102 ++++++++++----------
 builtin-mv.c                                |   43 ++++----
 builtin-name-rev.c                          |    2 +-
 builtin-pack-objects.c                      |    6 +-
 builtin-read-tree.c                         |    4 +-
 builtin-reflog.c                            |    6 +-
 builtin-remote.c                            |  131 +++++++++++++-------------
 builtin-rerere.c                            |   54 +++++-----
 builtin-reset.c                             |    2 +-
 builtin-rev-list.c                          |    2 +-
 builtin-rev-parse.c                         |    2 +-
 builtin-revert.c                            |    2 +-
 builtin-rm.c                                |    2 +-
 builtin-shortlog.c                          |   42 ++++----
 builtin-show-branch.c                       |    6 +-
 builtin-show-ref.c                          |   10 +-
 builtin-symbolic-ref.c                      |    2 +-
 builtin-tag.c                               |    6 +-
 builtin-unpack-objects.c                    |    2 +-
 builtin-update-index.c                      |    2 +-
 builtin-update-ref.c                        |    2 +-
 builtin-verify-pack.c                       |    2 +-
 builtin-verify-tag.c                        |    2 +-
 builtin-write-tree.c                        |    2 +-
 cache.h                                     |   10 +-
 color.c                                     |    4 +-
 color.h                                     |    2 +-
 config.c                                    |   27 +++---
 connect.c                                   |    7 +-
 convert.c                                   |    4 +-
 daemon.c                                    |    4 +-
 diff-lib.c                                  |   22 ++--
 diff.c                                      |    8 +-
 diff.h                                      |    4 +-
 fast-import.c                               |    6 +-
 hash-object.c                               |    2 +-
 help.c                                      |    6 +-
 http.c                                      |    6 +-
 imap-send.c                                 |    4 +-
 index-pack.c                                |    6 +-
 ll-merge.c                                  |    4 +-
 mailmap.c                                   |   12 +-
 mailmap.h                                   |    4 +-
 pager.c                                     |    2 +-
 path-list.c                                 |  134 --------------------------
 path-list.h                                 |   28 ------
 receive-pack.c                              |    6 +-
 reflog-walk.c                               |   10 +-
 remote.c                                    |    4 +-
 setup.c                                     |    4 +-
 shortlog.h                                  |    6 +-
 string-list.c                               |  138 +++++++++++++++++++++++++++
 string-list.h                               |   28 ++++++
 unpack-file.c                               |    2 +-
 var.c                                       |    8 +-
 wt-status.c                                 |    4 +-
 wt-status.h                                 |    2 +-
 92 files changed, 603 insertions(+), 592 deletions(-)
 delete mode 100644 Documentation/technical/api-path-list.txt
 create mode 100644 Documentation/technical/api-string-list.txt
 delete mode 100644 path-list.c
 delete mode 100644 path-list.h
 create mode 100644 string-list.c
 create mode 100644 string-list.h
