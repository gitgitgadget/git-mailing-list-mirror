From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Tue, 12 Apr 2016 14:05:33 -0700
Message-ID: <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
	<1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
	<xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 23:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq5VJ-0003MA-G8
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 23:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934251AbcDLVFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 17:05:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933172AbcDLVFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 17:05:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 284E255B0D;
	Tue, 12 Apr 2016 17:05:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LweEdB4BKopGNZDec5TilMe5xQ8=; b=SLkT4G
	ZD8+y4+nsJ7h8tWeb1ReDEu0F59fIC+1RUU79Jxmtv0TBWxVPK8Gng9YG/UgV8N9
	Qwkd8+xRoF/WuD9EqffhGGeGhbnT3aEMB9w2U7H2JPg7zyLBsZViXE+CT7n9t56w
	UMsxdT+QIwBeigGW4yY9eN0oHF7mO3UOUFSt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bGW2C1gV6IFw6rtZza1Ug2WHCA6/PMGB
	jyEeNqCd+gLnnHbuIQYPuVqIoMs60m1oGa1zerDk+5xQ0HjCmW7kI64ssR2IMquV
	7PyMRHFE/7SMNI+ip0jiuFZsGTGdtzPgTk69NxaFbqpZ2HhKXFNHxGaP4c2TRroI
	IqMjUQkKSfI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F81555B0C;
	Tue, 12 Apr 2016 17:05:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E15355B0A;
	Tue, 12 Apr 2016 17:05:34 -0400 (EDT)
In-Reply-To: <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 12 Apr 2016 13:40:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C7AFAE0-00F2-11E6-8C2C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291295>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
>> +			    remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
>> +	} else {
>> +		strbuf_addf(&local, "%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
>> +			    branch_get_color(BRANCH_COLOR_RESET));
>> +		strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
>> +			    branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
>
> The overlong lines are somewhat irritating, but the change above in
> this round relative to the previous one shows a good use case for
> the conditional formatting feature and illustrates how powerful the
> concept it is.  I like it.
>
> Thanks, will queue.

Having said that, doesn't this need to be further adjusted for
95c38fb0 (branch: fix shortening of non-remote symrefs, 2016-04-03)?

http://thread.gmane.org/gmane.comp.version-control.git/290622/focus=290624
