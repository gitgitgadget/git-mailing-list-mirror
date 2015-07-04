From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 18/23] checkout: retire --to option
Date: Sat, 4 Jul 2015 04:59:06 -0400
Message-ID: <CAPig+cT0H=Pj8Wt5Xhpj=MApfDby66EyO6WW7pCjYQnfNHi7aA@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-19-git-send-email-sunshine@sunshineco.com>
	<CACsJy8Cog302k+-tFVJqneh3ShWYL57qhHQk8cFqvYX9Qc9q8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 11:50:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBgZ2-0002nI-S1
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 11:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbbGEJuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 05:50:17 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35806 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbbGEJuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 05:50:15 -0400
Received: by ykfs198 with SMTP id s198so21324784ykf.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VGGlOh1c8WItyl49OQsUFpVtKBEEvv/QkZpU8YqEhSY=;
        b=p1447Gxq1aJXABuO/D+LrUtAQGl8g2LffalfUpe5I7wDmnP2Pr3S5R/fwTvKTEnG/h
         ckr2i7nNQFztuX7n0Fk64WLF0NsTnea1xM9DB2bB0o6eM5FG6jaDXgdYHDhNkVOfqG1y
         PEY0UQpi68x/udCWxZiO03AB1VsHqKEO5Xu1yBSz5f9k1zlt9eXR5iGej1owIAalAaOI
         N2DR1XwgdQzTk1QVNc3lnyTfyyNs9dCQBFHTxBCNsNS/EcNBdojA289pnnnT99aeyo7o
         gPIvV9nhpnSvlMk6ygHaWIeSNL7myH4HnEk7tS2jBjX+zFmnNEHOKHKHpUeo4a62eMSi
         6zTg==
X-Received: by 10.129.50.207 with SMTP id y198mr48387662ywy.39.1436000346971;
 Sat, 04 Jul 2015 01:59:06 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 4 Jul 2015 01:59:06 -0700 (PDT)
In-Reply-To: <CACsJy8Cog302k+-tFVJqneh3ShWYL57qhHQk8cFqvYX9Qc9q8Q@mail.gmail.com>
X-Google-Sender-Auth: faA1ruiyeeGB_u5m5W87jYhxK8M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273356>

On Fri, Jul 3, 2015 at 11:04 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Now that "git worktree add" has achieved user-facing feature-parity with
>> "git checkout --to", retire the latter.
>>
>> Move the actual linked worktree creation functionality,
>> prepare_linked_checkout() and its helpers, verbatim from checkout.c to
>> worktree.c.
>>
>> This effectively reverts changes to checkout.c by 529fef2 (checkout:
>> support checking out into a new working directory, 2014-11-30) with the
>> exception of merge_working_tree() and switch_branches() which still
>> require specialized knowledge that a the checkout is occurring in a
>> newly-created linked worktree (signaled to them by the private
>> GIT_CHECKOUT_NEW_WORKTREE environment variable).
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>  builtin/checkout.c | 156 +----------------------------------------------------
>>  builtin/worktree.c | 138 ++++++++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 133 insertions(+), 161 deletions(-)
>
> If I didn't lose track of changes, "--to" is still described in
> git-checkout.txt?

You're right. v1 did remove --to from git-checkout.txt, but somehow I
overlooked it in v2. Thanks for pointing out this oversight.
