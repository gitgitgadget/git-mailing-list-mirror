From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Mon, 18 Oct 2010 23:41:21 +0200
Message-ID: <vpq8w1v5gce.fsf@bauges.imag.fr>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 23:44:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7xVl-0006xx-JK
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 23:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757630Ab0JRVog convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 17:44:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:63130 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755116Ab0JRVof convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 17:44:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9ILfLbp011565
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 18 Oct 2010 23:41:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P7xSL-0003ON-M8; Mon, 18 Oct 2010 23:41:21 +0200
In-Reply-To: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> (Thore Husfeldt's message of "Mon\, 18 Oct 2010 22\:45\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 18 Oct 2010 23:41:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159290>

Thore Husfeldt <thore.husfeldt@gmail.com> writes:

> Read it as the friendly, but
> somewhat exasparated suggestions of a newcomer. I=E2=80=99d love to h=
elp (in
> the form of submitting patches to the documentation or CLI responses)=
,
> but I=E2=80=99d like to test the waters first.

(it's common practice here to test the water with RFC/PATCHes too)

> There are at least two uses of the word *tracking* in Git's
> terminology.

Actually, there's a third, known to be rather unfortunate.

=46or example, when you clone a repository, by default, you end up with

1) The master branch hosted remotely
2) origin/master, locally, but "remote-tracking"
3) master, your working branch.

When you do a "git pull" when sitting on local branch master, Git
knows it must :

a) fetch (i.e. download) from branch 1) into branch 2)
b) merge from branch 2) into branch 1)

Rule a) come from remote.<remotename>.fetch, and rule b) comes from
branch.master.merge in your .git/config.

Usually, we refer to tracking branch to mean rule a), but the "track"
in "git branch --track" means "setup git for rule b) above".

We already came up with a better wording, namely "upstream", and used
in in "git push --set-upstream". Probably a next step would be to
deprecate any other occurence of --track meaning the same thing (git
checkout --track seems to me to be a candidate, git branch has both
--track and --set-upstream). One difficulty is to do that with
backward compatibility in mind.

> 3. Duplicate various occurences of `cached` flags as `staged` (and
> change the documentation and man pages accordingly), so as to have,
> e.g., `git diff --staged`.

I do like this, but to be complete, one should also deal with more
complex cases. For example, "git apply" has _both_ --index and
--cached, with different semantics.

And changing just _some_ of the occurences of --index and --cached may
help, but do not fix the problem of inconsistancies. Up to now, there
have been many efforts towards consistancy, but I guess no one had the
courrage of doing a global-enough approach to eliminate all
inconsistancies.

In other words, I encourage you to continue the effort you've stated
here, but that won't help much unless you push the idea far enough
IMHO.

>     changed but not updated:
>
> I=E2=80=99m still not sure what =E2=80=9Cupdate=E2=80=9D was ever sup=
posed to mean in this
> sentence.

Historically, the staging area was seen as a cache (hence the name),
which was purposedly out-of-date when doing a partial commit. Hence,
Git inherited some of the terminology of usual caches (a cache is
"dirty" when it's not in sync with what it caches, "clean" when it is,
and you "update" it to make it in sync).

But I do agree that the analogy with a cache is disturbing for the
user, even if it's meaningful for the developper: as a user, a cache
is meant to be a performance optimization, not supposed to interfer
with the functionality.

> 2.
>     Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>
> should be
>
>     Untracked files:
>     (use "git track <file>" to track)

This hypothetical "git track" actually exists under the name "git add
-N".

> The opposite of staging is `git
> reset HEAD <file>` and the opposite of tracking is -- well, I=E2=80=99=
m not
> sure, actually. Maybe `git update-index --force-remove <filename>`?

git rm --cached ?

As a bare mortal, you shouldn't need update-index, it's a plumbing
command (i.e. meant for scripts or low-level manipulations).

> An even more radical suggestion (which would take all of 20 seconds t=
o
> implement) is to introduce `git track` as another alias for `git
> add`. (See above under `git status`). This would be especially useful
> if tracking *branches* no longer existed.

I disagree that adding aliases would help users. See your confusion,
and then the relief when you found out that index, cache, and staging
area were synonymous. Now, what should a user think after learning
stage, track and add, and asking for the difference.

I agree that adding new files and adding new content to existing files
are done for different reasons, but the conceptual simplicity of Git
comes from the fact that Git is purely snapshot oriented, and I to
some extent, it's nice to have this reflected in the user-interface.

When you say "git add X", you don't talk about the difference between
the previous commit and the next, or about the difference between
working tree and next commit, or so. You're basically saying "file X
will exist in the next commit, and it will have this content". Whether
it existed or not in the previous commit doesn't matter. It's
implemented this way, and it's really something fundamental in the Git
model.

> There=E2=80=99s another issue with this, namely that =E2=80=9Cadded f=
iles are
> immediately staged=E2=80=9D. In fact, I do understand why Git does th=
at, but
> conceptually it=E2=80=99s pure evil: one of the conceptual conrnersto=
nes of
> Git -- that files can be tracked and changed yet not staged,

Rephrase that as "the working tree can have content different from the
staged content". Both "working tree content" and "staged content" are
snapshot (i.e. they exist regardless of each other). Then newly
created files won't be different anymore. Files exist, with some
(possibly empty) content, or they don't.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
