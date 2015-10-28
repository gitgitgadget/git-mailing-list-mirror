From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the ".git/gitdir" file?
Date: Wed, 28 Oct 2015 09:23:21 -0700
Message-ID: <xmqqwpu7klmu.fsf@gitster.mtv.corp.google.com>
References: <87a8r4ary9.fsf@kyleam.com>
	<xmqqpozzncs0.fsf@gitster.mtv.corp.google.com>
	<CANoM8SWDHyS1P=o1FwZUnE4OVUhhFS+-dFfgPQPE-zeHtGAp3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kyle Meyer <kyle@kyleam.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 17:23:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrTVd-0004Kg-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 17:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965995AbbJ1QXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 12:23:24 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965264AbbJ1QXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 12:23:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F01B524B99;
	Wed, 28 Oct 2015 12:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YArvCbsbWE9lHOYoS+HMTrmUvM=; b=VfiG64
	yslUUAg8EtFnkwj/vd+6e/+oeIuImSyAVVqJMFnBZFfeSvnClZa2Y9tvtUlVWlsZ
	H8kg9fOoLMDLFy4xmFi93OLBMOAWpZBF+3FW6W28RHjig4mAV4Vh0kYhgEAyEE4n
	P/AcPztAMZVCQB4LqLWTI50PN+BNpgZ/PLVgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yI3WLpNKaFLQ+v24ItoUo9JCWi9IgXf3
	k6CaqzXO/zFaPjQsM3xhLCU2vFNAt15VQ2pxDmR/IaIigY7Esh5lXPJsLP/TotpX
	Uouu19Ogmnljx6rmvnHSCIV9GzgZbjiKxR4RIb7fMmrjkCOdisJm9mrSMiJNNL05
	xecbqFp6Ap8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E840724B98;
	Wed, 28 Oct 2015 12:23:22 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 578D724B96;
	Wed, 28 Oct 2015 12:23:22 -0400 (EDT)
In-Reply-To: <CANoM8SWDHyS1P=o1FwZUnE4OVUhhFS+-dFfgPQPE-zeHtGAp3A@mail.gmail.com>
	(Mike Rappazzo's message of "Tue, 27 Oct 2015 19:26:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 351AF7FA-7D90-11E5-AC20-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280375>

Mike Rappazzo <rappazzo@gmail.com> writes:

> On Tue, Oct 27, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Kyle Meyer <kyle@kyleam.com> writes:
>>
>>> When a ".git" file points to another repo, a ".git/gitdir" file is
>>> created in that repo.
>>>
>>> For example, running
>>>
>>>     $ mkdir repo-a repo-b
>>>     $ cd repo-a
>>>     $ git init
>>>     $ cd ../repo-b
>>>     $ echo "gitdir: ../repo-a/.git" > .git
>>>     $ git status
>>>
>>> results in a file "repo-a/.git/gitdir" that contains
>>>
>>>     $ cat repo-a/.git/gitdir
>>>     .git
>>
>> Sounds like a bug in the recently added "worktree" stuff.  Perhaps
>> update_linked_gitdir() tweaked by 82fde87f (setup: update the right
>> file in multiple checkouts, 2015-08-25) is misbehaving?
>
> I noticed that as I was working on the worktree list command that my
> linked worktree gitdir files were being clobbered to '.git'.  I
> attributed it to my work, but now that you mention it, I think it has
> happened with the 2.6.1 release as well.

Thanks; I trust those who worked on the worktree feature in 2.6
timeframe would first take a look, OK?
