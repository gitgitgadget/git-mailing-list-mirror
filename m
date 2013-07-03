From: Ed Hutchins <eh@demeterr.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Wed, 3 Jul 2013 08:47:17 -0700
Message-ID: <CADL+T9Z=SrVyMMnYk3M7Dmb4c5xGiQtCTiDYaceKwB2-51TV-g@mail.gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	<vpqehbgrnrx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 03 17:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuPH9-00031y-3m
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 17:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab3GCPrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 11:47:18 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:61606 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128Ab3GCPrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 11:47:18 -0400
Received: by mail-qa0-f48.google.com with SMTP id cm16so225848qab.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 08:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=Bvh14vo8MAVJcrDnTaFBc2DjNs/0DHInlJqpSNpgW5M=;
        b=Yxv5ddCxTtrhV90iAojAr1Us10XI8s3uUt06VCv1Kx3pMHquRdxqCuh50vPViIeZ+s
         EqqVUtFFxAkmQ1A2Dx+4+5Q3eN35/jIo1D1Q+F4WLE62Rl5GE/goKuZSBIHt9V86k/32
         0HbjzroyQmL2ithRbK9XOWAGxyiUHcKMjcOQXkvvJwyo62EHpQ62xVARJyRO1+NPQ7m5
         DnvwOUaYl+B/7wgCVYTR7M1XoGClKFOPy3wKQBJAJuPvsgdlgaT9IZ4hQ5T0bxeOuRTj
         bxZpWqcrx2MqvDghL0wlObTvV2DUS26VXtYTyUkSuR0zATVLoyKX/z+1m6eRfgga1oo2
         rZ2A==
X-Received: by 10.229.170.199 with SMTP id e7mr497541qcz.29.1372866437449;
 Wed, 03 Jul 2013 08:47:17 -0700 (PDT)
Received: by 10.49.76.234 with HTTP; Wed, 3 Jul 2013 08:47:17 -0700 (PDT)
In-Reply-To: <vpqehbgrnrx.fsf@anie.imag.fr>
X-Gm-Message-State: ALoCoQkdO/zwmIXngILSM59Tqrj0qMulJOSEDqvJldU/g6TqZbrd/ZL8yD99VqzYGeEc0K5xRDkz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229495>

I'm not trying to change the way git does things (which works perfectly
well), I'm asking for some extra information to be added to the commit
so that analysis of the ancestry graph can be tied to the branch topics
that the original author was working from. Currently if you have a
rebase-branch/ff-merge-to-master workflow, the graph of commits looks
like a single user produced all of the code. It would be very useful for
both forensic and display purposes to categorize those commits by their
original topics, but that history is lost in such a workflow. Certainly
there are work-arounds (notes etc.) to capture this history, but I think
that this is a basic feature which most projects would benefit from. I
fully understand that branches are not global and that it may be
confusing to keep an "author branch" name around in some cases, but the
vast majority of cases where authors pick meaningful branch names would
benefit from being able to look back and go "ah-ha! that was a commit to
fix bug such-and-such" or "that was a commit from when I was working on
super-cool feature X". Even just knowing that two commits were from
different (or the same) branches would tell you something useful about
the evolution of the project. Arguing that branch names are local and
thus meaningless misses the point: branches are *names* which were
meaningful to the author at the time the branch was being worked on.
Discarding this information makes it harder to reason about or display
the history of the project and is an irritating defect in an otherwise
wonderful tool.

On Wed, Jul 3, 2013 at 2:33 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ed Hutchins <eh@demeterr.com> writes:
>
>> I realize that branch names are ephemeral repo-specific things, but it
>> would be really useful to be able to determine what branch a commit
>> was authored from (as a hint to ancestry graph layout tools, for
>> example). Is there any way to do this currently, is it planned, or
>> would it be deemed useful enough to be worth adding to each commit
>> object?
>
> FWIW, this is what Mercurial's "named branches" do. Instead of having
> branches point to commit, each commit says what branch it belongs to.
>
> One drawback of this approach is that the branch name is part of the
> commit and can't be changed without changing the commit's sha1. Hence, a
> local, private, branch name becomes permanent the day it's merged
> upstream.
>
> (for completeness: Mercurial also has essentially Git-like branches,
> but they call this "bookmarks")
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
