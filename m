Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597EAC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 01:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D08520CC7
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 01:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+S+Y4Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfLQB2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:28:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40200 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQB2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 20:28:02 -0500
Received: by mail-pj1-f68.google.com with SMTP id s35so3800654pjb.7
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 17:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EDhz7tvNDi2nEuBdMnzrwAJazvicXMuCme8NnuJ8Oqc=;
        b=k+S+Y4IyWw5ap9uBg0deeZpXet5MXS53g4LFy51YeV3tqt6zDMuEEHx9bHrJUaeD6v
         8EFyorIDkSI3hWiYcbspoxAcQgcBr61E0FK2EN7TfujWzriTrpHNyWw043uZR29VleZY
         xcrLC/bihOaIAPVZ+P1fjC1kKzlOO0JN9pI8zjy/EVUGq1NaVmwCrxpH1JRofvoIgRdN
         WUyPZ7GD1Iq563lLOhOGw2RXT5lhvc2r+UmcGNXp8dVW307E0fPXeV47SOJhZRa/CVem
         8M4iYGkL+ebhJ0tlfxj8yCzmgR7xvE03NZpW1AKQSf3lL37MaUrBOjAQTdt0zCKcvWsK
         CadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EDhz7tvNDi2nEuBdMnzrwAJazvicXMuCme8NnuJ8Oqc=;
        b=AVRJqv9VzOC37Jr79QEw7hly65FCx2ftLIYpbRzfUEQNehidXdWAHushMqX0DHtF7e
         4FdC8F94eNp2Ru82t3AIyDrQy7G6I8YgWjn808pGahi3PKrAgfvd8LrLzwa/xlRYTXwi
         hR/ODelIyQIf+KHgGgG8UGBq3j9OS86wrGiw/suCnMyueWaqUNBb79vn9XgnqB7Ef3YU
         7l9BhrcLMB3kQ2gHMft+5C5qrtmP774LfAA7K2SQ/eRlAEeQFFV/KKbM+IJWEI0hLXJX
         IM9hUq4YtXYao/Go76Qys462dK+c73jiJQ76LbfNGvjes+MqEoSDgER1qFf+vKnvXvE9
         ZRww==
X-Gm-Message-State: APjAAAUVm27WyTlvi5sR5cXFh+EVh9p0nhI2ILoRPGjnnXHj4t9zKZjA
        sGXwPn5FKAXhOYcN7ofkUmZn8VF5NB0=
X-Google-Smtp-Source: APXvYqybfXn327s0c6gP6u9vj6vrpbw6SVhUKLScSRKhrx5Ad1eaR5Yd7f+bwqcnJoJmpt6Y/Z8w6w==
X-Received: by 2002:a17:902:82cc:: with SMTP id u12mr18495336plz.342.1576546081391;
        Mon, 16 Dec 2019 17:28:01 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k9sm753660pje.26.2019.12.16.17.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 17:28:00 -0800 (PST)
Date:   Mon, 16 Dec 2019 17:27:56 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191217012756.GQ135450@google.com>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
 <20191214010002.GA945704@coredump.intra.peff.net>
 <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
 <20191216192014.GA2678964@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216192014.GA2678964@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 02:20:14PM -0500, Jeff King wrote:
> On Mon, Dec 16, 2019 at 10:55:40AM -0800, Junio C Hamano wrote:
> 
> > LIB_H could contain command-list.h (and other GENERATED_H files) if
> > we did this, but dups in dependency does not hurt in general, and I
> > did not find anything potentially problematic in the existing use of
> > $(LIB_H) in our Makefile.
> > 
> > How about doing this as a further clean-up?  I am reasonably sure
> > the status-quo description is correct, but I find the justification
> > a bit weak (in other words, I do not have a good answer to "who
> > cares if those that depend on $(LIB_H) are not rebuilt when
> > command-list.h gets rebuilt?")
> 
> Yeah, I don't think there's any change in behavior here, since with the
> exception of hdr-check, every mention of $(LIB_H) also mentioned
> $(GENERATED_H). And in the case of hdr-check, we explicitly exclude the
> only item found in $(GENERATED_H).

To check my understanding - hdr-check just says "the headers are
syntactically correct", right? $HCO's target '-o /dev/null' says
"don't save the output", '-c' says "just compile, don't link", and '-xc'
says "in C"; it expands to a target for each file ending in .h but not
in $EXCEPT_HDRS, and hdr-check calls each one of those expanded targets,
so I think I understand hdr-check is compiling each header...

> 
> But this would enable us to start checking command-list.h. I'm on the
> fence on whether that's useful or not; the patch below makes it pass,
> but I'm not sure if that is really turning up any useful problems. I
> suppose somebody besides help.c could include command-list.h, in which
> case some of those MAYBE_UNUSED bits could become useful.

Firstly, I think if someone besides help.c includes command-list.h it
blows up because there's no include guards :)

My gut wants to say, "I need to be sure my generated header is correct!"
But it seems that will also be checked when I try to include that header
from something actually important. So maybe it's not actually useful.
But then it seems like hdr-check target isn't that useful for anybody,
since those headers should always be included sometime down the road (or
why have them). So that makes me think I must still be missing
something, like maybe I parsed hdr-check wrong.

> 
> I actually wonder if the whole thing would be simpler if command-list.h
> was a static tracked file with the declarations, and we generated
> command-list.c with "extern const char *command_list[]", etc.
> 
> > --- >8 ---
> > Makefile: include GENERATED_H in LIB_H
> > 
> > $(LIB_H), which is meant to be the list of header files that can
> > affect (hence trigger recompilation) the objects that go in
> > libgit.a, in a directory extracted from a tarball is computed by
> > running "find \*.h" but instead computed with "ls-files \*.h" in a
> > working tree managed by a git repository.  The former can include
> > generated header files after a build, and omit them in a clean
> > state.  The latter would not, as generated header files are by
> > definition not tracked.
> > 
> > Explicitly add $(GENERATED_H) to $(LIB_H) to make things consistent.
> 
> I do think this is slightly simpler to reason about than the existing
> setup (though see my "should it just be a C file?" above).
> 
> Here's the patch that would make hdr-check work:
> 
> ---
> diff --git a/Makefile b/Makefile
> index 87b68962ed..1eac8e7a7a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2780,7 +2780,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> -GEN_HDRS := command-list.h unicode-width.h
> +GEN_HDRS := unicode-width.h
>  EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
>  ifndef GCRYPT_SHA256
>  	EXCEPT_HDRS += sha256/gcrypt.h
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 71158f7d8b..7b0751e3e1 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -48,6 +48,7 @@ define_categories () {
>  define_category_names () {
>  	echo
>  	echo "/* Category names */"
> +	echo "MAYBE_UNUSED"
>  	echo "static const char *category_names[] = {"
>  	bit=0
>  	category_list "$1" |
> @@ -61,6 +62,7 @@ define_category_names () {
>  }
>  
>  print_command_list () {
> +	echo "MAYBE_UNUSED"
>  	echo "static struct cmdname_help command_list[] = {"
>  
>  	command_list "$1" |
> @@ -78,6 +80,7 @@ print_command_list () {
>  
>  print_config_list () {
>  	cat <<EOF
> +MAYBE_UNUSED
>  static const char *config_name_list[] = {
>  EOF
>  	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> @@ -101,7 +104,8 @@ do
>  	shift
>  done
>  
> -echo "/* Automatically generated by generate-cmdlist.sh */
> +echo "#include \"gettext.h\"
> +/* Automatically generated by generate-cmdlist.sh */
>  struct cmdname_help {
>  	const char *name;
>  	const char *help;
