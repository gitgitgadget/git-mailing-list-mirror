From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|") in
 sed regular expressions
Date: Wed, 11 Mar 2009 23:55:49 -0700
Message-ID: <7viqmfjklm.fsf@gitster.siamese.dyndns.org>
References: <1236837389-35687-1-git-send-email-brian.p.campbell@dartmouth.edu>
 <1236837389-35687-2-git-send-email-brian.p.campbell@dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Brian Campbell <brian.p.campbell@dartmouth.edu>
X-From: git-owner@vger.kernel.org Thu Mar 12 07:57:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LherC-00028t-Rq
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 07:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbZCLG4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 02:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbZCLG4B
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 02:56:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbZCLG4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 02:56:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 669985168;
	Thu, 12 Mar 2009 02:55:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9C99E5166; Thu,
 12 Mar 2009 02:55:53 -0400 (EDT)
In-Reply-To: <1236837389-35687-2-git-send-email-brian.p.campbell@dartmouth.edu> (Brian
 Campbell's message of "Thu, 12 Mar 2009 01:56:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D733B916-0ED2-11DE-AB5A-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113006>

Brian Campbell <brian.p.campbell@dartmouth.edu> writes:

> +current_branch()
> +{
> +	echo "$(git symbolic-ref HEAD | sed -e 's#^refs/heads/##' -e 's#^refs/top-bases/##')"
> +}

Two micronits.

 - what happens when you are on a detached HEAD?

 - You will be utterly confused by a local branch whose name is
   "refs/top-bases/foo"

To fix these, you might want to do something like:

	if head_=$(git symbolic-ref HEAD)
        then
                case "$head_" in
                refs/heads/*)
                        echo "${head_#refs/heads/}"
                        ;;
                refs/top-bases/*)
                        echo "${head_#refs/top-bases/}"
                        ;;
                *)
                        echo "$head_"
                        ;;
                esac
	else
        	whatever you want to do on a detached HEAD
	fi
