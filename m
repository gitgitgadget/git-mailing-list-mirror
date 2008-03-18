From: Junio C Hamano <gitster@pobox.com>
Subject: Unresolved issues
Date: Mon, 17 Mar 2008 18:12:02 -0700
Message-ID: <7v7ig096ot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 02:13:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbQOd-0007zM-Vl
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 02:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbYCRBM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 21:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757562AbYCRBMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 21:12:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbYCRBMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 21:12:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7BEF21F4;
	Mon, 17 Mar 2008 21:12:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4F36821F3; Mon, 17 Mar 2008 21:12:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77476>

I tagged 1.5.5-rc0 Sunday night (my time, obviously).

Our contributors have been busy inventing new features and reinventing old
ones in C during the 1.5.5 cycle, and we have a fair number of known
breakages.  Here is a short list of issues I know (or I think I've heard)
about, that we would like to address (either "resolve", or "declare to
postpone") before the final release, but I am sure I missed some things.

Let's hope contributors are as responsive in fixing their own mess as they
are responsive in scratching their own itch, and we can resolve most of
them shortly.

* synopsys: use {} instead of () for grouping alternatives (Jari Aalto)
  $gmane/72243

  This was discussed during 1.5.4 pre-freeze timeframe but never
  materialized.

* "git remote" showing remotes/origin/HEAD as a candidate for pruning,
  and pruning it results in removal of what is pointed at by it.

  Pointers?  This may not be a regression but bug-to-bug compatibility
  with the older implementation, but this should better be fixed.

* fetch with "refs/*:refs/*" errors out erroneously
  $gmane/77335

  Breakage exposed by recent git allowing "mirror" layout with "git remote
  add --mirror".

* fetch with tag following uses smudged object database
  $gmane/74141

  Regression introduced by recent C-rewrite of git-fetch.

* "git fetch" does not exit with non-zero status when it failed to update
  some refs due to non-ffness
  $gmane/77178

  Regression introduced by recent C-rewrite of git-fetch.

* "git fetch" shows error when dangling symref exists at the remote
  but does not really error out
  $gmane/76658

  I am not sure what the right course of action is.  Maybe we should
  ignore dangling symrefs in upload-pack?

* D/F conflict to merge a tree with D into a tree with F
  $gmane/77352

  Needs more info.

* revision.c::limit_list() breakage
  $gmane/72324
  t/t6009

  When you run "git rev-list A..B C", and there is a commit in the chain
  between A and B whose timestamp is much older than its parent, sometimes
  we fail to mark C as reachable from A (hence not interesting) even when
  it actualy is.  This is very expensive to solve in general, and we are
  not going to introduce "generation number" field to the commit objects,
  so we may have to settle with a heuristic.

* "[alias] st = status" and "cd .git && git st" (Jeff King)
  $gmane/72327

  This shows everything as deleted, I believe it hasn't resolved.  I am
  not sure if this is worth resolving, though.
