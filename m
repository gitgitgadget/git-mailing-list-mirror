Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15A81F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfHZTKL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:10:11 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54857 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfHZTKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:10:11 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C5A83200004;
        Mon, 26 Aug 2019 19:10:08 +0000 (UTC)
Date:   Tue, 27 Aug 2019 00:40:06 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Update in-memory config when changing config
 options
Message-ID: <20190826191006.dmcj6kipwxnttc3s@yadavpratyush.com>
References: <20190822223316.11153-1-me@yadavpratyush.com>
 <xmqqimqkknup.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqimqkknup.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/08/19 07:22AM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> 
> > Subject: Re: [PATCH] git-gui: Update in-memory config when changing config options
> 
> s/git-gui: Update/git-gui: update/
 
I fixed this in my tree, just didn't send a re-roll with it. I assumed 
you will pull from there so you'd get the updated subject.

> >  lib/option.tcl | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/option.tcl b/lib/option.tcl
> > index e43971b..139cf44 100644
> > --- a/lib/option.tcl
> > +++ b/lib/option.tcl
> > @@ -344,6 +344,7 @@ proc do_save_config {w} {
> >  	if {[catch {save_config} err]} {
> >  		error_popup [strcat [mc "Failed to completely save options:"] "\n\n$err"]
> >  	}
> > +	load_config 1
> 
> This may make the symptom go away, and in that sense it would be a
> good change in the short term.
 
True.

> But I have to suspect that it may indicate a misdesign in the "edit
> configuration" part of the program that the newly set configuration
> value must load back to the program from the filesystem.  That feels
> backwards.
> 
> NaaNaïvely, one would imagine a program wia capability to save and
> load run-time options to disk to behave this way, no?
> 
>  * a set of in-core variables exist to control various aspects of
>    the program (e.g. font size, background colour, etc.)
> 
>  * there is a "load config" helper function that can be called to
>    populate these in-core variables from an external file.
> 
>  * there is a "edit config" UI that can be used to toggle these
>    in-core variables (the checkboxes and radio buttons may not
>    directly be connected to the underlying variables, but to their
>    temporary counterparts and there may be a "OK" button in the UI
>    to commit the changes to the temporaries to the real in-core
>    variables).
> 
>  * there is a "save config" helper function that can be called to do
>    the reverse of "load config"; one of the places that calls this
>    helper is upon the success of "edit config".

I took a deeper look, and saving config should _in theory_ update the 
in-memory state, and this indeed does happen for repo-specific settings 
(which I unfortunately didn't test too well. Sorry). Changing global 
settings is what is flawed.

I leave it up to you to decide if you want to pull the current patch. I 
don't mind if you don't. I'll see if I can find some time to debug this 
and send a proper fix.

Thanks for your input.
 
> I didn't look at the lib/option.tcl to check, but I would suspect
> that it would require a far larger change than your single liner if
> we wanted to restructure the option tweaking part in such a way, and
> it would be much more preferrable to use the single liner patch at
> least for now, but in the longer term you might want to consider
> such a clean-up.

-- 
Regards,
Pratyush Yadav
