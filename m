From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Clarified how "git submodule add" handles relative paths.
Date: Wed,  1 Jun 2011 11:56:32 -0400
Message-ID: <1306943792-1825-1-git-send-email-marcnarc@xiplink.com>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 17:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRnmr-000872-Om
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 17:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab1FAP4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 11:56:45 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:47456 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757136Ab1FAP4o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 11:56:44 -0400
Received: from rincewind.xiplink.com ([192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p51Fugnc022969;
	Wed, 1 Jun 2011 11:56:43 -0400
X-Mailer: git-send-email 1.7.5.3.1.ge85f0
In-Reply-To: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174871>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-submodule.txt |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

On 11-05-31 07:23 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> Back when Junio accepted the original patch, he said "If you maintain and
>> serve a set related projects you need to give the users a single URL (per
>> where the user is and how to reach the server)."
> 
> I think it was phrased badly. At least it should have s/need/only need/;
> 
> Imagine ta project has many components, all of which are kept as
> submodules of a single top-level superproject. You wrote and manage
> everything; there is no borrowed code. In that context, imagine that I am
> talking to the maintainer of that set of projects and calling the person
> "you".
> 
> By giving the URL for the top-level superproject, without having to give
> any other URL for the subprojects, you can let your users fetch from you,
> as everything underneath is relative. Another convenience this may give
> you and your users is when the user needs to talk to you over different
> transport. You may give "git://your.site/project.git" to the users, but
> they may come to "http://your.site/project.git".
> 
> By recording submodule.<path>.url as relative to where your users happen
> to have fetched your project in the superproject's .gitmodules file, your
> users do not have to run around fixing URLs for 47 different component
> submodules.
> 
> At least I think that is what I meant back then.

I see -- I was confused by the phrase "give ... a single URL" (since the
URLs are already in the .gitmodules file, how is there ever any need to
give more than one URL?).

So this is really about saving the users the hassle of modifying all the
URLs in the .gitmodules file.  Does this patch document what you mean?

		M.


diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1a16ff6..54dfebb 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -77,8 +77,17 @@ to exist in the superproject. If <path> is not given, the
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
-or ../), the location relative to the superproject's origin
-repository.
+or ../) a URL relative to one of the superproject's remote
+repostories:  If the superprojet's currently checked-out branch tracks
+a remote branch then that remote's URL is used, otherwise the "origin"
+remote's URL is used.  Relative URLs allow users to easily clone the
+superproject and its submodules using a different URL than what the
+superproject's maintainer might use (e.g. the maintainer can use ssh://
+URLs while the users might use git:// URLs).  With relative URLs in the
+.gitmodules file, the users won't have to edit all the submodule URLs.
++
+*NOTE*: This means that you can *not* use a relative path to refer to a
+repository in your local filesystem.
 +
 <path> is the relative location for the cloned submodule to
 exist in the superproject. If <path> does not exist, then the
-- 
1.7.5.3.1.ge85f0
