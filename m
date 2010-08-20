From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Tags, Grafts, and Clones, oh my!
Date: Fri, 20 Aug 2010 19:09:32 +0530
Message-ID: <20100820133925.GE9448@kytes>
References: <20100820061459.GB12794@kytes>
 <5752362.117414.1282309220152.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:43:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRs5-0003sm-35
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab0HTNl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:41:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:32818 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0HTNlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:41:25 -0400
Received: by pvg2 with SMTP id 2so1198830pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 06:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tkU4XmKh03apnhYTGMXDh741reVEFz37Wx+z8lrGgkU=;
        b=VGUBosL6Gq3v50NPB242CmIrEF0NzfniE7DwIfCzFXNLj+/XV+Zt1XR8Xb3RGJ1r6l
         dMK+21IqtidVxdMRv1qM9ec9CZEoraGxHEzF8+Kxraz9X1zn8Mbflo8gDF5++eJKFMGk
         8dsegEYGbqed2z/FW3P+dWj4poxDAgGQmSIa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DZtYNX//4d5RYzahwE2FpRAzZpyXytq7JUW43spG4XtV9sQlNw4ajAv+DWRUMzguMT
         /0dca5I4MwhFtcd74eKyTe7RoEOhAdH+i7ykzMFO2MLqqdAi68oKO0M8IEEiuZoegQdW
         JPfYuJNzQj8pLHRjNr4oYwa52a6p0QkXKsN80=
Received: by 10.114.59.10 with SMTP id h10mr1461977waa.194.1282311685341;
        Fri, 20 Aug 2010 06:41:25 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d38sm4902737wam.20.2010.08.20.06.41.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 06:41:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5752362.117414.1282309220152.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154037>

Hi Stephen,

Stephen Bash writes:
> Sure:
> 
> mkdir gitTagBug
> cd gitTagBug
> 
> git init foo
> cd foo
> echo A >> foo.txt
> git add foo.txt
> git commit -m "Created foo"
> GRAFT_PARENT=`git rev-parse master`
> echo B >> foo.txt
> git commit -am "Added B"
> cd ..
> 
> git init bar
> cd bar
> echo A >> foo.txt
> echo C >> foo.txt
> git add foo.txt
> git commit -m "Added C"
> GRAFT_CHILD=`git rev-parse master`
> git tag -am "Tagging foo C" tagFoo $GRAFT_CHILD
> cd ..
> 
> cd foo
> git fetch ../bar refs/tags/tagFoo:refs/tags/tagFoo
> echo "$GRAFT_CHILD $GRAFT_PARENT" >> .git/info/grafts
> git filter-branch --tag-name-filter cat tagFoo
> cd ..
> 
> # Purposely use a file URL to prune any unreferenced objects
> git clone file:///`pwd`/foo newFoo
> 
> My output from the clone:
> 
>    Cloning into newFoo...
>    remote: Counting objects: 9, done.
>    remote: Compressing objects: 100% (3/3), done.
>    remote: Total 9 (delta 0), reused 0 (delta 0)
>    Receiving objects: 100% (9/9), done.
>    error: refs/tags/tagFoo does not point to a valid object!

Thanks for the testcase! Offhand, it definitely looks like a bug. I'm
investigating to figure out which part of the chain is at fault.

-- Ram
