From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH 1/4] git.el: Support for showing unknown/ignored directories.
Date: Fri, 22 Feb 2008 16:53:16 +0100
Message-ID: <8763whkmxf.fsf@wine.dyndns.org>
References: <87zludorqs.fsf@wine.dyndns.org>
	<20080222153051.GA20984@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSaDu-0003Qp-F2
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 16:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbYBVPx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 10:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbYBVPx1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 10:53:27 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:54179 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbYBVPx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 10:53:26 -0500
Received: from adsl-84-226-29-199.adslplus.ch ([84.226.29.199] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JSaD8-0000yB-Sa; Fri, 22 Feb 2008 09:53:25 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 486291E715D; Fri, 22 Feb 2008 16:53:16 +0100 (CET)
In-Reply-To: <20080222153051.GA20984@diana.vm.bytemark.co.uk> ("Karl
	=?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Fri, 22 Feb 2008 16:30:51
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74730>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-02-07 13:50:19 +0100, Alexandre Julliard wrote:
>
>> Instead of recursing into directories that only contain unknown
>> files, display only the directory itself. Its contents can be
>> expanded with git-find-file (bound to C-m).
>
> I have a bunch of directories in my tree with only ignored files in
> them. They used to not show up at all, but now they do. If I press
> return with the cursor on top of one of them, it vanishes (which is
> equivalent to expanding to all the 0 non-ignored files in that
> directory, I guess).
>
> I presume this wasn't the intended behavior? I like the idea for
> subdirectories that actually contain non-ignored files, but
> directories with only ignored files should really not be shown at all=
=2E

It probably needs something like this:

=46rom b32a397a64eec64d433aa0ee00147003723cfeee Mon Sep 17 00:00:00 200=
1
=46rom: Alexandre Julliard <julliard@winehq.org>
Date: Fri, 22 Feb 2008 16:48:53 +0100
Subject: [PATCH] git.el: Do not display empty directories.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index d91fbb8..7cb86df 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -753,7 +753,7 @@ Return the list of files that haven't been handled.=
"
 (defun git-run-ls-files-with-excludes (status files default-state &res=
t options)
   "Run git-ls-files on FILES with appropriate --exclude-from options."
   (let ((exclude-files (git-get-exclude-files)))
-    (apply #'git-run-ls-files status files default-state "--directory"
+    (apply #'git-run-ls-files status files default-state "--directory"=
 "--no-empty-directory"
            (concat "--exclude-per-directory=3D" git-per-dir-ignore-fil=
e)
            (append options (mapcar (lambda (f) (concat "--exclude-from=
=3D" f)) exclude-files)))))
=20
--=20
1.5.4.1.132.gd85f75

--=20
Alexandre Julliard
julliard@winehq.org
