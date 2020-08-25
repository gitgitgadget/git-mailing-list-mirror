Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431F6C433E3
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE72E2076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2iPR5gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHYTwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:52:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50673 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHYTwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:52:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F554DEAC1;
        Tue, 25 Aug 2020 15:52:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xoy+WEKoAXuFakkSAiqJUSKj3Mo=; b=J2iPR5
        gK+apRrFeZprPd6RmD4Y1mlzNyRzSEUNLfrNURIiVI6PYmMrtsS9BgG+Kd2rD1bC
        PQTvJMLzH4h9RCXKmJ/peY1PAmRW8SWfSBvE1FWlP+0EkCIMJ/me2yB4Pz2S9jvj
        MjdQ4nd2oBlmH+AvUpXT7KSd/xgXKJxwpfvm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gNtMH2HKY/ikQge/h4sfDr/5ITNecibf
        pBWGAoejmvDXr845QI2vhMUGxf52zrMHbWPRHTqAA1WRgVoSMToQX6QZjgUCdLNy
        4yCQ/41MHC28uX8xbZbLQ516QyBs8LRDZGIO55fHvVj/wG4Rs/ruyJxy3UZJ2iA6
        /hSxdWU2WEA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27CF0DEAC0;
        Tue, 25 Aug 2020 15:52:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9AA5CDEABE;
        Tue, 25 Aug 2020 15:52:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Mismatched HEAD default behavior from git log
References: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
        <xmqq8se21pl1.fsf@gitster.c.googlers.com>
        <20200825194619.GB1419759@coredump.intra.peff.net>
Date:   Tue, 25 Aug 2020 12:51:59 -0700
In-Reply-To: <20200825194619.GB1419759@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 25 Aug 2020 15:46:19 -0400")
Message-ID: <xmqq4koq1p28.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71679930-E70C-11EA-A03C-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> As the intent for adding the "--stdin" option to any subcommand has
>> always been "we may need to feed many many things, that may bust the
>> command line length limit, hence we let you feed these things from
>> the standard input, but otherwise there should be no change in
>> behaviour or semantics", when the behaviour of command line and
>> "--stdin" differ, it is a bug in the latter.
>
> Agreed. It also helps in this case that the command-line behavior is
> sensible and the --stdin one is not. :)
>
> I think the solution is probably something like:

You beat me to it while I was wondering what to do between the local
got_rev_arg variable and the revs->rev_input_given field.


> diff --git a/revision.c b/revision.c
> index 96630e3186..f5bbefa091 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2099,12 +2099,13 @@ static void read_pathspec_from_stdin(struct strbuf *sb,
>  		strvec_push(prune, sb->buf);
>  }
>  
> -static void read_revisions_from_stdin(struct rev_info *revs,
> -				      struct strvec *prune)
> +static int read_revisions_from_stdin(struct rev_info *revs,
> +				     struct strvec *prune)
>  {
>  	struct strbuf sb;
>  	int seen_dashdash = 0;
>  	int save_warning;
> +	int got_rev_arg = 0;
>  
>  	save_warning = warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity = 0;
> @@ -2124,12 +2125,14 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>  		if (handle_revision_arg(sb.buf, revs, 0,
>  					REVARG_CANNOT_BE_FILENAME))
>  			die("bad revision '%s'", sb.buf);
> +		got_rev_arg = 1;
>  	}
>  	if (seen_dashdash)
>  		read_pathspec_from_stdin(&sb, prune);
>  
>  	strbuf_release(&sb);
>  	warn_on_object_refname_ambiguity = save_warning;
> +	return got_rev_arg;
>  }
>  
>  static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
> @@ -2754,7 +2757,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  				}
>  				if (revs->read_from_stdin++)
>  					die("--stdin given twice?");
> -				read_revisions_from_stdin(revs, &prune_data);
> +				if (read_revisions_from_stdin(revs, &prune_data))
> +					got_rev_arg = 1;
>  				continue;
>  			}
>  
>
> Possibly it would make sense to push that flag into rev_info, though,
> and let handle_revision_arg() set it. That would fix this bug and
> prevent similar ones in other code paths (though we're not likely to get
> revisions from anywhere else, I suppose).
>
> -Peff
