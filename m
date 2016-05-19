From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Thu, 19 May 2016 14:05:33 -0700
Message-ID: <xmqqshxdhi76.fsf@gitster.mtv.corp.google.com>
References: <20160519010935.27856-1-sbeller@google.com>
	<xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 19 23:05:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3V8Y-0006EQ-U8
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbcESVFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 17:05:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932710AbcESVFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:05:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F4E51D1D3;
	Thu, 19 May 2016 17:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VY8qCD3yEvvJiF14aTNpq2vkA3g=; b=Y4zvPL
	bKzZ7mtKVbkAx7kwF54DKi+AzuhQntXZEjebtTg4/F13s6ruWVzwLgqvj0etkdc9
	E0OUQtPh0VqlVm8tMsr4Jfe2B76DKsJNc5JRA8vS8zxN5rYeSizedQASrBczoC8n
	CvUfxjEDUQboZT7e9XSohSy0a3QYC6LxO15KA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=obqyAtRxT+01Adr5/f7SUPJERy9BN19v
	Zl5xI6DMwWIFha7DTJmw6q5249Ex70HGgPJ9FcJYPSUGg8EQWJdP0lsK06Z4RiVO
	hh07w9puXuTMTETBTvojk6dzT16WxQVaDZqECiN3OQfhIuCV3R3X3JYfM+bACeE5
	+KQfdcMYJpA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3691B1D1D1;
	Thu, 19 May 2016 17:05:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A39F91D1CC;
	Thu, 19 May 2016 17:05:35 -0400 (EDT)
In-Reply-To: <CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 19 May 2016 14:00:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E5FFEE6-1E05-11E6-BF9D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295102>

Stefan Beller <sbeller@google.com> writes:

> (B) requires some thought though. Here is my vision:
>
>     1) Allow pathspecs for sparse checkout.
>
>       I wonder if we just add support for that in .git/info-sparse-checkout
>       or if we add a new file that is for pathspecs only, or we have a config
>       option whether sparse-checkout follows pathspecs or gitignore patterns
>
>     2) Teach `git clone` a new option `--sparse-checkout <pathspec>`
>       When that option is set the pathspec is written into the new file from
>       (1) and core.sparsecheckout is set to true
>
>     3) Advertise to do a `git clone --sparse-checkout
> :(attr:default_submodules)`
>
> Going this way we would help making submodules not different but integrate more
> into other concepts of Git. As a downside this would require touching
> sparse checkout which may be more time consuming than just adding a
> `git clone --init-submodules-by-label` which stores the labels and only upddates
> those submodules.
>
> Or are there other ideas how to go from here?

My take is to pretend sparse checkout does not exist at all and then
go from there ;-)  It is a poorly designed and implemented "concept"
that we do not want to spread around.

You were going to add defaultGroup and teach 'clone' (and other
commands) about it, and have clone find submodules in that Group,
right?  Isn't the pathspec magic just another way to introduce
how you express the "defaultGroup", i.e. not with the "label" thing
in .gitmodules, but with pathspec elements with attribute magic?
