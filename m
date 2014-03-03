From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/11] Use ALLOC_GROW() instead of inline code
Date: Mon, 03 Mar 2014 11:07:12 -0800
Message-ID: <xmqqr46jp0db.fsf@gitster.dls.corp.google.com>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
	<CAPig+cQ-6h3JJr5uUu0J1_m+ENfFq2X4CusetPssQuJNB61zCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:08:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYDr-00039Y-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbaCCTHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:07:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754445AbaCCTHR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:07:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A6727029A;
	Mon,  3 Mar 2014 14:07:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AdGCoePljLQq3vg99Bi3WHnCAeM=; b=KEur+P
	jnpqgX1nNDPEz6V0KjnORG1gaK9EC7Jq4J5BMkh0RBL9wlsOAeeW+etZKyb9Uw29
	v7tlEUNph8P4W775w7hvuBUfkxaCkmmTq0PCDPi60F3/7cNf1CcdSpD0NGw8i24Y
	bU/28y9vRX982W3nZvrLPnUe7mDwbopdhzoHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x3QJJ8acqY5PNMOtCGFxFiqY+vEL4Xko
	G43THhkjXZeY2ehaTRY94uFiB6SsQEuwQMNfBT9yO/R7v2lYnX+ymCWgsAaNw2iS
	p7frKAsHE2HhtHHV0PCeYcrLQ6AeVGrCbZNxcx6rU9vOivAghAu2EfWKQ690lkx4
	Wq6LAcbRSnM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE87F70298;
	Mon,  3 Mar 2014 14:07:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCB5C70290;
	Mon,  3 Mar 2014 14:07:14 -0500 (EST)
In-Reply-To: <CAPig+cQ-6h3JJr5uUu0J1_m+ENfFq2X4CusetPssQuJNB61zCA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Mar 2014 03:23:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0822B428-A307-11E3-985D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243256>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 3, 2014 at 2:18 AM, Dmitry S. Dolzhenko
> <dmitrys.dolzhenko@yandex.ru> wrote:
>> Dmitry S. Dolzhenko (11):
>>   builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
>>   bundle.c: use ALLOC_GROW() in add_to_ref_list()
>>   cache-tree.c: use ALLOC_GROW() in find_subtree()
>>   commit.c: use ALLOC_GROW() in register_commit_graft()
>>   diff.c: use ALLOC_GROW()
>>   diffcore-rename.c: use ALLOC_GROW()
>>   patch-ids.c: use ALLOC_GROW() in add_commit()
>>   replace_object.c: use ALLOC_GROW() in register_replace_object()
>>   reflog-walk.c: use ALLOC_GROW()
>>   dir.c: use ALLOC_GROW() in create_simplify()
>>   attr.c: use ALLOC_GROW() in handle_attr_line()
>>
>>  attr.c                 |  7 +------
>>  builtin/pack-objects.c |  9 +++------
>>  bundle.c               |  6 +-----
>>  cache-tree.c           |  6 +-----
>>  commit.c               |  8 ++------
>>  diff.c                 | 12 ++----------
>>  diffcore-rename.c      | 12 ++----------
>>  dir.c                  |  5 +----
>>  patch-ids.c            |  5 +----
>>  reflog-walk.c          | 12 ++----------
>>  replace_object.c       |  8 ++------
>>  11 files changed, 18 insertions(+), 72 deletions(-)
>>
>> --
>> 1.8.5.3
>>
>> This version differs from previous only minor changes:
>>   - update commit messages
>>   - keep code lines within 80 columns
>
> Place this commentary at the top of the cover letter since that's
> where people look for it.
>
> You want to ease the reviewer's job as much as possible, so it helps
> to link to the previous submission, like this [1].
>
> Likewise, you can help the reviewer by being more specific about how
> you updated the commit messages (and perhaps by linking to the
> relevant discussion points, like this [2][3]).
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/242857
> [2]: http://article.gmane.org/gmane.comp.version-control.git/243004
> [3]: http://article.gmane.org/gmane.comp.version-control.git/243049

It would be helpful for people to also pay attention to what is
pushed out on 'pu' ;-)
