From: brizly vaan van Ulciputz <brizly@freenet.de>
Subject: Re: setup gitosis on Fedora 11
Date: Sat, 18 Jul 2009 09:40:35 +0200
Message-ID: <1247902835.2384.86.camel@brizlyMobil>
References: <1247867114.2384.15.camel@brizlyMobil>
	 <2e24e5b90907171844o11eb6699m929e3c0df621ef67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 10:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS5Z8-0001Su-Ii
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 10:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbZGRIq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 04:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbZGRIq1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 04:46:27 -0400
Received: from mout7.freenet.de ([195.4.92.97]:49900 "EHLO mout7.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610AbZGRIq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 04:46:26 -0400
X-Greylist: delayed 3947 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2009 04:46:26 EDT
Received: from [195.4.92.12] (helo=2.mx.freenet.de)
	by mout7.freenet.de with esmtpa (ID brizly@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MS4X7-0001tl-13; Sat, 18 Jul 2009 09:40:37 +0200
Received: from p4fc98e06.dip0.t-ipconnect.de ([79.201.142.6]:49328 helo=[192.168.23.106])
	by 2.mx.freenet.de with esmtpsa (ID brizly@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.69 #93)
	id 1MS4X6-0002IG-Px; Sat, 18 Jul 2009 09:40:36 +0200
In-Reply-To: <2e24e5b90907171844o11eb6699m929e3c0df621ef67@mail.gmail.com>
X-Mailer: Evolution 2.26.2 (2.26.2-1.fc11) 
X-purgate-ID: 149285::1247902836-000065DC-2CE5B306/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123511>

i think it could be the think with post-update.
But because i don't know for sure how to set it up,
i will at first try to be sure the other mentioned points are correct.

brizly2 is my notebook
s28 is the server with gitosis

Sitaram Chamarty:
> This error could mean one of the following:
> 
> (1) you're using the wrong key/repo pair.  Of course your key *is* in
> gitosis.conf but the repo you're trying to push to isn't, or doesnot
> list you as one of the valid users

to be sure i paste the md5 of the two keys:

[brizly2@brizlyMobil ~]md5sum ~/.ssh/id_rsa.pub 
ece497792a3cf840e55308f94b854efd  /home/brizly/.ssh/id_rsa.pub

[root@s28 ~]# md5sum /home/brizly/.ssh/id_rsa.pub
ece497792a3cf840e55308f94b854efd  /home/brizly/.ssh/id_rsa.pub

comment: gitosis uses the same key as me as admin. isn't a problem, is
it? The user brizly exists on notebook as on s2

> (2) your gitosis.conf is all correct, but you forgot the "chmod" somewhere
> above, and the post-update hook never ran, so the real gitosis.conf (which
> gitosis uses -- this is ~git/.gitosis.conf) doesn't have the same data

as mentioned above i don't know exactly where to set up the thing with
the post-update. And i actually don't have a git-user on the server (i
had one, but thought i didn't need one, so deleted it).

> I also don't like that howto; it appears to be doing everything on one
> machine, with the same userid, so people who don't grok ssh very well will
> still have trouble even after all this is done to translate that knowledge to a
> real deployment.

Because my first run wasn't very successfull, i tried another tutorial
where the developer-machine and the gitosis-server are 2 different ones.
see http://www.shakthimaan.com/installs/gitosis.html

> Bottom line: here's what should match for that error to go away:
> 
>   - the public key corresponding to the private key your client-side ssh is
>     using
>   - must match *exactly* one of the public keys in the server-side
>     ~git/.ssh/authorized_keys

see md5sums above, i think they are the same.

> [this is probably OK in your case, but please check there is *exactly one*.  I
> have a vague memory of seeing a case when someone adds a key twice with
> different usernames in error.  Ssh picks up perhaps the first one, while your
> gitosis.conf talks about the second one...]

So it is a problem when by 'normal' user on the server uses the same key
as gitosis does? The server is not only serving gitosis, an for other
reasons the user "brizly" is, for perspective of ssh, the same on
notebook and on server.

> and
>   - the name after "gitosis-init" on the pubkey line that matched above
>   - must match a username in ~git/.gitosis.conf (which is a symlink to
>     something but never mind)

How do i check that?

> and
>   - this username must be mentioned in the members= line of some section in
>     gitosis.conf which also has "writable = my-first-repo"

> You can check *all* of this by looking at ~git/.gitosis.conf and
> ~git/.ssh/authorized_keys on the server and ~/.ssh/id_[rd]sa.pub on your
> client

by all my tries i know restarted end end up in again beeing prompted for
gitosis-password:

[root@s28 gitosis]# sudo -H -u gitosis gitosis-init
< /home/brizly/.ssh/id_rsa.pub 
Reinitialized existing Git repository
in /var/lib/gitosis/repositories/gitosis-admin.git/
Reinitialized existing Git repository
in /var/lib/gitosis/repositories/gitosis-admin.git/
[root@s28 gitosis]# su - gitosis
-sh-4.0$ pwd
/var/lib/gitosis
-sh-4.0$ cat .gitosis.conf 
[gitosis]

[group gitosis-admin]
writable = gitosis-admin
members = gitosis@s28

###
and after that (same on notebook or s28)
[brizly@s28 ~]$ git clone gitosis@192.168.23.27:gitosis-admin.git
Initialized empty Git repository in /home/brizly/gitosis-admin/.git/
gitosis@192.168.23.27's password:


so, at the moment i am again at the end of ideas, but the post-update.
How to check that?

_____
luck up
brizly
