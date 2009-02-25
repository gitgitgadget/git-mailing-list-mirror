From: <4jxDQ6FQee2H@dyweni.com>
Subject: Re: Bug in Git-Gui - Creates corrupt patch
Date: Wed, 25 Feb 2009 10:24:53 -0600
Message-ID: <20090225102453.38d993ce@family.dyweni.com>
References: <20090225090322.301cdb77@family.dyweni.com>
	<49A567C9.5050203@viscovery.net>
	<20090225101037.104b48a1@family.dyweni.com>
Reply-To: 4jxDQ6FQee2H@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 17:26:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcMaZ-0003LU-Pg
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 17:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbZBYQY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 11:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756651AbZBYQY5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 11:24:57 -0500
Received: from pl1.haspere.com ([208.111.35.220]:35301 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755475AbZBYQY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 11:24:57 -0500
Received: from family.dyweni.com (173-23-155-27.client.mchsi.com [173.23.155.27])
	by pl1.haspere.com (Postfix) with ESMTPSA id 31C15C9FB7;
	Wed, 25 Feb 2009 10:24:55 -0600 (CST)
In-Reply-To: <20090225101037.104b48a1@family.dyweni.com>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.11; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111467>

In case anyone else is facing this same situation, a simple script like
this did the trick for me:

------------------------------------------------
#!/bin/bash

find ./ -type f | grep -v .git | while read filename
do
	last=$(
		tail -c 1 "$filename" | 
		od -x | 
		head -n 1 | 
		awk '{ print $2 }'
	)
	
	if [ "x$last" != "x000a" ]
	then
		echo >> "$filename"
	fi
done
------------------------------------------------


> <4jxDQ6FQee2H@dyweni.com> wrote:
> 
> Hannes / List,
> 
> Thank you for the advise on "\ No newline at end of file".
> 
> I have almost 4,000 files that are formatted with "\ No newline at end
> of file".  Does anyone know of an easy way to re-format my files so
> that they have a newline at the end?
> 
> The files in question are PHP files that are dynamically included, so
> I want to prevent arbitrary spaces from showing up in the rendered
> pages.
> 
> I'm running Linux.  A bash or perl script would be preferable, but
> anything will suffice.
> 
> Thanks!
> 
> 
> > Johannes Sixt <j.sixt@viscovery.net> wrote:
> >
> > 4jxDQ6FQee2H@dyweni.com schrieb:  
> > > 3. Using git-gui, try to stage *only* the last line marked for
> > > removal (should be '-	}').
> > > 
> > > I get 'fatal: corrupt patch at line 22'.    
> > 
> > "Stage/Unstage line" does not work for files that have
> > 
> > \ No newline at end of file
> > 
> > -- Hannes
