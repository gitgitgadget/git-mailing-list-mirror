From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] git: make "git -C '' <cmd>" not to barf
Date: Fri, 06 Mar 2015 16:23:05 +0530
Message-ID: <54F98711.6010401@gmail.com>
References: <1425625534-11869-1-git-send-email-karthik.188@gmail.com> <CAPig+cSeTA=SfQDouP-WCaSjsMBkUg=9Qm8xxfp0jcq=+GSksg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 11:54:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTptU-0004UG-M1
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 11:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359AbbCFKyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 05:54:05 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:42380 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbbCFKxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 05:53:25 -0500
Received: by pdbfl12 with SMTP id fl12so43051396pdb.9
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 02:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vdV575esQEAjjiuodnNPYAj7/CID72FbqZesidd/hzM=;
        b=Q74txfSdfvtSM9DnE/3zwMx33tBs8qb3wbx9wFDyqZrUhDoyQwG70mdj1YWU7nMcLF
         0+D2k9pp8CvjBb0T8R+uAfcB2W52w9jUuXIorKoVrK6FSEgp0srP34h46g6AwRFBIZxd
         HFXwL9OOkiwzq4QtH0rXG9D0N2jFgGX0EYll/XNXfFU2hIOhla2BaOl9UdNZq8q4g/2f
         JyiIwCG5ZsOtoL+OyY2kApVVqGFZ2eMUUUr+GCN+tun8kGSeLZqfv74puB1DiRERp3ix
         uPhaTBp07wXnJ8b0gSITdrlkoE8AxmH1ill3u4jiq2jqlmJmOI840SG/UhOHGN6faADf
         ow7g==
X-Received: by 10.66.101.106 with SMTP id ff10mr24823360pab.103.1425639204897;
        Fri, 06 Mar 2015 02:53:24 -0800 (PST)
Received: from [192.168.43.24] ([182.156.10.227])
        by mx.google.com with ESMTPSA id ni8sm9203084pdb.83.2015.03.06.02.53.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 02:53:23 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cSeTA=SfQDouP-WCaSjsMBkUg=9Qm8xxfp0jcq=+GSksg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264910>


On 03/06/2015 02:23 PM, Eric Sunshine wrote:
> On Fri, Mar 6, 2015 at 2:05 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > It now acts like "cd ''" and does not barf and treats
> > it as a no-op.
>
> What does "barf" mean in this context? Does the program crash? Spit
> out nonsensical messages? Misbehave in some fashion? A good commit
> message should explain the problem with sufficient detail so readers
> don't need to guess what the "bad" behavior is.
>
> > This is useful if a caller function
> > does not want to change directory and hence gives no
> > path value, which would have generally caused git to
> > output an undesired error message.
>
> This is an odd justification. A caller not wanting to change the
> directory wouldn't pass -C in the first place. A better justification
> might be that die()ing is unnecessarily harsh behavior for what
> otherwise could be considered a no-op, citing "cd ''" as an example.
>
> Also, write in imperative mood, as if you're instructing the code to
> change itself.
>
> Taking the above observations into consideration, you might say:
>
>      git: treat `-C <path>' as a no-op when <path> is empty
>
>      `git -C ""' unhelpfully dies with error "Cannot change to ''",
>      whereas the shell treats `cd ""' as a no-op. Taking the shell's
>      behavior as a precedent, teach git to treat `-C ""' as a no-op, as
>      well.
>
Hey Eric,
I see what you mean.
> > Included a simple test to check the same, as suggested
> > by Junio.
>
> It is a bit weak to say that Junio "suggested" the test, considering
> that he actually wrote it[1].
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> > diff --git a/git.c b/git.c
> > index 8c7ee9c..d734afa 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -204,10 +204,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> >                                  fprintf(stderr, "No directory given for -C.\n" );
> >                                  usage(git_usage_string);
> >                          }
> > -                       if (chdir((*argv)[1]))
> > -                               die_errno("Cannot change to '%s'", (*argv)[1]);
> > -                       if (envchanged)
> > -                               *envchanged = 1;
> > +                       if (*((*argv)[1]) == 0)
>
> Saying '\0' rather than 0 would make the intent clearer.
>
> > +                               ; /* DO not change directory if no directory is given*/
> > +                       else {
> > +                               if (chdir((*argv)[1]))
> > +                                       die_errno("Cannot change to '%s'", (*argv)[1]);
> > +                               if (envchanged)
> > +                                       *envchanged = 1;
> > +                       }
>
> The 'if/else' statement you've composed (with an empty 'if' branch) is
> unnecessarily complicated when a simple 'if' suffices:
Yes, will change this.
>
>      if (*(*argv)[1]) {
>          if (chdir((*argv)[1]))
>              die_errno("Cannot change to '%s'", (*argv)[1]);
>          if (envchanged)
>              *envchanged = 1;
>      }
>
> >                          (*argv)++;
> >                          (*argc)--;
> >                  } else {
> > diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
> > index 99c0377..a6b52f1 100755
> > --- a/t/t0056-git-C.sh
> > +++ b/t/t0056-git-C.sh
> > @@ -14,6 +14,14 @@ test_expect_success '"git -C <path>" runs git from the directory <path>' '
> >          test_cmp expected actual
> >   '
> >
> > +test_expect_success '"git -C <path>" with an empty <path> is a no-op' '
> > +       mkdir -p dir1/subdir &&
> > +       cd dir1/subdir &&
>
> When Junio composed this test[1], he intentionally wrapped it in a
> subshell via '(' and ')'. The problem with dropping the subshell, as
> you did here, is that the 'cd' in this test will still be in effect
> when tests following this one are run, which typically will break
> them. Wrapping the test in a subshell side-steps the problem because
> the parent shell is not affected by 'cd' within the subshell. To
> summarize: Don't remove the subshell from Junio's example.
>
> (You lucked out in this case, by accident, since the following tests
> are not impacted by such ill-behavior.)
I did not know that. I got lucky, definitely.
>
> > +       git -C "" rev-parse --show-prefix >actual &&
> > +       echo subdir/ >expect
>
> Broken &&-chain.
>
> > +       test_cmp expect actual
> > +'
> > +
> >   test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
> >          test_create_repo dir1/dir2 &&
> >          echo 1 >dir1/dir2/b.txt &&
> > --
> > 2.3.1.167.g7f4ba4b.dirty
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/264871
>
Thanks for the code review, will be back with the next patch :D
