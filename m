From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] t2200, t7004: Avoid glob pattern that also matches
 files
Date: Wed, 18 Mar 2009 17:47:21 -0700
Message-ID: <7v7i2mbap2.fsf@gitster.siamese.dyndns.org>
References: <cover.1237410682.git.j6t@kdbg.org>
 <3827d7fab3e9e233a0ac528b84ab2d6a36658365.1237410682.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 01:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk6RT-0006hm-PU
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 01:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbZCSAr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 20:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbZCSAr2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 20:47:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbZCSAr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 20:47:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C681B78EE;
	Wed, 18 Mar 2009 20:47:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 32F6278EC; Wed,
 18 Mar 2009 20:47:23 -0400 (EDT)
In-Reply-To: <3827d7fab3e9e233a0ac528b84ab2d6a36658365.1237410682.git.j6t@kdbg.org>
 (Johannes Sixt's message of "Wed, 18 Mar 2009 22:27:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83F3E512-141F-11DE-996E-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113710>

Johannes Sixt <j6t@kdbg.org> writes:

> On Windows, there is an unfortunate interaction between the MSYS bash and
> git's command line processing:
>
> - Since Windows's CMD does not do the wildcard expansion, but passes
>   arguments like path* through to the programs, the programs must do the
>   expansion themselves. This happens in the startup code before main() is
>   entered.
>
> - bash, however, passes the argument "path*" to git, assuming that git will
>   see the unquoted word unchanged as a single argument.
>
> But actually git expands the unquoted word before main() is entered.

Doesn't this mean on Windows, the glob pathspec git supports is not useful
at all?

I am wondering if we want to treat any feature that involves globs as
unusable like any feature that involves pathnames with a TAB in it.

> In t2200, not all names that the test case is interested in exist as files
> at the time when 'git ls-files' is invoked. git expands "path?" to only
> the subset of files the exist, and only that subset was listed, so that the
> test failed.  We now list all interesting paths explicitly.

But that conversion misses the whole point of that particular test,
doesn't it?  It wants to see path2 that was unmerged and existed only in
the index but not in the work tree has disappeared, while the similarly
unmerged path1 resolved after "add -u".  IOW, you are not testing that
"add -u" notices a removal of path2 from the work tree anymore.
