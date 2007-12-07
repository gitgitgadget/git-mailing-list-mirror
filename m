From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Something is broken in repack
Date: Fri, 7 Dec 2007 18:05:38 -0500
Message-ID: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 00:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0mGf-0001I6-LV
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 00:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbXLGXFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 18:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbXLGXFj
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 18:05:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:51985 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbXLGXFi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 18:05:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1752072wah
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 15:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=6+5eauNX+T864TT4W+jovyMzFo7M+mG5L0u8JH3gxog=;
        b=tR5gYdq2zpsDKm/3WQ4MMRP7GBKcueY7asAsoSFZUfOVQcYSCYuth9XcsOzxx9kOywE+xBI7g3DOzTs9/mv12DJpMOEIwcXnH1RFEJ6AsPE6i5Fzulilyt+ooBAkkINen7u0HZCZ/qR7dZh4W96QsE+q3LVpCPW1RbDI1NEgdBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=w49BziHeApQCEbNXtZxdOzKC5L6hLSV+tEHDsJTvRdFiwsqcGEQafP3kD/upfVeDySISyu0XVdUkcAJ/hDSNcPdgGNydj0e5m2SLejrRSs+JSR+VSNAWgQOrw968X50w/b+70BSuGvG/iYo1EmHTt1i52dqODZBohRol/CdwXOs=
Received: by 10.114.160.1 with SMTP id i1mr1575461wae.1197068738125;
        Fri, 07 Dec 2007 15:05:38 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 15:05:38 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67485>

Using this config:
[pack]
        threads = 4
        deltacachesize = 256M
        deltacachelimit = 0

And the 330MB gcc pack for input
 git repack -a -d -f  --depth=250 --window=250

complete seconds RAM
10%  47 1GB
20%  29 1Gb
30%  24 1Gb
40%  18 1GB
50%  110 1.2GB
60%  85 1.4GB
70%  195 1.5GB
80%  186 2.5GB
90%  489 3.8GB
95%  800 4.8GB
I killed it because it started swapping

The mmaps are only about 400MB in this case.
At the end the git process had 4.4GB of physical RAM allocated.

Starting from a highly compressed pack greatly aggravates the problem.
Starting with a 2GB pack of the same data my process size only grew to
3GB with 2GB of mmaps.

-- 
Jon Smirl
jonsmirl@gmail.com
