From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull
 --rebase
Date: Thu, 16 Jul 2009 13:41:46 -0700
Message-ID: <7vhbxc8inp.fsf@alter.siamese.dyndns.org>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
 <1247731921-2290-1-git-send-email-santi@agolina.net>
 <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRXmI-000065-35
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 22:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbZGPUly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 16:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933315AbZGPUly
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 16:41:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933308AbZGPUlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 16:41:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 02DCA6715;
	Thu, 16 Jul 2009 16:41:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 540CC6714; Thu,
 16 Jul 2009 16:41:48 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu\, 16 Jul 2009 10\:51\:46 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 177DE774-7249-11DE-A008-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123420>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> How about
>
> 	oldremoteref="$(git rev-list --boundary HEAD --not \
> 			$(git rev-list -g $remoteref | sed 's/$/^@/') |
> 		sed -e '/^[^-]/d' -e q)"
>
> Explanation: the "git rev-list -g $remoteref" lists the previous commits 
> the remote ref pointed to, and the ^@ appended to them means all their 
> parents.  Now, the outer rev-list says to take everything in HEAD but 
> _not_ in those parents, showing the boundary commits.  The "sed" call 
> lists the first such boundary commit (which must, by construction, be one 
> of the commits shown by the first rev-list).

Hmm, I am not sure about that "(which must..." part.  When you have

          Y---X
         /
	B---o---o---o---H

wouldn't "rev-list --boundary H --not X^@" give B, not X nor Y?
