From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Mon, 11 Jun 2007 22:13:17 -0300
Message-ID: <466DF32D.802@xs4all.nl>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com> <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 03:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxv3W-000114-A7
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 03:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbXFLBUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 21:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbXFLBUP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 21:20:15 -0400
Received: from main.gmane.org ([80.91.229.2]:40237 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518AbXFLBUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 21:20:14 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hxv3C-00083d-B4
	for git@vger.kernel.org; Tue, 12 Jun 2007 03:20:02 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 03:20:02 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 03:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49907>

Benjamin Sergeant escreveu:
> A perforce command with all the files in the repo is generated to get
> all the file content.
> Here is a patch to break it into multiple successive perforce command
> who uses 4K of parameter max, and collect the output for later.
> 
> It works, but not for big depos, because the whole perforce depo
> content is stored in memory in P4Sync.run(), and it looks like mine is
> bigger than 2 Gigs, so I had to kill the process.

General idea of the patch is ok.  some nits:

> +        chunk = ''
> +        filedata = []
> +        for i in xrange(len(files)):

why not 

  for f in files:

?

> +            f = files[i]
> +            chunk += '"%s#%s" ' % (f['path'], f['rev'])
> +            if len(chunk) > 4000 or i == len(files)-1:

4k seems reasonable enough, but can you take the min() with
os.sysconf('SC_ARG_MAX') ?

Can you address this and resend so we can apply the patch? 
Thanks.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
