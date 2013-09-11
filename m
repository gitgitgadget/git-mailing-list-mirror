From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] reset: handle submodule with trailing slash
Date: Wed, 11 Sep 2013 12:08:06 +0100
Message-ID: <20130911110806.GT2582@serenity.lan>
References: <cover.1378840318.git.john@keeping.me.uk>
 <c7e026f44f9ccbf5736b72e728a360b31887a50f.1378840318.git.john@keeping.me.uk>
 <52300838.5040703@kdbg.org>
 <20130911082042.GR2582@serenity.lan>
 <CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 13:08:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJiHY-0001wu-GJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 13:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099Ab3IKLIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 07:08:20 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43001 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab3IKLIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 07:08:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5550ECDA5BB;
	Wed, 11 Sep 2013 12:08:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YhNmic1UgFcW; Wed, 11 Sep 2013 12:08:18 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 01D90CDA5BF;
	Wed, 11 Sep 2013 12:08:17 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E6455161E032;
	Wed, 11 Sep 2013 12:08:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pjfl3AwH89Og; Wed, 11 Sep 2013 12:08:16 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4633B161E4AE;
	Wed, 11 Sep 2013 12:08:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CACsJy8BgEM3eEDo8wOgkqYTL1fkh9azZNqbogxBubp9g5KRNbQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234558>

On Wed, Sep 11, 2013 at 05:54:48PM +0700, Duy Nguyen wrote:
> On Wed, Sep 11, 2013 at 3:20 PM, John Keeping <john@keeping.me.uk> wrote:
> > On Wed, Sep 11, 2013 at 08:05:44AM +0200, Johannes Sixt wrote:
> >> Am 10.09.2013 21:13, schrieb John Keeping:
> >> > When using tab-completion, a directory path will often end with a
> >> > trailing slash which currently confuses "git rm" when dealing with
> >> > submodules.  Now that we have parse_pathspec we can easily handle this
> >> > by simply adding the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag.
> >> >
> >> > Signed-off-by: John Keeping <john@keeping.me.uk>
> >> > ---
> >> >  builtin/reset.c            | 5 +++++
> >> >  t/t7400-submodule-basic.sh | 6 ++++--
> >> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/builtin/reset.c b/builtin/reset.c
> >> > index 5e4c551..9efac0f 100644
> >> > --- a/builtin/reset.c
> >> > +++ b/builtin/reset.c
> >> > @@ -220,8 +220,13 @@ static void parse_args(struct pathspec *pathspec,
> >> >             }
> >> >     }
> >> >     *rev_ret = rev;
> >> > +
> >> > +   if (read_cache() < 0)
> >> > +           die(_("index file corrupt"));
> >>
> >> When the index is now read here, I would have expected hunk in this
> >> patch that removes a read_cache() invocation.
> >
> > I think that needs to look like this on top - there's also a
> > read_cache_unmerged() around line 68 but I don't think we can remove
> > that one.
> >
> > -- >8 --
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 9efac0f..800117f 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -143,7 +143,6 @@ static int read_from_tree(const struct pathspec *pathspec,
> >         opt.output_format = DIFF_FORMAT_CALLBACK;
> >         opt.format_callback = update_index_from_diff;
> >
> > -       read_cache();
> >         if (do_diff_cache(tree_sha1, &opt))
> >                 return 1;
> >         diffcore_std(&opt);
> > @@ -169,7 +168,7 @@ static void set_reflog_message(struct strbuf *sb, const char *action,
> >
> >  static void die_if_unmerged_cache(int reset_type)
> >  {
> > -       if (is_merge() || read_cache() < 0 || unmerged_cache())
> > +       if (is_merge() || unmerged_cache())
> >                 die(_("Cannot do a %s reset in the middle of a merge."),
> >                     _(reset_type_names[reset_type]));
> 
> reset --soft does not go through these code paths (i.e. it does not
> need index at all). If we fail to load index index in "reset --soft" I
> think it's ok to die(). Corrupt index is fatal anyway. But "reset
> --soft" now has to pay the cost to load index, which could be slow
> when the index is big. Assuming nobody does "reset --soft" that often
> I think this is OK.
> 
> Alternatively we could load index lazily in _CHEAP code only when we
> see trailing slashes, then replace these read_cache() with
> read_cache_unless_its_already_loaded_earlier() or something.

read_cache() already has an early return if the index is already loaded
so I don't think we need to worry about a special function for that.

I'm not sure it's worth optimizing this case too heavily, but it might
be a nice change to make parse_pathspec() not rely on the index being
loaded before it is called with certain flags.
