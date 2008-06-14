From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Sat, 14 Jun 2008 10:16:42 +0900
Message-ID: <200806140117.m5E1HZj6032168@mi0.bluebottle.com>
References: <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
	<5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	<20080611230344.GD19474@sigill.intra.peff.net>
	<alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	<loom.20080612T042942-698@post.gmane.org>
	<6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	<4851F6F4.8000503@op5.se>
	<20080613055800.GA26768@sigill.intra.peff.net>
	<48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
	<7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
	<bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com>
	<7v3anhuonj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: sverre@rabbelier.nl, "Jeff King" <peff@peff.net>,
	"Andreas Ericsson" <ae@op5.se>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Eric Raible" <raible@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 03:18:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7KPY-000135-Ld
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 03:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953AbYFNBRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 21:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757903AbYFNBRh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 21:17:37 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:52895 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756840AbYFNBRg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 21:17:36 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5E1HZj6032168
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 18:17:35 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:date:to:cc:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=KAP/KrFZPvcAos5LMt1rXkuV4vfOYgM/ACTxgD0SpVxarRAWW1nxgYfNjRMY7Uz9e
	E4e46MqrA6EAvjzE1eW5Qn9hgYysuBqmcWTczMu7PzeUHI7C7RHghiwh0Q3k5i1
Received: from nanako3.mail.bluebottle.com ([211.140.192.186])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m5E1HArU007073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Jun 2008 18:17:19 -0700
In-Reply-To: <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <1e7ddf22bf0846d85747e60e9acd56e9>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84958>

Quoting Junio C Hamano <gitster@pobox.com>:

> I do not personally care too deeply about the "keep" approach.  An easier
> to explain (and perhaps easier to implement, too) alternative would be to
> have a per-ref configuration variable that specifies the reflog retention
> period per ref, e.g. "git config reflog.refs/stash.expire never".

I think I am primarily responsible for this auto expiration
behavior of git-stash command.  The original use case that led
to my git-save script was only about very short-term use.  To
tell you the truth, I did not even realize myself that I can use
stash@{<<number>>} to refer to more than one states until
Johannes Schindelin pointed it out to me.  It was only about
saving the current state once, and that proves it was about very
short-term use and nothing else.

But I think git-stash may have outgrown the original motivation.

Configurable expiration period per reflog like you suggested
sounds like the most sane solution to the issue to me.  I think
that approach is especially attractive because it can kill a few
birds with the same stone.  You can configure remote tracking
branches' logs to expire much sooner than your own branches'
ones, for example.

But I think "reflog.refs/stash.expire" you mentioned above is a
bad name.  Because the default expiration period is configured
with "gc.reflogexpire", it would be better to make the variable
name start with "gc".

By the way, I sent a documentation patch to git-stash but did
not hear any response.  Was there anything wrong with it?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com/tag/3
