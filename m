From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: exporting the last N days of a repository
Date: Wed, 5 Nov 2008 14:24:06 +1030
Message-ID: <93c3eada0811041954i24a15e33tcdd89f50c162b8d2@mail.gmail.com>
References: <93c3eada0810281801l29253e02g95c7a6851c4c4db3@mail.gmail.com>
	 <alpine.DEB.1.00.0810291610340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <93c3eada0811021716y37ba999fkc2085b1060fbea2d@mail.gmail.com>
	 <cc29171c0811030855s2fb0d7a5ncdfdd6acd7c71537@mail.gmail.com>
	 <93c3eada0811041449u20e0fc74gf6a1cb420923e484@mail.gmail.com>
	 <cc29171c0811041618jfbcb293l42a19805f06803a0@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Bob Hiestand" <bob.hiestand@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 05:03:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxZcL-00040L-HP
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 05:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbYKEECS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 23:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbYKEECS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 23:02:18 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:7283 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbYKEECR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 23:02:17 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2561320rnd.17
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 20:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2+uBmA/xEsCvVN8sjcC4N0A3y7ykZDCcfNh98CBHyzQ=;
        b=imx3QxUdzPNtJUV1PvUA6CHkcgA55yNPw6BXjYVjgIDx5Rq7VryvIOE0sXQEMX57gO
         6evxBUN8nzhVlGUdxrpjOF34uhlwO5PrffNdFW9pT/dSUYBNzoun3l+rukrJee2ej7DM
         up5JJl31OHaNLpwXHbAFceOGlrXQRLT11GqYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=rf37o5BDfEcnOVoe0zaZcc4BKBrrfrrQ391XkzeeCObhrqqiopcaOYiUiINviyEsSS
         cstMLcnRVlB9RJd9dZt8rlsOPEm1s9Yn0P9UZcSneioeNTllBKKbDV/QiC0X/Hy1XBPY
         4I6v+Rv3z+KHJnWlUDL4i3ATgiV5GfI9spUzY=
Received: by 10.151.111.15 with SMTP id o15mr886981ybm.21.1225857246683;
        Tue, 04 Nov 2008 19:54:06 -0800 (PST)
Received: by 10.150.181.6 with HTTP; Tue, 4 Nov 2008 19:54:06 -0800 (PST)
In-Reply-To: <cc29171c0811041618jfbcb293l42a19805f06803a0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100142>

On Wed, Nov 5, 2008 at 10:48 AM, Bob Hiestand <bob.hiestand@gmail.com> wrote:
> On Tue, Nov 4, 2008 at 4:49 PM, Geoff Russell
> <geoffrey.russell@gmail.com> wrote:
>> Apologies to Johannes and Bob who have tried to help
>> but I'm still having difficulties, here is my current non-working script:
>>
>> ------------------------------------------------------------------
>> #!/bin/sh
>> DIR=/tmp/gitdemo
>> # for testing just arbitrarily
>> # select the 15th most recent commit as our new origin
>> NEWORIGIN=$(git rev-list master@{15} | head -1)
>> echo $NEWORIGIN
>> # checkout earlist point we are interested in
>> # we want to drop any history before this point
>> git checkout $NEWORIGIN
>> # now make a new directory, initialise with new origin
>> # and apply all commits after that point
>> mkdir $DIR && (cd $DIR ; git init) &&  \
>>    rsync -aHv --exclude=.git ./ $DIR && \
>>    (cd $DIR ; git add . ; git commit -m "starting point" </dev/null ) && \
>>    git fast-export $NEWORIGIN..master | (cd $DIR ; git fast-import )
>>
>> ----------------- end of script
>>
>> The fast-import gives me a message I don't understand and doesn't
>> do the import.
>
> If I understood your requirement (I know nothing about fast-export),
> it would look like this:
>
> #!/bin/sh
> DIR=/tmp/gitdemo
> ORIGDIR=$PWD
> git checkout -b shorthistory
> NEWORIGIN=$(git rev-list --since='5 months ago' --reverse HEAD| head -1)
> echo $NEWORIGIN
> git filter-branch --parent-filter '
>        test $GIT_COMMIT = '$NEWORIGIN' &&
>        echo || cat' \
>        --tag-name-filter cat $NEWORIGIN^..
> mkdir $DIR
> cd $DIR
> git init
> git fetch $ORIGDIR shorthistory:master

Thanks Bob but when I ran your version (using master@{15} instead of
--since =...) it
effectively dropped the recent history, not the old history. Imagine a sequence
of 30 commits, no branches.  I want to keep, for example, 15 through
30 and dump 1
to 15.  So I need to have the working directory as at commit 15 and
then all the changes
to bring it up to 30.

       ... 11--12--13--14--15 ... 28--29--30

       ... Dump 1 to 15           keep 15 to 30.

Your script kept 1 to 15 and dumped the rest.

Cheers,
Geoff.




>
>
> Thank you,
>
> bob
>



-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
