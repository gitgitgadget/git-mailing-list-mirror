From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Fri, 11 Feb 2011 19:55:13 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102111811300.26684@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vd3mz33xb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 01:55:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po3lm-0007Ay-9Q
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 01:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088Ab1BLAzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 19:55:22 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48837 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1BLAzV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 19:55:21 -0500
Received: by vxb37 with SMTP id 37so1715264vxb.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 16:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=Lysx5bLCDLMvDRMWRQTOakL0V+LAnBE9BwFpGVirs5s=;
        b=HfrPZCS77UFeuYn30ciKHu4Xa02cIhX/3XozBHswMCbklvg0irt+Do4B5pFDaCPns7
         SyGXmz/6f3cMmG9ak5RQuBDh2IujOEHaryUPwjabkW2i/Vwf/KFQjqo95UPlQwW1BFax
         0n5AwCOW5zC/L52qDecvGmBR5mcsy78ZXYTZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=EBfevuBeZ0kSQCJo5BTLxVWyJErOwis9/V2LsLi9Ln65xxsgZP19aIXAOTETtYEUDk
         o6oORzebfSaKOc/2AdGfxJ9pVlgAA3aSrpGHuEcmQ4WiRy4W+/vspIdZeIGDnCacUyeV
         0HQAD/9P3Q0LxFqxdzxfqM5k381gJHUGrZrqg=
Received: by 10.220.94.208 with SMTP id a16mr1515667vcn.6.1297472120355;
        Fri, 11 Feb 2011 16:55:20 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e10sm593372vch.19.2011.02.11.16.55.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 16:55:18 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vd3mz33xb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166584>

On Thu, 10 Feb 2011, Junio C Hamano wrote:

> I am not sure if forbidding "-v --continue" adds any value;

If I remember correctly, it was just the simplest possible way to not
have to handle cases like "-i/-p/-m --continue" specially.

> would it be
> too much effort to allow "--continue -v" instead to achieve the same
> degree of consistency between the two?

I think it would be doable. Maybe something like:

 * Check that only the allowable options (-v/-q, -s, -X,
   --[no-]rerere-autoupdate) are passed together with --continue or
   --skip. For simplicity, maybe we can just accept the same set of
   flags with --abort as well, even though only -v/-q would make any
   sense.

 * When reading the saved state, first check for each of the options
   if it is already set. If it is, write it to disk instead, to make
   sure it is remembered across future interruptions. Otherwise, just
   read it as usual.

I think that should be all that's needed. I'll have a look at it when
I get some time.


/Martin
