From: Fritz Anderson <fritza@uchicago.edu>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 16:27:42 -0500
Message-ID: <47A38129-92A6-4CA5-8B79-E93CE9BF867B@uchicago.edu>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu> <7vd48b6md8.fsf@alter.siamese.dyndns.org> <200907082242.51495.j6t@kdbg.org> <20090708211201.GA21600@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 23:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOegI-0000AP-0N
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 23:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbZGHV1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 17:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbZGHV1v
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 17:27:51 -0400
Received: from authsmtp00.uchicago.edu ([128.135.249.245]:38682 "EHLO
	authsmtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbZGHV1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 17:27:51 -0400
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp00.uchicago.edu (8.13.1/8.13.1) with ESMTP id n68LRgJx031180
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2009 16:27:43 -0500
In-Reply-To: <20090708211201.GA21600@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122922>

On Jul 8, 2009, at 4:12 PM, Jeff King wrote:

>  1. Hardlinking "git" into exec-path. That means we will always be =20
> able
>     to find the wrapper, even if the PATH has been munged. Admittedly=
,
>     it sounds far fetched to me that something would exec from the =20
> PATH
>     and then munge the PATH afterwards, but that seems to be what sud=
o
>     is doing (and it is pretty commonly used).

Here's an interesting experiment (RHEL 5):

=3D=3D=3D=3D=3D
$ echo $PATH
/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/home/fritza/bin
$ cat >tryme.sh
echo $PATH
$ chmod a+x tryme.sh
$ sudo ./tryme.sh
/usr/bin:/bin

$ sudo git --exec-path
/usr/local/libexec/git-core
$ cat >tryme.sh
git --exec-path
$ ./tryme.sh
/usr/local/libexec/git-core
$ sudo ./tryme.sh
=2E/tryme.sh: line 1: git: command not found
=3D=3D=3D=3D=3D

That is to say, possibly there is some sudo magic that uses the =20
invoker's PATH to find the command in the first argument. After that, =20
however, PATH is a "safe" value. So if you invoke git via sudo, it =20
will internally see a PATH different from the one at the time of =20
invocation.

=46or what it's worth.

	=97 F
