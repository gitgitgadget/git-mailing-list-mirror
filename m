From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Thu, 2 Jul 2015 15:00:45 -0400
Message-ID: <CAPig+cTm7Qzxr_E+_p6UYmPrsQzTFCN-Mouu-FigNqRH=gSPKg@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
	<CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
	<CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
	<CAPig+cR2tn6G0N1sSsrkP_Lo_U_hjLYi08qEsMr+gcsjheaX7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 21:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAjjE-00029b-OT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 21:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbbGBTAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 15:00:51 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36584 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbbGBTAq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 15:00:46 -0400
Received: by ykdr198 with SMTP id r198so76660637ykd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vZQT+22U9kMeIYdUr8JPyhiNTkfB87CWAxsKz+UEfRw=;
        b=xaPw4g+swFZpFlmyWWoyD5cXBXotnxbx6Eavg/oYCr6PVRijz4I4QDEtrSduobPFD1
         uhZak6sL6jtEfDVuHsUrUal7FqIvsybajMru6OeOu0HNDRgwna7wTPkW5B7obhG23bN/
         SmYMS7gsB3ppUXqHWzkcqHa+MyO4eo+4EWcWQaxlSL4XrwkmHQYgoOqfak3Zp2hr1wE7
         NnbFjgdxApF4CbivijgVYPpE5DAswxVR9T2GC2k7jYSP1k9kbbrUFbeIqAoJDymWAX78
         9IUPhpdJr52/CtfiyOvRi8bMUtFfc29KUO6HZECe+8KpL/ieOyrVbt9K4z9Jh4BiCYUw
         RDrg==
X-Received: by 10.129.70.69 with SMTP id t66mr26222400ywa.4.1435863645549;
 Thu, 02 Jul 2015 12:00:45 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 2 Jul 2015 12:00:45 -0700 (PDT)
In-Reply-To: <CAPig+cR2tn6G0N1sSsrkP_Lo_U_hjLYi08qEsMr+gcsjheaX7A@mail.gmail.com>
X-Google-Sender-Auth: S_cltSlKuk3d8GsR0yVPvOFkzDk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273270>

On Thu, Jul 2, 2015 at 2:45 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> There's another instance: 3473ad0 (checkout: don't require a work tree
> when checking out into a new one, 2014-11-30) added this:
>
>     if (!new_worktree)
>         setup_work_tree();
>
> which the "worktree add" patch changed to:
>
>     setup_work_tree();
>
> which doesn't hurt (since setup_work_tree() protects itself against
> multiple invocations) but isn't semantically clean. If I understand
> correctly, I think a better approach would be to move the
> setup_work_tree() call to worktree.c just before it invokes
> git-checkout, and revert 3473ad0 entirely (including this bit):
>
>     - { "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
>     +{ "checkout", cmd_checkout, RUN_SETUP },
>
> so that git-checkout once again requires a worktree.

I mis-stated that a bit. The bit about "multiple invocations" isn't
relevant. The point is that I think that 3473ad0 can simply be
reverted as long as worktree.c calls setup_work_tree() before invoking
git-checkout.
