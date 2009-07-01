From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bisect; is there a way to pick only from the children of a given commit
Date: Wed, 01 Jul 2009 13:02:23 -0700 (PDT)
Message-ID: <m38wj8w4s1.fsf@localhost.localdomain>
References: <loom.20090701T170535-707@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Stonehouse <rstonehouse@solarflare.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:02:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM60m-0006K3-Mf
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 22:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbZGAUCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 16:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZGAUCW
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 16:02:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:33720 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbZGAUCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 16:02:22 -0400
Received: by fg-out-1718.google.com with SMTP id e12so973968fga.17
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=vOBaDm7DpLTs5nn/mfPAK7A9I2ecbjscDKitSoSSGw8=;
        b=g2Ar5ic86l9OU/pD1rFLkU0wuCsbWbY0jVWxsVwj4XSwawBPPTaZproBU3/9jfxmNr
         EElUvbykRev/2QHqa0aLZDSpbzytIHfe0VVzf45gyzKb7P12dB6EnbqsW1AZ2nmuwfVn
         HZ9MSLLJRmOfS+0N1EYz6xvI9d9eYLXiwu2zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=B/8ZVajDpqAz8iCIQu540HHdgP7EFFqUioeXJF52/FJ2/qXzLVmwApbQoF0TM1aOBF
         VzyjekoOITH/qPGj1mp4EXO9gnjUhVb5qEybinZAOou4RZ/spbe4OD8Ww2LZ446mv+M4
         yLFuoekYAj+qDH1NshqfexoW687RhzmRpbfAw=
Received: by 10.86.58.9 with SMTP id g9mr4959916fga.18.1246478543546;
        Wed, 01 Jul 2009 13:02:23 -0700 (PDT)
Received: from localhost.localdomain (abwo245.neoplus.adsl.tpnet.pl [83.8.238.245])
        by mx.google.com with ESMTPS id 3sm4545911fge.17.2009.07.01.13.02.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 13:02:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n61K2NHX018858;
	Wed, 1 Jul 2009 22:02:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n61K2M7N018855;
	Wed, 1 Jul 2009 22:02:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20090701T170535-707@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122597>

Robert Stonehouse <rstonehouse@solarflare.com> writes:

> I had a problem where I thought git bisect would be a good way forwards.
> It didn't work as expected so I made myself a simpler test-case.
> 
> featureA (which was a new build target) was broken at HEAD. It had been
> developed on the featureA branch. After featureA was merged into master,
> featureB (which had branched from master at the same point as featureA) was
> merged with master.
> 
>   $ git log --graph --abbrev-commit --pretty=oneline
>   * b394c57... master4
>   *   7e8d675... Merge branch 'featureB'
>   |\  
>   | * 8d87aee... featureB2
>   | * c1a8450... featureB1
>   * | 44c5601... master3
>   * |   269602a... Merge branch 'featureA'
>   |\ \  
>   | * | 91b1bbb... featureA2
>   | * | 0c15834... featureA1
>   | |/  
>   * | 1ea4a0c... master2
>   |/  
>   * 204f839... master1
> 
> Tag featureA1 was my good commit, and HEAD was the bad.
> I was surprised that git bisect was asking me to test commits on the featureB
> branch. I couldn't test the build target that was broken on branch featureB
> because it wasn't present in the code at that point.

That is what "git bisect skip [<rev>|<range>...]" is for."

> Is there a way to do what I want (bisect all children of a commit)?

Also in 'pu' there is refs/replace mechanism, which was intendend
mainly to "repair" un-bisectable history...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
