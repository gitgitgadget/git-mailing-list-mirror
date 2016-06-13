From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Mon, 13 Jun 2016 22:47:53 +0000
Message-ID: <20160613224753.GA4761@dcvr.yhbt.net>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
 <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
 <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com>
 <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
 <20160609002150.GA28547@dcvr.yhbt.net>
 <070d6313-8328-3086-b04f-0bf70e236264@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCaeF-0000dY-2B
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423062AbcFMWrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:47:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59116 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422699AbcFMWrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:47:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EF0B1FF40;
	Mon, 13 Jun 2016 22:47:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <070d6313-8328-3086-b04f-0bf70e236264@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297256>

Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
> On 06/09/2016 02:21 AM, Eric Wong wrote:
> >Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
> >>Email::Simple library uses qr/\x0a\x0d|\x0d\x0a|\x0a|\x0d/ [1].
> >>Should we handle \n\r at end of line as well?
> >
> >"\n\r" can never happen with local $/ = "\n"
> 
> If the email file contains "\n\r", setting $/ = "\n" will leave "\r" at
> the beginning of each line.
> 
> We could trim them with:
> 
>   s/^\r//;
>   s/\r?\n$//;
> 
> But is it worth adding `s/^\r//;` to handle that extremely rare case?

I doubt it.  Having a "\r" in the wrong place is likely a bug in
whatever program that generated the email.  It should be exposed
so whoever generated that email has a chance to fix it on their
end rather than being quietly hidden.
