From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 1/3] Testing: XDG config files: Export a suitable
                              `XDG_CONFIG_HOME' environment variable
Date: Tue, 17 Jul 2012 16:41:20 -0000
Message-ID: <679ad82bd4604d1c903f3c2fff2a8cfb-mfwitten@gmail.com>
References: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
Cc: Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:44:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrBoj-0008Cx-VK
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 19:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab2GQRoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 13:44:09 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:65070 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab2GQRoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 13:44:08 -0400
Received: by weyx8 with SMTP id x8so437368wey.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=8BxiQbXQoIw08xsgpfUGyNBcmEB/T2vOOpFWf/vtHlE=;
        b=dik4gQMoSE2i/je+L9jPib2IbOHnJoAAIygW+WLOlBpLau8vd3JB13ANb9G5ahBqQN
         tyjAOPIKtAn8TGHUoZ8inwyztlI8WDCuEAmU4UwQy5n/CXR4Av2b+ZvDpfv3aLbA6qAc
         3AifRutBnK1qYZyGpKcciqF6LXNfzons5hBLgz8JRCgNrtndMP+w2UUsrrVNFmz9nD/G
         Q432O8tB9m2/TwXuby1WMmt3zS4H0psCacfqRd/l0J3XMsDjhuLKzaqkaiJOeYdJRdGS
         b/5Nq0YFlA+5+JbiK9zHrOpr/WusRdIa+MADZ7XzrVT0h4sqBzRhxKhZuBlEeJRFEUCI
         6Wdw==
Received: by 10.216.29.81 with SMTP id h59mr1801919wea.41.1342547046725;
        Tue, 17 Jul 2012 10:44:06 -0700 (PDT)
Received: from gmail.com (saito.countshockula.com. [65.183.151.13])
        by mx.google.com with ESMTPS id k20sm28084899wiv.11.2012.07.17.10.44.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 10:44:06 -0700 (PDT)
In-Reply-To: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201610>

The tests in:

  t/t1306-xdg-files.sh

were failing because the git commands were using the environment
variable `XDG_CONFIG_HOME' as it was set for the user's usual
environment, rather than as set for the testing environment.

This commit provides the quickest, simplest hack to make things work;
because there is already the setting and exporting of the environment
variable `HOME' in:

  t/test-lib.sh

this commit simply adds to that file the setting and exporting of
the variable `XDG_CONFIG_HOME' (based on the variable `HOME' that is
provided there).

However, the existing tests [sometimes] don't use these variables
explicitly, so the whole structure of this testing rests on the
hope that people maintain the conventions captured by the values
of these variables; another commit should fix this instability
by using these variables explicitly.

(Note: Double quotes are not needed around the value assigned
to the variable, as word splitting is not performed).

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 t/test-lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index acda33d..69bcc75 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -544,6 +544,9 @@ rm -fr "$test" || {
 HOME="$TRASH_DIRECTORY"
 export HOME
 
+XDG_CONFIG_HOME=$HOME/.config
+export XDG_CONFIG_HOME
+
 if test -z "$TEST_NO_CREATE_REPO"; then
 	test_create_repo "$test"
 else
-- 
1.7.11.1.29.gf71be5c
