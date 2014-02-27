From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch: change install_branch_config() to use skip_prefix()
Date: Thu, 27 Feb 2014 14:17:29 -0800
Message-ID: <xmqqy50ww686.fsf@gitster.dls.corp.google.com>
References: <530F5B41.1050900@yandex.ru>
	<xmqq4n3kz6jb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:17:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9Gs-0005BN-K7
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaB0WRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:17:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaB0WRd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 17:17:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38CD47021F;
	Thu, 27 Feb 2014 17:17:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q7MetTjjS0iW/EtEN1wbV0wpbYE=; b=wbDZAE
	kHwntDWAANBISRaMEbfWrRiSQw41DbfQ5BIxh6u897DlFjENbNPGyJ3J6UqBHMzR
	VdSyWPEzNDbhBbUevWbdHC8W2QgOvEU5zMFqMMfSslA8AHSpJq7jDC85QvMSphtf
	YBNEyweUlmA2kSXPZaOPnjqYRScz69SRbcH8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ib4EjntSkZgjnp6VqaqRowZcPzRnyIWz
	s2v2cy4sKTpKS7AdD1S16+IvQxQ4ZrtARRF5EGgwGDhT1t3RBoHRa/+/Armlw0jK
	vzsT1W0t5xFBHCobZy69pLToxNOS7ruayTYDXkAF0fY1rhL9bP2RhWoQu/JERu9b
	Bg1+X4NMsIo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F010E7021E;
	Thu, 27 Feb 2014 17:17:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B27A7021D;
	Thu, 27 Feb 2014 17:17:32 -0500 (EST)
In-Reply-To: <xmqq4n3kz6jb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 27 Feb 2014 11:42:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3C948D2-9FFC-11E3-9C08-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242868>

Junio C Hamano <gitster@pobox.com> writes:

> "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru> writes:
>
>> Change install_branch_config() to use skip_prefix()
>> for getting the short name of the remote branch.
>>
>> Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
>> ---
>>  branch.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 723a36b..9382e02 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -49,8 +49,8 @@ static int should_setup_rebase(const char *origin)
>>  
>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>  {
>> -	const char *shortname = remote + 11;
>> -	int remote_is_branch = starts_with(remote, "refs/heads/");
>> +	const char *shortname = skip_prefix(remote, "refs/heads/");
>> +	int remote_is_branch = shortname != NULL;
>
> That sounds more reasonable, compared to the previous round.
> I'd probably say this
>
> 	int remote_is_branch = !shortname;
>
> instead, if I were doing this patch myself, though.

Heh, that is !!, not !.

>
>>  	struct strbuf key = STRBUF_INIT;
>>  	int rebasing = should_setup_rebase(origin);
