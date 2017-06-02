Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7CF320D12
	for <e@80x24.org>; Fri,  2 Jun 2017 07:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdFBHAz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 03:00:55 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:35092 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFBHAz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 03:00:55 -0400
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 7ED37D400B2;
        Fri,  2 Jun 2017 10:00:52 +0300 (MSK)
Date:   Fri, 2 Jun 2017 10:00:52 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Davide Fiorentino <davide.fiorentino@gmail.com>
Subject: Re: How to avoid "Please tell me who you are..."?
Message-ID: <20170602070052.3lq22arcncuh6rrl@tigra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
 <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 02:02:22AM -0400, Jeffrey Walton wrote:

> I'm working on a test machine. It mostly needs to be a clone of
> upstream. On occasion it needs to test a particular commit.
> 
> When I attempt to test a commit it produces:
> 
>     $ git cherry-pick eb3b27a6a543
> 
>     *** Please tell me who you are.
[...]
> This is a nameless test account, so there is no information to provide.
> 
> How do I tell Git to ignore these checks?
[...]
> Well, they don't exist so there's nothing to set.
> 
> The machine below its a CubieBoard used for testing. I remote into it
> with test@. As a matter of policy, no check-ins occur on it. Other
> than the password database and authroized_keys file, there is no
> information on it to be lost or stolen.

`git cherry-pick` wants to record a commit.  A commit in Git always
possess the information on "the committer" -- whoever recorded the
commit (it might be distinct from the commit author, as is the case with
cherry-picking).  There's no way to not set the committer.

I envision two ways to get around this situation:

1) Patch the ~/.whatevershellrc of your test account to set this
   information by setting and exporting the GIT_AUTHOR_NAME and
   GIT_AUTHOR_EMAIL env. variables (and may be others -- see the
   "git" manual page; run `git help git`).
   
   May be even add it in /etc/skel to make all accounts create inherit
   it.

2) Set these parameters in the repository you're working with.

   While Git suggests you to pass "--global" to the `git config`
   invocations, it's perfectly OK to use "--local" with them (which is
   IIRC the default, if not supplied) to make these settings be recorded
   in the repository's configuration rather than in ~/.gitconfig.

3) Pass these options explicitly to Git invocations or make a shell
   alias which would do so, like with

   function git() {
     command git \
		-c user.name='Joe Tester' \
		-c user.email=tester@acme.corp \
		"$@"
   }

I'd personally go with (2).

