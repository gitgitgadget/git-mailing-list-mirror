Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C271FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 04:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbdD0Ebq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 00:31:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35561 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdD0Ebp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 00:31:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id a188so5771237pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0LxsZI6enPuKNCAI6CI2yS3lSv3cXrJFy050WvGxG/g=;
        b=QrPXhwe7KrpF/M3BOPK1GDtZsji5SkdYWcXmn55mO82wsAlHCzLcLeAo3cV/bKlzq1
         txR5jLQfCZHc4Q4LjmXtc4L7ek/lBCsMc/fpuEN+Dj/HLUOPDH6dCd+xO+6GZxifcBZa
         vYzpPrnwFFjw8Ou0DyFAPw31rM28HvoxPyyVPCkibY8kdPc4s4GpI6g0DF9AhSoPuons
         kl5GrL9ES/FH/hQHAd7JayXoKKB5ZlrPJ4ybmFsRkzxy75ltJgi5jWw+SfGPe99zeR1r
         YWepxvDs6Bcc0LApGHc2Sqc0zI+jtSNxY8/3MEupglJ4IuVqiVEaPUOaTqwSurZDtpCb
         yULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0LxsZI6enPuKNCAI6CI2yS3lSv3cXrJFy050WvGxG/g=;
        b=rFx5R5IErbWidUOMCkqwYMEz9CyrfqiDFN0nTnRnKP4lah5uPjsg6Jh3QbOPtcdF1x
         rqxqd1TBIe6+X4Pzu2Xv6syuW19z3rHplgH/1z7+LnklVP3gERsCvl2nDMRQM4nKnFLO
         hq/HusYeM8tPt7jLtuHhiHS2qymsxxdyWE2xi+R25Wpn1zNJmpzjJukcBZPaxMravLI3
         mMHEOSPe6i/p6P0kiRxAH3HF12XHSB5/WN6VAOS+5TT+14hfBnsLP8t7Yr3LF+C69drg
         9hJO6Z1gnv8grFeKwajNi8z9sqSm7bBUL++N+vBB+Dc8e2gaVo6VTajtN+T8qvkd7Kon
         ylcg==
X-Gm-Message-State: AN3rC/629gp4WpDpVZi8p6XT7D0l8JE5R+WLyrZwOq5q7kDyl+6Bo8DB
        Q1Vdt7c7LVY7tQ==
X-Received: by 10.99.65.4 with SMTP id o4mr3503420pga.90.1493267504762;
        Wed, 26 Apr 2017 21:31:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id p68sm1440030pga.6.2017.04.26.21.31.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 21:31:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
Date:   Wed, 26 Apr 2017 21:31:43 -0700
In-Reply-To: <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 13:59:13 +0200
        (CEST)")
Message-ID: <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/sequencer.c b/sequencer.c
> index 77afecaebf0..e858a976279 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2388,3 +2388,48 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  
>  	strbuf_release(&sob);
>  }
> +
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv)
> +{
> +	char *format = xstrdup("%s");
> +	struct pretty_print_context pp = {0};
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rev_info revs;
> +	struct commit *commit;
> +
> +	init_revisions(&revs, NULL);
> +	revs.verbose_header = 1;
> +	revs.max_parents = 1;
> +	revs.cherry_pick = 1;
> +	revs.limited = 1;
> +	revs.reverse = 1;
> +	revs.right_only = 1;
> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> +	revs.topo_order = 1;
> +
> +	revs.pretty_given = 1;
> +	git_config_get_string("rebase.instructionFormat", &format);
> +	get_commit_format(format, &revs);
> +	free(format);
> +	pp.fmt = revs.commit_format;
> +	pp.output_encoding = get_log_output_encoding();

All of the above feels like inviting unnecessary future breakages by
knowing too much about the implementation the current version of
revision.c happens to use.  A more careful implementation would be
to allocate our own av[] and prepare "--reverse", "--left-right",
"--cherry-pick", etc. to be parsed by setup_revisions() call we see
below.  The parsing is not an expensive part of the operation
anyway, and that way we do not have to worry about one less thing.

> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		return error(_("make_script: unhandled options"));
> +
> +	if (prepare_revision_walk(&revs) < 0)
> +		return error(_("make_script: error preparing revisions"));
> +
> +	while ((commit = get_revision(&revs))) {
> +		strbuf_reset(&buf);
> +		if (!keep_empty && is_original_commit_empty(commit))
> +			strbuf_addf(&buf, "%c ", comment_line_char);

Presumably callers of this function (which does not exist yet at
this step) are expected to have done the configuration dance to
prepare comment_line_char to whatever the end-user specified?

> +		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
> +		pretty_print_commit(&pp, commit, &buf);
> +		strbuf_addch(&buf, '\n');
> +		fputs(buf.buf, out);
> +	}
> +	strbuf_release(&buf);
> +	return 0;
> +}

Other than that, this looks reasonable.

> diff --git a/sequencer.h b/sequencer.h
> index f885b68395f..83f2943b7a9 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -45,6 +45,9 @@ int sequencer_continue(struct replay_opts *opts);
>  int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv);
> +
>  extern const char sign_off_header[];
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
