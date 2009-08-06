From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] wt-status.c: rework the way changes to the index and
 work tree are summarized
Date: Thu, 06 Aug 2009 08:50:15 -0700
Message-ID: <7vhbwlndqg.fsf@alter.siamese.dyndns.org>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
 <20090806144638.GA1970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ5Ea-00088O-UG
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbZHFPuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755888AbZHFPuU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:50:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbZHFPuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 11:50:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 45DA623089;
	Thu,  6 Aug 2009 11:50:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 52C5F23088; Thu, 
 6 Aug 2009 11:50:17 -0400 (EDT)
In-Reply-To: <20090806144638.GA1970@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 6 Aug 2009 10\:46\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8492C4A-82A0-11DE-B9EE-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125089>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 05, 2009 at 02:15:44AM -0700, Junio C Hamano wrote:
>
>> diff --git a/wt-status.c b/wt-status.c
>> index 47735d8..1614352 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -20,6 +20,7 @@ static char wt_status_colors[][COLOR_MAXLEN] = {
>>  	GIT_COLOR_RED,    /* WT_STATUS_CHANGED */
>>  	GIT_COLOR_RED,    /* WT_STATUS_UNTRACKED */
>>  	GIT_COLOR_RED,    /* WT_STATUS_NOBRANCH */
>> +	GIT_COLOR_YELLOW, /* WT_STATUS_UNMERGED */
>>  };
>
> Does this belong in 3/5? It looks like the WT_STATUS_UNMERGED symbol is
> not used at all until 4/5, which seems like the more logical place
> (since it deals explicitly with unmerged entries). Also, why does it
> start yellow here and then turn to red in the next patch?
>
> And related:
>
>> diff --git a/wt-status.h b/wt-status.h
>> index 78add09..f80142f 100644
>> --- a/wt-status.h
>> +++ b/wt-status.h
>> [...]
>>  	WT_STATUS_NOBRANCH,
>> +	WT_STATUS_UNMERGED,

Thanks.  For the same reason, stagemask and unmerged_mask() helper
function should move from 3/5 to 4/5.
