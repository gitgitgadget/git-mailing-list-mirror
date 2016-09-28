Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565101F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 22:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754310AbcI1WT2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 18:19:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56812 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753890AbcI1WT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 18:19:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6F70411C9;
        Wed, 28 Sep 2016 18:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ETXc05c/92AHW/joT9VHBkm2Oh0=; b=RB8SZH
        x4jIOMl5sufM0ynao2wFtGGKMqUIqNwV8FPCmoE2kwNkUSqmrjMJaazec7DuvkB1
        O+cUIar9Ws9FwQCog4YIbXg8TqWkR+qwwQPrcMq72G2uTaDYt7O+UXuEyIB2KzgO
        rHZygJLHmGmy/8iJ/fUilSXyj3iXgEjOnAXOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WFSxIKb0rHHd8lcoze5ndl3LkjsHIeci
        lKpk5DzcN0a5CXe00dBxspiBDQLXD57daVO1EtP6FsIadorBQPt+nR1zeRy0MS+k
        OuY5S/V4R+ajrIsEXN96RhmuZiAlZ9XGPkSmUhyC9LloVjwKw/u8k1tuxZBCOgl0
        DQTRdg3SEdw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBA13411C8;
        Wed, 28 Sep 2016 18:19:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D195411C7;
        Wed, 28 Sep 2016 18:19:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v5 1/4] git: make super-prefix option
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1475099443-145608-1-git-send-email-bmwill@google.com>
        <1475099443-145608-2-git-send-email-bmwill@google.com>
Date:   Wed, 28 Sep 2016 15:19:22 -0700
In-Reply-To: <1475099443-145608-2-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Wed, 28 Sep 2016 14:50:40 -0700")
Message-ID: <xmqqzimrhdlh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C956CAC-85C9-11E6-97B2-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Add a super-prefix environment variable 'GIT_INTERNAL_SUPER_PREFIX'
> which can be used to specify a path from above a repository down to its
> root.  The immediate use of this option is by commands which have a
> --recurse-submodule option in order to give context to submodules about
> how they were invoked.  This option is currently only allowed for
> builtins which support a super-prefix.

Yes, it can be used to specify that, but it is unclear (1) how such
a path thusly specified is used, (2) how it affects the outcome of
the operations, and (3) what it means (the same applies to the
documentation update).

It would help future readers of "git log", "tig blame", etc. to have
a few sentences after the first sentence above.  Perhaps

    ... specify a path from above ... down to its root.  When such a
    super-prefix is specified, the paths reported by Git are
    prefixed with it to make them relative to that directory
    "above".  The paths given by the users on the command line
    (e.g. "git subcmd --output-file=path/to/a/file" and pathspecs)
    are taken relative to that directory "above" to match.

or something like that?

> @@ -468,6 +469,7 @@ extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
>  extern int get_common_dir(struct strbuf *sb, const char *gitdir);
>  extern const char *get_git_namespace(void);
>  extern const char *strip_namespace(const char *namespaced_ref);
> +extern const char *get_super_prefix();

Nice, but 

    extern const char *get_super_prefix(void);

> +const char *get_super_prefix()

Likewise.

> +{
> +	if (!super_prefix)
> +		super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
> +	return super_prefix;
> +}

Good.

>  	commit_pager_choice();
>  
> +	if (!help && get_super_prefix()) {
> +		if (!(p->option & SUPPORT_SUPER_PREFIX))
> +			die("%s doesn't support --super-prefix", p->cmd);
> +		if (prefix)
> +			die("can't have both a prefix and super-prefix");
> +	}

Nice.  I'd phrase the latter as "can't use--super-prefix from a
subdirectory", though.

