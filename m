From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] refs.c: Write reflogs for notes just like for branch heads
Date: Tue, 30 Mar 2010 12:18:16 -0700 (PDT)
Message-ID: <m3mxxpipqw.fsf@localhost.localdomain>
References: <d6c334ec855bf04d9edb432b9cdc3590ab96d6e9.1269867675.git.git@drmicha.warpmail.net>
	<201003291625.22977.johan@herland.net>
	<20100330171932.GE17763@coredump.intra.peff.net>
	<201003302000.35616.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 30 21:18:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwgxV-0005YP-Qr
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 21:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab0C3TS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 15:18:26 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:32991 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab0C3TSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 15:18:20 -0400
Received: by bwz1 with SMTP id 1so4653776bwz.21
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=S0TwBnKVIcvlrDPAdSTUSa0YVJZrHw3PFUH9Xj6PbQs=;
        b=vJM4xz5PJeQ1aANjZgs0aDUN0kkm8zpXZEMVK4o4E4xdhtqOtj0X7IufsDZGrzNo/n
         4YGCc+uWjkPZSBlRCo7zQBl8Eo1WageTfWvw8rE5CSinunubDL3Jc6ztRBp+uCxqm3VR
         9E6eTow7ZfgbAkZfco9PcfAMrwEwtEYlpXn4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=PCMR5/an1l/fp0UVJKcxxp5XUPOvRFJP59lL4EjMcq24qBrEnnY+zGWWkm9JcMqqp3
         C5n5V0sOBnQ7UITbXlxRCbOoyCk6uwP5AqRr8DO0EEICemFO6jvKOMSL0zDQ2QNrk35W
         4Ks+HP0BZqT8Fle6BfgnmFZAXQd/bAHt8a5xg=
Received: by 10.204.156.5 with SMTP id u5mr2273283bkw.161.1269976699195;
        Tue, 30 Mar 2010 12:18:19 -0700 (PDT)
Received: from localhost.localdomain (abvx12.neoplus.adsl.tpnet.pl [83.8.221.12])
        by mx.google.com with ESMTPS id a11sm50397802bkc.15.2010.03.30.12.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 12:18:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2UJHSPi016619;
	Tue, 30 Mar 2010 21:17:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2UJGtNT016614;
	Tue, 30 Mar 2010 21:16:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201003302000.35616.johan@herland.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143591>

Johan Herland <johan@herland.net> writes:
> On Tuesday 30 March 2010, Jeff King wrote:

> > I like the idea of having a reflog, just because you could use it to
> > salvage an old cache if you were playing around with your helper's
> > options (or debugging your helper :) ). The usual 90-day expiration
> > time is perhaps too long, though.
> 
> Yes, 90 days as a default might be excessive, but you can always 
> override it with a "git gc --prune=now"...

You can always set different expire time for notes by using

  [gc "refs/notes"]
        reflogExpire = 7 # days, I suppose

Which is not documented (I have found it in RelNotes-1.6.0.txt).  
Oh well...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
