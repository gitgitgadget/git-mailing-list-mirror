Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04051FAE2
	for <e@80x24.org>; Wed, 17 Jan 2018 06:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeAQGRG (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 01:17:06 -0500
Received: from ikke.info ([178.21.113.177]:58400 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeAQGRG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 01:17:06 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 2E1524402C5; Wed, 17 Jan 2018 07:17:04 +0100 (CET)
Date:   Wed, 17 Jan 2018 07:17:04 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Keith Smiley <k@keith.so>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20180117061703.GB5618@alpha.vpn.ikke.info>
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
 <20171229224825.31062-1-szeder.dev@gmail.com>
 <87y3ll6s0e.fsf@evledraar.gmail.com>
 <20171230005222.GT3693@zaya.teonanacatl.net>
 <87vago76i8.fsf@evledraar.gmail.com>
 <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
 <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
 <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com>
 <xmqqh8rlvdgh.fsf@gitster.mtv.corp.google.com>
 <20180117004419.GA14263@duynguyen.dek-tpc.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117004419.GA14263@duynguyen.dek-tpc.internal>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 07:44:19AM +0700, Duy Nguyen wrote:
> On Tue, Jan 16, 2018 at 10:57:34AM -0800, Junio C Hamano wrote:
> > Duy Nguyen <pclouds@gmail.com> writes:
> > 
> > > On Tue, Jan 16, 2018 at 4:43 AM, Keith Smiley <k@keith.so> wrote:
> > >> So it sounds like either we should deprecate rm, or I should update the patch to the suggested method where we just complete remotes, but not rm in the list of completions.
> > >
> > > I vote for deprecation. I could send a patch to start warning to
> > > switch from 'rm' to 'remove'. Then perhaps we can delete it after two
> > > releases. It's not classified as plumbing should we don't have worry
> > > too much about scripts relying on 'remote rm'.
> > 
> > I do not know about "two releases" part (which amounts to merely
> > 20-24 weeks), but looking at "git remote -h" output and seeing that
> > we do spell out "rename" (instead of saying "mv" or something cryptic),
> > it probably makes sense to remove "rm" some time in the future.
> > 
> > I actually do think "rm" is _already_ deprecated.  
> > 
> > "git remote --help" does not mention it in its synopsis section and
> > it merely has ", rm" after "remove" as if an afterthought.
> 
> It's actually my bad. I should have replaced 'rm' with 'remove' in
> git-remote.txt in e17dba8fe1 (remote: prefer subcommand name 'remove'
> to 'rm' - 2012-09-06)
> 
> > I am not sure if it is worth being more explicit, perhaps like this?
> 
> Looks good. If we want to be more careful, we can follow up with
> something even more annoying like this before removing 'rm'
> 
> -- 8< --
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 577b969c1b..0a544703e6 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -90,7 +90,6 @@ In case <old> and <new> are the same, and <old> is a file under
>  the configuration file format.
>  
>  'remove'::
> -'rm'::
>  
>  Remove the remote named <name>. All remote-tracking branches and
>  configuration settings for the remote are removed.
> diff --git a/builtin/remote.c b/builtin/remote.c
> index d95bf904c3..774ef6931e 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1609,7 +1609,10 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
>  		result = add(argc, argv);
>  	else if (!strcmp(argv[0], "rename"))
>  		result = mv(argc, argv);
> -	else if (!strcmp(argv[0], "rm") || !strcmp(argv[0], "remove"))
> +	else if (!strcmp(argv[0], "rm")) {
> +		warning(_("'rm' is a deprecated synonym. Use 'remove' instead."));
> +		result = rm(argc, argv);
> +	} else if (!strcmp(argv[0], "remove"))
>  		result = rm(argc, argv);
>  	else if (!strcmp(argv[0], "set-head"))
>  		result = set_head(argc, argv);
> -- 8< --
> 
> PS. This also makes me thing about supporting subcommand aliases, so
> that people can add back 'git remote rm' if they like (or something
> like 'git r rm' when they alias 'remote' as well). Which is probably a
> good thing to do. Long command names are fine when you have completion
> support, they are a pain to type otherwise.
> 

Couldn't they just create an alias like git rrm then, if they use it so
often that it becomes an issue? Having another layer of aliases does
create a lot of complexity.

> --
> Duy
