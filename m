From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] change all unchecked calls to setenv to xsetenv
Date: Tue, 13 Dec 2011 10:33:29 -0800
Message-ID: <7v1us8wccm.fsf@alter.siamese.dyndns.org>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
 <1323778227-1664-2-git-send-email-kusmabite@gmail.com>
 <20111213181946.GC1663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 19:33:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaXAX-0003V4-R5
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab1LMSdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:33:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab1LMSdc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 13:33:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B5FD7A6F;
	Tue, 13 Dec 2011 13:33:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eS7uYWT8UIq/r7qKmXjG0zIclpg=; b=FSrmLu
	tj53BiEPCZikOLOfL7iBSOmEbp/HluL0CUMI2ybbsku9nbKwPfNXAlO0wV6VFFD+
	+Wuk4J0iEANfRSAFickasYBDKh4UWoPu/pRbGnLTpTwFA2gPtyJyRx/rtnJJtkxv
	HW4pflcMCijD5lka9PhUC/grigsBlCC7LTiqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oPZ6IQa8C/45IAwCaW7sY5X+YVp+3iwy
	mvRFYtjBQL8ehO4WcHq/+2UBtQAIkMUQWXK0K/Ay1/ND0RZ8Ykz3nythSJG5NC5S
	FLcboWH2+1oEOrN6tqzYfbBuyt5IlD1ozQmoLuyd3p5dIw51cjVt/AaXFlasZfyc
	XHQ+exD72ac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 925067A6E;
	Tue, 13 Dec 2011 13:33:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 267B37A6D; Tue, 13 Dec 2011
 13:33:31 -0500 (EST)
In-Reply-To: <20111213181946.GC1663@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Dec 2011 13:19:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4F45BD6-25B8-11E1-9FED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187041>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 13, 2011 at 01:10:27PM +0100, Erik Faye-Lund wrote:
>
>> While reviewing some patches for Git for Windows, I realized that
>> we almost never check the return-value from setenv. This can lead
>> to quite surprising errors in unusual sitations. Mostly, an error
>> would probably be preferred. So here we go.
>> 
>> However, I'm not at all convinced myself that all of these make
>> sense; in particular settings like GIT_EDITOR and GIT_PAGER could
>> perhaps benefit from having a warning printed rather than a hard
>> error.
>> 
>> Thoughts?
>
> I wrote almost the same patch once[1], but failed to actually push it
> through to acceptance.

In both cases, the patches are _designed_ to fail to attract any
attention.  Your earlier one had this preamble:

  Here is a patch. I still feel a little silly writing this. The chances
  that you will run out of memory doing setenv but _not_ doing any of the
  other git operations seems very low.

which rather *loudly* says "ignore me, please!" ;-)

Erik's patch this round is no better; if its log message said something
like "On platform X, the environment space is merely nKB and setenv has
much higher chance of failing than on typical Linux boxes", it would have
been a no brainer for me to respond with "makes perfect sense but don't we
also use putenv?" immediately.
