From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Teach merge the '[-e|--edit]' option
Date: Fri, 7 Oct 2011 15:07:42 -0400
Message-ID: <CAG+J_DxrQCS8zn5KJ8HnpqShVbMw=zCbqDVa=w08EEibw=tsAA@mail.gmail.com>
References: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com>
	<7vk48gwvyd.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz7-tTdgT=cqoKhK+fAhmESLnp93yHyxOF_NOY5Wx01+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:07:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCFls-000747-QD
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab1JGTHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 15:07:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53537 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab1JGTHn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 15:07:43 -0400
Received: by ywb5 with SMTP id 5so3923210ywb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fxbjJoVytfYb5oQxHptLaDi3UX6XhZ4DKIyw+sD3HFA=;
        b=Hcr3/RXYH2cR9yu9UUZg/oM7v9mCF40OluS9wi7aWUVAsj1hG+LGy+E4VRtCx0hBMP
         pzdnX+AI5gH6Oy+XlMcH/ouWp+SO+E3FzTbv+LnESIbavbBjxgOeb2rFMUwnFUfgYMqP
         pjRaONetUna2H6MJzECdsOq5SZFZl6S8R7y78=
Received: by 10.236.190.200 with SMTP id e48mr12029603yhn.59.1318014462808;
 Fri, 07 Oct 2011 12:07:42 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 7 Oct 2011 12:07:42 -0700 (PDT)
In-Reply-To: <CAG+J_Dz7-tTdgT=cqoKhK+fAhmESLnp93yHyxOF_NOY5Wx01+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183098>

On Fri, Oct 7, 2011 at 2:01 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I actually think a better choice would be to remove commit_tree() from
> merge and always have it run commit externally. I'm not seriously
> suggesting that be done, but it would make git more consistent. But
> I'm not going to send in a patch which makes the situation worse.

The other inconsistencies I'm aware of between "merge --no-commit &&
commit" vs "merge" on a clean merge are:

* reflog
  - merge uses either "Merge made by the '...' strategy." OR "In-index merge"
  - commit uses "commit (merge) <subject>"

* hooks
  - merge calls
    1) "prepare-commit-msg MERGE_MSG merge"
    2) "post-merge [0|1]" where [0|1] indicates a squash or not.
  - commit calls
    1) "pre-commit"
    2) "prepare-commit-msg COMMIT_EDITMSG merge"
    3) "commit-msg COMMIT_EDITMSG"
    4) "post-commit"

* gc
  - merge calls "git gc --auto" after a successful merge unless
--squash was used
  - commit does not call "git gc --auto"

* diffstat: merge shows it, commit does not

j.
