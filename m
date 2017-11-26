Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA59C20954
	for <e@80x24.org>; Sun, 26 Nov 2017 02:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdKZCcP (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 21:32:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63772 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751882AbdKZCcO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 21:32:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F141C6C61;
        Sat, 25 Nov 2017 21:32:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=13mc/mQbpapYhRwY4vXdUISwlAw=; b=MXA+Q1
        eprwBF9ni+pC3vGpQBRYSFUVC7yhEK/xOO5GAalE5gQnGIFZXQP6O35Tkj+rrpeP
        ++ioQEMK8dnbjPTJ0NU89R30y6BSibu/e/KpBs+CfnP4NxxGYhPoZ2d3pkMZBI88
        0vTF9Wm5/+/gjjq8Jv4bv2sd5YIWl7lJGUAzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gUmkYaS9X3TI2OyJ5kJSi6m3Rl1mgf6y
        X6xlfQVpCBUbZu43Q/oB/ABr90SwnCyKmNVnX03TM/4Dh3LtjpLwA+qHZGrCSblc
        /eyshIYpKE2kmxPePgWitWW7xevUCIdliSvbPyhaEODspkum5ssS6avLf7feMryz
        d1u3lXJql88=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D23C6C60;
        Sat, 25 Nov 2017 21:32:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B241C6C5F;
        Sat, 25 Nov 2017 21:32:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        David Turner <dturner@twitter.com>,
        David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
References: <20171124195901.2581-1-newren@gmail.com>
        <xmqqd147kpdm.fsf@gitster.mtv.corp.google.com>
        <CABPp-BGcfFOvv+-uW2_EaftLiU-xs_D4g8hsYOZqjk1XwK_8Fw@mail.gmail.com>
Date:   Sun, 26 Nov 2017 11:32:11 +0900
In-Reply-To: <CABPp-BGcfFOvv+-uW2_EaftLiU-xs_D4g8hsYOZqjk1XwK_8Fw@mail.gmail.com>
        (Elijah Newren's message of "Sat, 25 Nov 2017 14:35:46 -0800")
Message-ID: <xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 029FFA5A-D252-11E7-8441-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I had another email I had been composing to try to argue for changing
> merge-recursive.c's design to the above, assuming I could get the time
> to work on it.  Nice to see that I'm not crazy, and that I apparently
> don't need to do much convincing.  :-)

You might even be better off coming up with a *new* merge strategy
backend if you want to do this, without using much from the existing
code in merge-recursive.c at all (I've written off that code as
mostly unsalvageable long time ago, and thanked for whoever had a
clever idea to allow different strategy backend to be made without
disrupting the rest of the system).

After we gain more confidence with the rewrite, we can switch the
internally built-in backend used by different codepaths from
merge-recursive.c::merge_recursive() to the new thing.
