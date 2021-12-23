Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82673C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 00:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbhLWALx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 19:11:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59303 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhLWALw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 19:11:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F0F9163020;
        Wed, 22 Dec 2021 19:11:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GTQiFrpMGNXw0VKyygrDxfiR7SLuLtYOYjR+JW
        UmpRk=; b=kdK4JoLTm3CO7R4HMHA6VT8BtKs2mhfS+jzVx8VNRrwnS/1jbslCZ1
        TC64x+x+Bl1k0UTJvVe85P2Q61oLiQXJgJXZ28kD28vFtPxOdLsUzbUbL3Yui8PN
        Soj23AkvnAf6AUrDCevXRCDrZPv1fqAy1JDz2zHq7iWV7XjEyq33c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3757C16301F;
        Wed, 22 Dec 2021 19:11:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 368D8163018;
        Wed, 22 Dec 2021 19:11:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
        <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
        <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
        <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net>
        <xmqqa6guub9n.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet>
        <xmqqczloju0q.fsf@gitster.g>
        <CA+JQ7M-8LydHMCgMYGP9LNMJMWk_-7LLYa5WEMMb_QMpeF-+Ag@mail.gmail.com>
Date:   Wed, 22 Dec 2021 16:11:45 -0800
In-Reply-To: <CA+JQ7M-8LydHMCgMYGP9LNMJMWk_-7LLYa5WEMMb_QMpeF-+Ag@mail.gmail.com>
        (Erik Cervin Edin's message of "Thu, 23 Dec 2021 00:40:53 +0100")
Message-ID: <xmqq35mkdvsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB137EDE-6384-11EC-A75C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> Another observation.
>
> This also applies to external aliases
>   git -c alias.fr='!git-filter-repo' fr --help
> returns
>   'fr' is aliased to '!git-filter-repo'
>  w exit code 0

I do not know what your 'w' is.  To me I get

    $ git -c alias.fr='!git-filter-repo' fr --help
    'fr' is aliased to '!git-filter-repo'

which is consistent with what I get for other aliases, e.g.

    $ git -c alias.lg='log --oneline' lg --help
    'lg' is aliased to 'log --oneline'

folowed by whatever "log --help" would give us.

So hopefully when your 'w' learns to show the documentation for
'git-filter-repo' command, such an alias would also work as
expected, no?

Anyway, unlike "man" and "info" where there is a standard way to
tell the command that "I have documentation pages in these places"
so that additional documentation can be installed to locations the
user chooses (and has access to), the "web" format viewers are
invoked without such customizability, i.e. in builtin/help.c, we see
this code snippet:

static void get_html_page_path(struct strbuf *page_path, const char *page)
{
	struct stat st;
	char *to_free = NULL;

	if (!html_path)
		html_path = to_free = system_path(GIT_HTML_PATH);

	/*
	 * Check that the page we're looking for exists.
	 */
	if (!strstr(html_path, "://")) {
		if (stat(mkpath("%s/%s.html", html_path, page), &st)
		    || !S_ISREG(st.st_mode))
			die("'%s/%s.html': documentation file not found.",
				html_path, page);
	}

	strbuf_init(page_path, 0);
	strbuf_addf(page_path, "%s/%s.html", html_path, page);
	free(to_free);
}

It may not be a bad idea to extand the function to understand a new
GIT_HTML_PATH environment variable, which can be a colon-separated
list of directories just like MANPATH and INFOPATH are.  It would be
rather trivial to update the block with a call to stat() above to a
loop over these directories.



