From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rev-list --bisect: Move finding bisection into do_find_bisection.
Date: Sun, 16 Sep 2007 01:47:13 -0700
Message-ID: <7vk5qr575a.fsf@gitster.siamese.dyndns.org>
References: <20070915125957.0899841b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 10:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWpmm-0001lB-Ep
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 10:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbXIPIrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 04:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbXIPIrT
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 04:47:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbXIPIrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 04:47:19 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 99137135E89;
	Sun, 16 Sep 2007 04:47:37 -0400 (EDT)
In-Reply-To: <20070915125957.0899841b.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 15 Sep 2007 12:59:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58307>

Christian Couder <chriscool@tuxfamily.org> writes:

> This factorises some code and make a big function smaller.

I think the refactoring itself makes sense, especially where it
simplifies the clean-up of weight array in early-return
codepath.  But I have a couple of comments, though.

> +static struct commit_list *do_find_bisection(struct commit_list *list,
> +					     int nr, int *weights);
> +
>  /*
>   * zero or positive weight is the number of interesting commits it can
>   * reach, including itself.  Especially, weight = 0 means it does not

The comment whose top part we can see here talks about the magic
values -1 and -2 used while do_find_bisection() after the
refactoring does its work, and these magic values are never
visible to the calling function.  You should move the comment to
the top of do_find_bisection() as well.

Also this forward declaration is unwarranted.  A bottom-up
sequence to define do_find_bisection() first, then to define its
sole caller find_bisection() next is easier to read at least for
me.

The latter comment also applies to your other patch.
