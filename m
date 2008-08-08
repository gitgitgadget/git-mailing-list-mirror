From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Enable parallel tests
Date: Thu, 07 Aug 2008 23:52:25 -0700
Message-ID: <7vvdycf17a.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 08:53:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRLr1-00085X-5w
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 08:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbYHHGwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 02:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYHHGwg
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 02:52:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbYHHGwe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 02:52:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DC1F59472;
	Fri,  8 Aug 2008 02:52:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BA37859471; Fri,  8 Aug 2008 02:52:28 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 8 Aug 2008 07:59:23 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 932A9836-6516-11DD-8899-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91627>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On multiprocessor machines, or with I/O heavy tests (that leave the
> CPU waiting a lot), it makes sense to parallelize the tests.

I was actually thinking about doing this eventually.  Thanks for beating
me to it.

> Parallel mode also triggers removal of the trash directory in the test
> itself if everything went fine, so that the trash directories do not
> pile up only to be removed at the very end.

I think making the tests remove their own mess makes sense regardless.

I have to wonder why you would want to make this change conditional on
MAKEFLAGS.  I was envisioning that parallel tests would run in "trash
directory/$(basename $0)" or something.

Are there downsides of doing this change unconditionally?

>  clean:
> -	$(RM) -r 'trash directory' test-results
> +	$(RM) -rf 'trash directory' test-results

This is not needed, I think, as RM is defined with -f already.
