From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/11] Use ALLOC_GROW() instead of inline code
Date: Mon, 03 Mar 2014 10:20:57 -0800
Message-ID: <xmqqa9d7rvna.fsf@gitster.dls.corp.google.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
	<53109F78.2060203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:21:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXUJ-0004Ac-Sl
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbaCCSVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:21:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbaCCSVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:21:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1337670CCA;
	Mon,  3 Mar 2014 13:21:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cy1u1zJkVMsVNThOwoz1RSI2Omk=; b=udfPAU
	a/WdajGJ1Bw+UA1Rq6ARMu6Cf6qDE9+5xYh9N+5Q62tCN2aCINkEC3Wq3k5o83pr
	4+3W3C434PCkYNd2lLDy2Jpboh9GnQw83a4gKyl4MUPNDjtw1KjWcLsLVGzcv9sD
	bYPFV10ym2l/PUXKt1xB0NiSyntw8A4cR0imc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZr8KXSKYGAPUR1zXkKnG6SUd1ceUGoc
	+qyjU7fNcVbD5i5E29CgoWrDd0uEQkluUA5y+wSnz6ssaqslgZuyTbF08F985z6B
	rodR1fdCAfnHVWbSgpykA4+CROMIvRHXLmc6hX+HsZ8YI3NpZNPqQP8eIEHUCTsD
	fkZJ+t7z9io=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E00E270CC9;
	Mon,  3 Mar 2014 13:20:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A31E870CC7;
	Mon,  3 Mar 2014 13:20:58 -0500 (EST)
In-Reply-To: <53109F78.2060203@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 28 Feb 2014 15:38:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 917247EA-A300-11E3-82DC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243244>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/28/2014 10:29 AM, Dmitry S. Dolzhenko wrote:
>> Thank you for your remarks. In this patch I tried to take them into account.
>> 
>> Dmitry S. Dolzhenko (11):
>>   builtin/pack-objects.c: change check_pbase_path() to use ALLOC_GROW()
>>   bundle.c: change add_to_ref_list() to use ALLOC_GROW()
>>   cache-tree.c: change find_subtree() to use ALLOC_GROW()
>>   commit.c: change register_commit_graft() to use ALLOC_GROW()
>>   diff.c: use ALLOC_GROW() instead of inline code
>>   diffcore-rename.c: use ALLOC_GROW() instead of inline code
>>   patch-ids.c: change add_commit() to use ALLOC_GROW()
>>   replace_object.c: change register_replace_object() to use ALLOC_GROW()
>>   reflog-walk.c: use ALLOC_GROW() instead of inline code
>>   dir.c: change create_simplify() to use ALLOC_GROW()
>>   attr.c: change handle_attr_line() to use ALLOC_GROW()
>> 
>>  attr.c                 |  7 +------
>>  builtin/pack-objects.c |  7 +------
>>  bundle.c               |  6 +-----
>>  cache-tree.c           |  6 +-----
>>  commit.c               |  8 ++------
>>  diff.c                 | 12 ++----------
>>  diffcore-rename.c      | 12 ++----------
>>  dir.c                  |  5 +----
>>  patch-ids.c            |  5 +----
>>  reflog-walk.c          | 13 +++----------
>>  replace_object.c       |  8 ++------
>>  11 files changed, 17 insertions(+), 72 deletions(-)
>
> Everything looks fine to me.  Assuming the test suite ran 100%,
>
> Acked-by: Michael Haggerty <mhagger@alum.mit.edu>

Looked good (modulo titles, which I think we already discussed),
and queued on 'pu'.

Thanks.
