From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/32] files-backend: break out ref reading
Date: Thu, 25 Feb 2016 12:27:15 -0800
Message-ID: <xmqq8u28o7rw.fsf@gitster.mtv.corp.google.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	<1456354744-8022-4-git-send-email-dturner@twopensource.com>
	<xmqqr3g1r66h.fsf@gitster.mtv.corp.google.com>
	<xmqq7fhtr4sq.fsf@gitster.mtv.corp.google.com>
	<1456431098.18017.52.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:27:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2VP-0003KD-7y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbcBYU1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:27:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750754AbcBYU1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:27:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF66547949;
	Thu, 25 Feb 2016 15:27:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HHNICwYaS+nmq7sRP4t1E9Otb/4=; b=Kb3qdv
	IWUHvS/SlDL5pR0dVvf7eHbSKd3xGqSy1VWVWnq9dvuj1OA+JxiOwiQC7Wtjk2Ap
	NkFv886SQ0gA9A8pp1icSopLkR/E3h0SiEhVq2fulV6+WMHyQKL9crTjBg/Dfqwu
	dyngfy24qpTBoRWU4ACbeNj3S5gFN87DT5Q/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AiT78KztD5vAVhe0lwbNdn7Lis+AkHiI
	4QrZMLoY+XAFAtkItDbGYwYdXF+FRDeCH29UxGSR2UQLP0yY951czT2vXM+4HEwZ
	GMgalASMSXThIBesUs5oIuScRoU+ndcFvC2UoY+MKKZ8yUzYdA7RsOc7DwL9QV3x
	Nzhh8b+QIoQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7C5847948;
	Thu, 25 Feb 2016 15:27:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A20347946;
	Thu, 25 Feb 2016 15:27:16 -0500 (EST)
In-Reply-To: <1456431098.18017.52.camel@twopensource.com> (David Turner's
	message of "Thu, 25 Feb 2016 15:11:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2925B440-DBFE-11E5-B860-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287431>

David Turner <dturner@twopensource.com> writes:

> Is there some standard workflow here?  I just rebased your version of
> my series (bd412fa) on top of the prior commit in pu (9db66d9), fixing
> the few conflicts.  (I think there is in general something I'm missing
> about how to maintain a patch set under the git.git workflow).  

We usually do not see multiple large topics stomping on each other's
toes, so it would be fair to say that we are still learning to find
some standard workflow.  The topic overlaps with what Stefan's
submodule-parallel-update topic touches, and both topics are
constantly rerolled, so I've been doing:

 * Pick a commit on 'master' as a stable base, and do not change
   this unless absolutely necessary. 

 * Merge the tip of Stefan's series to it.

 * Apply your series on top (if you didn't rebase, but Stefan
   rerolled, this will be cherry-pick of your latest round).

to rebuild dt/refs-backend-lmdb topic every time either one of you
rerolled.
