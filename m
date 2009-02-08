From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gc considered dangerous
Date: Sun, 08 Feb 2009 12:00:57 -0800
Message-ID: <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com>
 <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWFrr-0006db-QS
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbZBHUBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 15:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbZBHUBH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:01:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbZBHUBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 15:01:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 213352AB5F;
	Sun,  8 Feb 2009 15:01:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E93BF2AB69; Sun, 
 8 Feb 2009 15:00:58 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 8 Feb 2009 15:56:38 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 372A4AEA-F61B-11DD-81E4-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109006>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My preliminary guess is that this code in pack-write.c needs to use the 
> lock file paradigm:
>
>         if (!index_name) {
> 		[...]
>         } else {
>                 unlink(index_name);
>                 fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
>         }

Whoa.  That particular code has been (and is still) correct.

When repacking we should pack into a temporary pack and idx file and then
replace the real ones after both new pack and its idx are successfully
written, and I thought that is how we've been doing this all the time.
Maybe the caller has been broken at some point?  Sigh...
