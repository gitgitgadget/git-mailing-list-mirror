From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ancestor and descendant ~ clarification needed
Date: Fri, 23 Oct 2015 09:56:40 -0700
Message-ID: <xmqqsi51plpz.fsf@gitster.mtv.corp.google.com>
References: <CAAF+z6HEeFEYD9R+6Uz3ebRYNMpy5Gh0Fo9EjpaTYwSbqyDLgQ@mail.gmail.com>
	<xmqqfv12r6vn.fsf@gitster.mtv.corp.google.com>
	<CAAF+z6H+wwCOhPCU-_Uh-Odc=411N+G+d_iE_AKX+JxVMDtsMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Xue Fuqiao <xfq.free@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 18:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpfe5-0004sX-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 18:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbbJWQ4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 12:56:45 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752991AbbJWQ4n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 12:56:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B8CC23CC9;
	Fri, 23 Oct 2015 12:56:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mbhFoeN39K9kuTzzR9k90Al63uw=; b=R5stXI
	2jUlYPKPh4IpSM86QVfIPpMiQP5iokQrX+76wVv8CRTbbcKUQXE0ZOOFfyLfbOV6
	j6rW83tIa5l11K3lsdwnHXXrkBOq9nYXiSPKMJgLP5WqI8FcyUfxEpfNhMLE6GCH
	meKcHndLf8WLf/Xy4pQuk7Akbe9qxvuGEc7Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YtDxsfpBcJKcUL7zMOcpnWdWQnqB8hia
	yO3bvKtPZqhQjR+2g6ii5tbCibuFDLKRG6ITh/10KYshi7IAdt1xntHIE5TWJaIN
	vXOd9Y4KlFspIcxtzycHXkUSBq+UAWaRVxLKUslMV5FgmWJ3cGy6fVVpjXIL1EAk
	C8ms/ypnDd4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0361F23CC8;
	Fri, 23 Oct 2015 12:56:42 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7B07823CC7;
	Fri, 23 Oct 2015 12:56:41 -0400 (EDT)
In-Reply-To: <CAAF+z6H+wwCOhPCU-_Uh-Odc=411N+G+d_iE_AKX+JxVMDtsMQ@mail.gmail.com>
	(Xue Fuqiao's message of "Fri, 23 Oct 2015 15:29:05 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08953318-79A7-11E5-87BA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280098>

Xue Fuqiao <xfq.free@gmail.com> writes:

> Hi Junio,
>
> On Fri, Oct 23, 2015 at 4:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Yeah, that is the other way around.
>>
>>  (1) If the current branch is a descendant of the other--so every
>>      commit present in the other branch is already contained in the
>>      current branch--then merging the other branch into the current
>>      branch is a no-op "Already up-to-date!".
>>
>>  (2) If the current branch is an ancestor of the other--so every
>>      commit present in the current branch is already contained in
>>      the other branch--then merging the other branch into the
>>      current branch can be fast-forwarded, by moving the tip of the
>>      current branch to point at the commit at the tip of the other
>>      branch, and by default Git does so, instead of creating an
>>      unnecessary merge.
>
> I see.  Thank you.  What do you think about the following minor patch
> for user-manual.txt?

While the updated text is more correct than the original, I do not
know if that is sufficient, or we would also want to mention the
"Already up-to-date!" case here while at it.

> -However, if the current branch is a descendant of the other--so every
> -commit present in the one is already contained in the other--then Git
> -just performs a "fast-forward"; the head of the current branch is moved
> -forward to point at the head of the merged-in branch, without any new
> -commits being created.
> +However, if the current branch is an ancestor of the other--so every commit
> +present in the current branch is already contained in the other
> branch--then Git
> +just performs a "fast-forward"; the head of the current branch is moved forward
> +to point at the head of the merged-in branch, without any new commits being
> +created.
