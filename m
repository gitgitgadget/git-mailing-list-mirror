From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH/RFC 04/20] rebase: remove unused rebase state
 'prev_head'
Date: Fri, 26 Nov 2010 19:45:49 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1011261919540.17721@debian>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com> <1290715083-16919-5-git-send-email-martin.von.zweigbergk@gmail.com> <4CEF67AB.6050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Nov 27 01:45:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM8v5-0006lT-OC
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 01:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0K0Apf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 19:45:35 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39123 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab0K0Ape (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 19:45:34 -0500
Received: by qyk12 with SMTP id 12so4047702qyk.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=rF/EMLdwbCHWaJOoqfVz4lWn1b73E2GimDJyriGFYyY=;
        b=huSu28SUJgGBPpGNrGcpZgRmwuwsVNOMlPRN5jeeLWdk/ZePDb5rZLOWUA3nXqVROJ
         aUQOq2h5uxqYVJkJ3+5+6XD8Qh91ioonBqu0BCw5R2EJPHE9HofrYkLydOt6jAjRhhc3
         tX+vV4vwn2KWu3vtqYqhWA0ISU7rWnEIRCJfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=kUqM4fk2BUj3419sGcdnM2oe9b+Hpu0aKQWHapu1gQ1cE0EnfSMTTmtayQlqs/h7VE
         adN79ILxVZfVEI2Df4x1uKPbPia7M8rwpYkipE91nh+mHfi9Mzjbn86l1ihteOMHFQEE
         OcyamMkMqgEBNkSqLGnQZkENSonCg2MEqDkRY=
Received: by 10.229.225.134 with SMTP id is6mr2287110qcb.99.1290818733599;
        Fri, 26 Nov 2010 16:45:33 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id mz11sm1559730qcb.3.2010.11.26.16.45.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 16:45:32 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4CEF67AB.6050700@drmicha.warpmail.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162288>


On Fri, 26 Nov 2010, Michael J Gruber wrote:

> Martin von Zweigbergk venit, vidit, dixit 25.11.2010 20:57:
> > The rebase state 'prev_head' is not used. Remove it.
> > 
> > Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> > ---
> 
> The actual value of prev_head was never used. But the check for its
> non-nullness made sure that git-rev-parse HEAD^0 succeeded when
> $merge_dir was created. Have you made sure that we don't need that check?

In continue_merge, the value written to prev_head is the output from
`git rev-parse HEAD^0`. The value written to prev_head when the rebase
is initiated seems to be `git rev-parse -q --verify` for some
reference. In the latter case, the rebase is aborted if the exit code
from rev-parse is non-zero. The prev_head file is only deleted when
the whole $merge_dir is deleted.

Unless I'm mistaken, the above taken together seems to mean that
$prev_head can only be empty if the output of rev-parse is empty. I'm
still way to unfamiliar with the Git C code to be able to figure out
if and when that may happen, but I'm sure you guys can help. The most
likely candidate I could think of was an orphan branch (same thing as
an unborn branch?), but even in that case was the output non-empty
(`git rev-parse HEAD^0` simply resulted in 'HEAD^0').

Do you see any case where we do need the check?


/Martin
