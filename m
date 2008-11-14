From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/11] gitweb: git_is_head_detached() function
Date: Thu, 13 Nov 2008 22:40:38 -0800
Message-ID: <7vk5b6dd3t.fsf@gitster.siamese.dyndns.org>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-7-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 07:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0sNk-0004T5-O8
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 07:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbYKNGlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 01:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbYKNGlA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 01:41:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbYKNGk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 01:40:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 744F17DEBA;
	Fri, 14 Nov 2008 01:40:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8D0897DEB9; Fri,
 14 Nov 2008 01:40:45 -0500 (EST)
In-Reply-To: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Thu, 13 Nov 2008 23:49:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 320C56D6-B217-11DD-B467-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100954>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> The function checks if the HEAD for the current project is detached by
> checking if 'git branch' returns "* (no branch)"

This one looks more like "oops, the way detached HEAD is detected in 08 is
sucky, let's cover it up by introducing a function as an afterthought."

Have a patch that introduces git_is_head_detached() first, and then use
that function to implement the feature.  I personally think the user (that
is, 08/11) is small and isolated enough that these two can be a single
patch.

> +# check if current HEAD is detached
> +sub git_is_head_detached {
> +	my @x = (git_cmd(), 'branch');
> +	my @ret = split("\n", qx(@x));
> +	return 0 + grep { /^\* \(no branch\)$/ } @ret;
> +}

Do not read from Porcelain in scripts.

"git symbolic-ref HEAD" should error out when your HEAD is detached, and
will return refs/heads/frotz when you are on frotz branch.

But realistically speaking, what does it mean to have a detached HEAD in a
repository published via gitweb?  First of all these things are supposed
to be bare and there would be no checkout.
