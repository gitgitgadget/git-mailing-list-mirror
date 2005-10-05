From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 09:09:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0510050902430.28854@localhost.localdomain>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com>
 <434299DB.7020805@zytor.com> <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com>
 <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com>
 <20051005155457.GA30303@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Wed Oct 05 18:11:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENBpc-0006vF-L9
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVJEQIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 12:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVJEQIo
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:08:44 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:54167 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1030207AbVJEQIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 12:08:43 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by x35.dev.mdolabs.com with [XMail 1.22 ESMTP Server]
	id <S1A3092> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 5 Oct 2005 09:08:40 -0700
X-X-Sender: davide@localhost.localdomain
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20051005155457.GA30303@trixie.casa.cgf.cx>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9716>

On 10/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:

> Still does not work for me. I cannot isolate the problem out of git,
> but at the moment the only way for me to make commit_index_file to work
> is to put unlink(indexfile) before rename(cf->lockfile, indexfile).

I don't know how Cygwin implemented rename(), but if they used MoveFile() 
they broke the POSIX rename() since MoveFile() fails if destination 
already exists. They should have used MoveFileEx(MOVEFILE_REPLACE_EXISTING)
instead, to guarantee POSIX semantics. The symptoms you're experiencing 
make me think this might be the case (even if it is strange, since other 
Unix software would fail the same way).


- Davide
