From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference
Date: Sat, 18 Jul 2015 14:57:38 +0700
Message-ID: <CACsJy8B5d250xdofWkj0+TXaye=h2fDoyEobA7ktBtw-0sJTwA@mail.gmail.com>
References: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com> <xmqqa8uu3edr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 09:58:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGN0m-0007nY-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 09:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbbGRH6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 03:58:10 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:32869 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbGRH6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 03:58:09 -0400
Received: by igbpg9 with SMTP id pg9so9883844igb.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xEElHayWHJ3Q8Vk0Ww6WmClo+fEq6gOEmAdjTxcRYOM=;
        b=w8VVIAsL6ZhI0yxVgaAJPc/Xr+ACFX+276gKS66jzZmlVqB5fr5S/UbiLTkIgArQkd
         KGQisjIxt1hKDp2WSYyIoeRyC/xxTXa4zmg0f3ozsFW5OtejAaP94eZuXdNe4kZpnoJ2
         nwGopH9SpXYVToHz210yXgCv6KrCUrExCIORhbIw0kwC/1SJew7GaSxgUEXn91FFVmDk
         5CFH8vBpKcCI7ZTWdcoy/KnjKTRuKGLb+E7NBZApj2o/f/II1xNRlQ8SHs9H5HKsSO6Q
         W/6yKSkUTnT8ElQRqcV2lc68BIwAQGKQwM7c31/bqu2QuqyVfUdVc2aw1X0yacd1i5m7
         yh9Q==
X-Received: by 10.50.142.9 with SMTP id rs9mr1781695igb.17.1437206288148; Sat,
 18 Jul 2015 00:58:08 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sat, 18 Jul 2015 00:57:38 -0700 (PDT)
In-Reply-To: <xmqqa8uu3edr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274156>

On Sat, Jul 18, 2015 at 12:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The other one is more heavy.  Do we even want to have and expose
> GIT_COMMON_DIR environment variable?
>
> The primary reason why we added GIT_DIR, GIT_OBJECT_DIRECTORY
> etc. in the early days of Git was because we didn't exactly know
> what kind of layout and flexibility was needed from "various SCMs
> that sit on top of Git core", and we wanted to make progress rapidly
> without making decisions back then.  But it is not 2005 anymore.
>
> Suppose a file "gitdir: /home/gitster/w/src/.git/worktrees/rerere"
> (call that $GIT_DIR) is there, and there is $GIT_DIR/commondir. Is
> there any valid reason why somebody may want to use only part of
> that arrangement and have a $GIT_COMMON_DIR that points at a place
> different from $GIT_DIR/commondir points at to override only a part
> of the setting?
>
> Or perhaps there is a plain vanilla $GIT_DIR that does not have
> $GIT_DIR/commondir.  Is there any valid reason why somebody may want
> to reuse only part of that directory as if it were a linked checkout
> and then use $GIT_COMMON_DIR to redirect the access to the meat of
> the repository elsewhere?
>
> The safety that comes from the primary checkout and the secondary
> checkouts all knowing everybody else is lost in such a use case,
> that is the whole point of adding this new feature.  The fact that
> $GIT_COMMON_DIR/worktrees/* and $GIT_DIR/commondir reference each
> other is what gives us object-prune-safety and multi-checkout-safety.
>
> Unless I am mistaken, I think a separate GIT_COMMON_DIR environment
> variable that can be tweaked by end-user is nothing but a source of
> future bugs and user confusion, without giving us any useful
> flexibility.

The flexibility here is not about extending this feature per se but
maybe trying out an entirely different setup. Yes a bunch of safety
nets are thrown out of the window if you try it. I guess I still had
the 2005 mindset when I designed this. If there is no strong objection
to $GIT_COMMON_DIR, I suggest we keep it until we sort out the
submodule problem. There are a few options on how to share git repos
between submodules that this explicit separation _might_ help.
-- 
Duy
