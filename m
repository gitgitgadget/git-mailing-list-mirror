From: "Francesco Pretto" <ceztkoml@gmail.com>
Subject: Gitweb is preprocessing content when it shouldn't
Date: Thu, 1 Nov 2007 22:36:27 +0100
Message-ID: <b13782500711011436g4d0d78f2y76e19e04ff207f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 22:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhjz-0003T2-F0
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013AbXKAVge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758982AbXKAVgd
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:36:33 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:38788 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758870AbXKAVga (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:36:30 -0400
Received: by el-out-1112.google.com with SMTP id j27so193018elf
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=hZ+u1LpwOV6/qn5GcPZv4LfhX74bf/sEIJRzS+4nH5A=;
        b=nhcgYwSbt8G6O6V7P0mIEaOdhViinbOJJHeF0PsQWf2P1rzBb4wJyqDg1+DQosv1uj/vxZo0zwJca2hHLNZ0+FLp6R4Lde71PESB95T7kYDYulKF+1d3C/5ayllbGikoYOnKlHrlPdqDgrBKFggo6DQGGngE4mbHMlhiPOZ5p+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EeSwLHJ/lQtK9UGdPv7QFX5L2R9WND9jElY7eJp5KvaYb5OO63z3UwFQuLHVopHmt7W9kv2xW7NVAImE6wpv3c3amLv8tjqLTDi2os3mfimwgXQmtto4hFrHEd7CE/3bhg/6vOsVUMWVrsAFRglJLHjymRoo3EAoKug6kPnuBH4=
Received: by 10.142.239.11 with SMTP id m11mr354781wfh.1193952988001;
        Thu, 01 Nov 2007 14:36:28 -0700 (PDT)
Received: by 10.142.50.2 with HTTP; Thu, 1 Nov 2007 14:36:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63013>

I was trying to follow the gitweb/README [1] to obtain http URLs that
were valid both as cloneable GIT URL and as browseable gitweb
interfaces. Unfortunately, gitweb is preprocessing all the content
inside http://domain/repo.dir/ , so the command:

    git clone http://git.vpsaruba.homeunix.org/bproofs.git

fails while trying to read XHTML generated pages.

I'm not yet sure if this is behaviour recently changed in gitweb but I
suppose this "hack" once worked (otherwise it wouldn't have been
documented).

My apache/vhost configuration follows:

ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"

<Directory "/var/www/cgi-bin">
    Options Indexes FollowSymlinks ExecCGI
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>

<VirtualHost 62.149.168.100:80>
    ServerName git.vpsaruba.homeunix.org:80
    DocumentRoot /var/git
    RewriteEngine on
    RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$
/cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
</VirtualHost>

Any consideration is appreciated.

Thanks,
Francesco

[1] http://git.kernel.org/?p=git/git.git;a=blob_plain;f=gitweb/README;hb=HEAD
