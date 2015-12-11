From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 01/10] ref-filter: introduce a parsing function for each atom in valid_atom
Date: Fri, 11 Dec 2015 14:18:03 -0800
Message-ID: <xmqqio44eijo.fsf@gitster.mtv.corp.google.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRYEmbsye78ESOLfmSi56sBFeKpaEkpGSEwF=qrLZWx8g@mail.gmail.com>
	<CAOLa=ZTFeKMMSRCTWi9RkSvuCh7ZecPudSgsJB4TV76U4aGJJA@mail.gmail.com>
	<CAPig+cRcxr7uT2OJX=TnaVf+gXQdw9ydp+7X+Kis4Vb5+6RHiA@mail.gmail.com>
	<CAOLa=ZTHaety8=cxP4PqcXqrRv9OAEAcRyTs9drY6nSFGKvyOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 23:18:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7W16-0005Xq-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 23:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbbLKWSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 17:18:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752460AbbLKWSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 17:18:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 221D033DC2;
	Fri, 11 Dec 2015 17:18:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jZkRUmu9HzwAjqmC0hdPTQgkMCY=; b=NlM02B
	R+M3y7jBiU9JXnnE/jcjVBDzMZ9HS2BNBX2dL3kOy2EgqAr2PliQvhQ/yPnWEubF
	xAksAOjHRiFvuiRuSSN0z2UPMPfTIrlVwI7V++lCiMMZMFxeIHB6KOSSd1f4caGH
	E8uMSc0XaIGmhzVi88aAQqLlBV/wQsECP7/Hg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mc7TsPOWuOfQgYwThVq6ZaMpLpX5oD/K
	HcdzgCFDjl6b6ubt7du+qa2MpoYmjp2AgDNNCsh/DDbYp5tjcpC0c/aXQtegLK+4
	wfq0jDfP1UcSfXNG97+m5fAryel9SWqQF99D5AKWEezVEFq1RFIGsNP88MZccSg/
	8t9E6v8IsUI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19C1033DC1;
	Fri, 11 Dec 2015 17:18:15 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8272D33DC0;
	Fri, 11 Dec 2015 17:18:14 -0500 (EST)
In-Reply-To: <CAOLa=ZTHaety8=cxP4PqcXqrRv9OAEAcRyTs9drY6nSFGKvyOQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 26 Nov 2015 23:31:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 125F1A24-A055-11E5-97A6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282280>

Karthik Nayak <karthik.188@gmail.com> writes:

>> This problem will go away if you introduce the 'valid_atom' field in
>> the patch which actually needs it (as suggested above) rather than in
>> this patch.
>
> Yup, agreed.
> Thanks for your suggestions.

In addition, most of the lines in this patch should become
unnecessary even after you start using the "parser" field.

As the majority of fields are compared as strings, and only a
selected few fields need custom parsers, you do not have to
explicitly write FIELD_STR everywhere, as long as you make sure the
value of FIELD_STR is zero (and use parser==NULL as a sign that no
custom parser is used, which I think you already do).
