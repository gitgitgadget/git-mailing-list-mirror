From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 05 Aug 2009 13:02:08 -0700
Message-ID: <7v3a862fnj.fsf@alter.siamese.dyndns.org>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <200908051940.48110.trast@student.ethz.ch>
 <7v3a869lw1.fsf@alter.siamese.dyndns.org>
 <200908052052.28067.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:02:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmgs-0000T5-5I
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbZHEUCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbZHEUCS
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:02:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbZHEUCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:02:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C57A622424;
	Wed,  5 Aug 2009 16:02:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 10A4522423; Wed, 
 5 Aug 2009 16:02:11 -0400 (EDT)
In-Reply-To: <200908052052.28067.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 5 Aug 2009 20\:52\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E005B6D4-81FA-11DE-86C5-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124960>

Thomas Rast <trast@student.ethz.ch> writes:

> So it detects there are worktree changes, but then decides not to show
> them because it's an unmerged entry.  I think the following should go
> in 3/5, but note that I haven't looked at the rest of the code to
> check if it breaks anything:

Thanks.  Shouldn't it go in 4/5 instead, though?

> -- 8< --
> diff --git i/wt-status.c w/wt-status.c
> index 6370fe2..5a68297 100644
> --- i/wt-status.c
> +++ w/wt-status.c
> @@ -400,7 +400,8 @@ static int wt_status_check_worktree_changes(struct wt_status *s)
>  	for (i = 0; i < s->change.nr; i++) {
>  		struct wt_status_change_data *d;
>  		d = s->change.items[i].util;
> -		if (!d->worktree_status)
> +		if (!d->worktree_status
> +		    || d->index_status == DIFF_STATUS_UNMERGED)
>  			continue;
>  		changes = 1;
>  		if (d->worktree_status == DIFF_STATUS_DELETED)
> -- >8 --

Not "d->worktree_status"?  That would be more consistent with what
wt_status_print_changed() actually ends up checking.
