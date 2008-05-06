From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Be more careful with objects directory permissions on 
 clone
Date: Mon, 05 May 2008 23:53:00 -0700
Message-ID: <7vprrzhqk3.fsf@gitster.siamese.dyndns.org>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz>
 <481ECCF0.6080308@viscovery.net>
 <alpine.BSO.1.10.0805051047260.7723@zrgural.vwaro.pbz>
 <481EDC4B.2010105@viscovery.net>
 <alpine.BSO.1.10.0805051121090.32248@zrgural.vwaro.pbz>
 <481EE478.9000704@viscovery.net>
 <alpine.BSO.1.10.0805051742020.10940@zrgural.vwaro.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
X-From: git-owner@vger.kernel.org Tue May 06 08:54:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtH3s-0007Ko-6p
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 08:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbYEFGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 02:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbYEFGxP
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 02:53:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbYEFGxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 02:53:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CEB6C44B6;
	Tue,  6 May 2008 02:53:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1B34A44B4; Tue,  6 May 2008 02:53:06 -0400 (EDT)
In-Reply-To: <alpine.BSO.1.10.0805051742020.10940@zrgural.vwaro.pbz> (Mark
 Hills's message of "Mon, 5 May 2008 17:46:42 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 174325FC-1B39-11DD-BFDB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81340>

Mark Hills <mark@pogo.org.uk> writes:

> diff --git a/git-clone.sh b/git-clone.sh
> index 8c7fc7f..9d88d1c 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -334,7 +334,10 @@ yes)
>  			fi
>  		fi &&
>  		cd "$repo" &&
> -		find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
> +		# Create dirs using umask and permissions and destination
> +		find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir -p) &&
> +		# Copy existing 0444 permissions on content
> +		find objects ! -type d -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
>  			exit 1

Looks much better.  Thanks.
