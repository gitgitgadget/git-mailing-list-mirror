Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BEEC433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ED22310E
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 13:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgLFNH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 08:07:58 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:51363 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFNH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 08:07:58 -0500
Received: from localhost (unknown [103.82.80.195])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 46B15100004;
        Sun,  6 Dec 2020 13:07:14 +0000 (UTC)
Date:   Sun, 6 Dec 2020 18:37:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-gui: fix colored label backgrounds when using
 themed widgets
Message-ID: <20201206130711.halhskksavsvojm2@yadavpratyush.com>
References: <20201122194537.41870-1-stefan@haller-berlin.de>
 <20201122194537.41870-2-stefan@haller-berlin.de>
 <20201201200634.bazwncj7yyp7vksn@yadavpratyush.com>
 <c8cbdfa1-f3f3-725a-124d-6f70b96767d1@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8cbdfa1-f3f3-725a-124d-6f70b96767d1@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12/20 09:52AM, Stefan Haller wrote:
> On 01.12.20 21:06, Pratyush Yadav wrote:
> > Hi Stefan,
> > 
> > Thanks for the patch.
> > 
> > On 22/11/20 08:45PM, Stefan Haller wrote:
> >> The aqua theme on Mac doesn't support changing the background color for labels
> >> and frames [1]. Since the red, green, and yellow backgrounds of the labels for
> >> unstaged and staged files and the diff pane are so important design elements of
> >> git gui's main window, it's not acceptable for them to have grey backgrounds on
> >> Mac.
> > 
> > I unfortunately don't have access to a Mac machine to I can't test this 
> > patch.
> 
> I could send screenshots if that helps.

Yes, that would be helpful.
 
> > Were the colors fine before c02efc1 (git-gui: improve dark mode support, 
> > 2020-09-26)? From what I understand that patch should not affect the 
> > colors of the "Staged Changes" or the "Unstaged Changes" parts.
> > 
> > If the colors were fine earlier then we need to figure out why colors 
> > from the theme are being used even when we hard-code green or red when 
> > creating those labels.
> > 
> > Can you give it a try on a commit before c02efc1 and see what happens?
> 
> No, the colors were wrong on Mac for the past ten years, all the way
> back to when ttk widgets were introduced in c80d7be5e1 ("git-gui: use
> themed tk widgets with Tk 8.5", 2010-01-26).
> 
> It is simply not possible to change the background color of a ttk button
> or label on Mac; c02efc1 doesn't have anything to do with this.

Ok. Thanks for the clarification. Will apply the patch.
 
> -Stefan
> 
> 
> >> To work around this, simply use non-themed widgets for all labels on Mac. This
> >> is not a big problem because labels don't look extremely different between the
> >> themed and non-themed versions. There are subtle differences, but they are not
> >> as bad as having the wrong background color.
> > 
> > Agreed. Though I certainly wish we didn't have to do this.
> >  
> >> [1] https://stackoverflow.com/a/6723911
> >>
> >> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> >> ---
> >>  lib/themed.tcl | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/themed.tcl b/lib/themed.tcl
> >> index 83e3ac7..02aae90 100644
> >> --- a/lib/themed.tcl
> >> +++ b/lib/themed.tcl
> >> @@ -174,7 +174,7 @@ proc InitEntryFrame {} {
> >>
> >>  proc gold_frame {w args} {
> >>  	global use_ttk
> >> -	if {$use_ttk} {
> >> +	if {$use_ttk && ![is_MacOSX]} {
> >>  		eval [linsert $args 0 ttk::frame $w -style Gold.TFrame]
> >>  	} else {
> >>  		eval [linsert $args 0 frame $w -background gold]
> >> @@ -183,7 +183,7 @@ proc gold_frame {w args} {
> >>
> >>  proc tlabel {w args} {
> >>  	global use_ttk
> >> -	if {$use_ttk} {
> >> +	if {$use_ttk && ![is_MacOSX]} {
> >>  		set cmd [list ttk::label $w -style Color.TLabel]
> >>  		foreach {k v} $args {
> >>  			switch -glob -- $k {
> > 

-- 
Regards,
Pratyush Yadav
