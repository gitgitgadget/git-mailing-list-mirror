From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Wed, 14 May 2008 11:28:48 -0700
Message-ID: <7vbq38oi3j.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141802480.30431@racer>
 <alpine.DEB.1.00.0805141803240.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 20:30:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLja-0006n4-GW
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040AbYENS3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbYENS27
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:28:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334AbYENS27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:28:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9268A5245;
	Wed, 14 May 2008 14:28:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CE0655240; Wed, 14 May 2008 14:28:52 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805141803240.30431@racer> (Johannes
 Schindelin's message of "Wed, 14 May 2008 18:03:31 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C60D580-21E3-11DD-85D6-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82127>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -3355,6 +3357,9 @@ void diff_addremove(struct diff_options *options,
>  	char concatpath[PATH_MAX];
>  	struct diff_filespec *one, *two;
>  
> +	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(mode))
> +		return;
> +
>  	/* This may look odd, but it is a preparation for
>  	 * feeding "there are unchanged files which should
>  	 * not produce diffs, but when you are doing copy

So both removal and addition of a submodule is an uninteresting event.

> @@ -3399,6 +3404,10 @@ void diff_change(struct diff_options *options,
>  	char concatpath[PATH_MAX];
>  	struct diff_filespec *one, *two;
>  
> +	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES) && S_ISGITLINK(old_mode)
> +			&& S_ISGITLINK(new_mode))
> +		return;

And a submodule changing from revision A to B is uninteresting.

Is it interesting if something that used to be a blob turns into a
submodule, or vice versa?  The code says it is, but I think it would be
more convenient to treat it as a removal of blob and addition of a
submodule.
