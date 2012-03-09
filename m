From: Stephen Bash <bash@genarts.com>
Subject: Passing commit IDs to git-archive
Date: Fri, 09 Mar 2012 17:14:05 -0500 (EST)
Message-ID: <8fb14091-99dc-4383-9cab-5bf508e0a554@mail>
References: <8c6d921d-9e8e-4caf-bc04-b1d2cfdd294f@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S684t-0000yC-BY
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946Ab2CIWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:14:17 -0500
Received: from hq.genarts.com ([173.9.65.1]:30125 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755107Ab2CIWOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:14:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 73A71BE94D3
	for <git@vger.kernel.org>; Fri,  9 Mar 2012 17:14:12 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWVFWTKKdp+h for <git@vger.kernel.org>;
	Fri,  9 Mar 2012 17:14:05 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id A0A14BE94D8
	for <git@vger.kernel.org>; Fri,  9 Mar 2012 17:14:05 -0500 (EST)
In-Reply-To: <8c6d921d-9e8e-4caf-bc04-b1d2cfdd294f@mail>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC17 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192744>

Hi all-

For an upcoming release, I'm attempting to update our build scripts to suck down some content from a remote Git repository and include it en masse in our installer.  My first inclination was to use submodules, but similar to this question on Stack Overflow

  http://stackoverflow.com/questions/6553743/

the content used to be in our development repository and has recently been migrated out, so jumping between branches/back and forth in history is causing problems (unlike the question, I'm not willing to rewrite history to make the submodule approach work).  So after googling around I came to git-archive using the --remote argument, which actually seems nice for my situation because the content is basically support material for the end user that the devs don't manage/edit.

Unfortunately I just attempted

  warp:bar bash$ git archive --remote=file:///Users/bash/Development/foo \
                             --output=test.tgz 3b9e49b \
                             path/to/subdir
  remote: fatal: no such ref: 3b9e49b
  remote: git upload-archive: archiver died with error
  fatal: sent error to the client: git upload-archive: archiver died with error

  warp:bar bash$ git archive --remote=file:///Users/bash/Development/foo \
                             --output=test.tgz 3b9e49b:path/to/subdir
  remote: fatal: no such ref: 3b9e49b
  remote: git upload-archive: archiver died with error
  fatal: sent error to the client: git upload-archive: archiver died with error

  warp:bar bash$ cd /Users/bash/Development/foo
  warp:foo bash$ git rev-parse --short master
  3b9e49b
  warp:foo bash$ 
  warp:foo bash$ git --version
  git version 1.7.9.2
  warp:foo bash$ 

on Mac OS 10.6.8 (obviously this is local testing, the goal is to use ssh remotely).  After parsing the error "no such ref" I attempted the same operation using master as the tree-ish and archive worked as expected (either specifying the path separately or using the colon syntax to reference the tree directly).  Is there a reason git-archive requires a named ref rather than just a commit (or tree) ID?  If not, would it be difficult to patch git-upload-archive to use the IDs?  I could use tags for the ref, but in my case would result in almost every commit being a tag which seems wasteful.

Thoughts?  Thanks in advance!

Stephen
