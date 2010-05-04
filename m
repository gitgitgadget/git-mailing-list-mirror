From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] Documentation/shortlog: scripted users should not rely
 on implicit HEAD
Date: Mon, 3 May 2010 21:57:10 -0500
Message-ID: <20100504025710.GB7322@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
 <20100504015635.GA7258@progeny.tock>
 <20100504025217.GA7322@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 04:57:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O98Jo-0002kv-72
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab0EDC46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 22:56:58 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:64696 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430Ab0EDC45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:56:57 -0400
Received: by iwn40 with SMTP id 40so4256643iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=y1X9ShiwEh5arud8J6Ocekb1CLoi75IFmH2Y2dq3OKA=;
        b=pUStdH0PweJ+la8q29j/hzYBPCi5M1agSoQ+CyfgE0hxSxeNtzSL6WI9Q5W17gsJKG
         0K5wp363+qyWZorEb17MmTCePQbhjIrenrOPKICcWo1v8OyRjFJhmrptlsl4f/qjWnxA
         5ImyoRIWgR8zS9P6Opxr1Fi/fJ2q5Czzc9CGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eSP+QGAt2BFMA6TfIPavXDXxgHoM2EsWh1iQMgeg9G8pWXsuKvy8vybbk2MgAmAKX3
         fMTfB7nopwHFjHDDmcLOF+6ggR4YfURHER64fr6NVRO/fPKdY8ScmWagYtp/s+SASTAx
         kNZRKbq+DRA6dFwwTA94F8jzFphf3lxb8u3IE=
Received: by 10.231.152.78 with SMTP id f14mr789467ibw.51.1272941816624;
        Mon, 03 May 2010 19:56:56 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm4896217iwn.2.2010.05.03.19.56.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 19:56:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504025217.GA7322@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146283>

When passed no revision arguments, =E2=80=98git shortlog=E2=80=99 reads=
 a log from
stdin if and only if stdin is not a tty.  So scripts that need to
function identically when standard input is a terminal (as when run
interactively) and not (as when run through a cron job) should either
supply a log themselves or specify the desired revisions explicitly.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-shortlog.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlo=
g.txt
index dfd4d0c..f11ea90 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 git log --pretty=3Dshort | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
-'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>=
[,<indent1>[,<indent2>]]]] [<committish>...]
+'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>=
[,<indent1>[,<indent2>]]]] <commit>...
=20
 DESCRIPTION
 -----------
@@ -19,6 +19,11 @@ the first line of the commit message will be shown.
=20
 Additionally, "[PATCH]" will be stripped from the commit description.
=20
+If no revisions are passed on the command line and either standard inp=
ut
+is not a terminal or there is no current branch, 'git shortlog' will
+output a summary of the log read from standard input, without
+reference to the current repository.
+
 OPTIONS
 -------
=20
--=20
1.6.5
