From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why not preserve file permissions?
Date: Fri, 05 Dec 2008 14:38:41 -0800
Message-ID: <7vljuuxn66.fsf@gitster.siamese.dyndns.org>
References: <87tz9igzbr.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 05 23:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8jLF-0002AN-PD
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 23:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbYLEWis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 17:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbYLEWis
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 17:38:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029AbYLEWir (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 17:38:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A24F1819A;
	Fri,  5 Dec 2008 17:38:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 231551811F; Fri, 
 5 Dec 2008 17:38:42 -0500 (EST)
In-Reply-To: <87tz9igzbr.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Sat, 06 Dec 2008 04:08:08 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A4AFDA0-C31D-11DD-9A87-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102421>

jidanni@jidanni.org writes:

> Why not preserve permissions the way you find them, instead of just
> using 644 and 755? It certainly couldn't be more complicated than what
> you are doing now, and that way one could do things like use git to
> update system administration files across a sneakernet containing e.g.,
> # dlocate -lsconf exim4-config|sed 's/ .*//'|sort -u
> -rw-r-----
> -rw-r--r--
> -rwxr-xr-x

Actually in a very early days, git used to record the full (mode & 0777)
for blobs.

Once people started using git, everybody realized that it had a very
unpleasant side effect that the resulting tree depended on user's umasks,
because one person records a blob with mode 664 and the next person who
modifies the file would record with mode 644, and it made it very hard to
keep track of meaningful changes to the source code.  This issue was fixed
long time ago with commit e447947 (Be much more liberal about the file
mode bits., 2005-04-16).
