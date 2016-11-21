Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0661FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 21:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbcKUVVu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 16:21:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64890 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753758AbcKUVVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 16:21:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34C5050A24;
        Mon, 21 Nov 2016 16:14:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A3bAjbOz4jCubvX0RDn7It8Bm4k=; b=AX7tTk
        xepE1LuYT2NIwgPRHo48lrkEY0KsdUuwaBK/B2/R1IKNTi89FZ+Noln33Ivdc+fS
        fMv+4xj4qQh1fiB0p0wvBD2tDhZiCZwF8UcJ3o3y+Rl0kRxxjMGBKHJfOLM5yyVd
        FXzDHiGx86wrlZYNzsTuD7Rln3JyZCfkHFgE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ttRJFDL8zIkGPGlZMw6JQGEc1HurGuRJ
        3QVoWbC2b9PokxyBgJ1KyJ8dpKscy8Fu6PP0uz40w85qD9zWQzL+CRuBUXLA9juM
        cwF7UNBfZJBBYFbV56xc+IwsBidWxhBx/J+bqkpORDOLWzM4ZxBa5qZSbtePdj8m
        oaSnWzP+dFo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B4E650A1C;
        Mon, 21 Nov 2016 16:14:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8A1650A1B;
        Mon, 21 Nov 2016 16:14:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, jrnieder@gmail.com, git@vger.kernel.org,
        Jens.Lehmann@web.de, hvoigt@hvoigt.net
Subject: Re: [PATCH 3/3] submodule--helper: add intern-git-dir function
References: <20161121204146.13665-1-sbeller@google.com>
        <20161121204146.13665-4-sbeller@google.com>
Date:   Mon, 21 Nov 2016 13:14:46 -0800
In-Reply-To: <20161121204146.13665-4-sbeller@google.com> (Stefan Beller's
        message of "Mon, 21 Nov 2016 12:41:46 -0800")
Message-ID: <xmqqy40ch6wp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8846F7A8-B02F-11E6-9941-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +interngitdirs::
> +	Move the git directory of submodules into its superprojects
> +	`$GIT_DIR/modules` path and then connect the git directory and
> +	its working directory by setting the `core.worktree` and adding
> +	a .git file pointing to the git directory interned into the
> +	superproject.
> ++
> +	A repository that was cloned independently and later added
> +	as a submodule or old setups have the submodules git directory
> +	inside the submodule instead of the
> ++
> +	This command is recursive by default.

Does this format correctly?

I somehow thought that second and subsequent paragraphs continued
with "+" want no indentation before them.  See for example the
Values section in config.txt and see how entries for boolean:: and
color:: use multiple '+' paragraphs.

If we do not have to refrain from indenting the second and
subsequent paragraphs, that would be great for readability, but I
take the existing practice as telling me that we cannot do that X-<.

> +test_expect_success 'setup a gitlink with missing .gitmodules entry' '
> +	git init sub2 &&
> +	test_commit -C sub2 first &&
> +	git add sub2 &&
> +	git commit -m superproject
> +'
> +
> +test_expect_success 'intern the git dir fails for incomplete submodules' '
> +	test_must_fail git submodule interngitdirs &&
> +	# check that we did not break the repository:
> +	git status
> +'

It is not clear what the last "git status" wants to test.  In the
extreme, if the failed "git submodule" command did

	rm -fr .git ?* && git init

wouldn't "git status" still succeed?  

What are the minimum things that we expect from "did not break" to
see?  sub2/.git is still a directory and is a valid repository?  The
contents of the .git/modules/* before and after the "git submodule"
does not change?  Some other things?
