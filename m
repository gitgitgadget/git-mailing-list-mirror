Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A5D200B9
	for <e@80x24.org>; Sat,  5 May 2018 23:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeEEXs4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 19:48:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51909 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEEXsz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 19:48:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC226DBD10;
        Sat,  5 May 2018 19:48:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=fVvh0Bc8cwbeZ/k6PPfgzR9Eq+I=; b=PiecPIz
        LtHKYreesHn17TY39GKbImEmKKMzb68sT34OLmKIChpfrr0PiYfYTtN8QUz1IrI+
        Hh2LSA7p0AgHQZQ2+gHRyrgQ5LcfIpfPZBmzw7xPISz74pFjiKX1tbJpR50wAT6N
        vSpbSXKak5J+7c6KcMGxm5xcnupt8frHu4kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=fyWR8XSVFwczrwDHKz6Gk1lI4qj2elooI
        h91xVgkSky5VLocUMnkiLVjsSCmze4+xO+Hxv7kuKXVpFWLsaStv5UenviIFswkn
        i0USVvXR9vdsOiP7X0NgYu3QptYfcfrJf/aiFlGu2Rst3lfWGdWF/Yn7NVlum0vg
        k356RBQOOw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D336ADBD0F;
        Sat,  5 May 2018 19:48:54 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E5ABDBD0E;
        Sat,  5 May 2018 19:48:54 -0400 (EDT)
Date:   Sat, 5 May 2018 19:48:52 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/18] branch-diff: use color for the commit pairs
Message-ID: <20180505234852.GR26695@zaya.teonanacatl.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <ba4791918c78770005d552856d8669648d7004f1.1525448066.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4791918c78770005d552856d8669648d7004f1.1525448066.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: DEA69078-50BE-11E8-BDE4-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

As many others have already said, thanks for this series!
I've used tbdiff a bit over the years, but having a builtin
will make it much more convenient (and the speed boost from
a C implementation will be a very nice bonus).

Johannes Schindelin wrote:
> @@ -430,6 +451,8 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
>  	struct string_list branch1 = STRING_LIST_INIT_DUP;
>  	struct string_list branch2 = STRING_LIST_INIT_DUP;
>  
> +	git_diff_basic_config("diff.color.frag", "magenta", NULL);
> +
>  	diff_setup(&diffopt);
>  	diffopt.output_format = DIFF_FORMAT_PATCH;
>  	diffopt.flags.suppress_diff_headers = 1;

Should this also (or only) check color.diff.frag?  I thought
that color.diff.* was preferred over diff.color.*, though
that doesn't seem to be entirely true in all parts of the
current codebase.

In testing this series it seems that setting color.diff
options to change the various colors read earlier in this
patch via diff_get_color_opt, as well as the 'frag' slot,
are ignored.  Setting them via diff.color.<slot> does work.

The later patch adding a man page documents branch-diff as
using `diff.color.*` and points to git-config(1), but the
config docs only list color.diff.

Is this a bug in the diff_get_color{,_opt}() tooling?
It's certainly not anything you've introduced here, of
course.  I just noticed that some custom color.diff settings
I've used weren't picked up by branch-diff, despite your
clear intention to respect colors from the config.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Abandon the search for Truth; settle for a good fantasy.

