From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Fri, 25 Feb 2011 12:27:03 -0800 (PST)
Message-ID: <m3sjvb7tg4.fsf@localhost.localdomain>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1297017841-20678-19-git-send-email-martin.von.zweigbergk@gmail.com>
	<4D58E17C.9090001@viscovery.net>
	<alpine.DEB.2.00.1102232216180.11038@debian>
	<20110224080734.GB25595@sigill.intra.peff.net>
	<20110224080904.GC25595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:27:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt4GT-0000v4-0M
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab1BYU1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 15:27:45 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38074 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab1BYU1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 15:27:44 -0500
Received: by fxm17 with SMTP id 17so2050018fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=yLpuG1L8yINcdkymyW1uf1j3XE8X9MuLGG/wo7MEc20=;
        b=W+2ma8x/zhaEKZUZRVKDcvXJoGxaF46E3QslARgNkHW/ltFEDlDy8DnssSA7G/y31T
         tVu1oVyX0FWGQT586yqrwnsRO7YlCp4i++8O1DZ+kGKkitXAkmR6klQ6tZpoW4MY/dke
         ykzR+neVaKfg+clqZCrQB0yWpIZnB1dMEuP1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=QxrLuz0k9JRCYL70PGdRqaVsfb0hV2VPLKJ23zkADe6WSy2Y/9jEpNwF7x3RVuqetT
         Y5nBFuwh/APrKSELBiRxFafWy+M9iqTipg01eawW4EiwGJLFkOdyBTWcq3RzPXRfjAsi
         C2NVGvxLYKwkdlbzXTKh1NUhIAqAfag4E8jsI=
Received: by 10.223.103.4 with SMTP id i4mr2779379fao.123.1298665625708;
        Fri, 25 Feb 2011 12:27:05 -0800 (PST)
Received: from localhost.localdomain (abwr26.neoplus.adsl.tpnet.pl [83.8.241.26])
        by mx.google.com with ESMTPS id o12sm520887fav.30.2011.02.25.12.27.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 12:27:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1PKQ1MJ011078;
	Fri, 25 Feb 2011 21:26:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1PKPGDe011072;
	Fri, 25 Feb 2011 21:25:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110224080904.GC25595@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167939>

Jeff King <peff@peff.net> writes:
> On Thu, Feb 24, 2011 at 03:07:34AM -0500, Jeff King wrote:
> > On Wed, Feb 23, 2011 at 10:27:23PM -0500, Martin von Zweigbergk wrote:
> > 
> > > > > +++ b/git-rebase--merge.sh
> > > > 
> > > > This should be mode 100755. (Ditto for git-rebase--am.sh in 19/31)
> > > 
> > > I was just about to fix now and I noticed that quite a few other
> > > script files are mode 100644. Should all be changed to mode 100755 or
> > > is there some kind of rule as to which mode they should be? Both
> > > git-sh-setup.sh and git-parse-remote.sh are also mode 100644 and I
> > > (think I) know that both are always sourced. If the rule is that
> > > sourced scripts should be mode 100644 (but I'm just guessing here),
> > > then I should actually have changed the mode of
> > > git-rebase--interactive.sh to that mode instead. Please advice.
> > 
> > Yes, sourced scripts should not have an executable bit. See 46bac90 for
> > rationale.
> 
> And I should have mentioned: they should go in SCRIPT_LIB in the
> Makefile, not SCRIPT_SH.

Shouldn't this information be in Documentation/CodingGuidelines, and
perhaps also (checking if one doesn't accidentally change executable
bit on sourced scripts) in Documentation/SubmittingPatches?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
