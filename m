From: "Konstantin V. Arkhipov" <voxus@onphp.org>
Subject: [PATCH] git-svn's dcommit must use subversion's config
Date: Wed, 14 Nov 2007 03:52:02 +0300
Organization: onPHP
Message-ID: <200711140352.02978.voxus@onphp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 02:17:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6sI-0005n7-89
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759812AbXKNBQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761965AbXKNBQ3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:16:29 -0500
Received: from [213.219.250.128] ([213.219.250.128]:55730 "EHLO shadanakar.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759812AbXKNBQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:16:28 -0500
X-Greylist: delayed 1460 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2007 20:16:28 EST
Received: from ppp-34-245.utech.ru (unknown [80.86.245.34])
	by shadanakar.org (Postfix) with ESMTP id 6E13F42C2510;
	Wed, 14 Nov 2007 03:52:27 +0300 (MSK)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64937>

When doing dcommit git-svn must use subversion's config or newly created
files will not include svn's properties
(defined in [auto-props] with 'enable-auto-props = yes').

Signed-off-by: Konstantin V. Arkhipov <voxus@onphp.org>
---
--- git-svn	2007-11-02 18:41:32.000000000 +0300
+++ git-svn	2007-11-12 19:35:44.000000000 +0300
@@ -406,6 +406,9 @@ sub cmd_dcommit {
 			my %ed_opts = ( r => $last_rev,
 			                log => get_commit_entry($d)->{log},
 			                ra => Git::SVN::Ra->new($gs->full_url),
+			                config => SVN::Core::config_get_config(
+			                        $Git::SVN::Ra::config_dir
+			                ),
 			                tree_a => "$d~1",
 			                tree_b => $d,
 			                editor_cb => sub {
