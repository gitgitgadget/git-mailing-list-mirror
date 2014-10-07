From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: mutually match SYNOPSIS and "usage".
Date: Tue, 07 Oct 2014 14:31:31 -0700
Message-ID: <xmqq1tqjefd8.fsf@gitster.dls.corp.google.com>
References: <87wq8cnla9.fsf@osv.gnss.ru>
	<xmqq4mvfg24e.fsf@gitster.dls.corp.google.com>
	<87bnpnsjrw.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 23:31:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbcM6-0003oc-CG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 23:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbaJGVbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 17:31:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65283 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752858AbaJGVbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 17:31:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 226FD149F2;
	Tue,  7 Oct 2014 17:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fDAZf0Udq2XeMPIsWpZp/NtjXkg=; b=sHzADl
	N5N8OnBWu2Km8awhsaaFZ9mnSwZfvc9J+W5hAhxw8Tfr5cfgc8gLRuncmEvWaSbL
	hEtGvmBisIZTryQxWzwfR6qwZUOjUV1m6bFOioBELhvmkOv1wTcUR3iyuD8vWKgt
	Pls631obxSTSdU/6CAUS5F1ikFU3cFWZWaTwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RIXTi3e5pyafnJI1QWGDmfJ+DXJcyezQ
	5+UGBz3bp7+KTsT0cJMTRumDaWSv2arfwHYyoN1S+mZey1APE5jGhJAWw+397Ttt
	uY21R9G5buuEFET6AurWedQSRIQbRdm7QTxZjP6+Ed30sClJ19Z7euineLdoQlHp
	s4uDdz7u8PA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18760149F1;
	Tue,  7 Oct 2014 17:31:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 959FD149EF;
	Tue,  7 Oct 2014 17:31:32 -0400 (EDT)
In-Reply-To: <87bnpnsjrw.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
	08 Oct 2014 00:32:35 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4EA9B30C-4E69-11E4-935B-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
> I was looking at the merge.c code, and that's how it seems to work. You
> can get new semantics without -m, and you can't get old semantics with
> -m, isn't it? It looks like the set of descriptions I produced is
> formally correct.

The thing is, with "-m <msg>" we will never fall into the
traditional syntax, hence "git merge -m <msg> <msg> HEAD <commit>"
appear to be allowed with "git merge [options] <msg> HEAD
<commit>...", but it is not.

And the inverse is not true (an obvious example is "git merge
$branch", even though it does not have "-m <msg>" it uses the modern
& common.

So the updated SYNOPSIS is not really helping.

>> In other words, I agree with your motivation to call for attention
>> that the command behaves differently with and without "-m", but I do
>> not think that part of the change in this patch achieves it well.
>
> Any particular suggestion?

I was going to suggest "explain how the traditional syntax is
triggered in the DESCRIPTION section", but it turns out that we
already do that.

      The second syntax (<msg> HEAD <commit>...) is supported for
      historical reasons. Do not use it from the command line or in
      new scripts. It is the same as git merge -m <msg> <commit>....

Strictly speaking, I think it is not qute "the same"---I recall
vaguely that it broke tests if you replace the traditional-style
invocation in 'git pull' with the -m <msg> syntax, but I do not have
details handy; you may want to try it out if you are interested.

So I would think

	SYNOPSIS
        	git merge [options] <commit>...
		git merge [options] <msg> HEAD <commit>...
                git merge --abort

should be sufficient, possibly with some clarification on "The
second syntax" paragraph in the DESCRIPTION section.
