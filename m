From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: branch: improve test rollback
Date: Thu, 31 Oct 2013 11:50:53 -0700
Message-ID: <xmqqsivh5l6a.fsf@gitster.dls.corp.google.com>
References: <1383211631-9244-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq1u3170l1.fsf@gitster.dls.corp.google.com>
	<CAMP44s01ABhU1tsqR+VKH6q6L+MNTDxHEgwfsCboxhP-euSmdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxKr-0005Ds-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab3JaSu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:50:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701Ab3JaSu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:50:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2948D4C4CF;
	Thu, 31 Oct 2013 14:50:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dnG+Bm7QLeP+RLNLzR2ul7P/Huc=; b=VVyTyn
	TSMPXKQMPk/nRqqNKf+MkkRmNodBWLxjDlhf8E3NGSdamm0v+waGZznYHUM4HQ7f
	j0H6ju7/JlrOQ7aJyX4KIQfrqJKUt+DNZjWPdrwZaf3lOBdx0KCInUzJrmpLO6xm
	OHSmtfPMlML2AOVN0VPNPdRJYneYvexTH4oxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EtLpjOwZ7Tx+OEKJYexfr5w5ugA9NCGy
	9v/pEhxqS6gNmBvG2DwtJ8yTmaZknFOZK3f6EeMfPx9c+JOb20bXjw0zR2InjutM
	+CoFd3bGRulXQfux3p5fb6qYcON4SPCmvo8ut9cQU4ZLHW6X/h0Ty90GGqjgYp4p
	5ls7pTa5ftg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 181604C4CD;
	Thu, 31 Oct 2013 14:50:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E8444C4CC;
	Thu, 31 Oct 2013 14:50:55 -0400 (EDT)
In-Reply-To: <CAMP44s01ABhU1tsqR+VKH6q6L+MNTDxHEgwfsCboxhP-euSmdA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 12:39:29 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5F9B4A90-425D-11E3-99FF-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237155>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Oct 31, 2013 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>>> index 0fe7647..33673e0 100755
>>> --- a/t/t3200-branch.sh
>>> +++ b/t/t3200-branch.sh
>>> @@ -329,7 +329,7 @@ test_expect_success 'tracking setup fails on non-matching refspec' '
>>>  '
>>>
>>>  test_expect_success 'test tracking setup via config' '
>>> -     git config branch.autosetupmerge true &&
>>> +     test_config branch.autosetupmerge true &&
>>>       git config remote.local.url . &&
>>>       git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
>>
>> And "remote.local.*" setting does not follow that "pristine"
>> principle, making the result of applying this patch inconsistent.
>> Is that desirable?
>
> This patch is *improving* test rollback, it's not making it perfect.
>
> Let not the perfect be the enemy of the good.

The patch is making it worse by stopping in the middle.
