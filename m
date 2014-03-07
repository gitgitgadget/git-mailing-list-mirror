From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] tag: grok "--with" as synonym to "--contains"
Date: Fri, 07 Mar 2014 12:07:35 -0800
Message-ID: <xmqqr46du60n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 21:07:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM13Z-0001kv-Bl
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 21:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbaCGUHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 15:07:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbaCGUHk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 15:07:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47A81715BC;
	Fri,  7 Mar 2014 15:07:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
	X/cpbiljwdgm70Jngztfr/iejc=; b=h5b9n4rO7fRSjxF8mSIs+XTwtGfBmdwKP
	JyAi4N+j1Yyh6zvNtsTBCNywSuynz3HlLdLvbc3d0hdkCXNzdukUv6nZL6JUVRRu
	QoG1ds6kswOvX7/YSlXvYfbyHEl+FClphbgxjsK9rCe5dYQou467oU7p9FfqpvKU
	mpde/OMkoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=OsI
	z0Rkdw3AYSqfQUf/oxKDD0mEHy4rz+M1ogEaTE/hlMoA9BhTqFpyHY1+UxGyX5rX
	FW/AJI5IqoCIu0ztwicBJtbuNeDVhL4QuKPx6KOMmksNSLRtjyomGPUNPLRm+jP3
	qzLHHD7oY3q59Ap4oy5I0cUuBAGmotdpY0ewAH9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D562715B3;
	Fri,  7 Mar 2014 15:07:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C8EB715B2;
	Fri,  7 Mar 2014 15:07:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 219FDEC8-A634-11E3-B524-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243627>

Just like "git branch" can be told to list the branches that has the
named commit by "git branch --with <commit>", teach the same
short-hand to "git tag", so that "git tag --with <commit>" shows the
releases with the named commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * After umpteenth time I got an optparse error I finally decided
   that this may be worth consideration.

   Just like "git branch", the synonym is not advertised in the
   documentation nor "git cmd -h" output.  We _might_ want to expose
   both at the same time, but that is not in the scope of this patch.

 builtin/tag.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/tag.c b/builtin/tag.c
index af3af3f..cb7bb2b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -471,6 +471,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
 		{
+			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
+			N_("print only tags that contain the commit"),
+			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_with_commit, (intptr_t)"HEAD",
+		},
+		{
 			OPTION_CALLBACK, 0, "points-at", NULL, N_("object"),
 			N_("print only tags of the object"), 0, parse_opt_points_at
 		},
