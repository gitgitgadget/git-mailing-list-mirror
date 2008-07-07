From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-rerere: fix conflict markers parsing
Date: Mon, 07 Jul 2008 10:39:23 -0700
Message-ID: <7vy74d4mr8.fsf@gitster.siamese.dyndns.org>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr>
 <alpine.DEB.1.00.0807071400180.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Marin <dkr+ml.git@free.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:40:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFuhU-0007Ge-MQ
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 19:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbYGGRjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbYGGRjf
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 13:39:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbYGGRje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 13:39:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0144D2E40C;
	Mon,  7 Jul 2008 13:39:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4479A2E40A; Mon,  7 Jul 2008 13:39:26 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807071400180.18205@racer> (Johannes
 Schindelin's message of "Mon, 7 Jul 2008 14:02:20 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8D7525C-4C4B-11DD-8936-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87636>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So what about
>
> 	<<<<<<< This hunk contains =====
> 	anythin
> 	=======
>
> 	Hello
> 	=======
> 	somethin else
> 	>>>>>>> problem!
>
>
> If you fix it, I think you should do it properly, and analyze the index.

I do not know offhand if analyzing the index is the right solution, but
your point is very valid.  You need to know which ====== is the real one
to be able to properly flip sides of the conflict.

I however think detecting that we have this ambiguous hunk is easy, and
punting gracefully and not re-resolving in such a case is million times
better than producing random results that the users need to be worried
about.
