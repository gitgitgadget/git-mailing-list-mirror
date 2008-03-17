From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: git-svn clone on a central server
Date: Mon, 17 Mar 2008 11:01:39 -0400
Message-ID: <eaa105840803170801p4155f21bpabc828a3be0e4aaa@mail.gmail.com>
References: <frh8k1$lc8$1@ger.gmane.org>
	 <eaa105840803151645j5e8ec443v991b9117df343b8f@mail.gmail.com>
	 <frjbtf$rd0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bruno Harbulot" <Bruno.Harbulot@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Mon Mar 17 16:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbGr1-0003rt-1k
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbYCQPBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbYCQPBn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:01:43 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:44629 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbYCQPBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:01:42 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1869983fkr.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=BjRHoRyfDcv3hIFFOVM3+uU6aN/E1oJxcuR988hA4Fk=;
        b=llqb2VdWxKSOx2/bWbVeXUWT6oReHX3mlBr9yhWeFDdF/QpV4gQqVbyRRzRtdm/wheMXEwdjNz2CEs2qH4De+9CYeaATuu8hKIqabKd4xUJV7XC5kW2/97oJgADBNYIWCwToDLxQpnHuyBR5Cy3pjAqtWHDa9bTAruWnCjSmaac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dU+9RGqXDUtXtqH7TpusAhAyH3Lt05yc6LIkUY83dLx6IjuyHf1Eg1AsdLaz5YvoQqn15Teyum1IPP0RYAV4Rb6HkptDfHdl8eSpcDhLZUeyx3qU4jS0P2B6cj8E8IFAqBiHx3nludBfeKToCqDpKQ8DVZq6io9lylwt55xodWE=
Received: by 10.78.107.8 with SMTP id f8mr42543893huc.40.1205766099288;
        Mon, 17 Mar 2008 08:01:39 -0700 (PDT)
Received: by 10.78.107.13 with HTTP; Mon, 17 Mar 2008 08:01:39 -0700 (PDT)
In-Reply-To: <frjbtf$rd0$1@ger.gmane.org>
Content-Disposition: inline
X-Google-Sender-Auth: 5bd407e383ca8a84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77433>

On Sun, Mar 16, 2008 Bruno Harbulot wrote:
>  The way I'm planning to use this is to create a "central" bare
>  repository on the server (by moving the '.git' directory and setting
>  bare=true in the config file) that I would like to keep in sync with the
>  original SVN repository (and also push by own branches).
>  I'd like then to pull these changes to my working copies of that central
>  repository. I'm not quite sure how to update this central bare git
>  repository (and then its clones) with the changes in the SVN repository
>  upstream. (By the way, I'm not planning to 'dcommit' anything directly,
>  just reading from this SVN.) Are there any recommendation on how to
>  achieve this?

I run "git svn fetch" hourly (and "git gc" daily) from cron on my
'server'. My working copies, I just "git pull" when I want an update
as usual.

I also occasionally "git svn (fetch|rebase|dcommit)" in my working
copies. Just remember to blow away .git/svn after each "git
(fetch|pull)" so that git-svn knows to rebuild the local index. Also,
you just have to wait for the central 'server' to run another update
before your next "git (fetch|pull)", or it will rewind the state of
your svn branches.

(Also note that state can get out of sync if an svn log message or
author changes between the working copy's "git svn
(fetch|rebase|dcommit)" and when the server's cron job triggers -
basically never, unless you happen to have coworkers who like to
ammend their svn log messages shortly after making a commit)

I don't push branches to my 'svn fetch' repo (I use a separate repo
for that), but I don't see why it would cause a problem.

I'm sure there are other ways to do this.

Peter Harris
