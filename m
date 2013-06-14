From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 03:06:17 +0530
Message-ID: <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org> <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
 <7v38sksq14.fsf@alter.siamese.dyndns.org> <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
 <7vsj0kpsb0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:37:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnbgM-0006vZ-Nv
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab3FNVhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:37:05 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52277 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab3FNVg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:36:58 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so2501358iet.37
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 14:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oN4g4JbbYV18IFFoRVSZTy2T48CpOVwa+ANXjEkETnY=;
        b=oI/XRFq40h0ZfqE9wttr6ilYZVUbPj8G0lyUvo8uH/m+Q8J4c/4ewwzRrkZWxKPPQ/
         xAY4Ln2fqJ0jg0s9L00bDsIJcPQcD6v+C4ynR9uKbYFmUapCLOIRnErbZuzj29E5x5ad
         yUXrGvSJEzX/ai13Gthgh4VVOZtCXoQpPo0E4ZSxo4n2uhoJ0stOkerIuY6cxmMnKCIh
         SvnJTMKmxumFiLWiqpV3Qyotz18IJ/08YsypqKenyToKYiE2IRPEOwwjWO88ItJ3BTr+
         Ems1coRxguK08/2kQsgC27E1BXvtXXi+uSHe87+y2xCpJeVmWv5qk7ud54T2nHQgAD4r
         VthA==
X-Received: by 10.50.154.106 with SMTP id vn10mr103387igb.0.1371245817807;
 Fri, 14 Jun 2013 14:36:57 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 14:36:17 -0700 (PDT)
In-Reply-To: <7vsj0kpsb0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227918>

Junio C Hamano wrote:
> If you first update "git checkout" so that it will pay attention to
> a custom reflog-action exported by Porcelain scripts that may want
> to internally use it to flip branches (and without a custom one, it
> will still record "checkout: moving from A to B"), without exporting
> custom reflog-action from "rebase" and other Porcelain scripts, that
> would not affect any externally visible behaviour.

rebase already sets a custom reflog-action; in fact,
'set_reflog_action rebase' is executed after it sources sh-setup.  I
have to go out of my way to deliberately unset it before every
checkout invocation to avoid breaking all the tests in t/status-help.
Most unnatural way to go about writing a series, if you ask me.

> Tests modified by b397ea4863a1 (status: show
> more info than "currently not on any branch", 2013-03-13) do change
> the original "# Not currently on any branch" to "detached at", but I
> do not think b397ea4863a1 _wanted_ to say where the $onto commit was
> during the rebase (or was it?), so if they have to change to
> "detached from", I do not think it is a problem at all.  I think it
> is very sane to update these selected "detached at" to "detached
> from" as needed.

... and you have missed the point yet again.

I previously wrote:
> I'd just like to point out quickly that I first attempted to write 6/6
> without this patch.  It is absolutely impossible, because the
> "detached HEAD from/to" messages no longer make any sense when
> checkout starts respecting GIT_REFLOG_ACTION.  At that point, I'm was
> just monkeying around the trash-directory running describes to somehow
> try and make the expected output equal to the actual output.  There
> was no method to the madness, and I was literally losing my mind.

Let me try and explain this once again: to determine "HEAD detached
from/to", wt-status must look for a previous "checkout: " message in
the reflog.  Since a rebase no longer executes a checkout, the
"detached HEAD from" message no longer has anything to do with the
rebase itself; it is completely _random_ and _incidental_, based on
what checkout operation was executed last (eg. in a previous test).
To change the "detached HEAD to" messages to "detached HEAD from"
messages, I have to turn myself into a monkey that goes around running
describes on the test-directory.  After enduring hours of this
mind-numbing job, the final result will be a terrible mess; tests can
no longer be added, removed, reordered, or even tweaked.  Everything
depends on the exact ordering of the tests, and the incidental
checkout invocations they contain.

> That would be a sensible compromise

How is it a compromise?  It is most uncompromising.

> because we do not want to see
> either "detached at" or "detached from" during "rebase" in the
> longer term.  We would rather want to see the message start with
> something like
>
>         # Rebasing X on top of Y (23 commits remaining to be replayed)
>
> which is under discussion in a separate thread lately.  The change
> to expected output (i.e. "detached at" to "detached from") will have
> to be changed again in that separate topic.

Orthogonal.  I want checkout-dash now, and I should not have to be
asked to do something as unrelated as redoing 'git status' output to
get what I want.

Since you have made it clear that you will defend every bit of b397ea
against all odds, and since I want checkout-dash now, we have to do
something.  I have a proposal: I will smudge the first line of the
'git status' output, before comparing it to make tests pass.  Never
mind that the line is incidental and Wrong; since I have no say in the
matter, I will just sidestep the issue.  I don't use the long-form
'git status' anyway, and am never going to see this ugliness.  We both
win.  Okay?
