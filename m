From: David Aguilar <davvid@gmail.com>
Subject: Re: subtree merge tries to merge into wrong directory
Date: Wed, 9 Dec 2009 20:20:08 -0800
Message-ID: <20091210042008.GA3398@gmail.com>
References: <4B206DCF.90202@naderman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nils Adermann <naderman@naderman.de>
X-From: git-owner@vger.kernel.org Thu Dec 10 05:19:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIaUr-0007Jj-O8
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 05:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbZLJETJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 23:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759918AbZLJETI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 23:19:08 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:34990 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759916AbZLJETH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 23:19:07 -0500
Received: by ywh36 with SMTP id 36so7361515ywh.15
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 20:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fTcAIxyPBAkp4Z5EtAIE84b9x0v/OkM8YgPGaSpNz2g=;
        b=Im9yNaF0BksuGhywXFpF8c5HLQwzMLG+0Zd8s63BtsL8s6w7UeYjnxPpe0DPoZLM4h
         LoZ+CcR/evdo4rnVXhaWUrGcuviuvUxp8KqCzJoYhWU1iyvNBCLml5kAnaBAqrTxk/QO
         hBvOeSZ208scyhtITT5QIEoLY6ZvMoJy5WxXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w0vDX0IFWkO2mHHzZu85uXjSyouvxPJl8+H5kmXIM6DS8QpX1GY5NEVetn7BMx2gmp
         zDH8PAT6O3RFzD8Bu8268BYa/g0vm7Z9/0g+MysVuUrV/CYcxXHkQe7OqAgRiroaukrx
         lT9QIbtIpsRWmClw/n0p+Kk1xxmlp47MANNCg=
Received: by 10.101.165.21 with SMTP id s21mr5674997ano.176.1260418753201;
        Wed, 09 Dec 2009 20:19:13 -0800 (PST)
Received: from gmail.com (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id 9sm214847ywf.20.2009.12.09.20.19.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Dec 2009 20:19:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B206DCF.90202@naderman.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135010>

On Thu, Dec 10, 2009 at 04:41:03AM +0100, Nils Adermann wrote:
> Following  
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html 
> I have subtree merged a 3rd party library (ezc-reflection) into my  
> repository (pflow). The prefix I used was lib/ezc/trunk/Reflection. Now  
> there have been changes to ezc-reflection but merging them into my  
> repository fails. The merge is attempted in example/ rather than  
> lib/ezc/trunk/Reflection.
>
> I originally set this up with:
>
> git remote add -f ezc-reflection /path/to/ezc-reflection
> git merge -s ours --no-commit ezc-reflection/master
> git read-tree --prefix=lib/ezc/trunk/Reflection -u ezc-reflection/master
>
> Reproduce my problem by executing the following:
>
> git clone git://github.com/naderman/pflow.git
> cd pflow
> git reset --hard f3e001e3
> git fetch git://github.com/naderman/ezc-reflection.git master
> git merge -s subtree FETCH_HEAD
>
> As you see this results in:
>
> CONFLICT (delete/modify): example/src/doc_comment_parser.php deleted in  
> HEAD and modified in FETCH_HEAD. Version FETCH_HEAD of  
> example/src/doc_comment_parser.php left in tree.
> Automatic merge failed; fix conflicts and then commit the result.
>
> As long as I don't make any changes to lib/ezc/trunk/Reflection that I  
> want to merge I can work around this by simply repeating my original  
> process like this:
>
> git clone git://github.com/naderman/pflow.git
> cd pflow
> git reset --hard f3e001e3
> git fetch git://github.com/naderman/ezc-reflection.git master
> git merge -s ours --no-commit FETCH_HEAD
> git rm -r lib/ezc/trunk/Reflection/
> git read-tree --prefix=lib/ezc/trunk/Reflection/ -u FETCH_HEAD
>
> Why does this problem occur and how can I get the merge to work properly?

I'm not sure, but maybe you can try git-subtree?
It makes this stuff easier for mere mortals.

http://github.com/apenwarr/git-subtree/

You might need to start redo your repo, but several people have
had good success with git-subtree.


-- 
		David
