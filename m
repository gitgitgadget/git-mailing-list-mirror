From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Finishing touches to "name-rev" fix
Date: Thu, 18 Jul 2013 15:16:06 -0700
Message-ID: <1374185768-7537-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 00:16:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzwUw-0007oS-5b
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 00:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932961Ab3GRWQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 18:16:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759460Ab3GRWQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 18:16:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD18322CC
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=I35E5debXXspfAYAKyVIvQVtxNk
	=; b=ItMyUmlBZyEx+ET1mT+MrGiNX1tXLtNU8CLgpytXUxbrL+mtwt4K8MNo+kf
	frsDrH93WTKQkLX6wn2w3Ep7zRpq+qPhoOe6xgS9gmkgVPJhLjY3+Cs3Mh/OWW/I
	z7/gSkNuXbZBfRC9GghbOakPtXWW8VJsYpWCQT/RHJPrgpBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=lSOk4bDOeec2zCTeWD+D1FX7Y0lIW
	ONRKgpBR72pSet2nJKYL+9dOPoStu6liWJvs2JD2810kvACa9+Gswzd6os39Xc7G
	oEOX712Gc3vLTv/VeY9R9KXh6X8wVK25ggUuwhQDAtQDDSC+d38L0qksNK+5UHDT
	y294Z7H5h9ThZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF8A322CB
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 590EC322CA
	for <git@vger.kernel.org>; Thu, 18 Jul 2013 22:16:10 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-992-gf0e5e44
X-Pobox-Relay-ID: A67D877E-EFF7-11E2-8DD8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230759>

This is an update to finish the jc/name-rev-exact-ref topic, which
fixed the command to convert an object name that points at a tag to
a refname of the tag (earlier, it did not show anything).  The
codepath to handle its command line arguments, however, fed the
commit that the tag points at to the underlying naming machinery.

The first patch in this follow-up series corrects it for the command
line codepath.

The second patch is a related fix for "git describe".  The command
is about naming the given commit in relation to a tag in its
neighbourhood, and while it does allow the input to be a commit-ish
(e.g. a tag that points at a commit), it did not unwrap it down to
commit, which is a bug (it is like "git commit-tree -p $tag" that
would mistakenly record a tag object as one of the parents of the
resulting commit).

Junio C Hamano (2):
  name-rev: differentiate between tags and commits they point at
  describe: fix --contains when a tag is given as input

 builtin/describe.c  |  3 ++-
 builtin/name-rev.c  | 41 ++++++++++++++++++++++++++++++++---------
 t/t6120-describe.sh | 24 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 10 deletions(-)

-- 
1.8.3.3-992-gf0e5e44
