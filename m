From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Fri, 08 Aug 2008 18:25:05 -0700
Message-ID: <7viqub9dzi.fsf@gitster.siamese.dyndns.org>
References: <200808080148.27384.trast@student.ethz.ch>
 <200808081614.44422.trast@student.ethz.ch>
 <alpine.DEB.1.00.0808081632580.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <200808082037.49918.trast@student.ethz.ch>
 <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 09 03:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRdDm-0006Q1-EN
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 03:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYHIBZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 21:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbYHIBZO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 21:25:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbYHIBZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 21:25:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B10D34F9E6;
	Fri,  8 Aug 2008 21:25:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0AC404F9E5; Fri,  8 Aug 2008 21:25:06 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808090212060.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 9 Aug 2008 02:16:22 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 02D57E94-65B2-11DD-8F04-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91739>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> (a) Both A and D bring the same subdirectory contents.  'rev-list
>>     --parents -- $subdir' drops one side of the merge during pruning. It 
>>     does not look past the merge to see whether the contents were 
>>     arrived at via different changesets.  Thus the history becomes
>> 
>>       A' -- C'
>> 
>>       D'
>> 
>>     and even that only if D was reachable by a different ref,
>>     otherwise D' is simply dropped.
>
> And this is what I call wrong.  Simply dropping one side of the equation 
> is not what I call "sane".
>
> If you drop information, you are disagreeing with "content is king".

I think the aggressive merge simplification that gives "one simplest
explanation for the contents of the paths specified" is a wrong mode of
operation to use when you are filtering branches.  It might be a good
thing to support as an option, but I agree with you that it should not be
the default.

Perhaps --full-history is needed to the rev-list call (and the recent
invention --simplify-merges that will hopefully appear sometime after
1.6.0)?  See recent discussion of --full-history and the default merge
simplification between Linus and Roman Zippel.  I suspect that back when
the original cg-rewritehistory was written, not many people understood the
issues explained in that thread.
