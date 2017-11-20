Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DF1202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 01:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbdKTBSC (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 20:18:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdKTBSB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 20:18:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37406B57AB;
        Sun, 19 Nov 2017 20:18:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SfTTINtiwn27YOfuIllWuFJB2S4=; b=fey5tl
        jaAz3OvYhF2Wnd6MBczGSYNAiOSPa4UZoJlNAUJ0isvVx7XOlJdH8Zi/rm46UMS3
        wFkUxDKbdu5ie8Qp1rdY4LdbtmPSEZWoSkX/HAkBxBzad6QkwWCntWfVNaTPjl0J
        6uW+3eCJAk679waVCfm53AlHx0tDwHflgt5xQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vWYFAD4mCHOJSC3Km5mVAa5DO5n8x/to
        PcYJ4E+Gh2XqQOWun13wSO8px/Os9t7jgrTg8HKfXn0YA0IUWUXRv62oICtzuCwv
        FdseZyLqpgW7KcZNLF5g4MAFjkuuGzBYS2RNa00hqiHzB1S7MbI6/IjEsHJ1ZK01
        Qg31xnPDqd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FCECB57A9;
        Sun, 19 Nov 2017 20:18:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0C17B57A5;
        Sun, 19 Nov 2017 20:17:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Michelbach <michelbach94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Documentation of post-receive hook
References: <1510872031.23230.7.camel@gmail.com>
        <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
        <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
        <1511112703.8109.5.camel@gmail.com>
Date:   Mon, 20 Nov 2017 10:17:58 +0900
In-Reply-To: <1511112703.8109.5.camel@gmail.com> (Christoph Michelbach's
        message of "Sun, 19 Nov 2017 18:31:43 +0100")
Message-ID: <xmqq1sktoiih.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5AE13B0-CD90-11E7-A661-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Michelbach <michelbach94@gmail.com> writes:

> On Fri, 2017-11-17 at 12:24 +0900, Junio C Hamano wrote:
>> So an updated suggestion for the text would be:
>> 
>>      This hook is invoked by 'git-receive-pack' on the remote repository,
>>      which happens when a 'git push' is done on a local repository.
>> 
>> Oh, wait.  That is what we already have ;-).
>
> But this text suggests that the hook is always invoked when a git push to that
> repo is done, which is not the case. How about adding "and updates are reference
> in the remote repository"?

Yeah, I think we are moving in the right direction.  Let's step back
a bit and try not to say "remote repository" twice.  

For that matter, I am not sure if local/remote is adding much value,
to be honest.  It has a certain value to clarify that the receive is
happening on the other end of the push (i.e. not in the repository
you push from), but we do not have to use local/remote for that---
and it is better to avoid 'local', that is relative: if you are in
the mindset of thinking about what happens during a receive, the
repository the receive-pack and the hook operates in is 'local' and
not 'remote' (it is only 'remote' if you think you are the one who
is pushing).

How about this rewrite?  Would it consider all the points raised and
make it easier to understand?

    This hook is invoked by 'git-receive-pack' when it reacts to
    'git push' and updates reference(s) in its repository.
