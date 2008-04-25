From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with git fetch over http://
Date: Fri, 25 Apr 2008 15:29:55 -0700
Message-ID: <7vskx9o9ek.fsf@gitster.siamese.dyndns.org>
References: <63F7B390-32D1-458A-8ED9-D5AC62F46745@newartisans.com>
 <alpine.LNX.1.00.0804251749390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Wiegley <johnw@newartisans.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:30:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpWRS-0003Zl-2r
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 00:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbYDYWaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbYDYWaG
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 18:30:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYDYWaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 18:30:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 34A8341AF;
	Fri, 25 Apr 2008 18:30:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 75E2941AD; Fri, 25 Apr 2008 18:29:59 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0804251749390.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 25 Apr 2008 18:04:16 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80352>

Daniel Barkalow <barkalow@iabervon.org> writes:

> John mentioned on IRC that clone works.
>
> $ git-ls-remote http://newartisans.com/git/ledger.git
> 96751442d9eda537480867e599e4c604663f4530        refs/heads/master
> 365baca5174232cc35e4ed190fd8ce93c3611c84        refs/heads/v2.4.1
> f972a89073843fdbb2a1bef969d9ca70509d4bfe        refs/heads/v2.5
> 6a81d760dc4ab9028b27430124702c28c0b894ed        refs/tags/cvs-20040410
> fed3956a310a2ea8c8595b7fde7aaa0623492ca6        refs/tags/v0.1
> ...
>
> $ git-ls-remote git://newartisans.com/ledger.git
> 96751442d9eda537480867e599e4c604663f4530        HEAD
> 96751442d9eda537480867e599e4c604663f4530        refs/heads/master
> 365baca5174232cc35e4ed190fd8ce93c3611c84        refs/heads/v2.4.1
> f972a89073843fdbb2a1bef969d9ca70509d4bfe        refs/heads/v2.5
> 6a81d760dc4ab9028b27430124702c28c0b894ed        refs/tags/cvs-20040410
> fed3956a310a2ea8c8595b7fde7aaa0623492ca6        refs/tags/v0.1
> ...
>
> Looks like either server-info.c:update_info_refs() needs to also list 
> HEAD, or transport.c:get_refs_via_curl() needs to guess that $url/HEAD 
> exists and fetch it to add to the list, or both.

Wait a minute.  How did "git fetch http://host/repo.git" work before C
rewrite?

The reason I ask is because info/refs traditionally did not list HEAD and
fetch either would have failed to start walking from HEAD (iow, the issue
was very old), or it didn't care (iow, the issue is a regression after C
rewrite).
