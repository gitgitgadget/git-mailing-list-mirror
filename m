From: Thomas Pasch <thomas.pasch@jentro.com>
Subject: Re: git-http-push / webDAV
Date: Tue, 02 Oct 2007 11:57:10 +0200
Organization: Jentro Technologies GmbH
Message-ID: <470215F6.2060105@jentro.com>
References: <4700F6BC.2070701@jentro.com> <20071001155454.GU975@void.codelabs.ru> <47020603.3080000@jentro.com> <20071002085416.GW975@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Tue Oct 02 11:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IceVL-0006Mm-SX
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 11:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXJBJ5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 05:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbXJBJ5T
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 05:57:19 -0400
Received: from mail2.infra.net ([212.89.96.7]:2944 "EHLO gamma.m.infra.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750954AbXJBJ5S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 05:57:18 -0400
Received: from epsilon.m.infra.net (epsilon.m.infra.net [212.89.96.8])
	by gamma.m.infra.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l929vCKY007148;
	Tue, 2 Oct 2007 11:57:12 +0200
Received: from [192.1.1.184] (u19-17.dsl.vianetworks.de [194.231.42.17])
	(authenticated bits=0)
	by epsilon.m.infra.net (8.13.4/8.13.4/Debian-3) with ESMTP id l929vAmG023101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2007 11:57:11 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <20071002085416.GW975@void.codelabs.ru>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59678>

Dear Eygene,

well, *somewhat* better with the trailing slash:

> echo "modified" >>grep.c
> git commit -a
Created commit e147e54: mod
 1 files changed, 1 insertions(+), 0 deletions(-)
> git push -v
Pushing to http://test@192.1.1.184/git/git.git/
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/master'
  from 34c6dbdef439f7cd93d3fe22493a3c1496ce96f7
  to   e147e54b14828fa2e88e88907e0ca4dc3d694448
    sending 3 objects
    done
Updating remote server info

There's no more error message. However, push has still
not worked. If I try to check out the new HEAD:

> git clone http://test@192.1.1.184/git/git.git/
Initialized empty Git repository in /home/tpasch/tmp/git/.git/
Getting alternates list for http://test@192.1.1.184/git/git.git
Getting pack list for http://test@192.1.1.184/git/git.git
Getting index for pack 563e2090185692c7d765775569a0ce986840fd17
Getting pack 563e2090185692c7d765775569a0ce986840fd17
 which contains 3af9d3e08da868c3a7687ab38d72f4296a99005d
[...]
walk 24778e335a6450e34257a311d0bf4a12bdb3006c
walk 19b2860cba5742ab31fd682b80fefefac19be141
walk bf0c6e839c692142784caf07b523cd69442e57a5
walk e497ea2a9b6c378f01d092c210af20cbee762475
walk 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
walk e83c5163316f89bfbde7d9ab23ca2e25604af290
Getting alternates list for http://test@192.1.1.184/git/git.git
Getting pack list for http://test@192.1.1.184/git/git.git
error: Unable to find e147e54b14828fa2e88e88907e0ca4dc3d694448 under
http://test@192.1.1.184/git/git.git
Cannot obtain needed object e147e54b14828fa2e88e88907e0ca4dc3d694448

Cheers,

Thomas

Eygene Ryabinkin wrote:
> Thomas, good day.
> 
> Tue, Oct 02, 2007 at 10:49:07AM +0200, Thomas Pasch wrote:
>> I've investigated my problem a little further. The nasty
>> 'UNLOCK HTTP error 400' has come from a proxy that
>> doesn't accept webDAV stuff. Thus I unset the 'http_proxy'
>> env variable (looks like cadaver hasn't cared...).
> 
> Yep, proxies can be tricky with the DAV stuff.
> 
>> However, the main problem still remains. Using a non empty
>> remote http repo, modifying and committing, then:
>>
>>> git push -v
>> Pushing to http://test@x.x.x.x/git/git.git
>>
>> still waits for a long time and finally:
>>
>> Error: no DAV locking support on remote repo http://test@x.x.x.x/git/git.git
>> error: failed to push to 'http://test@x.x.x.x/git/git.git'
> 
> Try using URL with the slash at the end, like
> 'http://test@x.x.x.x/git/git.git/'.  This should help.
