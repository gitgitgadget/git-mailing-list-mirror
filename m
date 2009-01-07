From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Wed, 07 Jan 2009 12:48:57 -0800
Message-ID: <7v63kqall2.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
 <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>
 <20081104004001.GB29458@artemis.corp>
 <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>
 <20081104083042.GB3788@artemis.corp>
 <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>
 <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
 <20090106111712.GB30766@artemis.corp>
 <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
 <1231359317.6011.12.camel@maia.lan>
 <alpine.DEB.1.00.0901072121260.7496@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:50:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKfMF-0005hX-9X
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbZAGUtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbZAGUtL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:49:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbZAGUtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 15:49:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 733168E991;
	Wed,  7 Jan 2009 15:49:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D4C738E98C; Wed,
  7 Jan 2009 15:48:59 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901072121260.7496@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Wed, 7 Jan 2009 21:38:36 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A127E46C-DCFC-11DD-83A4-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104831>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> After compiling and installing, something like this should be fun to 
> watch:
>
> 	$ git rev-list --all --parents | \
> 	  grep " .* " | \
> 	  while read commit parent1 parent2 otherparents
> 	  do
> 		test -z "$otherparents" || continue
> 		git checkout $parent1 &&
> 		git merge $parent2 &&
> 		git diff > without-patience.txt &&
> ...
> 		if ! cmp without-patience.txt with-patience.txt
> 		then
> 			echo '==============================='
> 			echo "differences found in merge $commit"
> ...
> 			cat with-patience.txt
> 		fi ||
> 		exit
> 	  done | tee patience-merge.out

An even more interesting test would be possible by dropping "&&" from the
two "git merge" invocations.

 - Your sample will exit at the first conflicting merge otherwise.

 - You may find cases where one resolves cleanly while the other leaves
   conflicts.
