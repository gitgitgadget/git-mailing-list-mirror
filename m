From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Mon, 09 Jun 2008 16:20:10 -0700
Message-ID: <7vy75edwlx.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806091458190.1783@racer>
 <1213051426-11530-1-git-send-email-vmiklos@frugalware.org>
 <7vd4mqfcb0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806100006140.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:21:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qfp-0001G5-Vd
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbYFIXUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbYFIXUU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:20:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbYFIXUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:20:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C9C75640;
	Mon,  9 Jun 2008 19:20:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A6033561F; Mon,  9 Jun 2008 19:20:12 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806100006140.1783@racer> (Johannes
 Schindelin's message of "Tue, 10 Jun 2008 00:08:01 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F122E36-367A-11DD-B4B8-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84450>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 9 Jun 2008, Junio C Hamano wrote:
>
>> Miklos Vajna <vmiklos@frugalware.org> writes:
>> 
>> > Exactly. I modified merge_bases_many() to use a commit list.
>> 
>> I just looked at your f755fb6; from the point of view of merge_bases() 
>> which is far more often used, I think this is not an improvement but 
>> actively wrong thing to do.  Most of the time callers compute merge base 
>> of two, and the codepath should be optimized for that case.
>
> But how much work is
>
> 	struct commit_list list = { two, NULL };
>
> 	merge_bases_many(one, &list);

But (1) that is not what f755fb6 does; it does commit_list_insert() that
has an allocation, and (2) how much work is to count, allocate and pass
array for slow and less frequent codepath which octopus-merge-base is?
