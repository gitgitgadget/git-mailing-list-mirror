From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Sun, 02 Mar 2008 08:59:13 -0800
Message-ID: <7vtzjpoye6.fsf@gitster.siamese.dyndns.org>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home>
 <20080302154238.GD2973@steel.home>
 <alpine.LSU.1.00.0803021555500.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrXk-0002Vc-Lg
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYCBQ7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 11:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYCBQ7b
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 11:59:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbYCBQ7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 11:59:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 89CBD1319;
	Sun,  2 Mar 2008 11:59:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C34021313; Sun,  2 Mar 2008 11:59:20 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803021555500.22527@racer.site> (Johannes
 Schindelin's message of "Sun, 2 Mar 2008 15:57:02 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75807>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 2 Mar 2008, Alex Riesen wrote:
>
>> -			add_file_to_cache(path, verbose);
>> +			if (add_file_to_cache(path, verbose))
>> +				exit(1);
>
> Does it really, really _have_ to be exit(1)?  I mean, now you block even 
> the faintest chance that we can libify libgit.a by overriding die_routine.

I think Alex did so not to break the existing scripts that rely on these
dying, but it should have been exit(128) to really stay compatible.

Why is this even needed to begin with?  I am aware of Dirk's original
issue discussed elsewhere, but we try fairly hard to be A-O-N when we can
afford to, and this option deliberately breaks it.  What is the real
reason why such an unreadable (either for privilege or for I/O error)
file should not live in .gitignore?

