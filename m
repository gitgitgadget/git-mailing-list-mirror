From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision walker: include a detached HEAD in --all
Date: Sat, 17 Jan 2009 22:01:00 -0800
Message-ID: <7v8wp917c3.fsf@gitster.siamese.dyndns.org>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
 <496EE559.3060901@viscovery.net>
 <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
 <200901151500.01876.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de>
 <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 07:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOQjw-0004c0-Tr
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 07:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbZARGBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 01:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbZARGBK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 01:01:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZARGBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 01:01:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ECECE91091;
	Sun, 18 Jan 2009 01:01:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C5AE491090; Sun,
 18 Jan 2009 01:01:01 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri, 16 Jan 2009 13:52:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65733BC0-E525-11DD-81DB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106142>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When HEAD is detached, --all should list it, too, logically, as a
> detached HEAD is by definition a temporary, unnamed branch.
>
> It is especially necessary to list it when garbage collecting, as
> the detached HEAD would be trashed.
>
> Noticed by Thomas Rast.
>
> Note that this affects creating bundles with --all; I contend that it
> is a good change to add the HEAD, so that cloning from such a bundle
> will give you a current branch.  However, I had to fix t5701 as it
> assumed that --all does not imply HEAD.

Sorry, but I do not understand.

> diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
> index 8dfaaa4..14413f8 100755
> --- a/t/t5701-clone-local.sh
> +++ b/t/t5701-clone-local.sh
> @@ -11,8 +11,8 @@ test_expect_success 'preparing origin repository' '
>  	git clone --bare . x &&
>  	test "$(GIT_CONFIG=a.git/config git config --bool core.bare)" = true &&
>  	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true
> -	git bundle create b1.bundle --all HEAD &&
> -	git bundle create b2.bundle --all &&
> +	git bundle create b1.bundle master HEAD &&
> +	git bundle create b2.bundle master &&

Because --all did not imply HEAD, "--all HEAD" used to be the way to say
"everything and HEAD".  Now --all does imply HEAD, but it should still be
a valid way to say "everything, by the way, do not forget HEAD".

Does the first one need to be changed to "master HEAD"?  If "--all HEAD"
makes the rest of the test unhappy because HEAD is listed twice, perhaps
that is an independent bug that needs to be fixed?

For that matter, what does "git bundle create x HEAD HEAD" do?  Does it
list HEAD twice?
