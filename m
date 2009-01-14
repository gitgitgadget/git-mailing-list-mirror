From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 0/3] fix "git add" pattern matching
Date: Wed, 14 Jan 2009 15:54:33 +0100
Message-ID: <1231944876-29930-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, johannes@familieschneider.info
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 15:56:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN79w-0004vJ-0K
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbZANOyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 09:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbZANOy3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:54:29 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:43210 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbZANOy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 09:54:28 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 15:54:22 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LN78e-0007o5-Q3; Wed, 14 Jan 2009 15:54:36 +0100
X-Mailer: git-send-email 1.6.1
X-OriginalArrivalTime: 14 Jan 2009 14:54:23.0373 (UTC) FILETIME=[FCE2E3D0:01C97657]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105638>

Hi,

Johannes Schneider reported that "git add '*'" did not add matching files.
And indeed pattern matching for tracked files is broken since 1.6.1. I've
never used this feature myself, but I can imagine it's useful in some
situations. For example, you can do "git add '*.c'" to add all .c files. The
equivalent command without pattern matching would be
"find .  -name '*.c' | xargs git add".

[PATCH 1/3] clean up pathspec matching
[PATCH 2/3] remove pathspec_match, use match_pathspec instead
[PATCH 3/3] implement pattern matching in ce_path_match

This patch series fixes pattern matching for "git add". The first two
patches are cleanups only. PATCH 3/3 then implements pattern matching in
ce_path_match. It is very intrusive in the sense that all commands using
ce_path_match will now have pattern matching. I suppose this is good in
general, but can also have undesired side-effects, as in "git log --follow
'*'", for example. I'd appreciate some double-checking in that context.

Cheers,
Clemens
