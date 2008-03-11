From: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>
Subject: Re: How to ignore deleted files
Date: Tue, 11 Mar 2008 15:53:20 +0100
Message-ID: <47D69CE0.3030505@bioinf.uni-sb.de>
References: <47D68203.10905@bioinf.uni-sb.de> <m3y78pxsf5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:54:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5rj-0004lL-AO
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 15:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbYCKOxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYCKOxX
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:53:23 -0400
Received: from theia.rz.uni-saarland.de ([134.96.7.31]:3040 "EHLO
	theia.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbYCKOxX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:53:23 -0400
Received: from mail.cs.uni-sb.de (mail.cs.uni-sb.de [134.96.254.200])
	by theia.rz.uni-saarland.de (8.14.1/8.14.0) with ESMTP id m2BErLA4027915
	for <git@vger.kernel.org>; Tue, 11 Mar 2008 16:53:21 +0200
Received: from domino.bioinf.uni-sb.de (domino.bioinf.uni-sb.de [134.96.237.60])
	by mail.cs.uni-sb.de (8.14.2/2008022900) with ESMTP id m2BErLF2014022;
	Tue, 11 Mar 2008 15:53:21 +0100 (CET)
Received: from [134.96.237.57] ([134.96.237.57])
          by domino.bioinf.uni-sb.de (Lotus Domino Release 8.0)
          with ESMTP id 2008031116053302-17377 ;
          Tue, 11 Mar 2008 16:05:33 +0100 
User-Agent: Thunderbird 2.0.0.5 (X11/20070725)
In-Reply-To: <m3y78pxsf5.fsf@localhost.localdomain>
X-MIMETrack: Itemize by SMTP Server on domino/CBISaar(Release 8.0|August 02, 2007) at
 11.03.2008 16:05:33,
	Serialize by Router on domino/CBISaar(Release 8.0|August 02, 2007) at
 11.03.2008 16:05:33,
	Serialize complete at 11.03.2008 16:05:33
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (theia.rz.uni-saarland.de [134.96.7.31]); Tue, 11 Mar 2008 15:53:21 +0100 (CET)
X-AntiVirus: checked by AntiVir MailGate (version: 2.1.2-14; AVE: 7.6.0.73; VDF: 7.0.3.16; host: AntiVir1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76857>

Dear Jakub!

Jakub Narebski schrieb:
>> our git repository contains a number of .tar.gz - files that are
>> automatically extracted and then deleted during the build process.
>> Unfortunately, commiting any changes after that step will mark those
>> files as deleted and try to commit that to the repository. Is there any
>> way to tell git to ignore those files automatically (apart from changing
>> our build process not to use or not to delete those files)?
>>     
>
> I don't quite understand: are those .tar.gz files stored in _source_
> repository? That would be a bit strange...
>
>   

I absolutetly agree that it's strange. The main reason for this is that
we have some collections of data files (some of them pretty large) that
can be compressed pretty effectively. At compilation time, it is decided
if the files are needed or not. If so, they are extracted. In the end,
the .tar.gz files are deleted since they are no longer needed. In
addition, once a user obtained a checkout, the whole thing is supposed
to work without a further net connection, so downloading the files
during build is not really an option.

> I guess that you have tried adding "*.tar.gz" to either .gitignore or
> .git/info/excludes file?
>   
I did, but as far as I understand it, these only work for untracked
files, and the files themselves are tracked (from time to time, they
change and the idea was to track those changes). Or am I missing
something here?

btw: I just noted that

git-commit $(git-ls-files -m --exclude-from=.git/info/exclude)

with the correct entries in the exclude file seems to do pretty much
what I want it to do, namely finding all modifications apart from those
mentioned in the exclude file and commiting them. Would this be a sane
strategy to handle things before we can maybe some day re-structure our
build process?


Thanks a lot for your help!

Andreas Hildebrandt
