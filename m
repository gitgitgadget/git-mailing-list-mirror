X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: reexporting git repository via git-daemon
Date: Sun, 10 Dec 2006 18:35:24 +0100
Organization: At home
Message-ID: <elhgcf$m4r$1@sea.gmane.org>
References: <200612082212.09682.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 10 Dec 2006 17:33:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 104
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33906>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtSYL-0005HV-17 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 18:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762277AbWLJRd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 12:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762267AbWLJRd0
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 12:33:26 -0500
Received: from main.gmane.org ([80.91.229.2]:42889 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762277AbWLJRdZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 12:33:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtSY3-0000zm-Lm for git@vger.kernel.org; Sun, 10 Dec 2006 18:33:11 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 18:33:11 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 10 Dec 2006
 18:33:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Arkadiusz Miskiewicz wrote:

> I have weird problem wit git (1.4.4.2).

I have tried to reproduce this error, but no luck.
 
> $ git --bare clone git://git.kernel.org/pub/scm/git/git.git
> fetches everything correctly;

It should be "git clone --bare git://git.kernel.org/pub/scm/git/git.git"
or "git clone --bare git://git.kernel.org/pub/scm/git/git.git git.git"
Git doesn't need GIT_DIR for clone.

> $ cd /tmp
> $ git clone /gitroot/home/gitrepo/git
> 
> also correctly fetched. The problem begins with exporting that cloned repo 
> once again via git-daemon:

I didn't do this second cloning, but it should not matter I think.

> $ git clone git://git.my-server/git
> fatal: unexpected EOF
> fetch-pack from 'git://git.my-server/git' failed.

True, the error messages of git-clone are bit cryptic and doesn't
give us much information. Does there exist such repository? Perhaps
it is not exported? Were there any error?

> strace on git-daemon side:
> [...]
> 18241 lstat("refs/tags/v1.4.1-rc2", {st_mode=S_IFREG|0644, st_size=41, ...}) = 
> 0
> 18241 open("refs/tags/v1.4.1-rc2", O_RDONLY) = 7
> 18241 read(7, "33c9db007159db11c1ad5fa7101ea95853740acf\n", 255) = 41
> 18241 close(7)                          = 0
> 18241 write(1, "004233c9db007159db11c1ad5fa7101ea95853740acf 
> refs/tags/v1.4.1-rc2\n", 66) = 66
> 18241 write(1, "0045abc02670169cee9541793a86324a014272ca8ed5 
> refs/tags/v1.4.1-rc2^{}\n", 69) = 69
> 18241 stat("refs/tags/v1.4.1.1", {st_mode=S_IFREG|0644, st_size=41, ...}) = 0
> 18241 lstat("refs/tags/v1.4.1.1", {st_mode=S_IFREG|0644, st_size=41, ...}) = 0
> 18241 open("refs/tags/v1.4.1.1", O_RDONLY) = 7
> 18241 read(7, "8419a453dc088b25b63ab1746d3d7e679caf686d\n", 255) = 41
> 18241 close(7)  
> 18241 write(1, "00408419a453dc088b25b63ab1746d3d7e679caf686d 
> refs/tags/v1.4.1.1\n", 64) = 64
> 18241 write(2, "fatal: ", 7)            = 7
> 18241 write(2, "corrupted pack 
> file ./objects/pack/pack-0bb22295a585ac173504a2f8dfb3e31e074a8715.pack", 85) 
> = 85
> 18241 write(2, "\n", 1)   
> 
> 100% repeatable at this moment. Any ideas?

WORKSFORME

$ git --version
git version 1.4.4.1

$ git clone --bare git://git.kernel.org/pub/scm/git/git.git
remote: Generating pack...
remote: Done counting 33587 objects.
remote: Deltifying 33587 objects.
remote:  100% (33587/33587) done
Indexing 33587 objects.
remote: Total 33587, written 33587 (delta 23205), reused 33325 (delta 23034)
 100% (33587/33587) done
Resolving 23205 deltas.
 100% (23205/23205) done

By the way, I wonder why git-clone names bare repository 'git',
and not 'git.git' as, I think, it should?

$ git-daemon --verbose --export-all --base-path=<pwd>
[31823] Connection from 127.0.0.1:46736
[31823] Extended attributes (16 bytes) exist <host=localhost>
[31823] Request upload-pack for '/git.git'
[31823] Disconnected

The above is generated when I was cloning locally, i.e. when I run the
following command:

$ git clone git://localhost/git.git
remote: Generating pack...
remote: Done counting 33587 objects.
remote: Deltifying 33587 objects.
remote:  100% (33587/33587) done
Indexing 33587 objects.
remote: Total 33587, written 33587 (delta 23205), reused 33587 (delta 23205)
 100% (33587/33587) done
Resolving 23205 deltas.
 100% (23205/23205) done
Checking files out...
 100% (743/743) done

which went without any problem.

P.S. Please reply also to git mailing list
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

