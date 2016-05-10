From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is ORIG_HEAD allowed to point to a non-existing object?
Date: Tue, 10 May 2016 11:14:06 -0700
Message-ID: <xmqqinylpyq9.fsf@gitster.mtv.corp.google.com>
References: <CAENte7jNxM7J9bWUnrOkLQJZ=8JEtYzw9-uxVkq-CpvGyk9UUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 20:14:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0CAi-0002nu-5h
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 20:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbcEJSOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 14:14:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751063AbcEJSOK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 14:14:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA3951A61C;
	Tue, 10 May 2016 14:14:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2BwoUcMtQQZv224iJ8NO1M6OJkI=; b=ToAtpT
	ylUcOBaja/sOdOuQgnziUT9mCaxxdyl7lU0x0guvVW8OtkMxzLH4hPtrPSyyP7DM
	wcOm/StWKLMbx0ehprSBDRAiV4o9QzOySuT/P2SbU8XIDC2ZA2tugh1zH6OrL4AE
	F07ja8CbnLu0BjMfZ/twOKkJeozHZJHKsiRao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PofIR8Ux5StjlOWhMdhKBnP2Et8ecxxk
	IzibsZEGNosyYM8DzupBLYidkYFqXx8DEjEV+WmR4A3bgxnHNMRKILmU1bSvgSye
	aSkJgmL5zeMYN36jDSanfu2kU3gBMPs2XWQHP82mgD8RxBuVMQiGLRVdrlrMrTdS
	fl4+aDKUbGw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D23911A61B;
	Tue, 10 May 2016 14:14:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AE501A619;
	Tue, 10 May 2016 14:14:08 -0400 (EDT)
In-Reply-To: <CAENte7jNxM7J9bWUnrOkLQJZ=8JEtYzw9-uxVkq-CpvGyk9UUw@mail.gmail.com>
	(Christian Halstrick's message of "Tue, 10 May 2016 14:15:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FCDF767E-16DA-11E6-8963-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294169>

Christian Halstrick <christian.halstrick@gmail.com> writes:

> If I do a "git-rebase -i ..." followed by "git reflog expire ..." and
> "git gc ..." then I can end up with a repo which has a ref ORIG_HEAD
> which points to a non-existing object.
>
> - Is this intended?

Yes.

HEAD is a ref, but other things like MERGE_HEAD, ORIG_HEAD,
FETCH_HEAD are not considered as refs and they are intended to be
temporary.  This does mean that they will become invalid if you
prune objects that are only reachable from them, but your "reflog
expire && gc" falls into "if it hurts, don't do it".
