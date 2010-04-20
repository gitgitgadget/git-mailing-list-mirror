From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: weird fatal on push when post-receive hook exists but is empty
Date: Tue, 20 Apr 2010 21:51:22 +0530
Message-ID: <g2x2e24e5b91004200921mc5b0ffoc1c1ec2af25f71c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 18:21:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4GCY-000111-5O
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 18:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab0DTQVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 12:21:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43974 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab0DTQVX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 12:21:23 -0400
Received: by vws5 with SMTP id 5so3071268vws.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=oHI3p1Mrespdfea5Ye6VOCkxaXrGQKGXFBnB5Wo8/To=;
        b=rq6EGzVeauUifUoamanLRVR15UBTJ8ZLN1XnW+GtyM/2rOHICiDbxDQo6f6JxAebtx
         VBMmndAFsrLjU0SwBkxzC4oxZbAbgxtRdmwQaFNWKLtLqf+3QidHhloIP7D/gXdmIqIE
         yo6vO6FUD/NXp8GmVlNY7hx/DFzwnikGHmsn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qpAtsP8Gy0eTrY2EiAvuYVKpllACIkNCZ3r51Mr5N/0ExaG2M4QqwvR2Itkf9/z5PL
         ytXau6KQT7XAodZIRtImRhy+jnYj1D5CRjNiIUTfrZoRkwQeZoedFurnNWGQYqsCy1R7
         B5LfVW54fSzBNktL9UWEjuQKYIehTPSaKfBXQ=
Received: by 10.220.98.73 with HTTP; Tue, 20 Apr 2010 09:21:22 -0700 (PDT)
Received: by 10.220.60.206 with SMTP id q14mr4875391vch.12.1271780482843; Tue, 
	20 Apr 2010 09:21:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145387>

Helping someone with what at first appeared to be a gitolite problem,
we found something curious.  Here it is, reduced to pure git, even
without ssh and other complications in between:

    21:47:05 sita-lt:t $ rm -rf a b c
    21:47:10 sita-lt:t $ git init --bare b
    Initialized empty Git repository in /home/sitaram/t/b/
    21:47:23 sita-lt:t $ git clone b a
    Initialized empty Git repository in /home/sitaram/t/a/.git/
    warning: You appear to have cloned an empty repository.
    21:47:29 sita-lt:t $ cat > b/hooks/post-receive
    #!/bin/bash
    # dummy
    21:47:55 sita-lt:t $ chmod +x b/hooks/post-receive
    21:48:00 sita-lt:t $ cd a
    21:48:02 sita-lt:a (master) $ date > foo;git add foo; git commit
-m foo; git push origin master
    [master (root-commit) f55bd25] foo
     1 files changed, 1 insertions(+), 0 deletions(-)
     create mode 100644 foo
    Counting objects: 3, done.
    Writing objects: 100% (3/3), 232 bytes, done.
    Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    fatal: The remote end hung up unexpectedly
    error: error in sideband demultiplexer
    error: .git/objects/f5/5bd251325ad1647a29869e75a8080fee1a5d97 died
of signal 13
    To /home/sitaram/t/b
     * [new branch]      master -> master
    error: failed to push some refs to '/home/sitaram/t/b'
    (rc=1)21:48:23 sita-lt:a $

Of course, this does not happen when the hook doesn't even exist...

-- 
Sitaram
