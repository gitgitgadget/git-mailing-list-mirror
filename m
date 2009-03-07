From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGit] Push to new Amazon S3 does not work? ("funny refname")
Date: Sat, 7 Mar 2009 18:50:37 +0100
Message-ID: <200903071850.38045.robin.rosenberg.lists@dewire.com>
References: <ff6a9c820903070805m34f792dard6b17d2029e41dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Cheng <j16sdiz+freenet@gmail.com>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Mar 07 18:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg0kC-0007Nz-7d
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 18:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbZCGRun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 12:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbZCGRum
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 12:50:42 -0500
Received: from mail.dewire.com ([83.140.172.130]:24381 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbZCGRum convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 12:50:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8A04D15E0DF2;
	Sat,  7 Mar 2009 18:50:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CSCc5rxiD9SK; Sat,  7 Mar 2009 18:50:38 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id CB7AA15E0DF1;
	Sat,  7 Mar 2009 18:50:38 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <ff6a9c820903070805m34f792dard6b17d2029e41dfe@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112556>

l=F6rdag 07 mars 2009 17:05:02 skrev Daniel Cheng <j16sdiz+freenet@gmai=
l.com>:
> Pushing to new Amazon S3 repository does not work.
> It say "funny refname" without pushing anything:
>=20
> <<<<<<<<<
> $ jgit push s3 master
> To amazon-s3://0NQ4APQ8R7S6HQ65TWR2@egitsdiz/1.git
>  ! [remote rejected] master -> master (funny refname)
> $ s3cmd la
>          DIR   s3://egitsdiz/1.git/
> $
> >>>>>>>>>
>=20
> Any idea what's happening here?
>=20
>=20
> The code is in WalkPushConnection.java line 137:
> <<<<<<<<<
> 134    final List<RemoteRefUpdate> updates =3D new ArrayList<RemoteRe=
fUpdate>();
> 135    for (final RemoteRefUpdate u : refUpdates.values()) {
> 136        final String n =3D u.getRemoteName();
> 137        if (!n.startsWith("refs/") || !Repository.isValidRefName(n=
)) {
> 138            u.setStatus(Status.REJECTED_OTHER_REASON);
> 139            u.setMessage("funny refname");
> 140            continue;
> 141        }
> >>>>>>>>>
>=20
> u.getRemoteName() gives "master" here.
> Removing  n.startsWith("refs/") would generate a bad `packed-refs`
> file in later code.
> I tried to fix this, but failed to do so without breaking GitSsh tran=
sports

This is not specific to s3. It seems jgit wants a fully qualified ref f=
or the remote
side, so refs/heads/master will work for the other protocols, and I gue=
ss s3 too.

- robin
