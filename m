From: worley@alum.mit.edu (Dale R. Worley)
Subject: [PATCHv2] git-submodule.txt:  Clarify 'init' and 'add' subcommands.
Date: Wed, 15 May 2013 18:28:39 -0400
Message-ID: <201305152246.r4FMkVW5005582@freeze.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 00:46:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UckT0-0001Sx-5v
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 00:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab3EOWqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 18:46:34 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:39758
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752327Ab3EOWqd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 May 2013 18:46:33 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id cDHV1l00727AodY5CNmYPH; Wed, 15 May 2013 22:46:32 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id cNmY1l0081KKtkw3fNmYQJ; Wed, 15 May 2013 22:46:32 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r4FMkVCo005583;
	Wed, 15 May 2013 18:46:31 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r4FMkVW5005582;
	Wed, 15 May 2013 18:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1368657992;
	bh=VkQ3XH4aw93FRYkyIn7AfRgYrq7mz7gKhl6wvVEWbd0=;
	h=Received:Received:Received:Received:Message-Id:From:Date:Subject:
	 To;
	b=Bq0WTaMOtg1yAyVo7j3nS5Y/EbCvKcslMwQvHSF3PNBWWScpZVXpDgvy4sUFo50k6
	 8KBUA7spzotL7QB4ucog2XzsfuZOFZqPoc03HrFgMzkZVFAKEsGamXpoEpEQcQ6omN
	 w1YfVWu14CYrY/887AMwojHPjbdQwX8jpjHzEQzePULToOPR4HCBY+swW1jRTFN6BS
	 0MRqy7BaAyzNZyswTMO4aEMMnvqfJmTS/gu52VtGeg09T5VdIdM78no4T3bmTy9INV
	 bmlsRS2MEgxn5MBJAX0fjWaGhllvVYGZK9QQqFOVxq8KcBKXZmdYv7y1Dltnde+iGt
	 sJF/6zd+n3u/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224452>

Describe how 'add' sets the submodule's logical name, which is used in
the configuration entry names.

Clarify that 'init' only sets up the configuration entries for
submodules that have already been added elsewhere.  Describe that
<path> arguments limit the submodules that are configured.

Signed-off-by: Dale Worley <worley@ariadne.com>
---
This patch seems to have all the features that we have discussed:

- Describes how 'add' selects the submodule logical name, including
  the effect of --name.  (My first patch was on a version of Git that
  did not support --name, so I didn't know of it.)

- Corrects description of 'init' to clarify that its behavior is
  driven by the gitlinks recorded in the index, rather than implying
  it is driven by the contents of .gitmodules.

- Describes 'init' behavior to be driven by the index, rather than my
  previous incorrect use of "file tree".  (Of course, gitlinks aren't
  visible in the file tree.)

- Updated text for 'init' is shorter and less technical than my
  previous patch.

- Since "(which were added and committed elsewhere)" is stated in the
  first sentence, I've removed the later sentence explaining that
  submodules must be added before they can be inited.

- Explains the effect of <path> arguments to 'init' subcommand.

 Documentation/git-submodule.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index c99d795..83235c0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -76,6 +76,8 @@ argument <path> is the relative location for the cloned submodule
 to exist in the superproject. If <path> is not given, the
 "humanish" part of the source repository is used ("repo" for
 "/path/to/repo.git" and "foo" for "host.xz:foo/.git").
+The <path> is also used as the submodule's logical name in its
+configuration entries unless `--name` is used to specify a logical name.
 +
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
@@ -123,8 +125,10 @@ linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
 too (and can also report changes to a submodule's work tree).
 
 init::
-	Initialize the submodules, i.e. register each submodule name
-	and url found in .gitmodules into .git/config.
+	Initialize the submodules recorded in the index (which were
+	added and committed elsewhere) by copying submodule
+	names and urls from .gitmodules to .git/config.
+	Optional <path> arguments limit which submodules will be initialized.
 	It will also copy the value of `submodule.$name.update` into
 	.git/config.
 	The key used in .git/config is `submodule.$name.url`.
-- 
1.7.7.6
