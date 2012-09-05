From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH 0/2] Add --expand to 'git notes get-ref'
Date: Wed, 05 Sep 2012 08:48:13 -0400
Message-ID: <cover.1346848834.git.wking@tremily.us>
Cc: "W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 15:48:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9FyB-0001k3-AQ
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 15:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab2IENsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 09:48:32 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:41436 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab2IENsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 09:48:31 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 09:48:31 EDT
Received: from odin.tremily.us ([unknown] [72.68.111.221])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M9V00HRUNKFKW30@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 05 Sep 2012 07:48:16 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 9FAE65C2E9D; Wed,
 05 Sep 2012 08:48:14 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 05 Sep 2012 08:48:21 -0400
X-Mailer: git-send-email 1.7.12.176.g3fc0e4c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204828>

From: "W. Trevor King" <wking@tremily.us>

I was recently confused when

  $ git notes merge -v refs/remotes/origin/notes/commits

failed to do (or print) anything.  It turns out that note refs must
live under 'refs/notes/', so my command line ref was expanding to

  refs/notes/refs/remotes/origin/notes/commits

which wasn't matching anything.

The first of my commits here adds the '--expand' option, so you can
see how Git is expanding your ref internally:

  $ GIT_NOTES_REF=commits git notes get-ref --expand
  refs/notes/commits

The second commit makes the expansion less strict about the location
of note refs.  In his initial mail introducing 'git notes', Johan says
that note refs should live under 'refs/notes' [1].  This seems like a
good place for local notes, but note refs from remote repos should
probably live somewhere else (e.g. 'refs/remote-notes/' or
'refs/remotes/<name>/notes/'.  In the initial thread there are a few
messages talking about looking up reverse mappings under 'refs/notes/',
but this seems to all have been before the 'refs/notes/<namespace>/'
stage.  If I'm missing a good reason to keep everything under
'refs/notes/', feel free to ignore the second patch.

Cheers,
Trevor

[1]: http://permalink.gmane.org/gmane.comp.version-control.git/48540


W. Trevor King (2):
  notes get-ref: --expand expands the output notes ref.
  notes: don't alter refs starting with 'refs/' in expand_notes_ref

 Documentation/git-notes.txt |  6 +++++-
 builtin/notes.c             | 26 +++++++++++++++++++++-----
 notes.c                     |  2 +-
 t/t3301-notes.sh            | 12 ++++++++++++
 4 files changed, 39 insertions(+), 7 deletions(-)

-- 
1.7.12.176.g3fc0e4c.dirty
