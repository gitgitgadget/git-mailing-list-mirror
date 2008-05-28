From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: use "$GIT_DIR/BISECT_START" to check if we are
 bisecting
Date: Wed, 28 May 2008 10:04:23 -0700
Message-ID: <7vmymauzqg.fsf@gitster.siamese.dyndns.org>
References: <20080528185702.4dcd2955.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed May 28 19:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1P5d-0005op-IR
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 19:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYE1REi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 13:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbYE1REi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 13:04:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbYE1REi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 13:04:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 771453BF0;
	Wed, 28 May 2008 13:04:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A834C3BEB; Wed, 28 May 2008 13:04:30 -0400 (EDT)
In-Reply-To: <20080528185702.4dcd2955.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed, 28 May 2008 18:57:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26199150-2CD8-11DD-AB93-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83113>

Christian Couder <chriscool@tuxfamily.org> writes:

> It seems simpler and safer to use the BISECT_START file everywhere
> to decide if we are bisecting or not, instead of using it in some
> places and BISECT_NAMES in other places.
>
> In commit 6459c7c6786aa9bda0c7a095c9db66c36da0e5f0 (Nov 18 2007,
> Bisect: use "$GIT_DIR/BISECT_NAMES" to check if we are bisecting.),
> we decided to use BISECT_NAMES but code changed a lot and we now
> have to check BISECT_START first in the "bisect_start" function
> anyway.
>
> This patch also makes things a little bit safer by creating
> the BISECT_START file first and deleting it last, and also by
> adding checks in "bisect_clean_state".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

What's the breakage scenario that this patch fixes?

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 4bcbace..991b2ef 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -44,7 +44,7 @@ sq() {
>  }
>  
>  bisect_autostart() {
> -	test -f "$GIT_DIR/BISECT_NAMES" || {
> +	test -s "$GIT_DIR/BISECT_START" || {

The reason you ignore an existing but empty BISECT_START file is...?
