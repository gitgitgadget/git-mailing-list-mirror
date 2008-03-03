From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Header files not mentioned in the makefile
Date: Mon, 3 Mar 2008 08:24:24 +0100
Message-ID: <20080303072424.GA25623@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:25:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW52m-0002sQ-7s
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbYCCHY0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 02:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYCCHY0
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:24:26 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55110 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYCCHYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 02:24:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 429D96CF0079
	for <git@vger.kernel.org>; Mon,  3 Mar 2008 08:24:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PFRl+cJoln7F for <git@vger.kernel.org>;
	Mon,  3 Mar 2008 08:24:24 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2AFB56CF0078; Mon,  3 Mar 2008 08:24:24 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75900>

When I modified fetch-pack.h I was surprised by the fact, that it does
not result in rebuilding all object files. In fact, no file was
rebuilt. It turned out, that fetch-pack.h was not mentioned in the
Makefile.

A quick search (on next) showed, that other header files are also not
taking part in dependency checking:

$for a in `ls *.h`; do grep "$a" Makefile >/dev/null || (echo "missing:=
 $a"; grep "$a" *.c|grep include) ; done
missing: branch.h
  branch.c:#include "branch.h"
  builtin-branch.c:#include "branch.h"
  builtin-checkout.c:#include "branch.h"
  builtin-reset.c:#include "branch.h"
missing: bundle.h
  builtin-bundle.c:#include "bundle.h"
  bundle.c:#include "bundle.h"
  transport.c:#include "bundle.h"
missing: color.h
  builtin-branch.c:#include "color.h"
  builtin-commit.c:#include "color.h"
  builtin-config.c:#include "color.h"
  builtin-diff.c:#include "color.h"
  builtin-log.c:#include "color.h"
  color.c:#include "color.h"
  diff.c:#include "color.h"
  wt-status.c:#include "color.h"
missing: exec_cmd.h
  builtin-add.c:#include "exec_cmd.h"
  builtin-archive.c:#include "exec_cmd.h"
  builtin-cat-file.c:#include "exec_cmd.h"
  builtin-describe.c:#include "exec_cmd.h"
  builtin-fetch-pack.c:#include "exec_cmd.h"
  builtin-init-db.c:#include "exec_cmd.h"
  builtin-revert.c:#include "exec_cmd.h"
  config.c:#include "exec_cmd.h"
  daemon.c:#include "exec_cmd.h"
  exec_cmd.c:#include "exec_cmd.h"
  git.c:#include "exec_cmd.h"
  help.c:#include "exec_cmd.h"
  http-push.c:#include "exec_cmd.h"
  receive-pack.c:#include "exec_cmd.h"
  run-command.c:#include "exec_cmd.h"
  shell.c:#include "exec_cmd.h"
  upload-pack.c:#include "exec_cmd.h"
missing: fetch-pack.h
  builtin-fetch-pack.c:#include "fetch-pack.h"
  transport.c:#include "fetch-pack.h"
missing: interpolate.h
  builtin-merge-recursive.c:#include "interpolate.h"
  daemon.c:#include "interpolate.h"
  interpolate.c:#include "interpolate.h"
  ll-merge.c:#include "interpolate.h"
missing: merge-recursive.h
  builtin-checkout.c:#include "merge-recursive.h"
  builtin-merge-recursive.c:#include "merge-recursive.h"
missing: reachable.h
  builtin-prune.c:#include "reachable.h"
  builtin-reflog.c:#include "reachable.h"
  reachable.c:#include "reachable.h"
missing: send-pack.h
  builtin-send-pack.c:#include "send-pack.h"
  transport.c:#include "send-pack.h"
missing: shortlog.h
  builtin-log.c:#include "shortlog.h"
  builtin-shortlog.c:#include "shortlog.h"
missing: tar.h
  archive-tar.c:#include "tar.h"
  builtin-tar-tree.c:#include "tar.h"
missing: thread-utils.h
  builtin-pack-objects.c:#include "thread-utils.h"
missing: walker.h
  builtin-http-fetch.c:#include "walker.h"
  http-walker.c:#include "walker.h"
  transport.c:#include "walker.h"
  walker.c:#include "walker.h"
missing: xdiff-interface.h
  builtin-blame.c:#include "xdiff-interface.h"
  builtin-merge-file.c:#include "xdiff-interface.h"
  builtin-merge-recursive.c:#include "xdiff-interface.h"
  builtin-rerere.c:#include "xdiff-interface.h"
  combine-diff.c:#include "xdiff-interface.h"
  diff.c:#include "xdiff-interface.h"
  grep.c:#include "xdiff-interface.h"
  ll-merge.c:#include "xdiff-interface.h"
  merge-file.c:#include "xdiff-interface.h"
  merge-tree.c:#include "xdiff-interface.h"
  xdiff-interface.c:#include "xdiff-interface.h"

Adding this header files to LIB_H should fix the problem.

mfg Martin K=F6gler
