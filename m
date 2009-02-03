From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Mon, 02 Feb 2009 20:30:30 -0800
Message-ID: <7vd4e0f8gp.fsf@gitster.siamese.dyndns.org>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu>
 <1233308489-2656-2-git-send-email-geofft@mit.edu>
 <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de>
 <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu>
 <alpine.DEB.1.00.0902012333060.3586@pacific.mpi-cbg.de>
 <7v8wopmizw.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902021326420.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoffrey Thomas <geofft@MIT.EDU>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUCxI-0005TC-CS
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 05:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZBCEav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 23:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbZBCEat
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 23:30:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbZBCEar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 23:30:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 94C4D2A52D;
	Mon,  2 Feb 2009 23:30:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C26AD2A51B; Mon, 
 2 Feb 2009 23:30:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 674F4596-F1AB-11DD-A3C4-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108141>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And last time I checked, many more encodings used 1 character/byte (or for 
> that matter, 1 column / byte) than not; utf8_width would be "more wrong" 
> than strlen() here, because strlen() would "happen to work" here.

Ahh, you are absolutely right here, and use of utf8_width without checking
is actively breaking things.

> There _has_ to be a way to check if the current author string is encoded 
> in UTF-8.  All I am asking is that the original poster would put just a 
> _little_ more effort into the issue and make the thing dependent on the 
> knowledge -- as opposed to the assumption -- that the author is encoded in 
> UTF-8.

Yeah, that makes sense.

> That is the code that barfs in wcwidth:
>
>         if (ch < 32 || (ch >= 0x7f && ch < 0xa0))
>                 return -1;
>
> That is not a big problem, but Geoff's code does not handle that case 
> correctly.

Thanks for checking --- I suspected something like that would be there
somewhere.
