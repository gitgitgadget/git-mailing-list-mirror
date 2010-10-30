From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 35/42] rev-parse: prints --git-dir relative to user's cwd
Date: Sat, 30 Oct 2010 02:09:42 -0500
Message-ID: <20101030070942.GC30613@burratino>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
 <1288334934-17216-36-git-send-email-pclouds@gmail.com>
 <AANLkTikO5N3JWYCJ0c8AQXra274NfAx9X0aUQTwsOGiw@mail.gmail.com>
 <AANLkTinircf2H9GcqOym036o=av1dvNx9xDVOVXok6xt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 09:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC5hS-00008t-MZ
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 09:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab0J3HJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 03:09:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41909 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0J3HJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 03:09:49 -0400
Received: by gyg4 with SMTP id 4so2388483gyg.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kzHccflkJQct4sHhronvNveQVZ9OCqQFuJ0vABOlnm0=;
        b=QlsIG6Iudy/1FCqtx+blVzyEEshm07A7OLXc8H4IrdMUQYvOqwwSUdu53NXNsDHgH3
         7y2pe5Up/wGyxbW8F8rFuKgD4viPNPMJPku1h32kZqV1HIH1sINgb2zk67NouYClwAMm
         oiT1+6mQ2XIOU/wB05JDjYRjExypY2ICnAWg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mhgGbevTgA63nFChyDBUGRjAV7k0zEEDoqvSukiSnIKfvCxbW17AHwKJCO47j/vvYS
         TAs/tILCjJxatuyvWVrRNcMVtYvdpjiylMXRJA5cgCrLI5K8MaQDiBv90DuP8KY1Llgl
         CDI6AbgLiLGuW+akJmis9RU5xu9hQiyR6H7K0=
Received: by 10.150.97.8 with SMTP id u8mr20677640ybb.357.1288422588288;
        Sat, 30 Oct 2010 00:09:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id k2sm318812ybj.20.2010.10.30.00.09.46
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 00:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinircf2H9GcqOym036o=av1dvNx9xDVOVXok6xt@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160389>

>> 2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>:

>>> git-rev-parse.txt does not say much about this. But I'm sure
>>> git-sh-setup.sh wants "git rev-parse --git-dir" be relative to user=
's
>>> cwd.

Yes, $(git rev-parse --git-dir) should be relative to the caller's
working directory, or else git-sh-setup in the ! "$NONGIT_OK" case
will fail, as you noticed.

Maybe this can be clarified?

The current behavior is often to print an absolute path rather than
a ../../etc string, but callers must be ready to accept a relative
path, too.  The most common output is ".git" (from the toplevel of
an ordinary work tree).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index 4a27643..10321cd 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -136,7 +136,12 @@ appending `/{asterisk}`.
 	directory (typically a sequence of "../", or an empty string).
=20
 --git-dir::
-	Show `$GIT_DIR` if defined else show the path to the .git directory.
+	Show `$GIT_DIR` if defined.  Otherwise, show the path to
+	the .git directory, relative to the current directory.
++
+If `$GIT_DIR` is not defined and the current directory
+is not detected to lie in a git repository or work tree,
+print a message to stderr and exit with nonzero status.
=20
 --is-inside-git-dir::
 	When the current working directory is below the repository
