Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854D61F829
	for <e@80x24.org>; Wed,  3 May 2017 17:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbdECRhr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 May 2017 13:37:47 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:47341 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753995AbdECRhl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 13:37:41 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 80DD32003B4;
        Wed,  3 May 2017 19:37:38 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] usability: don't ask questions if no reply is required
Date:   Wed, 03 May 2017 19:37:38 +0200
Message-ID: <2484534.KmWiS2caPb@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20170503164744.GY28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr> <20170503164744.GY28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mercredi 3 mai 2017, 09:47:44 CEST Jonathan Nieder a écrit :
> Hi,
> 
> Jean-Noel Avila wrote:
> > As described in the bug report at
> > 
> > https://github.com/git/git-scm.com/issues/999
> 
> External issue tracker URLs have been known to change or disappear and
> we try to make commit messages self-contained instead of relying on
> them.  It is common to put a 'Requested-by:' footer or sentence saying
> 'Requested at <url> by <person>' near the bottom of a commit message
> for attribution and context.  Relying on the bug report more heavily
> like this example (instead of including any relevant information)
> makes it harder for a reader to understand the patch easily in
> one place.
> 
> In other words, instead of asking the reader to read the bug report,
> please include pertinent information the reader needs to
> understand the patch here so they don't have to.

Ok. Will include more context in the commit message and just provide the BT as 
an additional link.

> 
> > the user was disconcerted by the question asked by the program not
> > requiring a reply from the user. To improve the general usability of
> > the Git suite, The following rule was applied:
> > 
> > if the sentence
> > 
> >  * appears in a non-interactive session
> >  * is printed last before exit
> >  * is a question addressing the user ("you")
> > 
> > the sentence is turned into affirmative and proposes the option.
> > 
> > Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> > ---
> > 
> >  help.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/help.c b/help.c
> > index bc6cd19cf..4658a55c6 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
> > 
> >  	if (SIMILAR_ENOUGH(best_similarity)) {
> >  	
> >  		fprintf_ln(stderr,
> > 
> > -			   Q_("\nDid you mean this?",
> > -			      "\nDid you mean one of these?",
> > +			   Q_("\nThe most approaching command is",
> > +			      "\nThe most approaching commands are",
> > 
> >  			   n));
> 
> For what it's worth, I find the new text harder to understand than the
> old text.
> 
> From the bug report:
> 
> 	Now git says git: 'stahs' is not a git command. See 'git --help'.
> 	Did you mean this?
> 
> 	stash
> 
> 	Git asked if i meant git stash. and i entered yes. and git
> 	printed the character y infinite times.
> 
> If I'm reading that correctly, the problem is not that questions are
> alarming but that Git did not cope well with the answer.  When I try
> to reproduce it, I get

No, I don't think that the questions are alarming. The whole point is that Git 
no longer runs when the user enters its reply. In the case of the bug report, 
the user was unlucky to type in the name of the shell command `yes` because he 
was thinking that Git was still running interactively, due to the question at 
the end of the run.

So this patch series'aim is simply to get rid of asking questions just before 
exiting. Even if a question might seem more user friendly, it's insufficiently 
formal to indicate to the user that there's no point replying. The question 
was just a hint, and it should presented as such.

To be fair, I'm not accustomed enough to the code to know exactly in which 
cases the given strings are occurring (except here). All the patch series 
tries to tackle this at different levels. Maybe squashing them all would be 
better for understanding. 

> 
> 	$ git stahs
> 	WARNING: You called a Git command named 'stahs', which does not exist.
> 	Continuing under the assumption that you meant 'stash'
> 	in 5.0 seconds automatically...
> 
> which is much clearer.  After commenting out "[help] autocorrect = 50" in my
> ~/.config/git/config, I get
> 
> 	$ git stahs
> 	git: 'stahs' is not a git command. See 'git --help'.
> 
> 	Did you mean this?
> 		stash
> 
> which does seem improvable, at least for consistency with the
> autocorrect case.  For example, would something like
> 
> 	$ git stahs
> 	fatal: You called a Git command named 'stahs', which does not exist.
> 	hint: Did you mean 'git stash'?
> 
> work better?  And the autocorrect case could say something like

Would adding a "hint:" prefix be enough to provide context? I don't think so. 
I'd prefer to be clearer on the objectives of the printed information, even at 
the risk of being clumsy.


>
> 	$ git stahs
> 	warning: You called a Git command named 'stahs', which does not exist.
> 	warning: Continuing under the assumption that you meant 'stash'
> 	warning: in 5.0 seconds automatically...
> 
> Is contact information for the bug reporter available so we can try out
> different wordings and see what works for them?

I guess so. The discussion on github is still open and only depends on the 
willingness of the reporter to reply.


> 
> Thanks and hope that helps,
> Jonathan


