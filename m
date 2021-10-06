Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6619C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AFA61027
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 18:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhJFSFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:05:46 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36301 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbhJFSFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 14:05:45 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 63D49200004;
        Wed,  6 Oct 2021 18:03:50 +0000 (UTC)
Date:   Wed, 6 Oct 2021 23:33:48 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Sashank Bandi <bandi.rao999@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
Message-ID: <20211006180348.22e5c2z4pqkwtokx@yadavpratyush.com>
References: <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
 <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
 <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
 <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
 <20211004075600.5lbqed4mnwfsy4al@yadavpratyush.com>
 <CABkJDHGdzOFW5yP43LZtuUrV7WsDTvAi+kxka84-5P7ShbV9FQ@mail.gmail.com>
 <20211006113912.n7xpnuzd25256cjm@yadavpratyush.com>
 <CABkJDHFap2DmjMr1Ri-Mrud+msChB3uEGRKYyczAxfmaLnF6jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABkJDHFap2DmjMr1Ri-Mrud+msChB3uEGRKYyczAxfmaLnF6jA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/21 08:15PM, Sashank Bandi wrote:
> > Does the Windows installation come with any other themes? You can use
> > `ttk::style theme names` to list all available themes.
> It contains all these themes in Windows 10 x64.
> "winnative clam alt default classic vista xpnative"
> Based of [0] (the best source I could find),
> "winnative", "vista", "xpnative" are Windows-only but built-in themes and
> "clam", "alt", "default", "classic" are built-in themes for all OSes.
> And this is part of the reason I am considering "default" to be the
> base of the new theme that I want to create instead of "vista".

You are of course free to design your own theme, but I would suggest you 
try all these themes already available first and see if any of them fit 
your needs.

> 
> > > > I think it would be nice if we can have a theme picker in the options
> > > > menu though, so that is something you might want to look into.
> > > Yes, I thought of adding a menu between "Tools" and "Help". It will
> > > contain 3 options(system, light, dark) as I said before.
> >
> > I think it would be better to put it in the "options" dialog.
> Ok.
> 
> > I don't mind carrying themes in the git-gui repo since Tk theming
> > support is not very well documented or standardized. But please do be
> > careful of licence compatibility when porting code.
> No, I want to imitate the look. And I don't actually know much about
> the license or legal side of the software so I try to avoid it at all
> costs and start from scratch.
> Kinda like "Linux is Unix-like, but it doesn't contain Unix's code" -
> The great Linus Torvalds.

Well, I am not expert on software licenses either. Though using a quick 
Google search for license compatibility generally does the trick for me.

> 
> The "equilux" theme is GPLv3, but I didn't find a license file in the
> repo. In the "Help > About" part of Git GUI, you mentioned it being
> GPL(I think v1). Please include it in the repo too.

git-gui is GPL v2 or later. So I would assume it is compatible with GPL 
v3 but I am not entirely sure.

Anyway, I came up with a quick proof of concept for a theme selector. It 
has many limitations and is not fit to apply just yet, but it should 
help you get started.

-- 8< --
Subject: [PATCH] git-gui: Add a very crude theme selector

Tk themeing is not very well documented and is not easy to get right.
Ideally one would want to set the theme for a toolkit in one standard,
but it is hard to find that standard config for Tk and even harder to
get it to work consistently.

Add a theme selection menu to make the lives of the user easier. Those
who would wish to use the Tk provided theme should be able to do so.

This is a very crude patch and it does not really ensure that. This is
more of a proof of concept.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh     | 4 ++++
 lib/option.tcl | 1 +
 2 files changed, 5 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 201524c..ff2ec1b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -862,6 +862,9 @@ proc apply_config {} {
 			set NS ttk
 			bind [winfo class .] <<ThemeChanged>> [list InitTheme]
 			pave_toplevel .
+			if {[get_config gui.theme] != {}} {
+				ttk::style theme use [get_config gui.theme]
+			}
 			color::sync_with_theme
 		}
 	}
@@ -895,6 +898,7 @@ set default_config(gui.fontdiff) [font configure font_diff]
 # TODO: this option should be added to the git-config documentation
 set default_config(gui.maxfilesdisplayed) 5000
 set default_config(gui.usettk) 1
+set default_config(gui.theme) "default"
 set default_config(gui.warndetachedcommit) 1
 set default_config(gui.tabsize) 8
 set font_descs {
diff --git a/lib/option.tcl b/lib/option.tcl
index e43971b..acce160 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -160,6 +160,7 @@ proc do_options {} {
 		{c gui.encoding {mc "Default File Contents Encoding"}}
 		{b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
+		{s gui.theme {mc "GUI theme"} {ttk::style theme names}}
 		{b gui.displayuntracked {mc "Show untracked files"}}
 		{i-1..99 gui.tabsize {mc "Tab spacing"}}
 		} {
-- 
Regards,
Pratyush Yadav
