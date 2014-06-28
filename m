From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Fri, 27 Jun 2014 20:42:19 -0400
Organization: PD Inc
Message-ID: <CEAC9BE9F83B4CD0AFD73BBAC8A54232@black>
References: <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com> <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Phil Hord'" <phil.hord@gmail.com>
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:42:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0gir-00061u-JM
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbaF1Am0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:42:26 -0400
Received: from mail.pdinc.us ([67.90.184.27]:42347 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbaF1AmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:42:25 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5S0gNEh005343;
	Fri, 27 Jun 2014 20:42:23 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac+SVFK8rL6RQuuWQaWXdVkf2liIZgAAaFHwAAHERuA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
In-Reply-To: <66A60DA77398CD439FA676CEF593977D52477A@exchange.1.internal.pdinc.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252591>

> -----Original Message-----
> From: Jason Pyeron 
> Sent: Friday, June 27, 2014 18:39
> 
> > -----Original Message-----
> > From: Phil Hord [mailto:phil.hord@gmail.com] 
> > Sent: Friday, June 27, 2014 17:46
> > To: Jason Pyeron
> > Cc: git
> > Subject: Re: Trouble merging renamed but identical files - 
> > CONFLICT (rename/rename)
> > 
> > On Fri, Jun 27, 2014 at 4:47 PM, Jason Pyeron 
> > <jpyeron@pdinc.us> wrote:
> > > There are two identical files from the same original 
> > parent, but both were
> > > renamed in their own branches. One branch moved the file to 
> > a new folder, the
> > > other renamed the file in the same folder.
> > 
> > You have not stated what you think the issue is.  You have 
> only stated
> > the setup.
> 
> Thanks, I could have said it better. 
> 
> I think that git should understand that I have moved a file 
> in path only (the tree object containing the file's entry 
> change, but not the entry it self) and that the branch from 
> which I want to merge back (with common ancestry) has renamed 
> the file in the same path ( the tree object is unchanged, but 
> the entry is) such that the object is re-parented and renamed 
> in that path.
> 
> How can this be done in git or if it cannot what are the 
> chalenges to patching git for this issue.
> 
> git cat-file -p b60070f4d0879e277f44d174a163bbb292325fea # 
> tree d8df83fc6714aab1fc1df061fcb03410e1dab1e5
> git cat-file -p d8df83fc6714aab1fc1df061fcb03410e1dab1e5 # 
> 040000 tree 68bb8a223284e0f5057421217a5965128bf1d51a    src
> git cat-file -p 68bb8a223284e0f5057421217a5965128bf1d51a # 
> 100644 blob 25c7d3b12bced67046359ba1e7945f82a2640147    TrueCrypt.sln
> 
> git cat-file -p a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68 # 
> tree 7f82a6c46f19931c3c40d44dc196cbfab7feaa72
> git cat-file -p 7f82a6c46f19931c3c40d44dc196cbfab7feaa72 # 
> 100644 blob 25c7d3b12bced67046359ba1e7945f82a2640147    CipherShed.sln
> 
> > 
> > 
> > I suppose you want Git to merge without conflict in the end, though,
> > based on your script.  Is that right?
> > 
> > 
> > > Steps to reproduce the issue:
> > > git init
> > > git fetch https://github.com/pdinc-oss/CipherShed.git
> > > git fetch https://github.com/srguglielmo/CipherShed.git
> > > git checkout -b test b60070f4d0879e277f44d174a163bbb292325fea
> > > git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68
> > >
> > > CONFLICT (rename/rename): Rename 
> > "TrueCrypt.sln"->"src/TrueCrypt.sln" in branch
> > > "HEAD" rename "TrueCrypt.sln"->"CipherShed.sln" in
> > > "a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68"
> > 
> > Git seems to be doing the correct thing here.
> > 
> > 
> > > git reset --hard b60070f4d0879e277f44d174a163bbb292325fea
> > > git mv src/TrueCrypt.sln src/CipherShed.sln
> > > git commit -m 'renamed to be congruent with a0c84ff'
> > > git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68
> > >
> > > Sill get a CONFLICT (rename/rename): Rename
> > > "TrueCrypt.sln"->"src/CipherShed.sln" in branch "HEAD" rename
> > > "TrueCrypt.sln"->"CipherShed.sln" in 
> > "a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68"
> > 
> > Git seems to be doing the correct thing here, too.
> > 
> > > I will have many more to come, any suggestions?
> > 
> > Maybe you meant to move the renamed file to the same folder where it
> > exists in the merge target.  I do not get a conflict when I do that.
> 
> Are you saying I should git mv src/TrueCrypt.sln CipherShed.sln ?
> 
> Then it will be in the wrong path as intended.
> 
> > 
> >    git reset --hard b60070f4d0879e277f44d174a163bbb292325fea
> >    git mv src/TrueCrypt.sln CipherShed.sln
> >    git commit -m 'renamed to be congruent with a0c84ff'
> >    git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68
> > 
> > No conflict (on that file, anyway).
> 
> Agreed, but not the desired end state.

Sorry for the http://pastebin.com/1R68v6jt (changes the merge to
1ca13ed2271d60ba93d40bcc8db17ced8545f172, and manually reconciles the merge),
but it was too long to be readable in the email.

git blame HEAD -- src/Main/Forms/CipherShed.fbp | cut -c 1-8 | sort -u 

Gives: 
ac812aa3
b50a2fb1

git blame b60070f4d0879e277f44d174a163bbb292325fea --
src/Main/Forms/TrueCrypt.fbp | cut -c 1-8 | sort -u

Gives: 
07b2176f
0eb8b4fa
12c94add
a17c95a3
a757b4d4
cac6cd14
d0a9dfa8
d94128a9
e6b1437a
f1bb489c

If I use cherry pick (vs merge), I can maintain the big history in b60070f, but
loose the small history in 1ca13ed

      [test]
      /     \
     /       \
[b60070f] [1ca13ed]
    |         |
    |         |
[65efd37]     |
    |    \    |
    |     \   |
[d8da778] [39ebb06]

How do I maintain all the history including the (line) changes in 1ca13ed?

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
