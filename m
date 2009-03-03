From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: avoid 'git reset' when possible
Date: Mon, 02 Mar 2009 16:57:45 -0800
Message-ID: <7v1vtfl8xi.fsf@gitster.siamese.dyndns.org>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
 <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>
 <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>
 <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302>
 <7vvdqt8wob.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903012242180.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 02:00:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIym-0002CB-Qt
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZCCA6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 19:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbZCCA6A
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:58:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbZCCA57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 19:57:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B1EDF2C5F;
	Mon,  2 Mar 2009 19:57:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 87CFD2C5D; Mon, 
 2 Mar 2009 19:57:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 55FE9410-078E-11DE-AEA6-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111986>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Or even
>
> 	current=$ONTO
> 	fd=3
> 	while read command sha1 rest
> 	do
> 		case "$fd,$command,$current" in
> 		3,pick,"$sha1"*|t,p,"$sha1"*)
> 			current=$sha1
> 			;;
> 		*)
> 			fd=1
> 			;;
> 		esac
> 		echo "$command $sha1 $rest" >&$fd
> 	done < "$TODO" > "$TODO.new" 3>> "$DONE" &&
> 	mv "$TODO.new" "$TODO"
>
> Hmm?

Certainly.

Even though "3 means we haven't found a non-pick yet" feels slightly
hacky, the logic is contained in this small loop and I do not see it as a
problem.  As long as you are sure $ONTO and all sha1 can be compared
without running them through rev-parse, avoiding rev-parse per iteration
is a very attractive optimization.
