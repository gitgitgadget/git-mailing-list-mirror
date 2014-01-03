From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] completion: fix branch.autosetup(merge|rebase)
Date: Fri, 03 Jan 2014 09:32:56 -0800
Message-ID: <xmqq1u0pnf7b.fsf@gitster.dls.corp.google.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
	<1388415138-11011-4-git-send-email-artagnon@gmail.com>
	<xmqqa9fendj3.fsf@gitster.dls.corp.google.com>
	<CALkWK0=tL4K7UHDBp_jGz5zUaHE9m=OESo2=2a0fUZwXB4auGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 18:33:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz8cN-0001gq-5l
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 18:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbaACRdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 12:33:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbaACRdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 12:33:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31EC15C423;
	Fri,  3 Jan 2014 12:33:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PumRdwlyHXB1QTgvDyallHEzw4Q=; b=hzD0H3
	ikwnzCn78O+i6IncnFnb3+5ap+ozWOS1u9t1A9bd5TpIjCN1fV68TBoBnrDy6qZa
	vBVwmdHKmD9fG/nXd+I9hT2Zzc0LqNX3/l8CoYvwRfzfHY/PgQw64fNETWnAGqVX
	0PPoin+Dtl0cet3zhuAQrumpzs5HG7Hm3BSUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ec4Gx8FAjwRbB+WHc/H9AHUVlTo7hqQh
	BjfqUjSuDiEu1//m1IOaL8hJCXiKJdOtG3K/cQnFBw0RyMuB4NqCYdwE2zrbqfRH
	BrHUp+G6IUm6bQACrVWyfc+W7su6ks9gUd5FlX5phF2GZJyAT4caK1MVvVAd6mxm
	tT3J/8s7HjM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2775C422;
	Fri,  3 Jan 2014 12:33:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 679705C421;
	Fri,  3 Jan 2014 12:32:59 -0500 (EST)
In-Reply-To: <CALkWK0=tL4K7UHDBp_jGz5zUaHE9m=OESo2=2a0fUZwXB4auGg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 3 Jan 2014 13:06:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 16E93A56-749D-11E3-8AAE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239917>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> If we are looking at "branch.autosetupmerge." followed by something,
>> who typed that final dot?
>
> I admit that it's a very unlikely case. The user did:
>
>   $ branch.autosetupmer<TAB>
>
> hit backspace to delete the trailing space, inserted a dot, and hit <TAB> again.
>
>> If you are working on a topic about
>> auto-setup-merge and named your branch "autosetupmerge", don't you
>> want to be able to configure various aspect of that branch via
>> branch.autosetupmerge.{remote,merge} etc., just like you can do so
>> for your "topic" branch via branch.topic.{remote,merge} etc.,
>> regardless of your use of "autosetupmerge" option across branches?
>
> My reasoning was that being correct was more important that being
> complete. So, if by some horrible chance, the user names her branch
> "autosetupmerge", we don't aid her in completions.
>
>> Besides, it smells fishy to me that you need to enumerate and
>> special case these two here, and then you have to repeat them below
>> in a separate case arm.
>
> I'm not too irked about correctness in this odd case; seeing that you
> aren't either, I'll resubmit the series without this hunk (+ the hunk
> in remote.pushdefault).

You seem to be calling it "incorrect" to give the same degree of
completion for a branch the user named "autosetupmerge" as another
branch "topic", but I think it is incorrect not to, so I cannot tell
if we are agreeing or disagreeing.

Puzzled...
