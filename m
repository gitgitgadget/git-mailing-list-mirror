Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1D81FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 17:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033528AbdDTRsH (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 13:48:07 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36284 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033530AbdDTRsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 13:48:05 -0400
Received: by mail-oi0-f48.google.com with SMTP id r203so60267338oib.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zdPzo5j6H6P7fmcgUD86CYxEFg/bBzDEoss/Mteb3YE=;
        b=evkkoIwh5D96wsS0/ADA4BBR5pPaCE7b8PFIm/pHqhu9zPX5ZgFDYGvGzg9qqUEnRQ
         JmblCGYy+FofQX6LfHBxVwMFUBPDvp6z5ADb3B32Wk6wlND9LA+BjEYRhibQwBX7J4q3
         XlECprZJZZA85mmNe34yiKp9KMJhWzwCB2Rfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zdPzo5j6H6P7fmcgUD86CYxEFg/bBzDEoss/Mteb3YE=;
        b=ES5UaHjJuvydNQpJqPozBVEItxWjDJhS5OuQo3h/ZbsaWcCkcqTetUUHcU+kURpGBi
         y4vBYrgRN//8CVRCnQRJitu5MRrJfq69aZgafA+srELJMxHyak9C5dQHFkhFUNL5kFnX
         as6GZuY0fgJlGW3hb0rw5We2izUXvQs0Fzs0yrLKdaRgmBzjhweffs7y3HTaIJ6ENjYm
         C5fMUlFr+hazIrJ4lXRNeQsekXV43F17yrBfWJcnnip5gQyOAuNxsbVmEsCxxeJjLH6s
         +JJBoZNYZdmf5iFqjMiQhsjVjI1+5ZiWF4RgBrG0jghAzD60UyxbKAZWMWMs32M8rK/3
         5g2g==
X-Gm-Message-State: AN3rC/4gX7TDzimXmi914NmIy7Y+5ZIuuf/UDRPf4tOpry71EK6rstha
        AwQQQnaj8BK0qqdd4q81uLEg8Pzwtg==
X-Received: by 10.157.56.189 with SMTP id p58mr2065263otc.25.1492710484611;
 Thu, 20 Apr 2017 10:48:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.39.43 with HTTP; Thu, 20 Apr 2017 10:48:04 -0700 (PDT)
In-Reply-To: <20170420135232.16415-1-aoakley@roku.com>
References: <20170420135232.16415-1-aoakley@roku.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 20 Apr 2017 18:48:04 +0100
Message-ID: <CAE5ih7-V6JzG8RZBoVDxGAOPuFt86r+UC1t5adKre29CFu8bOw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: improve branch option handling
To:     Andrew Oakley <aoakley@roku.com>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 April 2017 at 14:52, Andrew Oakley <aoakley@roku.com> wrote:
> It is sometimes useful (much quicker) to request commands only operate
> on a single branch.
>
> The P4Sync command has been updated to handle self.branch being None for
> consitency with the P4Submit.

Should that be consistency?


>
> The P4Rebase command has been given a branch option which is forwarded
> to the P4Sync command it runs.
>
> The P4Submit command has been simplified to not call P4Sync itself, it
> lets P4Rebase do it instead (now that the branch can be handled).  This
> fixes an issue where P4Submit does a sync of the requested branch and
> then does a rebase which does a sync of all branches.
>
> Signed-off-by: Andrew Oakley <aoakley@roku.com>
> ---
>  Documentation/git-p4.txt |  4 ++++
>  git-p4.py                | 15 +++++++--------
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 7436c64..a03a291 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -328,6 +328,10 @@ Rebase options
>  ~~~~~~~~~~~~~~
>  These options can be used to modify 'git p4 rebase' behavior.
>
> +--branch <branch>::
> +       Sync this named branch instead of the default p4/master.  See the
> +       "Sync options" section above for more information.
> +
>  --import-labels::
>         Import p4 labels.
>
> diff --git a/git-p4.py b/git-p4.py
> index 8d151da..e58b34a 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2161,13 +2161,9 @@ class P4Submit(Command, P4UserMap):
>          elif len(commits) == len(applied):
>              print ("All commits {0}!".format(shelved_applied))
>
> -            sync = P4Sync()
> -            if self.branch:
> -                sync.branch = self.branch
> -            sync.run([])
> -
>              rebase = P4Rebase()
> -            rebase.rebase()
> +            rebase.branch = self.branch
> +            rebase.run([])
>
>          else:
>              if len(applied) == 0:
> @@ -2343,7 +2339,7 @@ class P4Sync(Command, P4UserMap):
>          self.silent = False
>          self.createdBranches = set()
>          self.committedChanges = set()
> -        self.branch = ""
> +        self.branch = None
>          self.detectBranches = False
>          self.detectLabels = False
>          self.importLabels = False
> @@ -3281,7 +3277,7 @@ class P4Sync(Command, P4UserMap):
>                  system("git fetch origin")
>
>          branch_arg_given = bool(self.branch)
> -        if len(self.branch) == 0:
> +        if not branch_arg_given:
>              self.branch = self.refPrefix + "master"
>              if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
>                  system("git update-ref %s refs/heads/p4" % self.branch)
> @@ -3567,14 +3563,17 @@ class P4Rebase(Command):
>      def __init__(self):
>          Command.__init__(self)
>          self.options = [
> +                optparse.make_option("--branch", dest="branch"),
>                  optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
>          ]
> +        self.branch = None
>          self.importLabels = False
>          self.description = ("Fetches the latest revision from perforce and "
>                              + "rebases the current work (branch) against it")
>
>      def run(self, args):
>          sync = P4Sync()
> +        sync.branch = self.branch
>          sync.importLabels = self.importLabels
>          sync.run([])
>
> --
> 2.10.2
>

Apart from the typo above, this looks sensible to me. Would you be
able to add a test case?

Thanks!
Luke
