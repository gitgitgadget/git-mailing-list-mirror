From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Make the output of "git svn clone" less confusing.
Date: Tue, 16 Oct 2007 13:00:01 +0200
Message-ID: <87ejfv1g0e.fsf@lysator.liu.se>
References: <87k5poflp5.fsf@lysator.liu.se> <20071016093228.GA30503@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 13:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihk9p-0004ZU-Oq
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 13:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841AbXJPLAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 07:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757795AbXJPLAG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 07:00:06 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52077 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbXJPLAE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 07:00:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2A30F200A21E;
	Tue, 16 Oct 2007 13:00:03 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 14921-01-13; Tue, 16 Oct 2007 13:00:02 +0200 (CEST)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4E4B9200A201;
	Tue, 16 Oct 2007 13:00:02 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id EEE147B4097; Tue, 16 Oct 2007 13:00:01 +0200 (CEST)
In-Reply-To: <20071016093228.GA30503@soma> (Eric Wong's message of "Tue\, 16 Oct 2007 02\:32\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61144>

Eric Wong <normalperson@yhbt.net> writes:

>> diff --git a/git-svn.perl b/git-svn.perl
>> index 777e436..d4450ca 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -286,6 +286,7 @@ sub do_git_init_db {
>> =20
>>  sub init_subdir {
>>  	my $repo_path =3D shift or return;
>> +	print "Creating directory $repo_path\n";
>>  	mkpath([$repo_path]) unless -d $repo_path;
>>  	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
>
> Since mkpath() isn't guaranteed to get called, maybe putting a
>
> 	print "Entering directory $repo_path\n"
>
> right before the chdir is better.

You're probably right.

> The other option would be to alter git-init to print the absolute pat=
h
> of the repository being initialized...

Absolute paths don't sound like a great idea to me. Ideally, I'd like
to see the path I gave it, or something relative to the working
directory. That is, *my* working directory, and not some internal one
because one of the tools did a chdir.

Can't we make init_subdir in git-svn not chdir, instead?  Like this,
highly untested?

--- a/git-svn.perl
+++ b/git-svn.perl
@@ -288,8 +288,7 @@ sub init_subdir {
 	my $repo_path =3D shift or return;
 	print "Creating directory $repo_path\n";
 	mkpath([$repo_path]) unless -d $repo_path;
-	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
-	$ENV{GIT_DIR} =3D '.git';
+	$ENV{GIT_DIR} =3D '$repo_path/.git';
 }
=20
 sub cmd_clone {


--=20
David K=C3=A5gedal
