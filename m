From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 21:40:36 -0700
Message-ID: <7vtz146mgr.fsf@alter.siamese.dyndns.org>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain>
 <20090723012207.GA9368@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 06:40:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTq6w-0005nw-38
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 06:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZGWEkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 00:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbZGWEkp
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 00:40:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbZGWEkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 00:40:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D9E4E61A;
	Thu, 23 Jul 2009 00:40:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 05458E618; Thu, 23 Jul 2009
 00:40:38 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 (Linus Torvalds's message of "Wed\, 22 Jul 2009 19\:23\:39 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FB309180-7742-11DE-AD6D-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123833>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 22 Jul 2009, Linus Torvalds wrote:
>> 
>> Ooh yes. That would do it. It's going to peel and look up every single ref 
>> it finds, so it's going to look up _hundreds_ of objects (all the tags, 
>> all the commits they point to, etc etc). Even if it then only shows a 
>> couple of branches.
>> 
>> Junio, any ideas?
>
> I had one of my own.

It seems that I missed all the fun while going out to dinner.

> It uses the "raw" version of 'for_each_ref()' (which doesn't verify that 
> the ref is valid), and then does the "type verification" before it starts 
> doing any gentle commit lookup.

Hmm, we now have to remember what this patch did, if we ever wanted to
introduce negative refs later (see ef06b91 do_for_each_ref: perform the
same sanity check for leftovers., 2006-11-18).  Not exactly nice to spread
the codepaths that need to be updated.  Is the cold cache performance of
"git branch" to list your local branches that important?
