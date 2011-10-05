From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 17:49:02 -0400
Message-ID: <CAG+J_DzU4wfbur9kBx+hYoePD9bM=Qy5zDyZX=GXi+G68X=64w@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
	<7vy5wz5dql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:49:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZKx-0005rQ-Kr
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935286Ab1JEVtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 17:49:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44789 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499Ab1JEVtC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 17:49:02 -0400
Received: by ggnv2 with SMTP id v2so1133318ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BwBFlC5BkajDJHssUMlw40deaT2KQ2m+++QmZkwRF6Y=;
        b=D8nKH+9iTy/PBS8UPP6TM3IEw6XaT5VWJL1m5ufWM6vtyvI2OLkW4vv8EILU7D82Il
         oMIfBOdLt/Lx2yNipvGY5UIaHBLxMdCY6Nyg34ZgiTYlafLp8vmxpnHKaqdm1rcjBgbk
         gYgz3TDOBx6flVioEvtz6DDi7osbmZmW529MI=
Received: by 10.147.154.12 with SMTP id g12mr2484476yao.36.1317851342256; Wed,
 05 Oct 2011 14:49:02 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 14:49:02 -0700 (PDT)
In-Reply-To: <7vy5wz5dql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182889>

On Wed, Oct 5, 2011 at 5:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am afraid to say, with that statement, that your knowledge about the way
> the tool can be used is not wide enough to judge if one policy restriction
> (e.g. "never check out the same branch in multiple places") is general
> enough to add to the tool. I do not claim mine is good enough, but I at
> least know better than proposing a rule that may be too restictive to
> negatively affect other people's workflows.
>
> I always maintain four workdirs that I can use to build the tip of four
> integration branches while I work on other things in the primary branch,
> plus another that has a detached HEAD so that I can "reset --hard" around
> without having to worry about what I do there would negatively affect what
> I do elsewhere or vice versa. Of course, updating 'master' in my primary
> repository will require the "build master" workdir to be "reset --hard"
> before it is used, and that is part of my workflow already. I consider it
> is one of "people learned to work around the restriction of the tool so
> well already that they may not realize it" we discussed earlier.

Is it a regression to your workflow that you have to now use "checkout
-f" instead of "checkout" to checkout the same branch in more than one
location?

> Also, if your goal is to give a different semantics, like:
>
>> In my mind, we're trying to make new-workdir usable for non-advanced
>> users. I think it's conceptually simplest to allow a branch to be
>> checked out only once.
>
> you would really need to make sure that your changes would not harm other
> users of the same tool that you are not targetting for, and also the
> changes to the core part of the system that needs your specialized policy
> makes sense in the wider context. The former you can claim "the policy
> does not kick in when configuration is not set", but that is weak if the
> policy is too ad-hoc and not well thought out. I actually care about the
> latter more, as it is not worth having to spend maintenance effort to
> carry changes that only stop some but not other kind of mistakes in the
> core part to be more widely applicable.

Perhaps:

  core.multipleCheckouts = {true,false}
    - false prevents multiple checkouts without -f
  advice.multipleCheckouts = {true,false}
    - false disables multiple-checkout notice

And when there are multiple checkouts, warn on committing about other
workdirs that now need reset --hard.

j.
