From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Mon, 22 Feb 2016 22:59:14 -0800
Message-ID: <xmqqegc33oal.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
	<1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
	<xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
	<87fuwnd4u7.fsf@freja.aidecoe.name>
	<xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
	<877fhwd1g0.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:59:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY6wM-0005yt-P9
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbcBWG7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 01:59:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757064AbcBWG7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 01:59:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87A6C3E0FA;
	Tue, 23 Feb 2016 01:59:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9H32FiLfaF6V
	E+gFiMrlJ2FFmz0=; b=D0LChMaRIFSofnxy+jtv56yRwOhfi/Qp17Zazua8P3qG
	7mRM/6KlFA7hIyc5B9yz0X/azXrr+Iqtbjo9VC5LhPaLax9RG4/xfciSScYNj+Af
	AnyXHTW5m4vD81+spqnszhhVP2SAiGHSgXG53tNPju3MRMdFH4OJ7xQ2lc+jPlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FeChDz
	wQvS6HMgczEiFFPJgYpKAyv5NiEnD2EqxdVr+zUdmXAhrnVqj+9JqbeXjmF8vkFm
	5fILWkMqBXOVnS75elMw8SQXxwABOGS74hy7EFfsK1SBA6eQl9qERunC/jOv50Cz
	KJbYwf4bHzfvctf5zYbMO2XN5o1D1wPSe7JcM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D2D43E0F9;
	Tue, 23 Feb 2016 01:59:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 03B483E0F8;
	Tue, 23 Feb 2016 01:59:15 -0500 (EST)
In-Reply-To: <877fhwd1g0.fsf@freja.aidecoe.name> ("Amadeusz =?utf-8?B?xbtv?=
 =?utf-8?B?xYJub3dza2kiJ3M=?=
	message of "Mon, 22 Feb 2016 18:50:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F3D10BBE-D9FA-11E5-954C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287027>

Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> I wonder if it makes sense to just silently allowing submit without
>> rebasing, and without telling the user how to clean it up.
>
> It is a good point. Maybe submit shouldn't be allowed by default at a=
ll
> From bare repository. What do you think about following approach?  If
> core.base is true, then if git-p4.submitFromBare is also true then
> submit without performing proper rebase, but update master ref from
> p4/master. If core.base is true, but git-p4.submitFromBare is false,
> abort immediately. Submitting from bare repository would require awar=
e
> decision from a user.

(I think you meant "bare" where you wrote "base" in the above).

As a non user of git-p4, the above sounds a safe and sensible
approach, but I'd like to hear from Luke, who has been active in
this area and is far more expert than I am ;-)

Thanks.
