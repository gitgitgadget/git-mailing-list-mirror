From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Don't free remote->name after fetch
Date: Tue, 14 Jun 2016 10:52:20 -0700
Message-ID: <xmqqh9cvaca3.fsf@gitster.mtv.corp.google.com>
References: <1465841837-31604-1-git-send-email-kmcguigan@twopensource.com>
	<xmqqbn34buak.fsf@gitster.mtv.corp.google.com>
	<CALnYDJO=_hfcQf+=+XuHQwmH4XewqHo4qggzB0rM79WVt+e6nQ@mail.gmail.com>
	<CALnYDJNS9QAtu37a76Q6N3C=GRbfgU8Xq3g7F1q7vX+b=rwOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Keith McGuigan <kmcguigan@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:52:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCsVo-0008CF-OR
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbcFNRwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:52:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752892AbcFNRwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 13:52:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6A6824D2C;
	Tue, 14 Jun 2016 13:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x9CKUwIEJGCXtCmNVeKKkcdU72c=; b=nA9grA
	gamVvqQUQnvj0w1hrkZh7MoamwdtdI1rKXJ/86lx/37qeV6f3G5PqFtJwxXJjKUe
	o7nO1PqT0hGUiW/WTSJckcJBOhNqh70e4U56SN5ao6LhQ2RYrzFKJ67wtPLLg+Km
	mxMSUDQ1Gs2BqqVjfTMoWlSAlmH4h/Kb5wQj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hxZEvBSGhVxbkjpGajQaGOvr3It+FkTi
	jX37/7GM5VcHDRJ0b4divQDCgmjweurcPXVup+Vve5TpgzKDHSSNFryPfLXila/+
	MNa4Dke+umGa1pAznNM2dpbMcpPND+opxZO44oNIpu1tGaSkJVAoq34B+IUHCYlc
	QilCgGRqUKw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEA5724D2A;
	Tue, 14 Jun 2016 13:52:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4904424D29;
	Tue, 14 Jun 2016 13:52:22 -0400 (EDT)
In-Reply-To: <CALnYDJNS9QAtu37a76Q6N3C=GRbfgU8Xq3g7F1q7vX+b=rwOOA@mail.gmail.com>
	(Keith McGuigan's message of "Mon, 13 Jun 2016 20:14:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BEED75AC-3258-11E6-BE57-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297313>

Keith McGuigan <kmcguigan@twopensource.com> writes:

> As an alternative, I could xstrdup each instance where remote->name is appended,
> which would make the string_list a homogenous dup'd list, which we
> could then free.

Yeah, I think that is the right way to fix it, even though I agree
with you that a small leak you introduced is probably better than
unwanted freeing we currently have.
