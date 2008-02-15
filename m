From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge-Recursive Improvements
Date: Fri, 15 Feb 2008 11:21:13 -0800
Message-ID: <7v63wqgh5i.fsf@gitster.siamese.dyndns.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
 <47B29EBF.7060607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 20:22:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ68M-0001Cq-5v
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 20:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbYBOTVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 14:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbYBOTVc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 14:21:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbYBOTVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 14:21:31 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9828942C2;
	Fri, 15 Feb 2008 14:21:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 B240342C1; Fri, 15 Feb 2008 14:21:21 -0500 (EST)
In-Reply-To: <47B29EBF.7060607@viscovery.net> (Johannes Sixt's message of
 "Wed, 13 Feb 2008 08:39:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73977>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Voltage Spike schrieb:
>> Third, git doesn't appear to have any sense of context when performing a
>> merge. Another contrived example which wouldn't be flagged as a merge
>> conflict:
>> 
>>   ptr = malloc(len); // Added in HEAD.
>>   init();            // Included in merge-base.
>>   ptr = malloc(len); // Added in "merge".
>
> You seem to say that you want this to result in a merge conflict.
>
> I'm opposed to this: It means that you would mark a conflict if there is a
> single unchanged line between the two changes that come from the merged
> branches. So far it has happened for me much more frequently that such
> merges were correct, and I should not be bothered with conflict markers. I
> conciously prefer to pay the price that such a merge is incorrect on occasion.

Actually I think we really should mark this as conflict.  The
tool should resolve only the most unquestionable cases and keep
humans in the loop to validate the result if there is any
uncertainty.  Resolving the above example automatically without
warning is most likely a problem waiting to happen.

Such a merge being more often correct than not is not an
argument for resolving them silently.  It's rare mismerge cases
that will bite you later, and we should really be careful,
especially when a mismerge is less common.
