From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] bisect: fix quoting TRIED revs when "bad" commit is
 also "skip"ped
Date: Thu, 26 Feb 2009 22:55:48 -0800
Message-ID: <7v8wnsnzbf.fsf@gitster.siamese.dyndns.org>
References: <20090227073122.ca74c387.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 07:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcwf3-0007td-UR
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 07:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbZB0Gz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 01:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbZB0Gz4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 01:55:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbZB0Gz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 01:55:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 917C99D909;
	Fri, 27 Feb 2009 01:55:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 53B2C9D908; Fri,
 27 Feb 2009 01:55:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ACDF9040-049B-11DE-B2E7-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111638>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 85db4ba..a9324b2 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -288,6 +288,8 @@ filter_skipped() {
>  		return
>  	fi
>  
> +	VARS= FOUND= TRIED=
> +

Did you have any particular reason to move these out of the subshell on
the downstream side of the pipe as I wrote in my response?  That is where
these variables matter.

>  	# Let's parse the output of:
>  	# "git rev-list --bisect-vars --bisect-all ..."
>  	eval "$_eval" | while read hash line
> @@ -309,7 +311,7 @@ filter_skipped() {

Also you seem to have lost my fix to ignore $line for "bisect_foo=value"
lines where $line is always empty.
