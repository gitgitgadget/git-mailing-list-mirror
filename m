From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] fast-import: add 'ls' command
Date: Fri, 11 Feb 2011 16:59:04 -0600
Message-ID: <20110211225904.GA22391@elie>
References: <20110211224339.GA9973@elie>
 <AANLkTimReMYu7QYZEuunmH6WqUz=C0nOnAZHzB6cddXt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 23:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po1xO-0005Br-A1
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 23:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758417Ab1BKW7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 17:59:13 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54254 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758352Ab1BKW7M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 17:59:12 -0500
Received: by vws16 with SMTP id 16so2012009vws.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 14:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Xtsrj6f0BK5T2HtKaHfObfsWpI3MbgnC2dP646rx8wE=;
        b=ZemDQU2k9/m8Igd19DVgMoL8Zp2vcwc7MxL1dNVSkJzn3VRRfhbkpLhpJnl9UuLi+R
         GFvl79l39wfHF2b/uPrb6RD5rPD9QZp9N8xNpsJTjRjcCStIdA9PJJSo4UmOqH6cD6Ed
         DSUG/rNnzaQHXAiA2s4a3nu0OSOMiKxcLWvok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pFXIAC0W3KymCZiBmiW0XIwTLzLGYJ21a01UbS9Ghumlo5WaGcvw2M32y4QnqpThTt
         WVX+upj3fPj35VrZU31GqCqzDy/FR56RzhyD/zyuGqA0EB+CgCINFI33hV7MM8mE9kBj
         F8hb2yxzJE7Oefb5zI08MbdkkJWiEmvLktRr8=
Received: by 10.220.90.146 with SMTP id i18mr1362205vcm.226.1297465151731;
        Fri, 11 Feb 2011 14:59:11 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id e18sm947421vbm.15.2011.02.11.14.59.09
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 14:59:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimReMYu7QYZEuunmH6WqUz=C0nOnAZHzB6cddXt@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166577>

Sverre Rabbelier wrote:
> On Fri, Feb 11, 2011 at 23:43, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Introduce an "ls" command to read directory entries from the active
>> commit or a named commit. =C2=A0This allows printing a blob from the=
 active
>> commit or copying a blob or tree from a previous commit for use in t=
he
>> current one.
>
> Useful addition I think. What happens if you ask it for a path that i=
s
> not a directory?

Hmm, the documentation was not at all clear, then.  Good catch.

The answer is that it always prints a single dirent, whether the path
supplied names a file or a directory.

	FE> ls :1 Documentation
	gfi> 040000 tree 9e6c2b599341d28a2a375f8207507e0a2a627fe9	Documentatio=
n
	FE> ls :1 git.c
	gfi> 100644 blob 23610aa0366ebe36e65e78fb8c5fba3f2d0b8f77	git.c
	FE> ls :1 thisfiledoesnotexist
	gfi> 040000 tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904	thisfiledoes=
notexist
	FE> ls :1 RelNotes
	gfi> 120000 blob b942e499449d97aeb50c73ca2bdc1c6e6d528743	RelNotes
	FE> ls 9e6c2b599341d28a2a375f8207507e0a2a627fe9 git-fast-import.txt
	gfi> 100644 blob 4f92954396e3f0f97e75b6838a5635b583708870	git-fast-imp=
ort.txt
	FE> cat-blob b942e499449d97aeb50c73ca2bdc1c6e6d528743
	gfi> b942e499449d97aeb50c73ca2bdc1c6e6d528743 blob 32
	gfi> Documentation/RelNotes/1.7.4.txt

Maybe this patch (for squashing) would help.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index 4f92954..495e01f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -336,9 +336,9 @@ and control the current import process.  More detai=
led discussion
 	`stdout` if unspecified.
=20
 `ls`::
-	Causes fast-import to print a directory entry in 'ls-tree'
-	format to the file descriptor set with `--cat-blob-fd` or
-	`stdout` if unspecified.
+	Causes fast-import to print a line describing a directory
+	entry in 'ls-tree' format to the file descriptor set with
+	`--cat-blob-fd` or `stdout` if unspecified.
=20
 `feature`::
 	Require that fast-import supports the specified feature, or
@@ -927,10 +927,11 @@ middle of a commit but not in the middle of a `da=
ta` command.
=20
 `ls`
 ~~~~
-Prints a directory entry to a file descriptor previously arranged with
-the `--cat-blob-fd` argument.  This allows printing a blob from the
-active commit (with `cat-blob`) or copying a blob or tree from a
-previous commit for use in the current one (with `filemodify`).
+Prints information about the object at a path to a file descriptor
+previously arranged with the `--cat-blob-fd` argument.  This allows
+printing a blob from the active commit (with `cat-blob`) or copying a
+blob or tree from a previous commit for use in the current one (with
+`filemodify`).
=20
 The `ls` command can be used anywhere in the stream that comments are
 accepted, including the middle of a commit.
@@ -957,7 +958,7 @@ Reading from a named tree::
=20
 See `filemodify` above for a detailed description of `<path>`.
=20
-Output uses the same format as `git ls-tree <tree> -- <path>`:
+Output uses the same format as `git ls-tree <tree> {litdd} <path>`:
=20
 =3D=3D=3D=3D
 	<mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
