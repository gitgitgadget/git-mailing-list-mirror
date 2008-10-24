From: david@lang.hm
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Thu, 23 Oct 2008 23:21:02 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810232314490.20238@asgard.lang.hm>
References: <gdok16$vh2$1@ger.gmane.org> <gdqbta$rhe$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 08:21:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtG3W-0002jP-Ij
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 08:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbYJXGUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 02:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYJXGUY
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 02:20:24 -0400
Received: from mail.lang.hm ([64.81.33.126]:39159 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbYJXGUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 02:20:22 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9O6KJDO017889;
	Thu, 23 Oct 2008 23:20:19 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <gdqbta$rhe$1@ger.gmane.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99011>

On Thu, 23 Oct 2008, Giuseppe Bilotta wrote:

> I decided to give the simpler GIT_DIR approach another go.
>
> The reworked Zit ( git://git.oblomov.eu/zit ) works by creating
> .file.git/ to track file's history. .file.git/info/excludes is
> initialized to the very strong '*' pattern to ensure that things such
> as git status etc only consider the actually tracked file.
>
> The obvious advantage over the previous implementation is that we
> don't rely on fragile and non-portable hardlinks. The disadvantage
> is that something really bad can happen if a command fails to obey
> GIT_DIR or GIT_WORK_TREE correctly.

this is a very interesting approach.

the thought that hit me as I finidhed reading this thread is that we 
are very close to having the full continum of file/repository combinations

1. everything in the dir is part of one repository (the normal git case)

2. some of all of the individual files in a dir is it's own repository 
(the zit case)

3. the in-between case where you can have multiple repositories that can 
have multiple files in them.

how hard would it be to extend zit to support case #3?

offhand I can see it complicating the task of figuing out which repository 
to use for a file, but what else?

David Lang


> Command delegation is made a little smarter:
>
> zit somecommand file [args...]
>
> gets delegated to
>
> git somecommand [args...]
>
> with GIT_DIR=.file.git and GIT_WORK_TREE="`pwd`", which works
> surprisingly well. To prevent stupid expressions such as zit add file
> file or zit commit file file, add and commit put the filename back at
> the end of the parameter list.
>
> Commands that seem to work correctly so far are init, add, log,
> status, diff, remote, push, pull, and even rebase -i.
>
> Commands that definitely need some work are rm (should it just remove
> the .file.git/ dir?) and mv (hairy: we would need to rename .file.git
> to .newname.git too, but rollbacks are likely to break things).
>
> The only new command introduced by zit is zit list, which lists all
> zit-tracked files in the current directory, currently in a very
> braindead way (e.g. I'd like it to display the proper status, such as
> C M or whatever; suggestions welcome).
>
> On the TODO list is also some smart way to guess which file we're
> talking about when no file is specified. Basically, the idea is to
> check if there's only one tracked file, or only one changed tracked
> file, and allow a missing file option in that case.
>
> As usual, comments suggestions and critiques welcome.
>
>
