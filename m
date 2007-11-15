From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: How to change a submodue as a subdirectory?
Date: Thu, 15 Nov 2007 16:14:19 +0800
Message-ID: <46dff0320711150014x4a35975eqc53ef1fce7d40b18@mail.gmail.com>
References: <46dff0320711140637s51e1368fv3f632b6f04d093d5@mail.gmail.com>
	 <20071114202651.GC3973@steel.home>
	 <46dff0320711142136r2c70d698vd380c02188f95507@mail.gmail.com>
	 <Pine.LNX.4.64.0711150614380.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:14:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZry-0000K4-Dw
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbXKOIOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbXKOIOW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:14:22 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:48512 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbXKOIOU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:14:20 -0500
Received: by py-out-1112.google.com with SMTP id u77so3327468pyb
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5OnJchRl2qoG3sTBNquQbNXhxKH/3VsP62sMukvhhgs=;
        b=HHsZMF2QxzazVRyWTtGV4FExbAytDz7hgVLnvnbXhutps1VRmnuFHi9wywEgLJFIgyw6G2lyusmJ/Ha2zLVnIZlmpiv5f6pMN6v3awl4Hx965qWV78321wULzUsAgDCSt6Y8aOd8MWSnil5rK8GanihguNXPNgepoi5LFJUIwxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oh95xR9y8K/DmeFoOYtwkXyZjqm3zXi6uZw2mhemhQMmQ1BS5HyHBeXqefSSyFILFGUoM5WdaK10KRQtaIKtLvouxcw8ZKO6Z6Zv5fi2fQ+j5uOE1SymxpHyrHscRk2U2OdAHg2uJUbOEUUgBDo3+Vf9sVOv2sZ/vwhzV0/M+EE=
Received: by 10.35.33.5 with SMTP id l5mr505072pyj.1195114459263;
        Thu, 15 Nov 2007 00:14:19 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Thu, 15 Nov 2007 00:14:19 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711150614380.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65082>

On Nov 15, 2007 2:16 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Provided you do not kill the repository of the submodule (you have some
> public repo for that, right?) you will not lose anything, since the
> history of the superproject has pointers to the submodule.
>
> But I guess that you want something different... You probably want to
> rewrite history as if the submodule had not been a submodule at all,
> right?
Yeah, this actually what i want. Now i find a way:
1. move submodule subB outside
    mv subB /newpath/to/subB
    git-commit subB
2. git-filter-branch to rename all files in subA repository to subB
directory (say subB/subB).

       cd newpath/to/subB &&
       git filter-branch --index-filter \
               'git ls-files -s | sed "s-\t-&subB/-" |
                       GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
                               git update-index --index-info &&
                mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
3. in directory of super project superA, git-fetch repository subB to
branch subB
   cd path/to/superA && git-fetch /newpath/to/subB master:subB
4. git-cherry-pick each commit  (except the root commit) of branch
subB to the super project superA
    git-cherry HEAD subB | awk '{print $2}' | sed -n '2,$ p' | while
read name; do git cherry-pick $name; done
>
> Ciao,
> Dscho
>
>



-- 
Ping Yin
