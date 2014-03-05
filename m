From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Wed, 5 Mar 2014 14:28:38 -0500
Message-ID: <20140305192837.GA11304@sigill.intra.peff.net>
References: <20140304174806.GA11561@sigill.intra.peff.net>
 <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
 <20140305005649.GB11509@sigill.intra.peff.net>
 <xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
 <20140305185212.GA23907@sigill.intra.peff.net>
 <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:28:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHUj-00031x-0p
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704AbaCET2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:28:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:33599 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751967AbaCET2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:28:39 -0500
Received: (qmail 19506 invoked by uid 102); 5 Mar 2014 19:28:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 13:28:39 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 14:28:38 -0500
Content-Disposition: inline
In-Reply-To: <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243470>

On Wed, Mar 05, 2014 at 11:18:17AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Mar 05, 2014 at 10:49:24AM -0800, Junio C Hamano wrote:
> >
> >> ... the plan, at least in my mind, has always been exactly that: grafts
> >> were a nice little attempt but is broken---if you really wanted to
> >> muck with the history without rewriting (which is still discouraged,
> >> by the way), do not use "graft", but use "replace".
> >
> > I certainly had in the back of my mind that grafts were a lesser form of
> > "replace", and that eventually we could get rid of the former. Perhaps
> > my question should have been: "why haven't we deprecated grafts yet?".
> 
> Given that we discourage "grafts" strongly and "replace" less so
> (but still discourage it), telling the users that biting the bullet
> and rewriting the history is _the_ permanent solution, I think it is
> understandable why nobody has bothered to.

Perhaps the patch below would help discourage grafts more?

The notable place in the documentation where grafts are still used is
git-filter-branch.txt.  But since the example there is about cementing
rewritten history, it might be OK to leave.

I used "outdated" below. We could also up the ante to "deprecated".

-- >8 --
Subject: [PATCH] docs: mark info/grafts as outdated

We should be encouraging people to use git-replace instead.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitrepository-layout.txt | 4 ++++
 Documentation/glossary-content.txt     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index aa03882..17d2ea6 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -176,6 +176,10 @@ info/grafts::
 	per line describes a commit and its fake parents by
 	listing their 40-byte hexadecimal object names separated
 	by a space and terminated by a newline.
++
+Note that the grafts mechanism is outdated and can lead to problems
+transferring objects between repositories; see linkgit:git-replace[1]
+for a more flexible and robust system to do the same thing.
 
 info/exclude::
 	This file, by convention among Porcelains, stores the
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 378306f..be0858c 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -176,6 +176,10 @@ current branch integrates with) obviously do not work, as there is no
 	you can make Git pretend the set of <<def_parent,parents>> a <<def_commit,commit>> has
 	is different from what was recorded when the commit was
 	created. Configured via the `.git/info/grafts` file.
++
+Note that the grafts mechanism is outdated and can lead to problems
+transferring objects between repositories; see linkgit:git-replace[1]
+for a more flexible and robust system to do the same thing.
 
 [[def_hash]]hash::
 	In Git's context, synonym for <<def_object_name,object name>>.
-- 
1.8.5.2.500.g8060133
