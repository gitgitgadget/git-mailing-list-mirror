From: Jakub Narebski <jnareb@gmail.com>
Subject: [StGIT BUG] StGIT errors out on rebasing patch deleting file with Unicode filename
Date: Sun, 1 Jun 2008 10:46:50 +0200
Message-ID: <200806011046.51872.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 10:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2jEh-0004R5-DG
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 10:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbYFAIrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2008 04:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYFAIrB
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 04:47:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:28084 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYFAIrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 04:47:00 -0400
Received: by nf-out-0910.google.com with SMTP id d3so245882nfc.21
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=nV2uRUa25oDO0doF1y3CsueiYdQKBo2u2Iyz/xAXrOQ=;
        b=Srgoh/fZanSMhKMA2NBrK6NPtaJTCuepwx57H8ecJ7X9OpFiM1pUkfQ+/T3t5huWHaH4MDxOnpurtX5I79Wc5lCv7GL14gY3vwWjACdz2OQpCTx7C5nH+Zla4D2CtVTmzdARiZ2oEFM6wn6uN5KGsp62OKIpSPCR14KHnGgSDhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kD4qYrZoRHYzx+P54O3/iqHVp6GJ6wAveZfqHT72xzSSMJ8S2lM7gZ4U22oXqlU0bq4V+uD7fGlNUnCwgGezubq7dcJvbNzKXWiZT6wFRUINo4NBawjml4yg4PFv56gsHPEc1CZ2WV2J3gMuwVJOAEoJlYEInp08sAwSGdWmbfE=
Received: by 10.210.23.3 with SMTP id 3mr2135147ebw.21.1212310018310;
        Sun, 01 Jun 2008 01:46:58 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.204.14])
        by mx.google.com with ESMTPS id d2sm3541396nfc.31.2008.06.01.01.46.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 01:46:56 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83439>

StGIT errors out on rebasing patch which deletes file with Unicode
characters in filename (with characters outside US-ASCII in filename).
The patch in question is patch deleting gitweb/test/* in git directory,
and is present already on the 'origin' branch (the branch we rebase
onto), so stg-rebase should result in an empty patch (as first patch).

 "gitweb/test/M\303\244rchen" |    2 --
 gitweb/test/file with spaces |    4 ----
 gitweb/test/file+plus+sign   |    6 ------
 3 files changed, 0 insertions(+), 12 deletions(-)
 delete mode 100644 gitweb/test/M=E4rchen
 delete mode 100644 gitweb/test/file with spaces
 delete mode 100644 gitweb/test/file+plus+sign

I guess the error is caused by using unescaped (quoted) filename.

Below is StGIT's error message:

1248:[gitweb/web@git]# stg rebase origin
Checking for changes in the working directory ... done
Popping all applied patches ... done
Rebasing to "origin" ... Traceback (most recent call last):
  File "/usr/bin/stg", line 43, in ?
    main()
  File "/usr/lib/python2.4/site-packages/stgit/main.py", line 281, in m=
ain
    command.func(parser, options, args)
  File "/usr/lib/python2.4/site-packages/stgit/commands/rebase.py", lin=
e 70, in func
    rebase(crt_series, args[0])
  File "/usr/lib/python2.4/site-packages/stgit/commands/common.py", lin=
e 356, in rebase
    git.rebase(tree_id =3D tree_id)
  File "/usr/lib/python2.4/site-packages/stgit/git.py", line 927, in re=
base
    reset(tree_id =3D tree_id)
  File "/usr/lib/python2.4/site-packages/stgit/git.py", line 872, in re=
set
    map(os.remove, rm_files)
OSError: [Errno 2] No such file or directory: '"gitweb/test/M\\303\\244=
rchen"'
1249:[gitweb/web@git]# stg version
Stacked GIT 0.14.2
git version 1.5.5.3
Python version 2.4.3 (#1, Jun 13 2006, 16:41:18)=20
[GCC 4.0.2 20051125 (Red Hat 4.0.2-8)]

--=20
Jakub Narebski
Poland
