From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Tue, 16 Feb 2016 13:54:48 -0800
Message-ID: <xmqqa8n0mic7.fsf@gitster.mtv.corp.google.com>
References: <72756249.nAoBccgOj7@thunderbird>
	<1455590305-30923-1-git-send-email-ischis2@cox.net>
	<C8BDC3289C184F40BFBE3B150CFBB50B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Stephen P. Smith" <ischis2@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Ovidiu Gheorghioiu" <ovidiug@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 22:54:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVnaB-0006Dg-LK
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 22:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcBPVyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 16:54:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756010AbcBPVyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 16:54:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 494B04413F;
	Tue, 16 Feb 2016 16:54:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pWjxo49kiUpS+JZbQ4RPymb/tV4=; b=Rbmvlb
	hQlzfOAPQJD4ZZ1J/hGlZ0SXVzYJ9B9vj/QiSUQlLAKWKFLUnhM2v86rvuCFSKbH
	etorO6C94AY5EvBh8RCS7IPUB8Y9Iu2WeJ76xKUImFFjOmX+w3MztSbbTxRHMPJd
	+lCV+AlDH2gS/5AAHxdxSIUxihULRmmpve28o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HbohSDz/HYwf6TCBw+96nvxp6KKLMRVm
	rr9zZXeVf+rN5xPEtdtP094HiLIA/4HoIK8u+aimqVnEPEifAJrH96u4qQle+N8H
	hWlhguRnlOqq4ugUKvKYeAA/0HGrOaGA8iO8jrBGVY51gUTUjVZmqcZvf7dBfIHy
	uymBT9bNCa8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 406684413E;
	Tue, 16 Feb 2016 16:54:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A9C964413C;
	Tue, 16 Feb 2016 16:54:49 -0500 (EST)
In-Reply-To: <C8BDC3289C184F40BFBE3B150CFBB50B@PhilipOakley> (Philip Oakley's
	message of "Tue, 16 Feb 2016 08:20:43 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6B181BE-D4F7-11E5-A58A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286438>

"Philip Oakley" <philipoakley@iee.org> writes:

>>    It appeared that the conditional for 'Reject an attempt to record a
>>    non-merge empty commit without * explicit --allow-empty.' could be
>>    simplified after adding this patch.
>>
>>    This change can't be propagated to the conditional because it allows
>>    a commit that was previously disallowed.

This last sentence sounds somewhat worrysome.  Does that mean some
commit that was previously disallowed (which ones?) is still
forbidden by "commit" without "--dry-run" (which is correct--we are
not interested in changing the behaviour of the main codepath), but
"--dry-run", even with this update, will say "OK you will make a
meaningful commit" by exiting with 0 for such disallowed commit?
