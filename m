From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit.c: Not add duplicate S-o-b when commit
Date: Thu, 26 Jul 2012 09:44:55 -0700
Message-ID: <7vpq7i8oag.fsf@alter.siamese.dyndns.org>
References: <ee08efceaa3f015732a19d49eb96bdeeaaf3d609.1343282283.git.worldhello.net@gmail.com> <7vy5m781j5.fsf@alter.siamese.dyndns.org> <CANYiYbH0Jfk0LLp8HXVEamD0uRzM2OGJCE8W4h_UoDLh1pMVHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 18:45:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuRBR-0006p2-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 18:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab2GZQo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 12:44:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137Ab2GZQo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 12:44:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30A827B40;
	Thu, 26 Jul 2012 12:44:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTIF5dubX/3vXqEamcv14toTkjA=; b=XBpy8q
	Vl5L53C7czOmVkKt2OUBAXWrzPuL41EXXZKQL1Kko84xdd3r/zC4gAYMR5Q+F3RE
	wi5/wZWtAI0yyGt+6feQVkO93bERbKn8mCPO35rmeL+Fjkxm1WQfKXpi4AA8yRyu
	sjMMaxAHq9FTcGCFEYuXSfPCrTFPipU0QmrhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pE5uIsked2MdbYiyoyAz+KoyRXSSCymd
	UqQgmZx2KSJn46ROEtv3lWRkTnd6E9kaHPpqcabsJXoJIDqpdAsa7riRjEJ559kp
	mevOKZ1CsdLF8FrQXm0W+hVwNqoMUL9AhmpIO1Gn0ZTZlWzpwuOJ4GIh7GFWA+wz
	Dx/+1VNJ1J8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E3277B3F;
	Thu, 26 Jul 2012 12:44:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 729C47B3E; Thu, 26 Jul 2012
 12:44:57 -0400 (EDT)
In-Reply-To: <CANYiYbH0Jfk0LLp8HXVEamD0uRzM2OGJCE8W4h_UoDLh1pMVHA@mail.gmail.com> (Jiang
 Xin's message of "Thu, 26 Jul 2012 15:15:24 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BD974A2-D741-11E1-BBB2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202276>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2012/7/26 Junio C Hamano <gitster@pobox.com>:
>> After stating the observation like the above, please make it a habit
>> to say "which is bad because...", if you think it is a bad behaviour
>> and the patch is about fixing it.
>
> Indead before I start, I examine git-commit and git-am, and find
> the behaviours of the two commands are different.
>
> "git commit -s" checks the last line of the footer, while "git -am"
> checks the last S-o-b.

I think "git am -s" (which I think you meant) is wrong, then.

> E.g. original commit X:
>
>     commit log...
>
>     Signed-off-by: A
>     Signed-off-by: B
>     Reported-by: C

The order in this "original" is already wrong, isn't it, though?
Didn't the change result by first C reporting an issue, fixes done
by A and forwarded by B?


> When user B amend the commit, the amended commit Y looks like:
>
>     commit log...
>
>     Signed-off-by: A
>     Signed-off-by: B
>     Reported-by: C
>     Signed-off-by: B
>
> While if the original commit X send to user B by patch, and
> user B run command "git am -s", the commit would be:
>
>     Signed-off-by: A
>     Signed-off-by: B
>     Reported-by: C
>
> So I guess duplicate S-o-b is not intentional.

I think the two commands are doing randomly different things on
garbage input.  The order in the input (i.e. your "original") does
not make sense.  C is not the person who handled the patch the last.

If you start from

	Reported-by: X
	S-o-b: A
	Reviewed-by: Y
        S-o-b: B

i.e. the last person who touched this patch is B, tweaking the patch
and amending a commit will add S-o-b for the person who amends, iff
that person is not B, which is what you usually want.

> I use an alias for commit:
>
>     git config --global alias.ci "commit -s"
>
> And will encounter duplicate S-o-b issues frequently, especially
> format-patch/send-email workflow.
