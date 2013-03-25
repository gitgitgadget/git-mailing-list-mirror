From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Tue, 26 Mar 2013 01:27:18 +0530
Message-ID: <CALkWK0mAkabTNrBjvv4s_YfTN9j2_Aros=7ZcF7j=KAjJE-yaw@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <51500C67.9040308@web.de> <CALkWK0kJ2QVA6is85Sdwn1mnGVbuNUSGqg_37WBxPYrepHz9ow@mail.gmail.com>
 <51509ABA.3040804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 25 20:58:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDWw-0003Nr-V0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 20:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699Ab3CYT5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 15:57:39 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:56853 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab3CYT5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 15:57:38 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so5855748iaa.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fHH4YWhVzbxcs/dKd1Wg2DsFM74V03tWyO0aouO+NBw=;
        b=dqUxEAb9lSmrhJoyrB4huYh296Y0Yh086LTz43IHuosMUC9P9kMER/rghYkPtWgvMu
         MY8lc8ez5e/gFv7VF8VgsJMWCwayGKFh3TGGFmyGhp2uuuWLb5yQnQmMzok3WoWWkwjz
         Nle1P1m41vgAboGSFx4s+GhN1xH0LIVFJKOHbdxgHU2Aca0ElkABPX/OdfWx2t1Qh05p
         N5ZC2DgRM0nZpQA+MBw+FIuIKYr71PGUAZgDguA8TAEdiNn/3dvTOExKe4fdK5429JjM
         /SQgUaJbw7FrRvBWmys+97jiRE2BYivZYlmOxYpCPuhDaXxw9aiBhpvMEKR5htD7siFz
         x4AQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr8972395igb.12.1364241458327;
 Mon, 25 Mar 2013 12:57:38 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 12:57:18 -0700 (PDT)
In-Reply-To: <51509ABA.3040804@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219071>

Jens Lehmann wrote:
> Am 25.03.2013 09:59, schrieb Ramkumar Ramachandra:
>> In my opinion, the 'git submodule add <path>' form is broken, because
>> it doesn't relocate the object store of the submodule repository (a
>> bug that we need to fix?).
>
> I don't think it is broken. Leaving the .git directory inside the
> submodule makes perfect sense for some users (e.g. those which never
> intend to push their submodule somewhere else) and doesn't do any
> harm unless you want to remove it again in the future (or need to go
> back to an older commit where the submodule directory would be in
> the way). We have to think very hard before making such changes to
> behavior quite some people may rely on, even though I agree some use
> cases would profit from it and I think we would do it differently if
> we could start over again.

Doesn't that sound horribly crippled to you?  Is there any advantage
to leaving the .git directory inside the submodule?  Isn't it always
better to relocate it?

> What I think we need rather soonish is "git submodule to-gitfile",
> which would help your case too. We should then hint that in those
> cases where we refuse to remove a submodule when using "git rm" or
> "git submodule deinit" (or the "git mv" for submodules I'm currently
> preparing).

Why a new subcommand?  Is there a problem if we do the relocation at
the time of 'add'?  Will some user expectation break?

>>  I always use the 'git submodule add
>> <repository> <path>' form, which puts the object store of the
>> submodule repository in .git/modules of the parent repository.  This
>> form is nothing like 'git add', but more like a 'git clone': arguably,
>> 'submodule clone' is a better name for it.
>
> Hmm, it does a clone first and then adds the submodule and the change
> to .gitmodules, so I still believe "add" is the correct term for it.
> So I really like the color the shed currently has ;-)

I meant a variant of add that would clone, but not stage.  I was
arguing for a new subcommand so that I don't have to touch 'submodule
add', not for a rename.

>> Maybe the WTF "You need to run this command from the toplevel of the
>> working tree" needs to be fixed first?  I think it's a matter of a
>> simple pushd, popd before the operation and building the correct
>> relative path.
>
> I won't object such a change (even though I suspect it'll turn out
> more complicated than that).

I'll have to investigate.

>>  I'm not sure how it'll work with nested submodules
>> though.  Then again, I think nested submodules are Wrong; submodules
>> are probably not the right tool for the job.
>
> How did you come to that conclusion? Nested submodules make perfect
> sense and most people agree that in hindsight --recursive should have
> been the default, but again we can't simply change that now.

Okay, I'll do it step-by-step now, with a live example:
1. git clone gh:artagnon/dotfiles, a repository with submodules.
2. git submodule update --init .elisp/auto-complete, a repository that
contains submodules.
3. .elisp/auto-complete/.gitmodules lists the submodules (lib/fuzzy,
lib/ert, and lib/popup).  Let's try to initialize them from that
directory ... No! go back to toplevel.
4. Fine.  Where are those submodules?  git submodule status doesn't list them.
5. Okay, let's join the paths by hand and try anyway: git submodule
update --init .elisp/auto-complete/lib/fuzzy.  Did you forget to 'git
add'?  Fantastic.
6. How am I supposed to initialize the darn submodules?!
7. git submodule update --init --recursive .elisp/auto-complete is the
ONLY way (is this even documented anywhere?).  But I just wanted to
initialize one, not all three!
8. Okay, now I want to execute a 'git submodule foreach' on just those
three submodules.  Seems impossible.  Fine, I'll do it myself: for i
in "lib/ert lib/fuzzy lib/popup"; do cd $i; git checkout master; git
reset --hard origin/master; cd ../..; done
9. Whew.  git status.  Changes in auto-complete.  git diff.
"Submodule .elisp/auto-complete contains modified content".  I'm not
allowed to see what changed now?
10. git checkout master; git reset --hard origin/master in
auto-complete.  git status.  How do I stage the changes in just
auto-complete, and not in auto-complete's submodules?  What is going
on, seriously?

This is just two levels of nesting: with more levels of nesting,
things only get worse.

>>>> Now, for the implementation.  Do we have existing infrastructure to
>>>> stage a hunk non-interactively?  (The ability to select a hunk to
>>>> stage/ unstage programmatically).  If not, it might be quite a
>>>> non-trivial thing to write.
> [...]
> Not that I know of.

Damn.  Then, it's certainly not worth the effort.  Atleast not now,
when there are bigger problems.
