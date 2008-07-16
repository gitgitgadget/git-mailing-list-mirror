From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-i: keep old parents when preserving merges
Date: Wed, 16 Jul 2008 14:36:47 -0700
Message-ID: <7vd4ldpl3k.fsf@gitster.siamese.dyndns.org>
References: <1216173109-11155-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJEhB-0006s0-TF
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 23:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122AbYGPVg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757034AbYGPVg6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 17:36:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109AbYGPVg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 17:36:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B1BC92ED69;
	Wed, 16 Jul 2008 17:36:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5B31E2ED65; Wed, 16 Jul 2008 17:36:49 -0400 (EDT)
In-Reply-To: <1216173109-11155-1-git-send-email-s-beyer@gmx.net> (Stephan
 Beyer's message of "Wed, 16 Jul 2008 03:51:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F49C1BC-537F-11DD-823A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88762>

Stephan Beyer <s-beyer@gmx.net> writes:

... Based on the discussion thread, here is a rewrite of the log message.

> When "rebase -i -p" tries to preserve merges of unrelated branches, it
> lost some parents:
>
>  - When you have more than two parents, the commit in the new history
>    ends up with fewer than expected number of parents and this breakage
>    goes unnoticed;
>
>  - When you are rebasing a merge with two parents and one is lost, the
>    command tries to cherry-pick the original merge commit, and the command
>    fails.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index a35212d..0df7640 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -174,6 +174,8 @@ pick_one_preserving_merges () {
>  				new_parents="$new_parents $new_p"
>  				;;
>  			esac
> +		else
> +			new_parents="$new_parents $p"
>  		fi
>  	done

Reading the surrounding code, it makes me wonder if you also need to futz
with variables like $preserve and $fast_forward.
