From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] vc-git: support asynchronous annotations, and improve versioning.
Date: Sun, 15 Jul 2007 20:20:57 -0700
Message-ID: <7v3azpavae.fsf@assigned-by-dhcp.cox.net>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
	<cfa5ed80635135dd7544f2b4c6df521a4353e90d.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAH99-0007SE-TE
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760152AbXGPDVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759999AbXGPDVA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:21:00 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:56005 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760083AbXGPDU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:20:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716032059.XIWL1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Jul 2007 23:20:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q3Ly1X0031kojtg0000000; Sun, 15 Jul 2007 23:20:58 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52629>

David Kastrup <dak@gnu.org> writes:

> (vc-git-symbolic-commit): Allow nil to pass through.
> (vc-git-previous-version): Use explicit parent argument.
> (vc-git-next-version): Simplify.
> (vc-git-annotate-command): Use `vc-do-command'.
> (vc-git-annotate-extract-revision-at-line): Rename from
> `vc-annotate-extract-revision-at-line'.
> (vc-git-checkout): Make nicer way of ensuring encoding.
>

These do not seem to match what the patch does at all.
I give up.

Will apply only the "install .el, too" change from the confusing
series for now.

> diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
> index 2a0a0fe..d7ad314 100644
> --- a/contrib/emacs/vc-git.el
> +++ b/contrib/emacs/vc-git.el
> @@ -173,23 +173,22 @@ Returns nil if not possible."
> ...
>  (defun vc-git-annotate-command (file buffer &optional version)
>    "Execute \"git blame\" on FILE, inserting the contents in BUFFER.
>  Optional arg VERSION is a version to annotate from."
> -  (vc-do-command buffer
> -		 'async
> -		 "git" file "blame"
> -		 (or version "HEAD")
> -		 "--"))
> +  (let ((coding-system-for-read git-commits-coding-system))
> +    (vc-do-command buffer
> +		   'async
> +		   "git" file "blame"
> +		   (or version "HEAD")
> +		   "--")))
>  
>  ;;(defun vc-git-annotate-command (file buf &optional rev)
>  ;;  (let ((name (file-relative-name file)))
> -- 
> 1.4.4.2
