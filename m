From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/16] git-submodule: avoid sed input with no newline
Date: Wed, 12 Mar 2008 15:41:03 -0700
Message-ID: <7vabl34lc0.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312214044.GM26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZe9-0008Ux-4H
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbYCLWlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbYCLWlU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:41:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbYCLWlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:41:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DBED20BC;
	Wed, 12 Mar 2008 18:41:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9935A20BA; Wed, 12 Mar 2008 18:41:14 -0400 (EDT)
In-Reply-To: <20080312214044.GM26286@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Mar 2008 17:40:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77016>

Jeff King <peff@peff.net> writes:

> Some versions of sed don't like this, and give no output at
> all. Instead, we can use git-config to pare down the matches
> for us.

Good use of --literal.

But doesn't this make you wonder if "--literal-match --get-regexp" is
quite a strange combination?  "Literal" covers the value part but the key
is still regexp (and we do want it to behave that way).  However, maybe we
would want to also allow "give entries whose key is this literal key and
whose value matches this regexp"?

> +	name=$(git config --literal-match -f .gitmodules \
> +		--get-regexp 'submodule\..*\.path$' "$1" |
> +		sed -e 's/submodule\.//' -e 's/\.path.*//')
> +	test -z "$name" &&
> +	die "No submodule mapping found in .gitmodules for path '$path'"
> +	echo "$name"
>  }
