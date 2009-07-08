From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 08 Jul 2009 10:34:29 -0700
Message-ID: <7vskh76pui.fsf@alter.siamese.dyndns.org>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
 <7viqi386th.fsf@alter.siamese.dyndns.org>
 <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fritz Anderson <fritza@uchicago.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOb2Z-0000Li-TP
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 19:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbZGHRef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbZGHRef
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 13:34:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbZGHRef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 13:34:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1653A26CE1;
	Wed,  8 Jul 2009 13:34:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 548EB26CE0; Wed, 
 8 Jul 2009 13:34:31 -0400 (EDT)
In-Reply-To: <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu> (Fritz
 Anderson's message of "Wed\, 8 Jul 2009 12\:10\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99DBAA2C-6BE5-11DE-9F8F-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122907>

Fritz Anderson <fritza@uchicago.edu> writes:

> Here is the result:
>
> ===
> $ git index-pack
> usage: git index-pack [-v] [-o <index-file>] [{ ---keep | -- 
> keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack- 
> file>] }
> $ sudo git index-pack
> usage: git index-pack [-v] [-o <index-file>] [{ ---keep | -- 
> keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack- 
> file>] }
> ===
>
> So git is apparently found. HOWEVER, if I do this, it's a different  
> story:
>
> ===
> $ which git
> /usr/local/bin/git
> $ sudo which git
> which: no git in (/usr/bin:/bin)
> ===

I was told sudo does this path munging for security reasons (I do not use
it personally) but it appears that it does _not_ do that for finding the
top level command in "sudo $command $args".

Very interesting.

Which makes the initial "sudo git clone..." find git in _your_ path before
sanitization (and that is why it even starts), but then the path is nuked
for the git process it launches, and we cannot find git-index-pack on the
PATH.

But this should be fine, as git is expected to find git-index-pack in its
GIT_EXEC_PATH that is compiled in the binary of "git" itself.

Which makes me suspect that your "git" in /usr/local/bin may be
misconfigured.  You might want to check what these tell you.

	$ git --exec-path
	$ /usr/local/bin/git --exec-path
