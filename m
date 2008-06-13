From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 12:33:41 +0200
Message-ID: <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	 <20080611230344.GD19474@sigill.intra.peff.net>
	 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	 <loom.20080612T042942-698@post.gmane.org>
	 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	 <4851F6F4.8000503@op5.se>
	 <20080613055800.GA26768@sigill.intra.peff.net>
	 <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
	 <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Andreas Ericsson" <ae@op5.se>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Eric Raible" <raible@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 12:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K76ce-00011z-7E
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 12:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbYFMKdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 06:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYFMKdm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 06:33:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:6101 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbYFMKdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 06:33:42 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4056845wfd.4
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FphyR6Nub7Vk6zdiznd5dQvYTHcwlblP8c8DLv5255s=;
        b=Dp+LtquGUslgH1WnY3hyUCoF4l1RMsJggqBJmx12u7Utsk2UOfGed4EVzT2rqEWHbG
         83McT6+kX9EhWbptXLOHE1I5ogJvF944xuZkLdKTwlBpFr0Qw6pkaXIkC1iV2Q/56QQo
         Ysyd4+qP52Vn5dX6dE9ZIP0fDoWvf0EnVK1yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=OiEKoSf3PYMoIuYiLMFGj+OO6or2IAzDUpXwrlKztPDN97HytfzriHdGR37R2w1CSU
         cYQym4D+dEA0WJvPpa5gosRzjyjYLnpOjQyu36qkhwr1E007kmMq6SNHZ2kG+VQbRSw7
         lFxsZznuy2zFYUKtNCdx5Lf2T2rnqWui+35vw=
Received: by 10.142.179.12 with SMTP id b12mr989755wff.282.1213353221421;
        Fri, 13 Jun 2008 03:33:41 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Fri, 13 Jun 2008 03:33:41 -0700 (PDT)
In-Reply-To: <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84864>

On Fri, Jun 13, 2008 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:

<big snip>

> But let's not talk nor think about per-branch stash for now.  How does the
> "keep" thing sound to people?

I'm divided on this:
 OOH: I like the idea of having a keep command to mark stashes as
valuable, making them not expire until dropped explicitly. Such a
feature would also encourage user to go through their stashes every
now and then and decide which ones are valuable, and which ones were
indeed not that valuable and may be dropped.

 OTOH: I dislike the idea of 'forcing' the users to go through their
stashes lest they lose their work. I don't see why anybody would want
to do some work, stash it, and then "for no apparent reason" (the
reason being not touching it for some time) lose it later. What if
their system borks up and gives a wrong value as current time (say, 10
years in the future), all of a sudden their stashes are gone, and they
might not even find out till it was too late. Sure, they'd lose some
stale objects too, but that I can live with, those they did not ask
git to take care of explicitly!

The per-branch stashes sounds very nice, especially if you can get a
'git stash list --all' feature, that shows all stashes, regardless of
what branch they are on. I myself would use such a per-branch feature
most of the time, it would be nice to have a config option that
defaults to that (making 'git stash' create a per-branch stash by
default that is).

-- 
Cheers,

Sverre Rabbelier
