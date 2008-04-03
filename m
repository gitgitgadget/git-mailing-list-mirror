From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken
 branch imports
Date: Wed, 02 Apr 2008 19:06:08 -0700
Message-ID: <7viqyz66b3.fsf@gitster.siamese.dyndns.org>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
 <7vprt8838y.fsf@gitster.siamese.dyndns.org>
 <1207187090.17329.15.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Mansfield <david@cobite.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 04:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhEr0-0002iv-2t
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 04:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758945AbYDCCGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 22:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758865AbYDCCGR
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 22:06:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758762AbYDCCGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 22:06:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D47DF2CC3;
	Wed,  2 Apr 2008 22:06:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 293062CC2; Wed,  2 Apr 2008 22:06:10 -0400 (EDT)
In-Reply-To: <1207187090.17329.15.camel@gandalf.cobite.com> (David
 Mansfield's message of "Wed, 02 Apr 2008 21:44:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78721>

David Mansfield <david@cobite.com> writes:

> Also, how does the git packaging (non-rpm version) specify and/or
> guarantee dependencies are at a certain version anyway?

We cannot really do much with the old cvsimport out in the field, but I
was wondering more about automatic detection in new cvsimport.

The way I read 02-cvsps-implement-branch-point-detection.patch, you have
three cases:

 - "Ancestor branch:" is not followed by "Branches:" before "Log:"
   (old cvsps);

 - "Ancestor branch:" is followed by "Branches:" before "Log:" (new);

 - "Branches:" without "Ancestor branch:" (new);

So perhaps your 04-cvsimport-redo-branch-creation-process.patch, instead
of ignoring what "Ancestor branch:" said, can remember it has seen what
"ancestor" (which may be a bit off) information it was given, and when you
see "Log:" (by that time, you either have seen "Branches:" from new cvsps,
or you didn't see it from old cvsps) you can decide which vintage of cvsps
it is reading from.

Or something like that.
