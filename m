Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F921FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 13:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdJKNiZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 09:38:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64104 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751462AbdJKNiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 09:38:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03415A801B;
        Wed, 11 Oct 2017 09:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=KlGB6o66vnMrcJiVZ7fa+EnHkN4=; b=H07fuu
        Al3y8hYKCtnJfJ9k5TPhUuTYYDdxNKKbLp78wAB0uH+rEWSF8MEnB+UdWJ8c28Ti
        5b3ml9Ka/PvPUaIcJKqk+KSmu90W/gh2ErhUhDo2sgG/yuxB6VIRvTdNBVKXYHzL
        P6SLAACwt/yErcEFI14xtYdSgpa66cKRoSEaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bmxbZ+h+fqLCue5/9QbMsLDBAneOzwqF
        j5JK3uMGb76wHrJnvT4VkQhBT8WG21C7j3jcJ4hjeFiRsEXg7YuCDozZh05rp9MY
        hlWUOnLmb4hFEmP9RglBqgbpuB3tn/8Azs/MAaxEuqoBmW4UKeMAr+KQS9S5SMiP
        jT2MmLyG80M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED62BA801A;
        Wed, 11 Oct 2017 09:38:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 585DCA8019;
        Wed, 11 Oct 2017 09:38:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
In-Reply-To: <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
        (Marius Paliga's message of "Wed, 11 Oct 2017 09:14:14 +0200")
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
        <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
        <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
        <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
Date:   Wed, 11 Oct 2017 22:38:21 +0900
Message-ID: <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7327189A-AE89-11E7-8EF2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Paliga <marius.paliga@gmail.com> writes:

> @@ -505,6 +509,12 @@ static int git_push_config(const char *k, const
> char *v, void *cb)
>          recurse_submodules = val;
>      }
>
> +    default_push_options = git_config_get_value_multi("push.optiondefault");
> +    if (default_push_options)
> +        for_each_string_list_item(item, default_push_options)
> +            if (!string_list_has_string(&push_options, item->string))
> +                string_list_append(&push_options, item->string);
> +
>      return git_default_config(k, v, NULL);
>  }

Sorry for not catching this earlier, but git_config_get_value* call
inside git_push_config() is just wrong.

There are two styles of configuration parsing.  The original (and
still perfectly valid) way is to call git_config() with a callback
function like git_push_config().  Under this style, the config files
are read from lower-priority to higher-priority ones, and the
callback function is called once for each entry found, with <key, value>
pair and the callback specific opaque data.  One way to add the
parsing of a new variable like push.optiondefault is to add

	if (!strcmp(k, "push.optiondefault") {
		... handle one "[push] optiondefault" entry here ...
		return 0;
	}

to the function.

An alternate way is to use git_config_get_* functions _outside_
callback of git_config().  This is a newer invention.  Your call to
git_config_get_value_multi() will scan all configuration files and
returns _all_  entries for the given variable at once.

When there is already a callback style parser, in general, it is
cleaner to simply piggy-back on it, instead of reading variables
independently using git_config_get_* functions.  When there isn't a
callback style parser, using either style is OK.  It also is OK to
switch to git_config_get_* altogether, rewriting the callback style
parser, but I do not think it is warranted in this case, which adds
just one variable.

In any case, with the above code, you'll end up calling the
git_config_get_* function and grabbing all the values for
push.optiondefault for each and every configuration variable
definition (count "git config -l | wc -l" to estimate how many times
it will be called).  Which is probably not what you wanted to do.

Also, watch out for how a configuration variable defined like below
is reported to either of the above two styles:

	[push]	optiondefault

 - To a git_config() callback function like git_push_config(), such
   an entry is called with k=="push.optiondefault", v==NULL.

 - git_config_get_value_multi() would return a string-list element
   with the string set to NULL to signal that one value is NULL
   (i.e. it is different from "[push] optiondefault = ").

I suspect that with your code, we'd hit

	if (strchr(item->string, '\n'))

and end up dereferencing NULL right there.

> @@ -515,7 +525,6 @@ int cmd_push(int argc, const char **argv, const
> char *prefix)
>      int push_cert = -1;
>      int rc;
>      const char *repo = NULL;    /* default repository */
> -    struct string_list push_options = STRING_LIST_INIT_DUP;
>      const struct string_list_item *item;
>
>      struct option options[] = {

Also, I suspect that this code does not allow the command line
option to override the default set in the configuration file.
OPT_STRING_LIST() appends to the &push_options string list without
first clearing it, and you are pre-populating the list while reading
the configuration, so the values taken from the command line will
only add to them.

The right way to do this would probably be:

 - Do not muck with push_options in cmd_push().

 - Prepare another string list, push_options_from_config, that is
   file-scope global.

 - In git_push_config(), do not call get_multi; instead react to a
   call with k=="push.optionsdefault" and

   - reject if "v" is NULL, with "return config_error_nonbool(k);"

   - otherwise, append "v" to the "from-config" string list--do not
     attempt to dedup or sort.

   - if "v" is an empty string, clear the "from-config" list.

 - After parse_options() returns to cmd_push(), see if push_options
   is empty.  If it is, you did not get any command line option, so
   override it with what you collected in the "from-config" string
   list.  Otherwise, do not even look at "from-config" string list.

By the way, I really hate "push.optiondefault" as the variable
name.  The "default" part is obvious and there is no need to say it,
as the configuration variables are there to give the default to what
we would normally give from the command line.  Rather, you should
say for which option (there are many options "git push" takes) this
variable gives the default.  Perhaps "push.pushOption" is a much
better name; I am sure people can come up with even better ones,
though ;-)

