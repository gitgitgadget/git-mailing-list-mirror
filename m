From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/21] bisect: use a bottom-up traversal to find relevant weights
Date: Fri, 15 Apr 2016 15:49:57 -0700
Message-ID: <xmqqpotq7ai2.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-20-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:50:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arCYw-0008Ck-Nb
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbcDOWuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:50:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750722AbcDOWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:50:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E562712452;
	Fri, 15 Apr 2016 18:49:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xmVp97THyJbuZ0JNh83A7Aotfy8=; b=fjuEx1
	zfsB/tbr4LgyiV92bxNkS0y+FEdKUlhSuMZh/mVJCr9AUHsXTk/snUYZvn4oj/a4
	Y9ZEXKvcLQ16HnRmL0dWj1FdFEYQ9GL8TkGoVyvJeKm7V4LuUZPh5nTGjXaxdd5n
	3QBNdW4TZzc8Z5WadFBuFnbL+b7y6xyYC76sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFPQ+6HBNlygivUbVxaWaWfV2p/V9JeH
	aCjegcNHH9iCUSC2TYPvCmHjuCyKKYSQl/3RjX29K6xHAJ7Jdgic/jAGibCCeFm/
	V7dyE0TZipqry11FGru3L7VvLuBMC6kPcFLF/oKhdIM6Xd7wpZr3C84jw65sut2C
	8cFZ3vpfr9M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD17912451;
	Fri, 15 Apr 2016 18:49:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 583C712450;
	Fri, 15 Apr 2016 18:49:58 -0400 (EDT)
In-Reply-To: <1460294354-7031-20-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 612F4DDA-035C-11E6-B3D4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291689>

Stephan Beyer <s-beyer@gmx.net> writes:

> +static struct commit *extract_merge_to_queue(struct commit_list **merges)
> +{
> +	assert(merges);
> +
> +	struct commit_list *p, *q;
> +	struct commit *found;
> +

"gcc -Werror -Wdecl-after-statement" will barf at this.
