Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2351F600
	for <e@80x24.org>; Sun, 23 Jul 2017 22:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbdGWWJ5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 18:09:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64946 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbdGWWJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 18:09:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D947C8BDE8;
        Sun, 23 Jul 2017 18:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BQALsS22Wjaz9hu7SsaPtDcrq0Q=; b=mnYTKH
        nbuC3IAmuAGpGlK1KVxi/GUg0bNom7EYGvf0SyI0omSGEgF2NFqeJEc6t+1Adb7j
        pKyyb+Dn/dfd7rIQxohsClbge688chDMwpotyMmTf8cUf7PnB7rOoklSqpIq9Tb+
        mu8aFIWd8bgA2GHQdoscZs5Zy2bpH8WNgmBnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xaApD2fZV6IerB7V66mfTj+0b/Z+1y4R
        KWc1kzmpO75n21yWGIkIcNkdcOOEnBqkRSZKMWgxUY+kNfIL0Y0ezXsJ0f0jCYw+
        +b4D+q5OkEW8C0eew9Gxy8p/lWOiy8OZzJTKjmuAyyC6QDWSC7i7ayotQkrHssDW
        enFOR6xj7LM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D282A8BDE7;
        Sun, 23 Jul 2017 18:09:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 450CE8BDE6;
        Sun, 23 Jul 2017 18:09:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Remove help advice text from git editors for interactive rebase and reword
References: <241D60E0-1687-4DD8-A18C-CF7310DBFAEB@jetbrains.com>
Date:   Sun, 23 Jul 2017 15:09:54 -0700
In-Reply-To: <241D60E0-1687-4DD8-A18C-CF7310DBFAEB@jetbrains.com> (Kirill
        Likhodedov's message of "Sun, 23 Jul 2017 13:03:49 +0300")
Message-ID: <xmqqshhmerf1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A88287C4-6FF3-11E7-8567-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Likhodedov <kirill.likhodedov@jetbrains.com> writes:

> My motivation is the following: I'm improving the Git client
> inside of IntelliJ IDEA IDE and I would like to provide only the
> plain commit message text to the user (any hints can be shown
> separately, not inside the editor).

Who is running "git commit --amend" and "git rebase -i" in the
workflow of a user of your tool?  Is it the end user who types these
commands to the shell command prompt, or does your tool formulate
the command line and does an equivalent of system(3) to run it?

I am assuming that the answer is the latter in my response.

> If there is no way to do it now, do you think it makes sense to
> provide a configuration variable for this, e.g. to introduce more
> advice.* config variables in addition to existing ones?

Not at all interested, as that would mean your tool will tell its
users to set such a configuration variable and their interactive use
of Git outside your tool will behave differently from other people
who use vanilla Git, and they will complain to us.

But I do not think adding a new command line option that only is
passed by a tool like yours when it runs "git rebase -i" via
system(3) equivalent would introduce such an issue, so that may be
workable.

But stepping back a bit, as you said in the parentheses, your tool
would need to grab these "hints" from Git, instead of having a
separate hardcoded hints that will go stale while the underlying Git
command improves, to be able to show them "separately".  Which means
to me that you would need to get the output Git would normally show
to the end user and do your own splitting and parsing anyway.  Which
in turn would mean that a configuration or a command line option to
squelch these, which would rob your tool the ability to read what
Git would have told to your users, would be a bad idea and not a
useful addition to the overall system.  So...


