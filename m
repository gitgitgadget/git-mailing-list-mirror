From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Tweak git-quiltimport to allow more flexible series format
Date: Thu, 22 Nov 2007 15:43:53 -0800
Message-ID: <7vsl2x26di.fsf@gitster.siamese.dyndns.org>
References: <20071122134849.GB6240@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, adobriyan@gmail.com
To: Alexey Dobriyan <adobriyan@sw.ru>
X-From: git-owner@vger.kernel.org Fri Nov 23 00:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvLiX-0003c8-BF
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 00:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXKVXoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 18:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbXKVXoB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 18:44:01 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51123 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbXKVXoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 18:44:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B27BA2EF;
	Thu, 22 Nov 2007 18:44:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3760398B06;
	Thu, 22 Nov 2007 18:44:17 -0500 (EST)
In-Reply-To: <20071122134849.GB6240@localhost.sw.ru> (Alexey Dobriyan's
	message of "Thu, 22 Nov 2007 16:48:49 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65857>

Alexey Dobriyan <adobriyan@sw.ru> writes:

> Make quiltimport also understand comments following patch name.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@sw.ru>
> ---
>
>  git-quiltimport.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -63,7 +63,7 @@ tmp_info="$tmp_dir/info"
>  commit=$(git rev-parse HEAD)
>  
>  mkdir $tmp_dir || exit 2
> -for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
> +for patch_name in $(sed -e 's/#.*//' < "$QUILT_PATCHES/series" ); do
>  	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
>  		echo "$patch_name doesn't exist. Skipping."
>  		continue

Is this consistent with the way quilt groks the series file?

IOW, does quilt forbid patchfile whose name contains a hash, and
anything after a hash on the line is taken as comment?

Can a line in a quilt series file name more than one patchfile?
If so, are they whitespace separated?
