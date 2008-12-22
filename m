From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: mark rename/delete conflict as unmerged
Date: Mon, 22 Dec 2008 15:12:22 -0800
Message-ID: <7v7i5rhkix.fsf@gitster.siamese.dyndns.org>
References: <85647ef50812220629o46134a70waf159bb6cd6d6e72@mail.gmail.com>
 <7v4p0whr7a.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0812222308410.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:14:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEtyk-0001AM-5g
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 00:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271AbYLVXMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 18:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756273AbYLVXMi
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 18:12:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbYLVXMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 18:12:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0989189F55;
	Mon, 22 Dec 2008 18:12:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0C1D89F53; Mon,
 22 Dec 2008 18:12:28 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0812222308410.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 22 Dec 2008 23:10:20 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 03DD11B2-D07E-11DD-8DE1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103779>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When a file was renamed in one branch, but deleted in the other, one
> should expect the index to contain an unmerged entry, namely the
> target of the rename.  Make it so.

That was quick, but the surrounding code makes me wonder if other
if/elseif branches also need similar handling.

For example, rename/add comes up with a new name that does not exist
anywhere, and adds both to the index; it is understandable that you need
to do this when processing a merge with non-zero depth because you need to
have a tree as the result, but shouldn't the final zero depth merge just
use the original names and leave the results in higher stages?
