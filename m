From: "Bob Hiestand" <bob.hiestand@gmail.com>
Subject: Re: exporting the last N days of a repository
Date: Tue, 4 Nov 2008 18:18:23 -0600
Message-ID: <cc29171c0811041618jfbcb293l42a19805f06803a0@mail.gmail.com>
References: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
	 <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <93c3eada0811021716y37ba999fkc2085b1060fbea2d@mail.gmail.com>
	 <cc29171c0811030855s2fb0d7a5ncdfdd6acd7c71537@mail.gmail.com>
	 <93c3eada0811041449u20e0fc74gf6a1cb420923e484@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 05 01:19:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxW7i-00054C-Oi
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 01:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbYKEASZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 19:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbYKEASZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 19:18:25 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:10253 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYKEASY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 19:18:24 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1952742wah.21
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 16:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MhKwxRY4TLVoDCDgnckeTHvfQzg5HUQPyv4889i8QF4=;
        b=DihEBBqJmkKDhDf9CykUzUFFE5GRMPykrBNiT2YxoYtcp6ITk0Xdbgt9/7RPWRQZ+k
         gl+iVIrdbS5DBr0o2Slq06rxuEyPoQkvVled6qyxQ1CHKxuaKCtO9Frn8xWav/B+zLQx
         L/DYJCm9W5mzqhrGDxNH1e2wQs57Gg4j89FeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bvnKpFD1lqHXjosh8WT3qW6WCoAAtrO0OSFKcAFjEKXed7LSG58l+nXgcKw0S4ESah
         jD1ncphHL11aA1dELSzqF6dVWDn3ptniuTuiXlkXtEOO/1mPK8aTZ8B5Y62VLEqZvSy0
         oP878uYO1ubTB5gFj0Hmpeuov48u2yUwjUXFo=
Received: by 10.115.89.18 with SMTP id r18mr168577wal.37.1225844303332;
        Tue, 04 Nov 2008 16:18:23 -0800 (PST)
Received: by 10.114.123.10 with HTTP; Tue, 4 Nov 2008 16:18:23 -0800 (PST)
In-Reply-To: <93c3eada0811041449u20e0fc74gf6a1cb420923e484@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100128>

On Tue, Nov 4, 2008 at 4:49 PM, Geoff Russell
<geoffrey.russell@gmail.com> wrote:
> Apologies to Johannes and Bob who have tried to help
> but I'm still having difficulties, here is my current non-working script:
>
> ------------------------------------------------------------------
> #!/bin/sh
> DIR=/tmp/gitdemo
> # for testing just arbitrarily
> # select the 15th most recent commit as our new origin
> NEWORIGIN=$(git rev-list master@{15} | head -1)
> echo $NEWORIGIN
> # checkout earlist point we are interested in
> # we want to drop any history before this point
> git checkout $NEWORIGIN
> # now make a new directory, initialise with new origin
> # and apply all commits after that point
> mkdir $DIR && (cd $DIR ; git init) &&  \
>    rsync -aHv --exclude=.git ./ $DIR && \
>    (cd $DIR ; git add . ; git commit -m "starting point" </dev/null ) && \
>    git fast-export $NEWORIGIN..master | (cd $DIR ; git fast-import )
>
> ----------------- end of script
>
> The fast-import gives me a message I don't understand and doesn't
> do the import.

If I understood your requirement (I know nothing about fast-export),
it would look like this:

#!/bin/sh
DIR=/tmp/gitdemo
ORIGDIR=$PWD
git checkout -b shorthistory
NEWORIGIN=$(git rev-list --since='5 months ago' --reverse HEAD| head -1)
echo $NEWORIGIN
git filter-branch --parent-filter '
        test $GIT_COMMIT = '$NEWORIGIN' &&
        echo || cat' \
        --tag-name-filter cat $NEWORIGIN^..
mkdir $DIR
cd $DIR
git init
git fetch $ORIGDIR shorthistory:master


Thank you,

bob
