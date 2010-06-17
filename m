From: Henrik =?utf-8?b?R3J1YmJzdHLDtm0=?= <grubba@grubba.org>
Subject: Re: [BUG] git clean not working on FreeBSD/NFS
Date: Thu, 17 Jun 2010 15:18:57 +0000 (UTC)
Message-ID: <loom.20100617T170956-287@post.gmane.org>
References: <4C1A30A3.9080708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 17:19:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPGsE-0005gG-EE
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 17:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236Ab0FQPTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 11:19:17 -0400
Received: from lo.gmane.org ([80.91.229.12]:36061 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890Ab0FQPTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 11:19:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OPGs2-0005Vv-Dq
	for git@vger.kernel.org; Thu, 17 Jun 2010 17:19:10 +0200
Received: from shipon.roxen.com ([212.247.28.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 17:19:10 +0200
Received: from grubba by shipon.roxen.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 17:19:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.247.28.156 (Mozilla/5.0 (X11; U; SunOS i86pc; en-US; rv:1.9.2) Gecko/20100117 Firefox/3.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149312>

T=C3=B6r=C3=B6k Edwin <edwintorok <at> gmail.com> writes:

> Hi,
>=20
> I am running git 1.7.1 on a FreeBSD 8 box which has its home dir moun=
ted
> via NFS (I guess the NFS server is a Linux box).
> When running 'git clean -x -f -d' it fails to remove some directories=
:
> warning: failed to remove 'libclamav/.deps/'
> warning: failed to remove 'libclamav/.libs/'
> warning: failed to remove 'libclamav/c++/.deps/'
> warning: failed to remove 'libclamav/c++/.libs/'
> warning: failed to remove 'libclamav/c++/llvm/test/CodeGen/X86/Output=
/'
>=20
> This causes buildbot managed builds to fail every 2nd time.

Sounds like the classic nfs problem with references to open deleted fil=
es.
If you look closer at the failing directories, I bet that you'll find f=
iles with
names like ".nfsDEAD".

You can use eg lsof to find the process that holds the open file refere=
nce:

  $ lsof tmp/.nfs536B=20
  COMMAND   PID   USER   FD   TYPE DEVICE SIZE/OFF     NODE NAME
  pike    29705 grubba    8w  VREG  285,4        0 10977399 tmp/.nfs536=
B

/grubba
