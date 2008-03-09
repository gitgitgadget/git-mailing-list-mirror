From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin remote rm: remove symbolic refs, too
Date: Sun, 09 Mar 2008 03:24:20 -0700
Message-ID: <7vlk4sp54b.fsf@gitster.siamese.dyndns.org>
References: <200803051338.44938.tlikonen@iki.fi>
 <7v7iggn9ts.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803082339060.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	James Bowes <jbowes@dangerouslyinc.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 11:25:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYIiP-0007Vf-BU
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYCIKYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 06:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYCIKYf
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 06:24:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYCIKYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 06:24:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 708451A14;
	Sun,  9 Mar 2008 06:24:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B5AE21A13; Sun,  9 Mar 2008 06:24:27 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803082339060.3975@racer.site> (Johannes
 Schindelin's message of "Sat, 8 Mar 2008 23:40:42 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76646>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> "git remote add" can add a symbolic ref "HEAD", and "rm" should delete
> it, too.
>
> Noticed by Teemu Likonen.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin-remote.c  |    5 +++++
>  t/t5505-remote.sh |    1 +
>  2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-remote.c b/builtin-remote.c
> index aa90cc9..f7653b6 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -267,6 +267,11 @@ static int add_branch_for_removal(const char *refname,
>  
>  	if (!prefixcmp(refname, branches->prefix)) {
>  		struct path_list_item *item;
> +
> +		/* make sure that symrefs are deleted */
> +		if (flags & REF_ISSYMREF)
> +			return unlink(git_path(refname));
> +

Heh, doing this in C is much easier and simpler ;-)
