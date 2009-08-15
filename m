From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] git stat: honor relative paths setting
Date: Sat, 15 Aug 2009 15:39:52 -0700
Message-ID: <1250375997-10657-5-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
 <1250375997-10657-2-git-send-email-gitster@pobox.com>
 <1250375997-10657-3-git-send-email-gitster@pobox.com>
 <1250375997-10657-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRvb-0003is-SA
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbZHOWkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZHOWkJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZHOWkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:07 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CF7CC4F9
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE59BC4F8 for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:08 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 96203090-89EC-11DE-87A2-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126037>

When run from a subdirectory, by default (and when status.relativepaths is
set), we should pass it to wt_status_print_body()

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Fix-up to 3/9; will be squashed in the final round.

 builtin-commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 0ef7c8f..7120876 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -922,6 +922,8 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	wt_status_collect(&s);
 
+	if (s.relative_paths)
+		s.prefix = prefix;
 	if (s.use_color == -1)
 		s.use_color = git_use_color_default;
 	if (diff_use_color_default == -1)
-- 
1.6.4.224.g3be84
