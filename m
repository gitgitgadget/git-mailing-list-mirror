From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 02:05:54 -0800
Message-ID: <7vhc2ubssd.fsf@gitster.siamese.dyndns.org>
References: <1234777061.090819.2512.nullmailer@beryx.hq.kred>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: ams@gnu.org
X-From: git-owner@vger.kernel.org Mon Feb 16 11:07:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0Ny-0003fQ-5H
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbZBPKGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 05:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbZBPKGH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:06:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbZBPKGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:06:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 499369A210;
	Mon, 16 Feb 2009 05:06:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EC6BE9A20D; Mon,
 16 Feb 2009 05:05:55 -0500 (EST)
In-Reply-To: <1234777061.090819.2512.nullmailer@beryx.hq.kred> (Alfred M.
 Szmidt's message of "Mon, 16 Feb 2009 10:37:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B0EEC3E-FC11-11DD-914A-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110158>

"Alfred M\. Szmidt" <ams@gnu.org> writes:

>    > when doing a `git svn clone' on a subversion repository that contains
>    > a large file (>1GiB), `git svn' dies with the following:
>    > 
>    > ams@trillian:~$ git svn clone REPO -T trunk -b branches -t tags
>    > [...]
>    > fatal: Out of memory? mmap failed: Cannot allocate memory
>    > hash-object -w --stdin-paths: command returned error: 128

Ding...

>    > git version 1.6.1.3
>
>    Core git requires objects to be able to fit into (virtual) memory.
>    Adding more swap space should solve the problem for you, but this is not
>    only a git-svn problem.
>
> In this case, the machine has 32G RAM, including ~20G swap.  So I do
> not think that this is the case, it could be I suppose...

The hash-object error message sounds like the issue that was fixed with
915308b (avoid 31-bit truncation in write_loose_object, 2009-01-29).  Does
v1.6.2-rc1 help?
