From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Mon, 18 May 2009 23:35:45 -0700 (PDT)
Message-ID: <m3r5ylk347.fsf@localhost.localdomain>
References: <20090517153307.6403.73576.>
	<20090517153647.6403.44036.chriscool@tuxfamily.org>
	<7v3ab3exht.fsf@alter.siamese.dyndns.org>
	<200905190616.30132.chriscool@tuxfamily.org>
	<7vws8d8y8i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 19 08:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Iva-0005u2-NY
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 08:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbZESGfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 02:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbZESGfq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 02:35:46 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:29837 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZESGfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 02:35:45 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2293297yxj.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 23:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=OV6da9Y+UunFkpergN/u32SLfrfiW3ih2jUqWN8A59Q=;
        b=gOgvEQiCVkih7MYpEmh/jYG1Pj3PIU7RatPI3BSRx8ul4iW9uDfypITlf37vrm8mCU
         glcyV7HNpU1yo/ID4OwrOOmCIeOKkxKW+S4+ZeC0sRAvHfzgKH0+o0a+/wlD11HuPSIs
         zsU/giDs4/lsABb1eVjvZXsdBBL711GTujc6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=USx5nILk4fQlWdfKTA0O4oAs6Jh5rg+KuWEcA1b0ZkJaOpWtEXGGgJzmXS0sVAYKjL
         tB4OMpUYoSuMcbBGN08s8dhhnZAACjrzl43L5H8/8ysc+A6ObBxszoUJL1BvvnOTbv1P
         SVdGvbCOuI9Mo9XsHOpkRK1zt5pMSt2cqWEAA=
Received: by 10.90.35.9 with SMTP id i9mr5842822agi.11.1242714946297;
        Mon, 18 May 2009 23:35:46 -0700 (PDT)
Received: from localhost.localdomain (abwi178.neoplus.adsl.tpnet.pl [83.8.232.178])
        by mx.google.com with ESMTPS id 4sm9133833agc.12.2009.05.18.23.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 23:35:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4J6dsDD008619;
	Tue, 19 May 2009 08:39:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4J6dq9s008616;
	Tue, 19 May 2009 08:39:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vws8d8y8i.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119495>

Junio C Hamano <gitster@pobox.com> writes:
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
> > By the way, when you say that you suspect an attempt to replace an object 
> > that is directly listed on the command line would not work very well with 
> > the current replace series, is it related to the unparsing commit problem?
> 
> What I fear is something like this.
> 
> 	git push $there 04a8c^2:master
> 
> It would need to parse 04a8c to find its second parent and then start
> discussing what object to send with the other end.  "04a8c^2" is a direct
> user input and should mean the same commit as git show "04a8c^2" would
> give the user, so it obviously needs to obey the replace rules (making
> 04a8c parsed), but the object transfer should not look at replace at all
> (that's the whole point of not using the "graft hack" that cannot be
> sanely transferred to the other end).

First, I have always thought that you cannot push arbitrary SHA-1
(arbitrary commits) in git; you can only push via refs. Isn't it true?

Second, the "refs/replace" mechanism has the advantage over grafts
that it is sanely transferrable. Whether "04a8c^2"^{replaced} exists
on remote side depends on if other side has the same replacement, or
if you push replacements in the same push.

Solution here could be to bail out and ask user to confirm whether
other side has the same replacements... or something like that.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
