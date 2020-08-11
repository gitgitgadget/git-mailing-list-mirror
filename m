Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA71C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F1F20768
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QcIhN/xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgHKPgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgHKPgY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 11:36:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79737C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:36:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so9696789qtq.8
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mXqGCkYhfceJdJHibhuQsoqaCw/AIqEzQyBRZQzZ/ZA=;
        b=QcIhN/xFhf2gE2r3blvKofgubvHdMNrdoI1gaAU093yMlMGTDGozvysJ+JXlDTMt8E
         K1C6B2o7xwj8d8e0IccurdpSaj2pzFfbirm3d1FEA06TwweNs4gvq6ZwYjQkg8K7ryrJ
         IzCw9P04+F157A+1mazc+s/tcyaKiJxolbr2DQ63rDl91FaE719KQEpk03NsOfhURr7o
         qWYQFKfEMiDZgiCxD6mmw0DdnETVBPIkoMQM9AjpgVSnFS4KE6imBQntCcVwcVKX5bZS
         /MCLUTJWmHLHo1chEBLgL+GKcoEKGOj9F/UoXJKKsrarSX2n/SWm2Oq5kT8jUedbfrwi
         hirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mXqGCkYhfceJdJHibhuQsoqaCw/AIqEzQyBRZQzZ/ZA=;
        b=Zyy9oQtg7xf9QEYQhcELLM1zbDXpaCrxOQ4tMU77aMvxvIHA3x55BYNT3RowwbDHFf
         MhKUkwLQotAfMUhAQPddRHvg4B9O4u790McdscqiQHZ7G3fU3FNxDANAkOHDAg99sWj/
         f8b8P3V8Gj9i/D4FXopwqP5tMF+nM5rYruo2jAcg2sevFlDu8xEAQg70xB71JmU+eeVy
         oZ2A263gliM8MffqbpmXU+JotwvzOkCvFyQ6AOE9k0OK1gBIaDO22T0Pf3mtAcwK7P+r
         1/3nUj8AWvIeF2RxFTH3Z7Lwtvz9hP7ztBop8yOX/BQ+VoAVQDTNkE7LgoEHkvy/vkXG
         c5tg==
X-Gm-Message-State: AOAM531FBNEEa6ewE8FPkFhp89v10CEaYCRAaCv3tvB72K47JRCZMql1
        7OOUnMC5fOUtbxArZBMyf+R7Fw==
X-Google-Smtp-Source: ABdhPJyzgIkCSdY1L8pd9Kbk3vvXYJcbU8jTjn65CAhD4vAFXu8MwrHcfhXDvGFj7Ab58J5Ih4VEBw==
X-Received: by 2002:ac8:4511:: with SMTP id q17mr1644878qtn.117.1597160183144;
        Tue, 11 Aug 2020 08:36:23 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id a21sm16890892qkg.54.2020.08.11.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:36:22 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:36:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
Message-ID: <20200811153621.GD19871@syl.lan>
References: <20200811131313.3349582-1-detegr@rbx.email>
 <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:32:37PM +0100, Phillip Wood wrote:
> Hi Antti
>
> On 11/08/2020 14:13, Antti Keränen wrote:
> > 'todo_list_write_to_file' may overwrite the static buffer, originating
> > from 'find_unique_abbrev', that was used to store the short commit hash
> > 'c' for "# Rebase a..b onto c" message in the todo editor.
> > Fix by duplicating the string before usage, so subsequent calls to
> > 'find_unique_abbrev' or other functions calling 'hash_to_hex_algop_r'
> > can't overwrite the buffer.
> >
> > Found-by: Jussi Keränen <jussike@gmail.com>
> > Signed-off-by: Antti Keränen <detegr@rbx.email>
>
> Thanks for working on this
>
> > ---
> >   sequencer.c                   |  7 ++++---
> >   t/t3404-rebase-interactive.sh | 13 +++++++++++++
> >   2 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index fd7701c88a..0679adb639 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -5178,13 +5178,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
> >   		    struct string_list *commands, unsigned autosquash,
> >   		    struct todo_list *todo_list)
> >   {
> > -	const char *shortonto, *todo_file = rebase_path_todo();
> > +	const char *todo_file = rebase_path_todo();
>
> I'm not sure it's worth rearranging these lines. It probably does not matter
> but we could do
>
> +	char shortonto[GIT_MAX_HEXSZ + 1];
>
> and then later call find_unique_abbrev_r() instead so we don't have to worry
> about freeing shortonto.
>
> >   	struct todo_list new_todo = TODO_LIST_INIT;
> >   	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
> >   	struct object_id oid = onto->object.oid;
> >   	int res;
> > -
> > -	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
> > +	char *shortonto;
> >   	if (buf->len == 0) {
> >   		struct todo_item *item = append_new_todo(todo_list);
> > @@ -5206,8 +5205,10 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
> >   		return error(_("nothing to do"));
> >   	}
> > +	shortonto = xstrdup(find_unique_abbrev(&oid, DEFAULT_ABBREV));
> >   	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
> >   			     shortonto, flags);
> > +	free(shortonto);
> >   	if (res == -1)
> >   		return -1;
> >   	else if (res == -2) {
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> > index 4a7d21f898..09af16753c 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -1760,6 +1760,19 @@ test_expect_success 'correct error message for commit --amend after empty pick'
> >   	test_i18ngrep "middle of a rebase -- cannot amend." err
> >   '
> > +test_expect_success 'todo has correct onto hash' '
> > +	write_script dump-raw.sh <<-\EOF &&
> > +		cat "$1"
> > +	EOF
> > +	git checkout branch1 &&
> > +	(
> > +		test_set_editor "$(pwd)/dump-raw.sh" &&
> > +		git rebase -i HEAD~5 >actual
> > +	) &&
>
> Thanks for taking the trouble to add a test, I think all the lines above
> could be simplified to
>
> 	GIT_SEQUENCE_EDITOR=cat git rebase -i HEAD~5 branch1 >actual

Good suggestion.

> > +	onto=$(git rev-parse --short HEAD~5) &&
> > +	test_i18ngrep "^# Rebase ..* onto $onto .*" actual
>
> we could lose the final .*

Ack, I noticed this too during my review, but apparently forgot to
comment on it. I'm puzzled by the first '..*'. If you're searching for
any non-empty string, how about '.+' instead?

> Many Thanks and Best Wishes
>
> Phillip
>
> > +'
> > +
> >   # This must be the last test in this file
> >   test_expect_success '$EDITOR and friends are unchanged' '
> >   	test_editor_unchanged
> >
Thanks,
Taylor
