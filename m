From: "Eric Raible" <raible@gmail.com>
Subject: BUG: "git stash apply <arg>" broken, "git-stash apply <arg>" works
Date: Wed, 4 Jun 2008 16:46:56 -0700
Message-ID: <279b37b20806041646jc29a695w685c3e01efc0dd0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: nanako3@bluebottle.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 01:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K42hq-0006Uh-K7
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 01:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148AbYFDXq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 19:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758671AbYFDXq6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 19:46:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:51291 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758021AbYFDXq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 19:46:57 -0400
Received: by rv-out-0506.google.com with SMTP id l9so373575rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 16:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=RQPvZp7r0HYSojJqlzU7kED6aipHxXOAm9Tx5G+lOyk=;
        b=DXnPYWI7NWn9LjLFfZsTwuhGRrcrI8+bhFnXnbdxVse8VJ30SEnIJSrw3hQYq0bxLe
         ik9l8GJR6b8rZnQ5QdGz/y1dnzn5LRek1J7ZzSnPYxz7A/gvshW3gte+yaz4zZEBd0JD
         gudW1EK6Uk0Jnu4kVyHnkLbOPiDyo+u0vNS2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=mu/S+Sk0C83etGhJTWw8F3GSiCyfmx0ISXL25aG520EVwUq27XaUGaRpNnojNTuFAK
         /TkJvZSe9WfJn6lygF1LBEEPqpws8yZBC0hu1aZMt9B21cX4oVR9c6A8s4x0Nc5Qpf/U
         ERVGAtHU59d9AOR6VKUM5PQ92Fk0js4aG/eVc=
Received: by 10.143.29.17 with SMTP id g17mr213519wfj.239.1212623216828;
        Wed, 04 Jun 2008 16:46:56 -0700 (PDT)
Received: by 10.142.180.10 with HTTP; Wed, 4 Jun 2008 16:46:56 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83838>

Synopsis:
"git stash apply stash@{1}" doesn't work, but
"git-stash apply stash@{1}" does.

Platform:
win xp (yeah, I know, I know)
msys (Git-1.5.5-preview20080413.exe)
git version 1.5.5.1015.g9d258

To reproduce:
	# Create a minimal repo
	mkdir stash-bug
	cd stash-bug
	git init
	echo line1 > file
	git add file
	git commit -m initial

	# Create the stash that we'll use
	echo "This is correct" > file
	git stash save "Save off correct line in what will be stash@{1}"

	# Create another stash (the default one) which we won't use
	echo "This should not be shown" > file
	git stash save "Save off incorrect line in what will be stash@{0}"

	# They are correctly created
	git stash list

	# "git-stash apply arg" works
	git reset --hard
	git-stash apply stash@{1}
	echo "git-stash apply respects its argument"
	cat file

	# But "git stash apply arg" doesn't
	git reset --hard
	git stash apply stash@{1}
	echo "git stash apply (no dash) doesn't respect its argument"
	cat file

- Eric
