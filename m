From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Wed, 8 Jul 2015 15:44:12 +0800
Message-ID: <CACRoPnS_T6trUC2GcofuXKBRTAf-4u=MyNDp6ir=E5f3SHsq4A@mail.gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
	<xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:44:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCk1n-0002gW-6D
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933544AbbGHHoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:44:18 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36276 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753AbbGHHoP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:44:15 -0400
Received: by lbbpo10 with SMTP id po10so50832601lbb.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 00:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bL1oXhmhS6mYOTxb7LqsXsoHdHlsftJecCiyAyrOQy4=;
        b=KLgDYHo1PfQMc4yBmOaN0bJaEZrvmVqP4qkdjse5DqOmZ8dKlut3QnyS60Rk+U1JnC
         v/SflraoGDhCUna2/mms6hBzceCGROYsDREgV3ruFYBxhtF0BtP8aw1GNLLaDGD7RvLr
         GhZjiprayV4hV/EhWktGigNB3hN1ZfFHaXaF97yBV46RMaxt2gThXJRYo2ZBiJszx3Qb
         1Vy2FmIl0LMqSyoApSsK607hUpZ/tPfKz6LuOqiX9vLM+aniMLCsBNqjqkbbFBx6buDy
         oGLDD8X6jsLFp4UPiRqssMOOMK4o5e4f8ssoGQ5kec2D3+v3KSyvpxZAtcckSM1kmbRh
         L1fA==
X-Received: by 10.152.2.38 with SMTP id 6mr8067089lar.80.1436341452854; Wed,
 08 Jul 2015 00:44:12 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 8 Jul 2015 00:44:12 -0700 (PDT)
In-Reply-To: <xmqqmvz7yuk4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273649>

On Wed, Jul 8, 2015 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> This patch series rewrites git-am.sh into optimized C builtin/am.c, and is
>> part of my GSoC project to rewrite git-pull and git-am into C builtins[1].
>
> I merged this to 'jch' (that is somewhere in between 'next' and
> 'pu', which is what I use for everyday work) and tried it to apply
> the 8-patch series that starts at $gmane/273622 on top of 912bd49.
>
> It appears that your builtin version makes "am -3s" barf at the
> [PATCH 7/8] in that series, complaining about lack of author
> identity.

Hmm? I compiled jch, and tried to reproduce the problem, but could not
do so. Here's what I did:

git checkout 912bd49
git am -3s mbox
Applying: refs.c: add err arguments to reflog functions
Applying: cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Applying: bisect: treat BISECT_HEAD as a ref
Applying: refs: Break out check for reflog autocreation
Applying: refs: new public ref function: safe_create_reflog
Applying: git-reflog: add exists command
Applying: update-ref and tag: add --create-reflog arg
Using index info to reconstruct a base tree...
M    builtin/update-ref.c
Falling back to patching base and 3-way merge...
Auto-merging builtin/update-ref.c
CONFLICT (content): Merge conflict in builtin/update-ref.c
error: Failed to merge in the changes.
Patch failed at 0007 update-ref and tag: add --create-reflog arg
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

... after resolving the conflict ...

git add builtin/update-ref.c
git am --continue
Applying: update-ref and tag: add --create-reflog arg
Applying: git-stash: use update-ref --create-reflog instead of creating files

And it completes successfully.

Thanks,
Paul
