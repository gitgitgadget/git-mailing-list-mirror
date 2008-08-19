From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Tue, 19 Aug 2008 00:53:21 -0700
Message-ID: <7vpro5fnke.fsf@gitster.siamese.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org>
 <7vy72tkfu0.fsf@gitster.siamese.dyndns.org>
 <20080819072650.GE11842@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:54:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVM30-0008Ad-Ls
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYHSHx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbYHSHx3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:53:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbYHSHx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:53:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CAF695F4C7;
	Tue, 19 Aug 2008 03:53:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DF1505F4C6; Tue, 19 Aug 2008 03:53:23 -0400 (EDT)
In-Reply-To: <20080819072650.GE11842@schiele.dyndns.org> (Robert Schiele's
 message of "Tue, 19 Aug 2008 09:26:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7ED5A06-6DC3-11DD-AB15-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92827>

Robert Schiele <rschiele@gmail.com> writes:

> On Mon, Aug 18, 2008 at 05:29:11PM -0700, Junio C Hamano wrote:
>> Haven't looked at the real declarations but if the decl are "extern" and
>> nobody refers to them, why should the resulting object file require them
>> to be defined anywhere?  If the decl are not and in (fortran-ish) "common"
>> section, on the other hand, you shouldn't have to define them yourself
>> like this either.
>> 
>> This sounds like a compiler bug to me.
>
> This was my first thought as well but after more inspection there are two
> things to consider:
>
> 1. I was not really precise enough in my description since I didn't spot that
>    when I looked into the issue first: Actually there are references to these
>    variables in static inline functions in cache.h.  Thus there actually is a
>    reference though one that will never be used since abspath.c (that includes
>    cache.h) is not calling any of these functions.
>
> 2. Since these symbols turn out to be referenced though in dead code only I
>    wouldn't call it a compiler bug.

Ok, as I said, I didn't look.  If they are indeed referenced, that is a
different story.

Even if that is the case, I do not like the prospect of having to maintain
a set of duplicated variable definitions.  If we really wanted to address
this issue, maybe we would want a separate source file that is linked to
both git-shell and to the rest of the system that has nothing but
definitions of these variables?  I thought environment.c was meant to be
something like that -- would linking environment.o pull in too many extra
references these days (again, I didn't try)?
