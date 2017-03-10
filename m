Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6EB1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 17:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755349AbdCJREI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 12:04:08 -0500
Received: from mout.web.de ([212.227.15.14]:59524 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755049AbdCJREG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 12:04:06 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfHhK-1cakCR18oc-00Ollz; Fri, 10
 Mar 2017 18:04:01 +0100
Subject: Re: [PATCH] Makefile: detect errors in running spatch
To:     Jeff King <peff@peff.net>
References: <20170310083117.cbflqx7zbe4s7cqv@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1fd87646-76fb-e67c-e61a-c0ccca20cf0a@web.de>
Date:   Fri, 10 Mar 2017 18:03:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170310083117.cbflqx7zbe4s7cqv@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Scoge8RgNM/kg5tZQSUQvleBwEf6xdmyDdRouG0muWaQEungAsy
 xHeiY6CoC6g3gRCdu+UdiJLLungRQ8IxbdTub0f1ss/+EDtvio1kUxDJjFknGJ3q9nn5Z3s
 pzcPPpoTAcnpyDhi9a+7ynosEFQJv42LGAvZaT615OC6rQNSb9b8t8b3HAeBpIWzj+WVSZM
 U4zHbq9HvjK6e9Pi0Tg5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tteFppaXsgQ=:5bV5bIsjC7HbdbV45OG45D
 pgSFVgDwWd9ZiPwkH0Z386WSKZ1bGyyxpdoz0BUNdkxG1vycYtYENW7mtDRXaFjhM1sC1BGy0
 9wId5RoJMuR+aIz04+pMUGnNxQG8OmdLSckuI66BUWOsZoSx/e1ZMgOj5IU3DTAjho7a2ho8y
 XkD9kUkHMOh39ZpckasEtNX6IGFADQ2ZW0Vb+60SQc3Z+MuIufv6H9Sw6Lsudpuyb1Z35stBK
 bhs6t8GNg7S++GPW8i96yu5+5akrjSYmoudOMaqaHEA2dw62U/EdIC2BUa/0s/m7lvGA04M5k
 6iFe68yXg+/QC6NidvSGQ2csc99kamQYZvGGBRcq0anK9nak0VffXg7pAmCNmT4aJG2jFchHn
 Z+dmJ0gzrNu1/9eKmy5KqfsTEYT4XojWZ7KOJcJCSUZONa0QcFu4ESo1z3+CqgrGqsXPNmv1d
 khBmte4toDC5frM3aZ+2oOGK7xmr5PBu3rdNQ1EzNVAavJYY/u2A981gSftxwjTV3nyw2EIPv
 Qo9RMFocdziA6WWBvfI+6YYJni8yT/2ieCVSsGR4SVSAHkAae4wpTvyQdYWBlREI/6A8KqUU8
 KJZbdfefLBDlOk+k+K0wX0XcUwhn8HpTmn7ACkwy0s7mQPWqzeCQb1JjicSuV1SM+WpLdlzlA
 vC5kMohMRCUquH6n232cioQMJCfFkNnPNfpOP1QzDEwe5hbWZScniZRcIjTUnOao+aGWtG/x7
 HakL/aDpUalQuFVaMXlBzgYd54OjcInDAnfS+uQUkeutgvQ/8XcjCHQPia4jUZOHYYikcAqx8
 4N7oaEK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.2017 um 09:31 schrieb Jeff King:
> The "make coccicheck" target runs spatch against each source
> file. But it does so in a for loop, so "make" never sees the
> exit code of spatch. Worse, it redirects stderr to a log
> file, so the user has no indication of any failure. And then
> to top it all off, because we touched the patch file's
> mtime, make will refuse to repeat the command because it
> think the target is up-to-date.
>
> So for example:
>
>   $ make coccicheck SPATCH=does-not-exist
>       SPATCH contrib/coccinelle/free.cocci
>       SPATCH contrib/coccinelle/qsort.cocci
>       SPATCH contrib/coccinelle/xstrdup_or_null.cocci
>       SPATCH contrib/coccinelle/swap.cocci
>       SPATCH contrib/coccinelle/strbuf.cocci
>       SPATCH contrib/coccinelle/object_id.cocci
>       SPATCH contrib/coccinelle/array.cocci
>   $ make coccicheck SPATCH=does-not-exist
>   make: Nothing to be done for 'coccicheck'.
>
> With this patch, you get:
>
>   $ make coccicheck SPATCH=does-not-exist
>        SPATCH contrib/coccinelle/free.cocci
>   /bin/sh: 4: does-not-exist: not found
>   Makefile:2338: recipe for target 'contrib/coccinelle/free.cocci.patch' failed
>   make: *** [contrib/coccinelle/free.cocci.patch] Error 1

That's nice.  The current version is just a contraption that does the 
bare minimum of work.

> It also dumps the log on failure, so any errors from spatch
> itself (like syntax errors in our .cocci files) will be seen
> by the user.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This shell code is getting a bit unwieldy to stick inside the Makefile,
> with all the line continuation and $-escaping.  It might be worth moving
> it into a helper script.

There is one for the kernel 
(https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/coccicheck). 
  It's quite big, though.

> It also doesn't help that shells are awkward at passing status out of a
> for-loop. I think the most "make-ish" way of doing this would actually
> be to lose the for loop and have a per-cocci-per-source target.
>
> I don't know if that would make the patches harder to apply. The results
> aren't full patches, so I assume you usually do some kind of munging on
> them?

They work with patch -p0.

We can get rid of the loop by using the spatch options --use-gitgrep and 
--dir.  I can't find the former one in the docs, though, so I'm not sure 
if it only works with certain versions or what exactly it is even doing. 
  It seems to have the side effect of producing git-style patches 
(applicable with patch -p1) at least.

> I resorted to:
>
>   make coccicheck SPATCH='spatch --in-place'

Using SPATCH_FLAGS for adding an option in such case would be a bit simpler.

>  Makefile | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9ec6065cc..d97633892 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2336,9 +2336,17 @@ check: common-cmds.h
>  C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
>  %.cocci.patch: %.cocci $(C_SOURCES)
>  	@echo '    ' SPATCH $<; \
> +	ret=0; \
>  	for f in $(C_SOURCES); do \
> -		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS); \
> -	done >$@ 2>$@.log; \
> +		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> +			{ ret=$$?; break; }; \
> +	done >$@+ 2>$@.log; \
> +	if test $$ret != 0; \
> +	then \
> +		cat $@.log; \
> +		exit 1; \
> +	fi; \
> +	mv $@+ $@; \
>  	if test -s $@; \
>  	then \
>  		echo '    ' SPATCH result: $@; \
>
