From: Kevin Daudt <me@ikke.info>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Thu, 25 Feb 2016 12:49:58 +0100
Message-ID: <20160225114958.GC15324@ikke.info>
References: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
To: Bill Okara <billokara@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 12:50:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYuQp-0002bb-JG
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 12:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbcBYLuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 06:50:01 -0500
Received: from ikke.info ([178.21.113.177]:38713 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbcBYLuA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 06:50:00 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id 9A531440082; Thu, 25 Feb 2016 12:49:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287363>

On Wed, Feb 24, 2016 at 04:38:11PM -0700, Bill Okara wrote:
> Hi,
> 
> I noticed the following 'git mv' issue with:
> git version 2.6.4
> 
> 
> If there are identical files in different subfolders, 'git mv' the
> root folder (and/or each file individually) will mess up the file path
> mapping. that is, if having identical 'content.txt' file under
> gitmvtest
>     |--demo/content.txt
>     |--dev/content.txt
>     |--prod/content.txt
> 
> after doing the "git mv gitmvtest/resources
> gitmvtest/src/main/resources", the 'git status' will show:
> 
> renamed:    gitmvtest/resources/demo/content.txt ->
> gitmvtest/src/main/resources/demo/content.txt
> renamed:    gitmvtest/resources/prod/content.txt ->
> gitmvtest/src/main/resources/dev/content.txt            <== NOTE:
> wrongly mapped the prod/content.txt to dev/content.txt
> renamed:    gitmvtest/resources/dev/content.txt ->
> gitmvtest/src/main/resources/prod/content.txt            <== NOTE:
> wrongly mapped the dev/content.txt to prod/content.txt
> 
> I tried running 'git mv' on each file individually, got the same problem:
> > git mv gitmvtest/resources/demo/content.txt gitmvtest/src/main/resources/demo/content.txt
> > git mv gitmvtest/resources/dev/content.txt gitmvtest/src/main/resources/dev/content.txt
> > git mv gitmvtest/resources/prod/content.txt gitmvtest/src/main/resources/prod/content.txt
> 
> > git status
> renamed:    gitmvtest/resources/demo/content.txt ->
> gitmvtest/src/main/resources/demo/content.txt
> renamed:    gitmvtest/resources/prod/content.txt ->
> gitmvtest/src/main/resources/dev/content.txt          <== WRONG
> renamed:    gitmvtest/resources/dev/content.txt ->
> gitmvtest/src/main/resources/prod/content.txt          <== WRONG
> 
> 
> NOTE:
> =======
> if modified the content.txt in the 3 folders to contain different
> data, then repeating the above 'git mv' will produce correct result,
> 
> renamed:    gitmvtest/resources/demo/content.txt ->
> gitmvtest/src/main/resources/demo/content.txt       <== CORRECT
> renamed:    gitmvtest/resources/dev/content.txt ->
> gitmvtest/src/main/resources/dev/content.txt             <== CORRECT
> renamed:    gitmvtest/resources/prod/content.txt ->
> gitmvtest/src/main/resources/prod/content.txt          <== CORRECT
> 
> 
> 
> just want to see if this is a bug, user error (on my end), or??
> 

This looks like the same issue as submodule--helper list has:
http://article.gmane.org/gmane.comp.version-control.git/287227
