From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Wed, 21 May 2008 11:08:32 -0700
Message-ID: <7v8wy34jj3.fsf@gitster.siamese.dyndns.org>
References: <482BE5F7.2050108@thorn.ws>
 <alpine.DEB.1.00.0805161139530.30431@racer>
 <alpine.DEB.1.00.0805161148010.30431@racer>
 <alpine.DEB.1.00.0805161403130.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tommy Thorn <tommy-git@thorn.ws>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 21 20:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyskr-0008DX-8R
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 20:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbYEUSIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 14:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933607AbYEUSIq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 14:08:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208AbYEUSIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 14:08:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DA0C4618C;
	Wed, 21 May 2008 14:08:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4782A6187; Wed, 21 May 2008 14:08:40 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805161403130.30431@racer> (Johannes
 Schindelin's message of "Fri, 16 May 2008 14:03:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F3093094-2760-11DD-BF2C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82560>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The function fgets() has a big problem with NUL characters: it reads
> them, but nobody will know if the NUL comes from the file stream, or
> was appended at the end of the line.
>
> So implement a custom read_line() function.

Looking at what handle_body() does for TE_BASE64 and TE_QP cases, I have
to wonder if this is enough.  The loop seems to stop at (*op == NUL) which
follows an old assumption that each line is terminated with NUL, not the
new assumption you introduced that each line's length is kept in local
variable len.
