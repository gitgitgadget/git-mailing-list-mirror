From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Tue, 12 Aug 2008 14:33:37 -0700
Message-ID: <7v7ialrk9a.fsf@gitster.siamese.dyndns.org>
References: <200808080148.27384.trast@student.ethz.ch>
 <200808082037.49918.trast@student.ethz.ch>
 <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <200808091200.21634.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:35:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT1W1-0005DI-2Q
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 23:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYHLVdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 17:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbYHLVdu
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 17:33:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbYHLVdt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 17:33:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D28E55E87;
	Tue, 12 Aug 2008 17:33:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D89B555E82; Tue, 12 Aug 2008 17:33:41 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58D9E68E-68B6-11DD-8690-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92143>

Thomas Rast <trast@student.ethz.ch> writes:

> Johannes Schindelin wrote:
>> But hey, if other people agree with you, and this kind of thinking ends 
>> up in Git proper, I can still resort to other DVCSes.
>
> BTW, the following is fairly ironic.  (It was later rewritten in
> 813b473 to the current one-shot 'rev-list --parents' form.)

Hmm, Dscho, perhaps we should take Thomas's patch as a "revert to 685ef54
to fix breakage introduced by 813b473", and demonstrate the breakage with
one of the new tests in his series?

I think it is Ok to use the "view --parents for all branches, instead of
looping with -1" approach when there is no path limiter, and that might be
faster, but if it complicates the logic too much, it probably is not worth
it.  I also _suspect_ that if you use --simplify-merges, the optimization
made by 813b473 would still be usable even with path limiter.

By the way, I am not sure if using --simplify-merges unconditionally is
necessarily a good thing to do.

The user who filters the branches may be interested in a full history
(where using --simplify-merges is the right thing to do), or may be
interested in getting one simplest possible explanation of the end result,
similar to what you get from rev-list without the option.
