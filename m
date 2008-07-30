From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 30 Jul 2008 11:37:04 +0700
Organization: AcademSoft Ltd.
Message-ID: <200807301137.04669.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 06:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3SC-0008Ah-Te
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 06:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbYG3EhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 00:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbYG3EhY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 00:37:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:53711 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYG3EhX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 00:37:23 -0400
Received: by ug-out-1314.google.com with SMTP id h2so218999ugf.16
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 21:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HwRRdeWUFL9xfT58EIIhc+oj2eDtG0mdT3n2vMdc4Xk=;
        b=g85BRj5/W8bc9d7ToFoq6yzmbGRGxiVyih4a8CePmssnzSniHDADA7eF3886KtfFWd
         ADxozP67LtxisJ2P7TDytmkBdwkNpCrYMcf49v/BXXtZwXRiIxop+0E5EjqxWH0TviWW
         jZd0ykhPbzdzn97IjXlxLdARyGBw/Gi5K1Zxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=M6M+yAepZr+nKsQEbGU+82l7QehTE+uPtvllcbVcU0f0wP4W+cj2fNoXpEmcSjuCv7
         A5OE3hzJyBw5ldE+Am92+C7+An5iihsg0uByY57g6Ox4IGZiuKLwIfu+CIuldDd/Iqqo
         au6/gsWmi09InocgaofkByrYjwlP8ipau323o=
Received: by 10.66.250.17 with SMTP id x17mr783462ugh.0.1217392641362;
        Tue, 29 Jul 2008 21:37:21 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id 34sm1461466ugh.76.2008.07.29.21.37.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jul 2008 21:37:19 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90734>

> This is a known issue, but since nobody with that itch seems to care
> enough to fix it, I doubt it will ever be fixed.

Hello again.

I have investigated this problem. Short result: git-svn and ANY file 
convertion will not work now.

In my case I have found the problem is the 
SVN::Git::Fetcher::apply_textdelta() function. To be more precicly call to 
SVN::TxDelta::apply(). We fetch previous version of file from git and then 
apply to it svn's delta. As far as we modify src file SVN fails to apply its 
delta. If I modify last commit and put original version of file everything 
works.

So it seems to me there are two solutions: 
1. Store original file somehow and use it to construct new file version;
2. In case of this error we could fetch full blob with new (or old) version of 
the file.

I did not find the way to gather full file conntent nor feel myself ready to 
rewrite git-svn to store original file somewhere.

Does anybody can help or comment on this ?
