Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BA31F516
	for <e@80x24.org>; Wed, 27 Jun 2018 15:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965569AbeF0PD5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 11:03:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59595 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965562AbeF0PD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 11:03:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3993EEB8F;
        Wed, 27 Jun 2018 11:03:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=/n9pA0uPbXiW9YUBHmWnR0GG1l4=; b=Dd0iIHQ
        wW3AV/QNGRlVtOq4JIEYb1jQNGnR7vbwW/+X52KB8znTdphotwdJIxqnV5cWVOwz
        9m4sOE5PGagTss6UU3FcYnqTDFkh+v5v5wvLwQwIt5poSWTOAjnpZtzKXKM0kKr6
        0qbx+pZ68C6BxknVkktS/BcwWhOVMFilwLFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=O/A7Q03aTNQiR7uGtrypsZ8e3LTIl4tj/
        lEaY5FGphku7Ru8znHPVDJJHy4CsfN2MAJKeqnpGB4Dw8LEayNBoRrnNjA4Xxleu
        qqmZo5PehQKYqFZtOMg6lfmVohvNkv9H8ERR1olLhjU9sHE33KCoUI/RLBbS+6la
        yrRWMX94eU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB54FEEB8E;
        Wed, 27 Jun 2018 11:03:54 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 750D3EEB8D;
        Wed, 27 Jun 2018 11:03:54 -0400 (EDT)
Date:   Wed, 27 Jun 2018 11:03:52 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180627150352.GJ20217@zaya.teonanacatl.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627141430.GA13904@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 4F230D7E-7A1B-11E8-9C90-40570C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Jun 27, 2018 at 12:56:37AM -0400, Todd Zullinger wrote:
> 
>> Replace `$(prefix)/etc/gitconfig` and `$(prefix)/etc/gitattributes` in
>> generated documentation with the paths chosen when building.  Readers of
>> the documentation should not need to know how `$(prefix)` was defined.
> 
> Yes, I was just complaining about this yesterday.

So what you're saying is that if I had procrastinated a
little, you may have written such a patch for me? :)

>                                                   Besides readers not
> having any clue what $(prefix) means here, $(prefix)/etc is not even
> correct for builds with prefix=/usr.
>
> So I like the overall direction here, but it leaves me with one
> question: what happens for documentation outside of customized builds?
> 
> Specifically, I'm thinking of:
> 
>   1. The pre-built documentation that Junio builds for
>      quick-install-doc. This _could_ be customized during the "quick"
>      step, but it's probably not worth the effort. However, we'd want
>      some kind of generic fill-in then, and hopefully not
>      "/home/jch/etc" or something.

If building docs separately for such a use, the values can
be overridden by setting ETC_GITCONFIG and ETC_GITATTRIBUTES
(or prefix or sysconfig).  To keep the same values as we
currently use, for example:

    make -C Documentation V=1 \
            ETC_GITCONFIG='$$(prefix)/etc/gitconfig' \
            ETC_GITATTRIBUTES='$$(prefix)/etc/gitattributes'

I don't know if that's sufficient for folks who build
documentation to share with a general audience or not.

It might be enough if the default values are relatively sane
and consistent.  That would be a slight improvement over the
current situation still.

>   2. The manpages on git-scm.com, which are built with asciidoctor. I
>      think we'd want the same generic value there. Ideally it would be
>      embedded in the asciidoc source as "if this attribute isn't
>      defined, then use this", but it's not the end of the world to
>      require a patch to the site to handle this.

We have that for the DEFAULT_(EDITOR|PAGER).  I didn't know
if we'd want that here, but maybe it's worth the effort if
it helps when building docs destined for the website and
such.  It might make the plain text files a bit less
readable though.

The EDITOR/PAGER bits are in git-var.txt, like this:

    GIT_EDITOR::
        Text editor for use by Git commands.  The value is meant to be
        interpreted by the shell when it is used.  Examples: `~/bin/vi`,
        `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
        --nofork`.  The order of preference is the `$GIT_EDITOR`
        environment variable, then `core.editor` configuration, then
        `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
        time, which is usually 'vi'.
    ifdef::git-default-editor[]
        The build you are using chose '{git-default-editor}' as the default.
    endif::git-default-editor[]

The ifdef would be a little different to set the var if it
was not set, of course.

I think if we ensure that ETC_GITCONFIG / ETC_GITATTRIBUTES
are set sanely by default (and easily overridden) then we
can probably avoid the need to handle it within the asciidoc
file though.  (There's more on that though below.)

>      (Related, there's a build target in the local Makefile for using
>      asciidoctor; does it need updated, too?)

I didn't test asciidoctor specficially, but it also respects
the ASCIIDOC_EXTRA parameters, so I think it will work just
as well.  I'll try to confirm that later today.

>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index d079d7c73a..75af671798 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -95,6 +95,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
>>  
>>  prefix ?= $(HOME)
>>  bindir ?= $(prefix)/bin
>> +sysconfdir ?= $(prefix)/etc
>>  htmldir ?= $(prefix)/share/doc/git-doc
>>  infodir ?= $(prefix)/share/info
>>  pdfdir ?= $(prefix)/share/doc/git-doc
>> @@ -205,6 +206,18 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
>>  ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
>>  endif
>>  
>> +ifndef ETC_GITCONFIG
>> +ETC_GITCONFIG = $(sysconfdir)/gitconfig
>> +endif
>> +ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
>> +ASCIIDOC_EXTRA += -a 'etc-gitconfig=$(ETC_GITCONFIG_SQ)'
>> +
>> +ifndef ETC_GITATTRIBUTES
>> +ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
>> +endif
>> +ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
>> +ASCIIDOC_EXTRA += -a 'etc-gitattributes=$(ETC_GITATTRIBUTES_SQ)'
>> +
> 
> It's a shame we have to repeat this logic from the Makefile, though I
> guess we already do so for prefix, bindir, etc, so far.
> 
> Should we factor the path logic from the top-level Makefile into an
> include that can be used from either?

Yeah, maybe.  I didn't like the duplication either, but as
you noticed, we do it already for many of the other
variables.  I suspect we could put these defaults into
config.mak.uname which Documentation/Makefile includes and
then you could run 'make -C Documentation' in a fresh clone
or tarball and get docs built with the defaults set for each
platform.

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 1cc18a828c..ed903b60bd 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -5,7 +5,7 @@ The Git configuration file contains a number of variables that affect
>>  the Git commands' behavior. The `.git/config` file in each repository
>>  is used to store the configuration for that repository, and
>>  `$HOME/.gitconfig` is used to store a per-user configuration as
>> -fallback values for the `.git/config` file. The file `/etc/gitconfig`
>> +fallback values for the `.git/config` file. The file +{etc-gitconfig}+
> 
> I think the formatting tweak you've done here is the right thing.
> There's no way to expand within literal backticks (since that's the
> point). So we only care about the monospacing effect, which ++ should
> give.

Thanks.  It took me longer to decide that I couldn't find a
clean way to do it without using ++ than anything else. :)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
No one ever went broke underestimating the taste of the American
public.
    -- H. L. Mencken

