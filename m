From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: Security problem
Date: Fri, 16 Jun 2006 12:37:21 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606161237.21997.lan@academsoft.ru>
References: <200606151709.22752.lan@academsoft.ru> <200606161054.46813.lan@academsoft.ru> <Pine.LNX.4.64.0606152137410.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 07:38:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr71w-0007aJ-BO
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 07:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWFPFhk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 01:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWFPFhk
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 01:37:40 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:57307 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1750888AbWFPFhj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 01:37:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id A06B7BDD0; Fri, 16 Jun 2006 12:37:37 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25151-03; Fri, 16 Jun 2006 12:37:28 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 2FC66BDBC; Fri, 16 Jun 2006 12:37:28 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 2B73F8DA2841; Fri, 16 Jun 2006 12:37:28 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 5DED58DA2840;
	Fri, 16 Jun 2006 12:37:22 +0700 (NOVST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0606152137410.5498@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21930>

> Well, they may not be "safe" - you just need to work a _lot_ harder to
> corrupt a pack-file in any interesting manner. And again, git-fsck-objects
> would pick up any such thing going on.
As it shown in pack-objects.c, each object have stored sha1, almost the same 
as file rename.

> The first is that git-fsck-objects will definitely find any repository
> inconsistency, and to get around that, you either have to get around the
> basic properties of SHA-1 (ie break the hash) _or_ you have to actually
> change the repository so that it's still a valid repo, just with different
> content.
I still belive SHA-1 is good enouth to hash files - I did not hear about 
generation reasonable duplicate that can compile and work :-)

>  - if you corrupt the repository, subsequent clones (or even pulls) from
>    the corrupt repository simply won't work if you use the native
>    protocol, because the native protocol doesn't actually trust anything
>    but the actual contents (so if the contents won't match, then neither
>    will the SHA1 names). So the corruption is pretty strictly limited to
>    the _one_ repository that the attacker had write access to.
As I understand sent pack file will contains actial SHA-1 of objects. And any 
hack will be cleary visible.

>    So there's a pretty fundamental "corruption containment" part there.
...
Situation with evil repo is clear to me: you can turst only to trusted commit 
identified by SHA-1

> But yeah, I actually still personally do a fair number of
> "git-fsck-objects". I've never found anything that way since very early on
> (and back then, the real problem was rsync getting objects that weren't
> reachable), but I still do it. It makes me feel happier.
As the result: Always fsck repo after pull/clone !
