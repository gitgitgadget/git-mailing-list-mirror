From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] pull.default
Date: Sun, 14 Apr 2013 03:24:56 +0530
Message-ID: <CALkWK0kbsYgOy6KjcgZe8+cKucqzWPQ3wyp3SqaYy372pW0eFw@mail.gmail.com>
References: <CALkWK0nT9hE_kRt3DLXfP45OwCSLurMOzuTqepxhkWjagbFDUQ@mail.gmail.com>
 <7vy5dkmt7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 23:55:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR8QB-0008T0-KM
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 23:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab3DMVzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 17:55:39 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48865 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab3DMVzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 17:55:39 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so4582702iec.13
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zNXOqvGFjH0vMKR9nzodGdiY1liAjmi8bfo53Gytz5Y=;
        b=xrxYdNfrTk7V0bFUzNZWPe9WgOv58H2oXsxO3kFDhFQXjgU5Dm6NGPn962iTLNCZDe
         jXGr8m5r4g9vOcQxX+YoCh5NiGit7QW+hyevoqBYm8bighb1Q4rwD3CYGGoIiD7jpSVs
         nKUEJd/XZ8hwL1sPH0AVbxqR0SGoCyngR1Yb39gv+qNa3MqvCGRzXwrYjS8jamN+sxE9
         15qwtl8HscozEJQy7Lan/FavrM+fo8IFKFgE6UJM2SXx4HzdovSk03HJD+3z7v9osmfU
         OHFi8dtB6rl4lWfbE+a/kLtcf6bYKYUZlrzoQdbBe6w9IWNDuYSu04TxdAxSmBmPcfsa
         rmhg==
X-Received: by 10.50.117.3 with SMTP id ka3mr2024652igb.107.1365890137244;
 Sat, 13 Apr 2013 14:55:37 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sat, 13 Apr 2013 14:54:56 -0700 (PDT)
In-Reply-To: <7vy5dkmt7k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221074>

Junio C Hamano wrote:
> I think you can shrink and enhance the above repertoire at the same
> time by separating "do I want to have stash and stash pop around"
> bit into an orthogonal axis.  The other orthogonal axes are "Under
> what condition do I integrate the work from the upstream?" (e.g.
> "only when I do not have anything, aka, ff-only") and "How would I
> integrate the work from the upstream?" (e.g. "rebase my work" and
> "discard anything I did aka reset --hard").

Okay, so this is what I currently have:

- pull.condition = clean-worktree | ff-update | no-local-changes |
always | never
- pull.action = merge | rebase* | reset
- pull.resetType = soft | hard | merge | keep
- pull.autostash = true | false

(ff-update is satisfied when FETCH_HEAD is directly ahead of
refs/remotes/<branch>, while no-local-changes is satisfied when
FETCH_HEAD is directly ahead of refs/heads/<branch>)

Personally, I would love the defaults pull.condition = ff-update,
pull.action = rebase, pull.autostash = true.  However, there are
branches that I have where this isn't applicable.  Any clues on how to
design branch-specific options for all these (there's
branch.<name>.pullAction is a bit yuck)?

Did I manage to cover everything?  Now that pull.autostash is done, I
will start writing pull.condition after feedback.

* pull.rebase is pending deprecation
