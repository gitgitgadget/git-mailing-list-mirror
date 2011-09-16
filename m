From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Thu, 15 Sep 2011 21:27:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109151956040.12564@debian>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com> <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com> <alpine.DEB.2.00.1109080753460.12564@debian>
 <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com> <alpine.DEB.2.00.1109082123300.12564@debian> <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com> <alpine.DEB.2.00.1109090900301.12564@debian> <alpine.DEB.2.00.1109122139110.12564@debian>
 <7vwrdaqxpk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 03:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4NDQ-0001tM-A2
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 03:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab1IPB1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 21:27:13 -0400
Received: from mail-vw0-f42.google.com ([209.85.212.42]:39549 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab1IPB1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 21:27:12 -0400
Received: by vwl1 with SMTP id 1so6101040vwl.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 18:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=IYSWb8bl5ChOL5VMMcubIJCpGBX1U1yjC+IWoqIokBY=;
        b=Qsza2+P/ensE1PSvlfr6mQQeteYsbFRQwH8AHW8UMgJsJrTfCpMvBQWr3kHZuOd+QP
         sjSDzSARdQF2BUdDhFBF7A30LP74XqVbB3n+FnqyOAffU8ydz0PrM69nfY/JVfG86kUt
         5c4V4oot8okhdPeShozcE21K0O7zAMlGfxiZ8=
Received: by 10.52.26.145 with SMTP id l17mr110074vdg.391.1316136431376;
        Thu, 15 Sep 2011 18:27:11 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca. [24.37.77.94])
        by mx.google.com with ESMTPS id gb4sm3061364vdc.16.2011.09.15.18.27.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 18:27:10 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <7vwrdaqxpk.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181523>

Hi,

On Wed, 14 Sep 2011, Junio C Hamano wrote:

> What I said is "all 'am' need to use from its input while rebasing is the
> commit object name"; that is very different from "we have only commit
> object name so we must use cherry-pick" or "because we have commit object
> name, we can afford to use cherry-pick".

Right. I didn't mean to suggest that we should use cherry-pick.

> Look for $rebasing in git-am.sh and notice that:

Thanks! I had no idea about these "tricks" in git-am.sh. Now I
understand much better what you meant. So we are currently getting the
metainfo from the commit rather than from the mailbox. With your
patch, we would also get the patch body from the commit. The only
thing remaining after that is the commit log message, correct?

Once all that git-am reads from the mailbox while in $rebasing mode is
the commit name, it would be as small change to teach it to read a
list of commit names instead. Is this what you meant or did you really
mean for format-patch to generate output without patch body? At this
point the name 'am' becomes quite misleading, but maybe that's not
worth worrying about.


Thanks,
Martin
