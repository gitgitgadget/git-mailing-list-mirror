Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A52C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 13:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360312082E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 13:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brightrockgames-com.20150623.gappssmtp.com header.i=@brightrockgames-com.20150623.gappssmtp.com header.b="iTRsGFPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLSNZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:25:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37015 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 08:25:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so7224818otn.4
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brightrockgames-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XpOKRIzWJjri3ezznGz7p8MNZxKIbgHtpwKX7CNKkM8=;
        b=iTRsGFPXJRl3SB4ZW72iW12NYXEeGUsQwDXISKS6Ogi2FVJ8TBbbzwQNGi3BknVqO0
         b/+mIJBnTuvrHx0LzFpz8XxuK2lGIRCD93RqSDimDo0dFi4Ts+NqNST27fGwt0QN3b56
         FoUfkdGqLTLeU9tUBOhd9uWxy+Ttr0LVOph4yVHmDV44OWfcPop/f/RTuErQk/WwqsVP
         bOzp9GBZj6BL9qBzP7Vrqr+opJO31NcSyHDoXKlieeClMrYHh4IwDPUV7yrfJliE6MP8
         BTjYkFzAzhXrHX3XgZyNEda4mY+FhdBvTjHCLSElB5ysl6D0P51c7zt046j4bb66mk7S
         WAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XpOKRIzWJjri3ezznGz7p8MNZxKIbgHtpwKX7CNKkM8=;
        b=S7lLTEiQk1KcJGCab9HG/ADugHdfUmhviqkBx5Nb8I5SY/agVDEcFx/T9deZHsYVGQ
         t5i8gYbPRF9k1U43st28Km+8uNsT1GHbqfeAHPzTS/M7mAP2yBYp3Gu2nx8sGXwI+fQC
         qY6qjvF6MC/Dcox77NWelPDKlwLEHOqZJt2KGKf7t/yPD2rlNjbreUrGKEWPPfFGk3aW
         V07TbcOEdQEcQdYu+YByPs6lNdbK73dScIvVZLnfePNU4aZkPyV+qKIX9RyyY/YKoHzz
         3hoFAfSewoxbyWcftzXYWzJqjNOF5jDt2fArGv6dJsjRKS1zLLXSYJdaAw/wmfO4d/N1
         lzSg==
X-Gm-Message-State: APjAAAV68f1woSq6S0gFh5V6nwwrI3OXmSxHJJDrtvs4zT2rfkDKvT21
        ELfjDxwA/Rgjq13sboocJO08W6xI0DzY8NMWWfVHcH3iZ3gxsA==
X-Google-Smtp-Source: APXvYqyamUbZ+xTu8tsn5Fvg0OzHbVC1HThMyxv54uwZFtA2aPnkk/8yiF71KvEGI1V7YuNBZPnIca2HXBrOHQWDIug=
X-Received: by 2002:a9d:7cd9:: with SMTP id r25mr8251836otn.326.1576761940708;
 Thu, 19 Dec 2019 05:25:40 -0800 (PST)
MIME-Version: 1.0
References: <CAB1T5w2GyfERoaCyFZeKaui_xuXd0r6J+Zvq4pecstBJ9UyRzw@mail.gmail.com>
 <20191218192741.ybi3xpvax7lrrubz@tb-raspi4> <CAB1T5w1Ct7_D7kiUypRuoK+zeiocyPJn0SindXfs6M5wUkVavw@mail.gmail.com>
 <20191219031227.xqlv564h3iq5ofq7@tb-raspi4>
In-Reply-To: <20191219031227.xqlv564h3iq5ofq7@tb-raspi4>
From:   Scott Richmond <scott@brightrockgames.com>
Date:   Thu, 19 Dec 2019 13:25:27 +0000
Message-ID: <CAB1T5w3k6RcsyaTFZ77aXrGp19fA2oFkvJU_xaJ3JekJK_aNqw@mail.gmail.com>
Subject: Re: Ability to ignore EOL changes for certain projects
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Scott, please avoid top-posting in this list, see my answers at the end.
Sure! Sorry I rarely use mail lists.

> But I still think, that this "modified" is unexpected,
> and a (possible) bug in Git, thanks for reporting.
>
> Which Git version do you use ?
> Is this test script a description of you problem ?

Yes this appears to be a correct repro of the kind of scenario that is
common in many dev environments like ours.
I'm not yet sure if this is actually a bug (I'd be happy if it is!).
Reading the docs I think this is intended behaviour - All the text
CRLF options relate to what Git should do on check in/out. It is
correctly reporting the file change, even if it is just EOL.
What Philip is describing with the sha1/iod check sounds to me what
the root cause "problem" is - Any file change will show up on git.
Philip appears to imply that there is no way to get git to do further
introspection on the file at this time. But maybe that can be added?
Re the Git version - I try to stay on the latest at all times. This
issue has been present for years, for as long as I can remember.

Regards,

Scott Richmond.
  Director, Producer, Programmer
  Brightrock Games
  T: 07480795661

On Thu, Dec 19, 2019 at 3:12 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> Scott, please avoid top-posting in this list, see my answers at the end.
>
> > On Wed, Dec 18, 2019 at 7:27 PM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> > >
> > > On Wed, Dec 18, 2019 at 11:10:27AM +0000, Scott Richmond wrote:
> > > > The Problem Domain
> > > > In certain dev environments (Unity3D projects) there is (AFAIK) an
> > > > unsolvable problem where some files are often modified with line
> > > > endings that aren't the native system or not the committed line
> > > > endings for that file. Secondarily, in this case line endings don't
> > > > matter - Nothing in the dev environment "cares" which kind of line
> > > > ending is used.
> > > >
> > > > The Problem
> > > > Git always cares about EOL. Git has options to transparently modify
> > > > EOLs when files are checked in or out. However it is not possible t=
o
> > > > tell Git to ignore EOLs in other commands:
> > > > Git status shows the file modified.
> > > > Merging/Pulling has to care because it can't merge with a modified
> > > > working tree. Which means the user has to care - They have to eithe=
r
> > > > stash the EOL changes or wipe them out. Sometimes, if the user has =
a
> > > > particular app running, it may automatically reload that file and
> > > > recreate the modified EOL changes, causing an endless loop. This
> > > > problem is often made unclear to the user how to solve, especially =
if
> > > > they aren't domain experts.
> > > >
> > > > To be clear, in this particular dev environment, I can say with
> > > > confidence that this particular issue is a major and common pain po=
int
> > > > for users. It is made worse as many users in this environment aren'=
t
> > > > programmers by trade and aren't domain experts in version control. =
I
> > > > also believe this environment is becoming a non-trivial portion of =
the
> > > > Git userbase and it would be worthwhile looking into resolving.
> > > >
> > > > Solution Request
> > > > It would be fantastic if we could tell Git to stop caring about EOL
> > > > changes on a per-repo basis, with the effective output being that g=
it
> > > > status shouldn't show changes for files with differing EOLs.
> > > >
> > > > I'm experienced with Git, though I am not expert enough to consider
> > > > creating such a change myself - It is unclear to me just how
> > > > complicated a change may be. However maybe I could look into it if =
it
> > > > was made clear that this improvement is possible and has no serious
> > > > side effects.
> > >
> > > Hej Scott,
> > > I think that you problem can be solved.
> > > For each repository, you can tell Git to ignore the line endings,
> > > CRLF vs LF.
> > >
> > > If you start with a fresh repo,
> > > you can do something like:
> > >
> > > echo "* text=3Dauto" >.gitattributes
> > > git add .gitattributes
> > > git commit -m "Add .gitattributes"
> > >
> > > For existing repos, we need to take another step:
> > >
> > > echo "* text=3Dauto" >.gitattributes
> > > git add .gitattributes
> > > git add  --renormlize .
> > > git commit -m "Add .gitattributes"
> > >
> > > More information can be found e.g. here:
> > > https://git-scm.com/docs/git-add
> > >
> > > Once you done that, you can merge branches
> > > into the master branch with help of the renormalize
> > >
> > > git merge -X renormalze branch-name
> > >
> > > See even here:
> > > https://git-scm.com/docs/git-merge
> > >
> > >
> > > This is just a (too) short introduction, I hope that it
> > > helps and that you find the time to dig somewhat deeper into
> > > the documentation.
> > >
> > > Other developers have that problem as well, you are not alone.
> > >
> > > If you have a public repo, I could help with one example.
> > >
> > >
> > > >
> > > > Regards,
> > > >
> > > > Scott Richmond.
> > > >   Director, Producer, Programmer
> > > >   Brightrock Games
> > > >   T: 07480795661
> On Wed, Dec 18, 2019 at 09:33:32PM +0000, Scott Richmond wrote:
> > Hey Torsten,
> >
> > Thanks for the reply!
> >
> > Correct me if am wrong, but those steps don't tell git to "ignore"
> > line endings. That just causes git to check all text files in and out
> > with a specific EOL type (Either automatically chosen, or not). If an
> > app in the dev env changes a files' EOL to something else, git will
> > notice the change locally.
> >
> > Regards,
> >
> > Scott Richmond.
> >   Director, Producer, Programmer
> >   Brightrock Games
> >   T: 07480795661
> >
>
> Hej Scott,
>
> I am not sure whether I understand your question correctly.
> So I set up a little test, to illustrate things better.
>
>
> user@linux:/tmp/EOLtest $ git init
> Initialized empty Git repository in /tmp/EOLtest/.git/
> user@linux:/tmp/EOLtest $ printf "Line1\r\nLine2\r\n" >file
> user@linux:/tmp/EOLtest $ git add file
> user@linux:/tmp/EOLtest $ git commit -m "add file with CRLF"
> [master (root-commit) 0e4d1df] add file with CRLF
>  1 file changed, 2 insertions(+)
>   create mode 100644 file
>
> user@linux:/tmp/EOLtest $ printf "Line1\nLine2\n" >file
> user@linux:/tmp/EOLtest $ git status
> On branch master
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>     (use "git checkout -- <file>..." to discard changes in working direct=
ory)
>
>         modified:   file
>
> no changes added to commit (use "git add" and/or "git commit -a")
> user@linux:/tmp/EOLtest $ git diff
> diff --git a/file b/file
> index 4aa551d..ac2dd81 100644
> --- a/file
> +++ b/file
> @@ -1,2 +1,2 @@
> -Line1
> -Line2
> +Line1
> +Line2
>
> user@linux:/tmp/EOLtest $ echo "* text=3Dauto" >.gitattributes
> user@linux:/tmp/EOLtest $ git add --renormalize .
> user@linux:/tmp/EOLtest $ git commit -m "Normalize the repo"
> [master b41136d] Normalize the repo
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  user@linux:/tmp/EOLtest $
>
> user@linux:/tmp/EOLtest $ printf "Line1\r\nLine2\r\n" >file
> user@linux:/tmp/EOLtest $ git status
> On branch master
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>     (use "git checkout -- <file>..." to discard changes in working direct=
ory)
>
>         modified:   file
>
> user@linux:/tmp/EOLtest $ git diff
> warning: CRLF will be replaced by LF in file.
> The file will have its original line endings in your working directory
>
> #############################
> No, at this point, I am surprised myself.
> "file" is reported as "modified", but it should not be modified, right?
> Is that the problem, that you have ?
>
>
> We can fix it, by running:
>
> user@linux:/tmp/EOLtest $ git add file
> user@linux:/tmp/EOLtest $ git status
> On branch master
> nothing to commit, working tree clean
>
> But I still think, that this "modified" is unexpected,
> and a (possible) bug in Git, thanks for reporting.
>
> Which Git version do you use ?
> Is this test script a description of you problem ?
>
