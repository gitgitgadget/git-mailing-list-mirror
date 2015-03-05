From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reset: allow "-" short hand for previous commit
Date: Wed, 04 Mar 2015 16:34:00 -0800
Message-ID: <xmqq1tl4705j.fsf@gitster.dls.corp.google.com>
References: <1425415911-496-1-git-send-email-sudshekhar02@gmail.com>
	<vpq4mq13f69.fsf@anie.imag.fr>
	<xmqq1tl5acwu.fsf@gitster.dls.corp.google.com>
	<CAODo60qimjiMfWY_FNuOcVaYc=JdbTv_4SJ3BROC-9Jo5qWkdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:34:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJjt-0004Ph-MY
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 01:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbbCEAeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 19:34:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752373AbbCEAeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 19:34:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA2CE3DB8B;
	Wed,  4 Mar 2015 19:34:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ne88mpgXRJHDOVinf8ha7ANn0mY=; b=TxiHqG
	68rCEIebqGXjlK7LXan4tn8dzN9dEEcZBzblQ5towtoLVXOR9Sy1I7k0RHgofRsY
	Nmsp7g1T8/YI9qUW6Bb9j8dQuwo/sMK53qyLfrG9cgl9DKy8igB70UdT4QKG/Noh
	G1QqCtRkfEbg3cRfT1Yw3zXBToJRG1otZIhGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q7/jYpsSyPuPxbhkOR+/++hMRHCJXJkO
	IIArdU2iOdbOO+qoXMvgkWgYONj/X1xDgqCo+FP1FaDleKS27FYbIsnm9K+qtZBw
	JJRYCNHFszviVKao7mA1+h2J+RZZlavv9Wn4bDEQZ2yHkGNMh8woqvM1vFriFs0f
	jhEV3bnkp04=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C292E3DB88;
	Wed,  4 Mar 2015 19:34:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E1013DB84;
	Wed,  4 Mar 2015 19:34:02 -0500 (EST)
In-Reply-To: <CAODo60qimjiMfWY_FNuOcVaYc=JdbTv_4SJ3BROC-9Jo5qWkdA@mail.gmail.com>
	(Sudhanshu Shekhar's message of "Wed, 4 Mar 2015 12:37:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5255D76C-C2CF-11E4-B403-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264803>

Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:

>> What should worry us even more is what the user would get when @{-1}
>> does not resolve to something the command can use.  It would be bad
>> if we give an error message with @{-1} in it that the user never
>> typed (and may not even understand what it means).
>
> I apologize for having overlooked this use case. 

Thanking is fine, but there is no need to apologize in response to
review comments. We are imperfect humans and review exchanges are
designed to allow us cover points each of us missed in our
collective effort to make Git better.

> Another thing, can someone guide me regarding the right place to add a
> test case? Should it be t7102-reset.sh or some other file?

At the end of that file sounds like a reasonable choice.  You would
want to test various cases, such as (1) what happens when there is
no @{-1} at all (you would need a newly initialied test repository,
just like the last test in that file creates mixed_worktree
repository for its own use), (2) what happens when there is, split
into two , i.e. (1-a) @{-1} does not exist but there is a file whose
name is "-"; (1-b) @{-1} does not exist and there is no file whose
name is "-"; (2-a) @{-1} exists but there is a file whose name is
"-"; and (2-b) @{-1} exists and there is no file whose name is "-".

Do not just test (2-b) and declare victory---making sure that a
feature does not trigger when it should not is also important.

Thanks.
