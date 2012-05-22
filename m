From: Steven Penny <svnpenn@gmail.com>
Subject: git stash destroys hard links
Date: Mon, 21 May 2012 23:24:01 -0500
Message-ID: <CAAXzdLWadNg9d_i8fZTawaxYm3ytcGCT4pzeth=LxrQYEO-3ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 06:24:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWgdk-0000f6-Lr
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 06:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab2EVEYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 00:24:04 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33851 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2EVEYC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 00:24:02 -0400
Received: by gglu4 with SMTP id u4so5031652ggl.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 21:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=S/1kcXQI4KQJo0GQFzlgo6L99QB66ohq/w8qn1OPiGM=;
        b=EPVXL6tm34Ej4pJupz1ryg39y9zhYl18Al9cYrRQZWFc/RVR6qNcN3Z9hK1wNMRbuD
         ZxXdJ6Un8/lu0lLs5TVffCaTI6wUOFLLbLfGQtFVKf3Wai+sSmajv/C2QrKjlY3c751F
         MdYobsCSY9uhg7FPVv0y05rHP/Vtqqr/syO1jrg6ejE3aWObseJDDEMOsFcxpwkuXL1X
         RDaf+24xU2YhsVtZIJ5hSP4pkNJLlQMjEByCORQ0OcWOeoxX+tVAhDqjQIgeG4vFnzev
         /UgxsI2PJJ/QO1KAQEYADucn6vWESoZmpZorPohrNCRs515GBpfpR9jLyfoKevrN8WTq
         LpWw==
Received: by 10.50.168.34 with SMTP id zt2mr8485416igb.10.1337660641389; Mon,
 21 May 2012 21:24:01 -0700 (PDT)
Received: by 10.231.134.4 with HTTP; Mon, 21 May 2012 21:24:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198169>

I dont know if this is even fixable, but I wanted to at least mention it.
Performing a git stash will destroy any hard links and replace them with simply
a copy of the file.

$ mkdir test
$ cd test
$ git init
$ touch foobar.sh
$ git add -A
$ git commit -m 'first commit'

$ ln foobar.sh foobar-link.sh

$ ls -l
total 0
-rw-r--r-- 2 Steven None 0 May 21 23:18 foobar.sh
-rw-r--r-- 2 Steven None 0 May 21 23:18 foobar-link.sh

$ git stash -u
$ git stash pop

$ ls -l
total 0
-rw-r--r-- 1 Steven None 0 May 21 23:18 foobar.sh
-rw-r--r-- 1 Steven None 0 May 21 23:18 foobar-link.sh
