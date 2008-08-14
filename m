From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow emails with boundaries to work again
Date: Wed, 13 Aug 2008 18:36:53 -0700
Message-ID: <7vtzdogyx6.fsf@gitster.siamese.dyndns.org>
References: <1218667559-26618-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 03:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTRmv-0003pg-IL
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 03:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbYHNBhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 21:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYHNBhA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 21:37:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYHNBhA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 21:37:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A5115611A;
	Wed, 13 Aug 2008 21:36:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 76C2B56119; Wed, 13 Aug 2008 21:36:56 -0400 (EDT)
In-Reply-To: <1218667559-26618-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Wed, 13 Aug 2008 18:45:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C7E5B60-69A1-11DD-AE03-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92305>

Don Zickus <dzickus@redhat.com> writes:

> Recent changes to is_multipart_boundary() caused git-mailinfo to segfault.
> The reason was after handling the end of the boundary the code tried to look
> for another boundary.  Because the boundary list was empty, dereferencing
> the pointer to the top of the boundary caused the program to go boom.
>
> The fix is to check to see if the list is empty and if so go on its merry
> way instead of looking for another boundary.

Hmm, at this point !*content_top means that we are at the outermost level
and we have just seen --boundary-- which is the terminating one, haven't
we?  Shouldn't we be simply returning?
