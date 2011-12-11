From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 20:53:05 +0100
Message-ID: <201112112053.07548.jnareb@gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org> <m3ehwbge8f.fsf@localhost.localdomain> <m2hb176iiy.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Gelonida N <gelonida@gmail.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Dec 11 20:53:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZpSV-0006qX-4a
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 20:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab1LKTxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 14:53:11 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50354 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab1LKTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 14:53:09 -0500
Received: by eaaj10 with SMTP id j10so259186eaa.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6uftlM+eM1b8LpVgEnVJz9P5c/wuTZQJWCWJm8PL2bg=;
        b=M1girNMss42q7JPoVq72/vqu0NL+PdbCA5OIp5+RtT/SYxqQgfjrvI2rn3QkqeKtEJ
         QXZ23xWZLw0mnq/aBE4guRdsenzdYRqgGGOQWGf+3cabUX5M+ZWk8xvm9hvE7FUnt3eM
         ZqmGtiJ2H13vddkj+b6DPyRwatvUJhaNJWtjk=
Received: by 10.213.8.21 with SMTP id f21mr1465168ebf.20.1323633188387;
        Sun, 11 Dec 2011 11:53:08 -0800 (PST)
Received: from [192.168.1.13] (abvp14.neoplus.adsl.tpnet.pl. [83.8.213.14])
        by mx.google.com with ESMTPS id q28sm65260213eea.6.2011.12.11.11.53.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Dec 2011 11:53:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <m2hb176iiy.fsf@igel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186809>

Andreas Schwab wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Something like
> >
> >   git for-each-ref '--format=%(refname) %(upstream)' |
> >   while read refname upstream
> >   do
> >   	# there is upstream
> >   	test -n "$upstream" || break

Here you should probably also check if we are already up-to-date:

    	test $(git rev-parse $upstream) = $(git rev-parse $refname) || continue

> >   	# and if fast-forwards
> >   	test $(git merge-base $refname $upstream) = $(git rev-parse $refname) || break
> >   	git update-ref -m "$message" $refname $upstream
> >   done
> 
> You probably meant s/break/continue/.

Yes, sorry about that.

BTW. git-update-ref invocation can be replaced by Sitaram's suggestion:

    	git branch -f $refname $upstream

-- 
Jakub Narebski
Poland
