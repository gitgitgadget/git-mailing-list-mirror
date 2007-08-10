From: Domenico Andreoli <cavokz@gmail.com>
Subject: git-log-branches
Date: Fri, 10 Aug 2007 09:53:49 +0200
Message-ID: <20070810075349.GA29584@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 09:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJPJP-0006UF-B4
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbXHJHxc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbXHJHxc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:53:32 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:36527 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbXHJHxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:53:31 -0400
Received: by mu-out-0910.google.com with SMTP id i10so987040mue
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 00:53:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=p70mF1dkKze/To+HIJaLjjqs3vsJ0LbZQHPXymA+4jbYy600iy58L3Mye36096NGLR98/2rH3BvOcD4EaKtc58+K1trfyaj2/oG6xKEP4TuIdXOE0vAirUeDZ1T3dvDAoYvFeh6FDFtJBGBT+FULznnK55hrJBJkGNmalwzPqD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=lFa05/UBUdkmJTWg1hmRsEfhgZ3QzMR/kpZUC5cWjX7N/2ZVeAqzQW8u/GqRk/2mTvbCK5uACZRtMCdf9BlOZ1HeKBul6Z+r/j0a54j5j0MabLytWj6x7ST6RSYoUyQWseHwyLG/SXIf83TTsVtOK1xeOIndnUuoP+mNIraEeR0=
Received: by 10.86.58.3 with SMTP id g3mr2156731fga.1186732408921;
        Fri, 10 Aug 2007 00:53:28 -0700 (PDT)
Received: from raptus.dandreoli.com ( [159.149.71.27])
        by mx.google.com with ESMTPS id k29sm4954633fkk.2007.08.10.00.53.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2007 00:53:28 -0700 (PDT)
Received: by raptus.dandreoli.com (Postfix, from userid 1000)
	id 96E057B0527; Fri, 10 Aug 2007 09:53:49 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55518>

Hi,

  in trying to survive in the forest of git repositories I spread all
over my boxes, I came to this script. I use it to see which changes
are in my local branches w.r.t. tracked remotes and vice versa.

It is pretty raw and uses only commands I know. Feel free to point me
to better command using. Or to a better script, which I am sure has
been already written ;)

cheers,
Domenico


#! /bin/sh

if [ -z "$1" ]; then
        echo "usage: $0 <remote>"
        exit
fi

for b in $(git branch | sed 's/^..//'); do
        if ! git branch -r | grep $1/$b >/dev/null; then
                continue
        fi

        if [ -n "$(git log $b..$1/$b)" ]; then
                echo "$b..$1/$b:"
                git log $b..$1/$b
        fi

        if [ -n "$(git log $1/$b..$b)" ]; then
                echo "$1/$b..$b:"
                git log $1/$b..$b
        fi
done


-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
