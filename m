From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename core.unreliableHardlinks to core.createObject
Date: Tue, 28 Apr 2009 13:59:25 -0700
Message-ID: <7vk554jxzm.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
 <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
 <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
 <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
 <7vws95vete.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904281022070.10279@pacific.mpi-cbg.de>
 <7v1vrdqi9i.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904281647350.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:03:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyuPs-00078b-4N
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbZD1U7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbZD1U7g
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 16:59:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZD1U7f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 16:59:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 851C9AE1CE;
	Tue, 28 Apr 2009 16:59:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A5D4AAE1C8; Tue,
 28 Apr 2009 16:59:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904281647350.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 28 Apr 2009 16:50:01 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 79930E94-3437-11DE-BCEF-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Wait a bit. Wasn't this about you accessing NTFS on your EeePC via unfs 
>> from the Linux side?
>
> Both.  I realized that there was a problem with the ufsd driver of the 
> Xandros Linux on my EeePC, accessing NTFS partitions.  (This is the issue 
> that made me add a config variable, but which was solved by Linus' 
> core.fsyncobjects suggestion.)
>
> Later I had a hunch that the issues 222 and 229 of msysGit might have 
> exactly the same reason, let the reporters test, and indeed, the problems 
> went away.
>
> But come to think of it, we can _easily_ just set core.createObject=rename 
> in msysGit, so I agree that there is no longer a need for the Makefile 
> variable.
>
> Want me to resend?

If it helps msys, I think we should allow compiling things in, but this
"compiled in default for the platform, and possible per-repository
override" made me a bit confused:

 (1) in your "This is Linux and on sane filesystems I do not weaken it to
     rename but on this one filesystem I do" case can be handled by adding
     .git/config in that repository;

 (2) problems with msysgit can be handled by compiled-in defaults as long
     as the user does not have .git/config entry to say "link";

 (3) if you use the same repository from both sides with (1), presumably
     by dual-booting, so having .git/config that says "rename" happens to
     work;

 (4) if somebody has a dual-boot setup and shares a repository hosted
     natively on the Linux side by mounting it on the Windows side (Ext2
     IFS?), I wonder what should happen.  While you are using the
     repository from the Linux side, you may not want to weaken it to use
     "rename" (so you do not add .git/config that says "rename").  When
     you are accessing it over Ext2 IFS, perhaps you would want to use
     "rename" (I do not know about the details of #222 and #229, so it may
     not applicable, though).

So,... as long as you do not have a triple-boot setup, third system among
which wants to use "link" on a repository where both Linux and Windows
side want to use "rename", I think you are Ok.
