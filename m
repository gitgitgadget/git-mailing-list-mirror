From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Sun, 17 Feb 2008 19:20:17 -0800
Message-ID: <7vwsp3uf0u.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site>
 <7vbq6fvudp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:21:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQwZF-0004YB-Kp
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 04:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbYBRDUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 22:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYBRDUq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 22:20:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbYBRDUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 22:20:45 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 54AC168E6;
	Sun, 17 Feb 2008 22:20:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 6FDB568E5; Sun, 17 Feb 2008 22:20:35 -0500 (EST)
In-Reply-To: <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 17 Feb 2008 19:03:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74223>

Junio C Hamano <gitster@pobox.com> writes:

> Side note.  I personally do not like naming hashes and arrays
> plural, and call a hash of paths and list of files %path and
> @file respectively.  That convention makes it easier to read
> things like these:
>
> 	$file[4] ;# fourth file, not $files[4]
> 	$path{'hello.c'} ;# path for 'hello.c', not $paths{'hello.c'}
> ...
> +    while (@canstatusfiles) {
> +	    my %basename = ();
> +	    my @status = ();
> +	    my @leftover = ();
> +	    for (my $i = 0; $i < @canstatusfiles; $i++) {
> +		    my $name = $canstatusfiles[$i];
> +		    my $basename = basename($name);

Side note to the side note.

A related naming guideline I failed to follow (because I was
mostly copying your code) suggests that the hash here should be
named %fullname, instead of %basename.  Then logically:

	$fullname{'hello.c'} = 'a/b/hello.c';

that is, you consult %fullname hash using the basename as the
key to extract the corresponding fullname.  The naming guideline
is "Name the dictionary after its values, not after its keys."
