From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: proper pack time stamping with
 --max-pack-size
Date: Thu, 13 Mar 2008 22:13:04 -0700
Message-ID: <7vlk4lubvj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803131440590.2947@xanadu.home>
 <7vmyp1vsa7.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803140035260.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 06:13:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja2Eu-00059P-PU
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 06:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYCNFNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 01:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbYCNFNR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 01:13:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYCNFNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 01:13:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FC6413CA;
	Fri, 14 Mar 2008 01:13:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5CF0F13C9; Fri, 14 Mar 2008 01:13:12 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803140035260.2947@xanadu.home> (Nicolas
 Pitre's message of "Fri, 14 Mar 2008 00:39:02 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77180>

Nicolas Pitre <nico@cam.org> writes:

>> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
>> > index f504cff..4c2ed70 100644
>> > --- a/builtin-pack-objects.c
>> > +++ b/builtin-pack-objects.c
>> > @@ -17,6 +17,8 @@
>> >  #include "progress.h"
>> >  #include "refs.h"
>> >  
>> > +#include <utime.h>
>> > +
>> 
>> Hmmm.  Shouldn't this go to git-compat-util.h?
>
> Maybe... if you say so.
>
> The whole header file arrangement logic is somewhat escaping my mind, so 
> I simply decided to do the same as in test-chmtime.c.

The general idea is to isolate the place system headers are included at,
so that we have to worry about the inclusion and feature-macro definition
order at only one place (see for example the hack about _ALL_SOURCE to
work around AIX 5.3, yuck).
