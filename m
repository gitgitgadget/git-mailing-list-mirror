Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC481FCA9
	for <e@80x24.org>; Tue, 13 Sep 2016 08:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbcIMIKS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 04:10:18 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36014 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbcIMIKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 04:10:16 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so157271580qkc.3
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 01:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A9WWkdDdkjSjzAqkoe9X9O+I7cOVrftXNVDmOFpZ2Y0=;
        b=inv78al2lj/vf2EYCj8mkmgKPQ48JlMhvi12lihk3rg3ZIA+rHbupS4yiZ3LRicC7f
         oYpWP0gCi+ba80d8Q1/V5e4oGjTkYa7mnohChpy3H6ydb5dA+AIt/eNJew2I76BOQehH
         tf/YME8yMrqTZrvTG2cJ6/68YlGqnhhQlGzwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A9WWkdDdkjSjzAqkoe9X9O+I7cOVrftXNVDmOFpZ2Y0=;
        b=LQyeUForEWTmpjdx41myKtogz3hs0VEZ0mQ+Z2AEPTJfpBgOk12Qw8Ng8+UXXKRAk4
         6mDlKukX1Hd1QdQMlPv7piUf0qp4uv3YcHjvaAEZLWtBKmFgkx8t3HU2KfQzGcsIpgrr
         wva5uIOU1WEPN7R7Mr49dWY9I+llTXyRMpF6S9jlgghYbRsERAE+MqaIJGsq0z4yd4kS
         Me7IHMEZIClNzASSJlN3vpg0qDvT4d0Vp7KUclipya0Z0X//HHyZADE2W5ScLwZiABjb
         Xn8aKvk/1hhSK5s+U3gS8/IPatplaEWyFeWwiR0xwv1CJymNDNZasPDuOHiFbTk5Mxhc
         4Pzw==
X-Gm-Message-State: AE9vXwOXPSgnwPUMsIIc/qWrZY7U41hv5LHZFcq7hkyS0Jn+I4knLzFN5wmFPfmMOD82pjQxRMT+hoGr/0CEsg==
X-Received: by 10.55.101.7 with SMTP id z7mr24436499qkb.186.1473754215773;
 Tue, 13 Sep 2016 01:10:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.33.104 with HTTP; Tue, 13 Sep 2016 01:10:15 -0700 (PDT)
In-Reply-To: <1473717733-65682-2-git-send-email-orirawlings@gmail.com>
References: <1473717733-65682-1-git-send-email-orirawlings@gmail.com> <1473717733-65682-2-git-send-email-orirawlings@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 13 Sep 2016 09:10:15 +0100
Message-ID: <CAE5ih79LCdUsTXXBYXdR-KL=A2wN=TfQ+SSD4g+_o2YDHKsQ3A@mail.gmail.com>
Subject: Re: [PATCH] [git-p4.py] Add --checkpoint-period option to sync/clone
To:     Ori Rawlings <orirawlings@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Vitor Antunes <vitor.hda@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Pete Wyckoff <pw@padd.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 September 2016 at 23:02, Ori Rawlings <orirawlings@gmail.com> wrote:
> Importing a long history from Perforce into git using the git-p4 tool
> can be especially challenging. The `git p4 clone` operation is based
> on an all-or-nothing transactionality guarantee. Under real-world
> conditions like network unreliability or a busy Perforce server,
> `git p4 clone` and  `git p4 sync` operations can easily fail, forcing a
> user to restart the import process from the beginning. The longer the
> history being imported, the more likely a fault occurs during the
> process. Long enough imports thus become statistically unlikely to ever
> succeed.

That would never happen :-)

The usual thing that I find is that my Perforce login session expires.

>
> The underlying git fast-import protocol supports an explicit checkpoint
> command. The idea here is to optionally allow the user to force an
> explicit checkpoint every <x> seconds. If the sync/clone operation fails
> branches are left updated at the appropriate commit available during the
> latest checkpoint. This allows a user to resume importing Perforce
> history while only having to repeat at most approximately <x> seconds
> worth of import activity.

I think this ought to work, and could be quite useful. It would be
good to have some kind of test case for it though, and updated
documentation.

Luke

>
> Signed-off-by: Ori Rawlings <orirawlings@gmail.com>
> ---
>  git-p4.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index fd5ca52..40cb64f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2244,6 +2244,7 @@ class P4Sync(Command, P4UserMap):
>                  optparse.make_option("-/", dest="cloneExclude",
>                                       action="append", type="string",
>                                       help="exclude depot path"),
> +                optparse.make_option("--checkpoint-period", dest="checkpointPeriod", type="int", help="Period in seconds between explict git fast-import checkpoints (by default, no explicit checkpoints are performed)"),
>          ]
>          self.description = """Imports from Perforce into a git repository.\n
>      example:
> @@ -2276,6 +2277,7 @@ class P4Sync(Command, P4UserMap):
>          self.tempBranches = []
>          self.tempBranchLocation = "refs/git-p4-tmp"
>          self.largeFileSystem = None
> +        self.checkpointPeriod = -1

Or use None?

>
>          if gitConfig('git-p4.largeFileSystem'):
>              largeFileSystemConstructor = globals()[gitConfig('git-p4.largeFileSystem')]
> @@ -3031,6 +3033,8 @@ class P4Sync(Command, P4UserMap):
>
>      def importChanges(self, changes):
>          cnt = 1
> +        if self.checkpointPeriod > -1:
> +            self.lastCheckpointTime = time.time()

Could you just always set the lastCheckpointTime?

>          for change in changes:
>              description = p4_describe(change)
>              self.updateOptionDict(description)
> @@ -3107,6 +3111,10 @@ class P4Sync(Command, P4UserMap):
>                                  self.initialParent)
>                      # only needed once, to connect to the previous commit
>                      self.initialParent = ""
> +
> +                    if self.checkpointPeriod > -1 and time.time() - self.lastCheckpointTime > self.checkpointPeriod:
> +                        self.checkpoint()
> +                        self.lastCheckpointTime = time.time()

If you use time.time(), then this could fail to work as expected if
the system time goes backwards (e.g. NTP updates). However, Python 2
doesn't have access to clock_gettime() without jumping through hoops,
so perhaps we leave this as a bug until git-p4 gets ported to Python
3.



>              except IOError:
>                  print self.gitError.read()
>                  sys.exit(1)
> --
> 2.7.4 (Apple Git-66)
>
