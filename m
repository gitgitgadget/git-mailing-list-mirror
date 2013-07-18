From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Thu, 18 Jul 2013 10:46:37 -0700
Message-ID: <7v4nbr4v7m.fsf@alter.siamese.dyndns.org>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
	<878v16kfqy.fsf@linux-k42r.v.cablecom.net>
	<7v38rd6l3j.fsf@alter.siamese.dyndns.org> <51E7E05E.4000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	"Dale R. Worley" <worley@alum.mit.edu>, git@vger.kernel.org,
	Jonas Fonseca <fonseca@diku.dk>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 19:46:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsHs-00053i-8B
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759245Ab3GRRqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:46:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759037Ab3GRRqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:46:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E6A32E9F;
	Thu, 18 Jul 2013 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWncCjEpqdSamucdML1k7xQXz5w=; b=GYXoXR
	Ee0FJsQLvxtadc+mJ/drwr9hyIq4CCneoqJEazSvIRuYdZ1SyA2yyQcpdVATv+ml
	OVLNhwhjVPiRWrOCxI++sF0qsmgyUg+PdIxhmjudMq0d+lluUw4H7MfKBUh6ckEn
	oztEXXEvgD6hkL03odh+yMU71jxqvHVbkbU0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FnaXy3Ay4KMRK8S5bFt3HSz1eclgv24Q
	L9QUnv3RzHRneJXVF1d7QSL7mYj7tpt9E5nUunZqCzCeLROLym+v2IuLcf813F7h
	4Et19wvVxhhHr8ubCi90HPmgb0w1pWrGpvSpPwCU7HCcGMJ875BAN3aHhHt7j/kc
	UKcDUnozfFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3682732E9D;
	Thu, 18 Jul 2013 17:46:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8026132E9B;
	Thu, 18 Jul 2013 17:46:38 +0000 (UTC)
In-Reply-To: <51E7E05E.4000201@gmail.com> (Drew Northup's message of "Thu, 18
	Jul 2013 08:32:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF531132-EFD1-11E2-AA25-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230714>

Drew Northup <n1xim.email@gmail.com> writes:

> I presume that I should apply this change to my porting of
> git_mkstemps_mode() to tig. If there are no complaints about this for
> a couple of days I will do so.

Hmph, Thomas and I were actually asking you to give us

	Signed-off-by: Drew Northup <n1xim.email@gmail.com>

for the patch in question.  If tig has the same issue, applying that
same patch there may make sense, but that is an independent issue.

Thanks.

>
> REF: $gmane/229961
>
> On 07/17/2013 03:29 PM, Junio C Hamano wrote:
>> Thomas Rast<trast@inf.ethz.ch>  writes:
>>> Thomas Rast<trast@inf.ethz.ch>  writes:
>>>> From: "Dale R. Worley"<worley@alum.mit.edu>
>>>>
>>>> open() returns -1 on failure, and indeed 0 is a possible success value
>>>> if the user closed stdin in our process.  Fix the test.
>>>>
>>>> Signed-off-by: Thomas Rast<trast@inf.ethz.ch>
>
>>>>   wrapper.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/wrapper.c b/wrapper.c
>>>> index dd7ecbb..6a015de 100644
>>>> --- a/wrapper.c
>>>> +++ b/wrapper.c
>>>> @@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>>>>   		template[5] = letters[v % num_letters]; v /= num_letters;
>>>>
>>>>   		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>>>> -		if (fd>  0)
>>>> +		if (fd>= 0)
>>>>   			return fd;
>>>>   		/*
>>>>   		 * Fatal error (EPERM, ENOSPC etc).
>
>
> --
> -Drew Northup
> --------------------------------------------------------------
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
