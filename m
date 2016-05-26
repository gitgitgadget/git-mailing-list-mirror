From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 26 May 2016 10:42:36 -0700
Message-ID: <xmqq8tywwwab.fsf@gitster.mtv.corp.google.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
	<20160522112019.26516-2-pclouds@gmail.com>
	<xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
	<574706A1.8040606@xiplink.com>
	<20160526162940.GB18210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 19:42:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5zJ1-000117-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbcEZRmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 13:42:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754556AbcEZRmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 13:42:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D647B1E784;
	Thu, 26 May 2016 13:42:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XSHheoMGCtnEnRplJHngf9JTiwQ=; b=pb6FVL
	cWKQJgAMlvUt4gn02YRcnmHRtZwm5p5CH7/c7PfhHdYmPRuwW68ObLU5YNXYu9Qh
	7yI8o1AIffl1TBy79sO/JSeSOGmh0/VSogdCJrziHwlK9WXEdHHELGeHxRv/kdXn
	OgW8uWW4HXAJKs0AtiFptu4whSJ1juVGAdgWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoRBiu1lIiEY4y0hG1RA5RZM7dEm6ocU
	dKyhDrD38q5j+vP0wCn1U6iz7jwPfKZ4mOKgKHbLvzD8M5aAINa1QOXFxYdL9rmR
	qfQaRYyMSw0CcvfcS/ncwNLcjfCgiCIh6exg0m4cXifDt0+P8LCxlCKlMUjjMnN9
	bGmPNitMn7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE00D1E783;
	Thu, 26 May 2016 13:42:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 422FB1E781;
	Thu, 26 May 2016 13:42:38 -0400 (EDT)
In-Reply-To: <20160526162940.GB18210@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 12:29:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CF89D90-2369-11E6-BBF3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295680>

Jeff King <peff@peff.net> writes:

> On Thu, May 26, 2016 at 10:22:25AM -0400, Marc Branchaud wrote:
>
>> Why do we need any kind of "->" at all?  How about simply (with an update to
>> "old-branch" for comparison to probably-more-common output):
>> 
>> From github.com:pclouds/git
>>    cafed0c..badfeed  pclouds/old-branch
>>  * [new branch]      pclouds/2nd-index
>>  * [new branch]      pclouds/3nd-index
>>  * [new branch]      pclouds/file-watcher
>
> That covers the common case of:
>
>   refs/heads/*:refs/remotes/pclouds/*
>
> but sometimes the remote and local names are not the same, and the
> mapping is interesting. Like:
>
>   $ git fetch origin refs/pull/*/head:refs/remotes/pr/*
>   ...
>    * [new ref]         refs/pull/77/head -> pr/77
>
> Or even:
>
>   $ git fetch origin refs/pull/77/head refs/pull/78/head
>   From ...
>    * branch            refs/pull/77/head -> FETCH_HEAD
>    * branch            refs/pull/78/head -> FETCH_HEAD
>
> So I think we need a scheme that can show the interesting mappings, but
> collapses to something simple for the common case.

True.  One of the entries in Marc's example is easily misread as
"pclouds/2nd-index branch at its refs/heads/pclouds/2nd-index was
fetched to its usual place", when Marc wanted to say "they had
2nd-index branch at refs/heads/2nd-index, and it was copied to our
refs/remotes/pclouds/2nd-index".

So even though we might be able to make sure it is unambiguous
without "this -> that" ("->" is pronounced as 'became'), it is
easily misread.
