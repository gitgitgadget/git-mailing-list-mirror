From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 14:05:36 -0800 (PST)
Message-ID: <m3d4eqzwuc.fsf@localhost.localdomain>
References: <1231883002.14181.27.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:07:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrPd-0000ig-V2
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbZAMWFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755175AbZAMWFl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:05:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:13413 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbZAMWFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:05:40 -0500
Received: by fg-out-1718.google.com with SMTP id 19so146355fgg.17
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 14:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=SkK4iSz7NklXrWB32GvVbpT0UPAebFFQneb8JArNADg=;
        b=jEwpkHfBMuo9vqagve44go/OtAY88ndQunKBFmXbdgl7StkB9YINvQAq+5C3ubFmzV
         FX74OEjtEQp/ZtfljrImfJouahbAf+i8kCoYYqYF8oaM5i1gOF13pW2jlFmlIaz5yKLZ
         MBfP0Oq/KIINdua+wInHrq6rAciB7ivE02FyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Lh0x1wwRJMkeyKlveY2JTLDs3hvyQC7FRD3utqu5OAcUXKutCmLnCR2HtYPFJjn+O2
         DzCMV96IRJAybNIjEwZ9h0CCIGu1UCujClL7yTce78ySd6D5OFc6uZ0hjAYetVR9AJOG
         gTrFbjAMqXXu3NYVJffUH6Z7Lytlu/cst3QYo=
Received: by 10.86.23.17 with SMTP id 17mr212964fgw.0.1231884337584;
        Tue, 13 Jan 2009 14:05:37 -0800 (PST)
Received: from localhost.localdomain (abvd199.neoplus.adsl.tpnet.pl [83.8.201.199])
        by mx.google.com with ESMTPS id 3sm2734879fge.57.2009.01.13.14.05.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jan 2009 14:05:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0DM51lh031369;
	Tue, 13 Jan 2009 23:05:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0DM4iJ6031364;
	Tue, 13 Jan 2009 23:04:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1231883002.14181.27.camel@starfruit>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105547>

"R. Tyler Ballance" <tyler@slide.com> writes:

> One of our developers "discovered" the --force option on `git push` and
> used it without taking the appropriate care and hosed one of the project
> branches we have running around in our central repository.
> 
> Besides a vigorous flogging, we're looking at other ways to prevent this
> sort of thing from happening again; the option we've settled on is to
> remove the "--force" flag from our internal build of v1.6.1
> 
> I'm wondering if somebody could point me in the right direction to
> remove "--force" (safely) from the builtin-push.c and removing the
> "rebase" command (we've got no use for it, and would prefer it gone).

First, the title (subject) of this email is misleading: it is about
your solution, and not about the problem you have (protecting against
"git push --force").

Second, there are two possible solutions: use receive.denyNonFastForwards
and perhaps also receive.denyDeletes (see git-config(1)) to forbid forced
pushes on server (target of push); removing '--force' is a client solution.
Or, better, use update or post-receive hook on server, forbidding 
non-fastforward updates to selected set of 'stable' branches; you can
use contrib/hooks/update-paranoid for that.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
