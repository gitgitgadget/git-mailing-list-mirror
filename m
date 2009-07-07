From: Eric Raible <raible@gmail.com>
Subject: =?ISO-8859-1?Q?Schr=F6dinger=27s_diff?=
Date: Mon, 6 Jul 2009 23:53:47 -0700
Message-ID: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 08:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO4Yv-000829-Db
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 08:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbZGGGxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 02:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZGGGxq
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 02:53:46 -0400
Received: from mail-vw0-f202.google.com ([209.85.212.202]:33135 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbZGGGxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 02:53:45 -0400
Received: by vwj40 with SMTP id 40so3592355vwj.33
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=U/6gJBgsCqOW8RzLfLZhp6h3xiyjAS5EV9mq1Meo+BE=;
        b=TwPGLMhpu1HIlkUrPKJ2OOX03QrJZX5KaDHv3S0ZlaVFk6nav4Sv/sXKQdIrIJQ7i5
         7MNdXqyIZgpLTVb8JxqaI4e0mw/c8HhciEQtCpVhvbJUPhQzdxiAr8l+gnZW1SNhTpNG
         g6wPE+A6mESREQFMqFngK77q6CyCfY33VA2Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FQIIq9KLfY4NeYkua3k8TxWMZhkr10BypgceDKCp/YVIFGC/tCgqCKUMQs86YDOG+s
         +JcSqeF7PV1HecB7M0v7WVyTeRlWYQjOdqk5y7fip8/y6djOZ+VEy7VrCgSe9dArZOEA
         zcNV4HB5sQYio8WK4W5m0om7NSK9VYcUzhjU4=
Received: by 10.220.87.8 with SMTP id u8mr11466920vcl.103.1246949627937; Mon, 
	06 Jul 2009 23:53:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122823>

git version 1.6.3.2.1299.gee46c (msysgit)

In trying to track down some annoying crlf corruption in a repo
I have found a Schr=F6dinger's diff.  In other words it's unknown
whether the diff will produce output or not on any particular run
of the following script.

Sometimes it does, and sometimes it doesn't (seems to be about
50/50).  But either way in any given repo rerunning the git-diff will
always give the same result.

Doing an "git ls-tree HEAD" gives an identical tree in both cases.

Can anyone explain why the output to this is not deterministic?
I'm at a complete loss.

	# Clean up from last run and start over
	rm -rf .git has-crlf
	git init
	git config core.autocrlf false

	# Add a "bad" file
	perl -e 'printf( "12%c%c", 0xd, 0xa )' > has-crlf
	git add has-crlf
	git commit -m"add crlf"

	# I realize that switching is ill-advised, but I'm
	# trying to track down a possibly related problem...
	git config core.autocrlf true

	# This sometimes produces output and sometimes it doesn't.
	# Either way rerunning just git-diff always gives the same result
	# as the first run in this repo.
	git diff

- Eric
