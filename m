From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin
 commands
Date: Tue, 10 Jan 2012 23:04:04 -0600
Message-ID: <20120111050404.GA13507@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino>
 <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkqHe-0001Ra-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726Ab2AKE7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 23:59:13 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44971 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab2AKE7M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 23:59:12 -0500
Received: by ggdk6 with SMTP id k6so157161ggd.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 20:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=57luYHSdnTHL+l1zyMeurmdrOkeuM9b9toQ5D/0mlJw=;
        b=hqucjam/osY8xzOT6uDcgC5M97TVWzmxozRm5CW/j6g5+5H8HL6eDBaQSXWpVELsgM
         tL1SqUTtsoYVOrma2Ymrvgk9ueOVC8bTr305Jc4rVH/NPPNoCYZBSI7VJQie7r87T+ms
         1EHgC6mu/ZzvlHvzJUlGYaQ9t3tj2ekYpsHUo=
Received: by 10.236.153.226 with SMTP id f62mr30566985yhk.62.1326257951362;
        Tue, 10 Jan 2012 20:59:11 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k3sm797514ani.13.2012.01.10.20.59.09
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 20:59:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188330>

Ramkumar Ramachandra wrote:

> I wrote that too quickly.  I can't stand seeing so many strcmp() calls
> all over my codebase -- look at the number of instances of matching
> opts->command to REPLAY_CMD_*.

If the number of such in sequencer.c is greater than 0, it's probably
a bug.  Why would the sequencer change behavior based on its caller's
name?

It's very easy for me to be wrong, though --- this is just a first
reaction, and I haven't looked at this version of sequencer.c yet,
since it doesn't exist. :)

Is this what you're talking about?

	if (opts->action == CHERRY_PICK)
		error(_("Your local changes would be overwritten by cherry-pick."));
	else
		error(_("Your local changes would be overwritten by revert."));

Now imagine "git rebase" wants to hook into the same stuff. What
should the message be?

Maybe:

	error(_("your local changes would be overwritten - aborting"));

Or:

	error(_(opts->error_msgs[REPLAY_WOULD_CLOBBER_LOCAL_CHANGES]));
