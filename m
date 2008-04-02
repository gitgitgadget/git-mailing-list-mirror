From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken
 branch imports
Date: Wed, 02 Apr 2008 12:29:17 -0700
Message-ID: <7vprt8838y.fsf@gitster.siamese.dyndns.org>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Mansfield <david@cobite.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 21:30:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh8f5-00077l-OK
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 21:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757023AbYDBT3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 15:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757179AbYDBT3g
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 15:29:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023AbYDBT3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 15:29:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F092240EF;
	Wed,  2 Apr 2008 15:29:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4BCBB40ED; Wed,  2 Apr 2008 15:29:24 -0400 (EDT)
In-Reply-To: <1207100091.10532.64.camel@gandalf.cobite.com> (David
 Mansfield's message of "Tue, 01 Apr 2008 21:34:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78704>

David Mansfield <david@cobite.com> writes:

> In case you're wondering, I'm actually the original author of cvsps,
> which is behind the scenes for cvsimport.  I don't call myself
> maintainer because I've hardly been that over the last few years.
>
> Anyway, the fix to cvsps is attached (1st 2 patches) as well as the
> patch to git-cvsimport.perl (2nd 2 patches) against the master branch as
> of today's git repo.
>
> The cvsps patches apply with fuzz against the 2.1 version which is out
> there.

When output from an unfixed cvsps is fed to the updated cvsimport, does it
gracefully do the wrong thing (iow, create the same broken history not too
much worse than the original)?

> @@ -826,12 +824,9 @@ while (<CVS>) {
>  		$branch = $_;
>  		$state = 5;
>  	} elsif ($state == 5 and s/^Ancestor branch:\s+//) {
> -		s/\s+$//;
> -		$ancestor = $_;
> -		$ancestor = $opt_o if $ancestor eq "HEAD";
> +		# now ignored.  see 'Branches' below
>  		$state = 6;
>  	} elsif ($state == 5) {
> -		$ancestor = undef;
>  		$state = 6;
>  		redo;
>  	} elsif ($state == 6 and s/^Tag:\s+//) {
