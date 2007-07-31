From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Support for incremental status updates.
Date: Tue, 31 Jul 2007 20:48:01 +0200
Message-ID: <874pjktnoe.fsf@wine.dyndns.org>
References: <87sl7ekt40.fsf@wine.dyndns.org>
	<20070730232226.GA2413@diana.vm.bytemark.co.uk>
	<87k5shudz7.fsf@morpheus.local>
	<20070731111438.GA17903@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFwlT-0005NS-Ot
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 20:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbXGaSsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 14:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757844AbXGaSsI
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 14:48:08 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:47323 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329AbXGaSsG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 14:48:06 -0400
Received: from adsl-84-227-18-170.adslplus.ch ([84.227.18.170] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IFwlH-0004KP-4l; Tue, 31 Jul 2007 13:48:03 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 140DA1E70D2; Tue, 31 Jul 2007 20:48:01 +0200 (CEST)
In-Reply-To: <20070731111438.GA17903@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Tue\, 31 Jul 2007 13\:14\:38
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54367>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> git.el already requires ewoc. And it uses a number of ewoc functions
> (and has done so since its creation); this newly introduced call is
> the only one that fails.
>
> Also, I've just discovered that with Emacs 22.1, I don't see this
> problem. So my guess is that ewoc-set-data is newer than Emacs 21.4.

Yes, it's a new function. Something like this should work:

=46rom 8da6b3257fe785484c5683fc97edccf75ac5588d Mon Sep 17 00:00:00 200=
1
=46rom: Alexandre Julliard <julliard@winehq.org>
Date: Tue, 31 Jul 2007 20:45:53 +0200
Subject: [PATCH] git.el: Avoid using ewoc-set-data for compatibility wi=
th Emacs 21.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 9bcd7c4..f6102fc 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -530,7 +530,7 @@ and returns the process output as a string."
     (setf (git-fileinfo->needs-refresh info) t)
     (when node   ;preserve the marked flag
       (setf (git-fileinfo->marked info) (git-fileinfo->marked (ewoc-da=
ta node))))
-    (if node (ewoc-set-data node info) (ewoc-enter-last status info)))=
)
+    (if node (setf (ewoc-data node) info) (ewoc-enter-last status info=
))))
=20
 (defun git-run-diff-index (status files)
   "Run git-diff-index on FILES and parse the results into STATUS.
--=20
1.5.3.rc3.97.gcb90c

--=20
Alexandre Julliard
julliard@winehq.org
