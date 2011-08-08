From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Tue, 9 Aug 2011 00:28:56 +0200
Message-ID: <CAGdFq_jzraS-_afjs+MmRS4ML805h73hXAjrRkrQ=tGUdSQqkQ@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org> <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vpqkfv8x1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:29:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYKQ-0008Ua-6i
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab1HHW3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:29:37 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46446 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab1HHW3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:29:37 -0400
Received: by pzk37 with SMTP id 37so8994885pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=84arNm3+Es9I2e36rpqIZHr+XJUkQHfx6RlfzxIje5s=;
        b=dO5SmGlXUHFUdnC1LptXaKRa6+feNpME+xTveFhhM17AF/8AvsnY68OaUFQUR2WV7n
         XAspgF3jKfkcd21sR4fSNe/ordm0mX8ZALubHcgP0yzh3A0UapUOd3E5RezDwKXpdAj4
         pclVCeJ7sdUsZ6djTOWB2nA41ZrOrSiEawqcw=
Received: by 10.143.13.10 with SMTP id q10mr6519593wfi.64.1312842576061; Mon,
 08 Aug 2011 15:29:36 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 15:28:56 -0700 (PDT)
In-Reply-To: <7vpqkfv8x1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178995>

Heya,

On Tue, Aug 9, 2011 at 00:24, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, which means you have a way to say "explicitly affirmative" vs "no
> information", but no way to say "explicitly negative", for example, and
> the worse part is that it is unclear if the approach the patch takes is
> extensible enough to allow that in the future. That is the kind of "myopic
> hack" attitude I did not particularly like in this patch.

Do we have a way to say explicitly negative on the commandline? Is
there a way to say "I don't want you to decorate this commit as
anything at all"?

> "The next person who needs more generic framework can rip out what this
> patch does and the work required is the same amount" is not a convincing
> argument---it would mean you are burdening that other person with an extra
> work to _redo_ what this series does properly, and it is not likely to be
> of help for that person after your interest in this codepath has long
> waned.

Be fair. How is "2 files changed, 8 insertions(+), 6 deletions(-)"
going to make it any harder at all for someone who is going to be
doing that huge patch series you described earlier?

>> Don't we already store that in the name field?
>
> Please remind yourself why then it is not sufficient for your patch to
> read from the name field please?

Sure, we could do it. But it would be duplicating all the effort
already being done in rev-parse!

> After all, wasn't the issue that "master^0..master" yields an empty set
> but you somehow wanted to know that the RHS of that dotdot was given as a
> positive ref?

The issue was that if I push "master" to origin but I already pushed a
"next" which points at the same commit nothing happens because
git-fast-export doesn't know to emit the "reset master :13878" line.

-- 
Cheers,

Sverre Rabbelier
