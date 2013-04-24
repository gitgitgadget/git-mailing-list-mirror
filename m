From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] submodule: fix quoting in relative_path()
Date: Wed, 24 Apr 2013 09:15:36 +0100
Message-ID: <20130424081536.GT2278@serenity.lan>
References: <cover.1365539059.git.john@keeping.me.uk>
 <cover.1366314439.git.john@keeping.me.uk>
 <cover.1366314439.git.john@keeping.me.uk>
 <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
 <7vfvyn4g46.fsf@alter.siamese.dyndns.org>
 <20130419074632.GC2278@serenity.lan>
 <7vmwsu31vh.fsf@alter.siamese.dyndns.org>
 <517199AB.50109@kdbg.org>
 <7vehe6z10t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 10:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUurz-0001zV-FG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 10:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758001Ab3DXIP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 04:15:56 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:33958 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757704Ab3DXIPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 04:15:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C31D2606593;
	Wed, 24 Apr 2013 09:15:52 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BYZhLsSrK6sR; Wed, 24 Apr 2013 09:15:52 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 45031198032;
	Wed, 24 Apr 2013 09:15:51 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 34F2D161E568;
	Wed, 24 Apr 2013 09:15:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N7eoq+Yjo4OY; Wed, 24 Apr 2013 09:15:49 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 0DA22161E3F4;
	Wed, 24 Apr 2013 09:15:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vehe6z10t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222237>

Commit caca2c1 (submodule: drop the top-level requirement) introduced a
relative_path helper but does not quote $curdir when it is stripped from
the front of a target path.  In this particular case this should be safe
even with special characters because we only do this after checking that
$target begins with "$curdir/" which is quoted correctly, but we should
quote the variable to be certain that there is not some obscure case
where we this could strip more or less than we want.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Fri, Apr 19, 2013 at 02:03:14PM -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Why not just replace the six-liner by this one-liner:
> >
> > 		target=${target#"$curdir"/}
> 
> Simple enough ;-)

This seems to have arrived on next without this fix, so here's a patch
on top.

 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 0eee703..db9f260 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -127,7 +127,7 @@ relative_path ()
 	do
 		case "$target" in
 		"$curdir/"*)
-			target=${target#$curdir/}
+			target=${target#"$curdir"/}
 			break
 			;;
 		esac
-- 
1.8.2.1.715.gb260f47
