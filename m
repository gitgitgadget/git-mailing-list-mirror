From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Thu, 17 Apr 2014 11:49:25 -0700
Message-ID: <xmqq7g6neqq2.fsf@gitster.dls.corp.google.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
	<mvm8ur42zn6.fsf@hawking.suse.de>
	<xmqq8ur3ga2y.fsf@gitster.dls.corp.google.com>
	<87zjjj50eq.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Jan Kara <jack@suse.cz>
To: Andreas Schwab <schwab@suse.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 20:49:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WarNS-00087o-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 20:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbaDQStb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 14:49:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32849 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbaDQSt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 14:49:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAFC67B451;
	Thu, 17 Apr 2014 14:49:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OQoTLfZSqksqWRKlEWQXdvTIcLw=; b=f/cdB5
	czI6uz6hUoJMfljami2aTKyqHbaidXp5y1jJoWDCShR5VUzVgoRrEotEq1G+4Dmf
	iZyOU+HFyFNeBWfBs/4kk5CFrMtM57/ur/I6yQAWhItx2HcDS6GLeI5iqHToo2ND
	vAMbH+76CYlhQxvZoDHayJEWbJRKI7tcRESt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MTn109BZH31ELt4ZF1QMgGUB4jVRlbGn
	UmUDlMbId3TI4wM1PNGp/JFZcejBTl0XLUkh6BFkckrjE3e7nbPwMueQZenrZhe8
	pssw5V0nmwt8sNeBaKTdGO99IcP/Ns6Tg1clXFqZAzkc7k3FE62kGBQcvo8ni4aV
	lOANTHHvLZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD9B67B450;
	Thu, 17 Apr 2014 14:49:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 565587B44D;
	Thu, 17 Apr 2014 14:49:27 -0400 (EDT)
In-Reply-To: <87zjjj50eq.fsf@igel.home> (Andreas Schwab's message of "Thu, 17
	Apr 2014 19:30:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 008B5F3A-C661-11E3-8E42-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246434>

Andreas Schwab <schwab@suse.de> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> When your project does not mind basing the description on rc tags,
>> between v3.4-rc1~192^2~9^2 and v3.5-rc1~120^3~76^2, I am not sure if
>> we would want to say that "the former is not so longer than the
>> latter, so use that", or what kind of heuristics to employ to reach
>> that conclusion.  Date-based selection (i.e. earliest first) is one
>> possibility.  Tagname-based selection has the issue of having to
>> configure "whose version numbering convention would you use when
>> sorting tags, and how you would tell Git that sorting order rule?"
>
> IMHO git should select based on topology: the first tag that isn't
> contained in any other tag still containing the commit in question, only
> when ambigous it needs to fall back to other criteria.

I think we are in agreement.  In the part you chopped from your
quote, I said:

>> For a possible cleaner alternative semantics, see the other message
>> I just sent to the thread.

didn't I?
