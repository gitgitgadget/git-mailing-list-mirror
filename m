Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5C120756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdARAV6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:21:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55594 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbdARAV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:21:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D75661A8E;
        Tue, 17 Jan 2017 19:15:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CYgFsDrvOr9pEdjq+Ql+jvDRJe4=; b=whBA5J
        uqIIE8gjK0WdqWpZ7YgHf7loqu0SpJeIceaNKardU8IVyC48UM2wY0QHuF4ZRokN
        mAs3vGy7Vx8Gm9+TwNU85NqJj8jBRZ/NpeiGfQ8BbPrxZ3aFL8FXtSAG5efdn6fe
        427jh5yeoiHJGeeRH/EUFqaH9PGMh7ViQZkNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mQJPphc2pQbUFYQQByAjDiLoYpgPsdQT
        glk8eGta6v6b0EBRUhYEwIDaOKmtvWmmARBXqwS7b2/fHRkjc/e+OCnQroZbwN3y
        +QWlQwJPLTITjnFFo+wVqPh98dKZ/omaUzCwLQVRW0GP1Xpmw7oChg0VbQ1a37t2
        nolMnPV88fM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F93261A8C;
        Tue, 17 Jan 2017 19:15:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B10D561A8B;
        Tue, 17 Jan 2017 19:15:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] transport submodules: correct error message
References: <20170113235427.5768-1-sbeller@google.com>
        <xmqq8tq9ckxo.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYu1Y2pwk9+kbSrMxwP3S0n8FMW6f4wdEE0mrACqrOPNA@mail.gmail.com>
Date:   Tue, 17 Jan 2017 16:15:09 -0800
In-Reply-To: <CAGZ79kYu1Y2pwk9+kbSrMxwP3S0n8FMW6f4wdEE0mrACqrOPNA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 17 Jan 2017 16:08:50 -0800")
Message-ID: <xmqqr341b4vm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CD1772A-DD13-11E6-A949-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jan 17, 2017 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Trying to push with --recurse-submodules=on-demand would run into
>>> the same problem. To fix this issue
>>>     1) specifically mention that we looked for branches on the remote.
>>
>> That makes an incorrect statement ("not found on any remote"---we
>> did not inspect all of the said remote, only heads and tags) into an
>> irrelevant statement ("not found on any remote branch"---the end
>> user would say "so what?  I know it exists there, it's just that not
>> all remote refs have corresponding tracking ref locally on our side").
>
> eh. So to be correct we need to tell the user we did not find any match on
> a "remote-tracking branch" as the gitglossary puts it.

I think the updated text is already "correct".  I am pointing out
that it may be correct but not very helpful to the users.

>> where remote tracking information is
>> incomplete if you only look at heads and refs, in the sense that we
>> no longer suggest ineffective workaround.
>
> s/ineffective/an effective/ ?

Even though I make many typoes, I meant ineffective in this case.
"The old message suggested workaround that would not help.  You no
longer give that workaround that does not work."

>> If that is the case, perhaps configuring push.recurseSubmodules to
>> turn this off (especially because you plan to turn the defaul to
>> "check") and not giving the command line option would give a more
>> pleasant end-user experience, I suspect.
>
> I though about going another way and adding another new value
> to the enum, such that
>
>     git push --recurse-submodules=sameRefSpecButNoCheck \
>         origin HEAD:refs/for/master
>
> works for Gerrit users.

It is unclear what that enum tells Git to do.  Care to explain?  How
is it different from "no"?
