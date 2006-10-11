From: Sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] separate .git from working directory
Date: Wed, 11 Oct 2006 11:43:03 -0400
Message-ID: <BAYC1-PASMTP10003954B66E10247020A7AE140@CEZ.ICE>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 17:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXgEo-0002PR-9Y
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 17:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWJKPnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWJKPnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 11:43:09 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:44899 "EHLO
	BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161048AbWJKPnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 11:43:06 -0400
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.42.136]) by BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 11 Oct 2006 08:46:40 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GXgEa-0003FM-EO; Wed, 11 Oct 2006 11:43:04 -0400
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Message-Id: <20061011114303.0a23496e.seanlkml@sympatico.ca>
In-Reply-To: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 11 Oct 2006 15:46:40.0890 (UTC) FILETIME=[71C87DA0:01C6ED4C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 Oct 2006 20:23:50 +0700
"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:

> I was thinking about this while reading subproject thread. In a simple
> case, I have a repo A located at ~/project-a and another repo B
> located at ~/project-a/some/dir/project-b. With this setup, command
> "find" and other directory-recursive commands will run horribly from
> ~/project-a when they go inside project-b/.git (no I don't want to
> repack -d everytime I want to find something).
> I propose to move project-b/.git outside and place a file, say
> .gitdir, in project-b directory. git-sh-setup and setup_git_directory
> are taught to recognize .gitdir, read it to find the actual GIT_DIR
> recorded inside .gitdir. This way git commands inside project-b should
> work fine while I can "find ~/project-a -name blah" or "grep -R blah"
> quickly.
> .gitdir format could be  a simple shell-like format with environment
> variable assignments.

Probably wouldn't be too hard to implement, but is it worth it?

You can export a GIT_DIR manually pretty easily if you want to move
the .git directory somewhere else.  Also you could make a "git find"
shell script named "gf" that does something like:

#/bin/sh
find "$@" ! -path '*/.git/*'

Which would let you type  "gf -name blah" and automatically ignore
the .git directory.

Sean
