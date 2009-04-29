From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Diftool problems
Date: Wed, 29 Apr 2009 21:42:59 +0200
Message-ID: <200904292142.59471.markus.heidelberg@web.de>
References: <7c0fdf4f0904290915i56f58981i70e7093e9bf87d8b@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcin Zalewski <marcin.zalewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:43:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzFh5-0003qN-HD
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 21:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbZD2TnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756169AbZD2TnD
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 15:43:03 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55071 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbZD2TnB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 15:43:01 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4A398FDFCBD6;
	Wed, 29 Apr 2009 21:43:00 +0200 (CEST)
Received: from [89.59.108.55] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LzFgK-0007e6-00; Wed, 29 Apr 2009 21:43:00 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7c0fdf4f0904290915i56f58981i70e7093e9bf87d8b@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/M9TRx/T1xfNpGJ7jeiM+d2wmfRDxvv8Bs7ftg
	I5M8ixjVAPoPc1RUXdchy3cPrblVQSIrwvnV6WLdhxTGsUBjlR
	vnLmCkTGdwcKd9CxWUsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117930>

Marcin Zalewski, 29.04.2009:
> Hi,
> 
> When git-difftool calls a diff tool, it uses file names given to it by
> git-diff. This is a problem because often one of the files to be
> compared is the same as the file to be merged into. What I mean is
> that, in the following fragment of the git-difftool--helper file, $1
> and $2 (I think) may end up being the same:
> 
> launch_merge_tool () {
> 	# Merged is the filename as it appears in the work tree
> 	# Local is the contents of a/filename
> 	# Remote is the contents of b/filename
> 	# Custom merge tool commands might use $BASE so we provide it
> 	MERGED="$1"
> 	LOCAL="$2"
> 	REMOTE="$3"
> 	BASE="$1"
> 
> Git-mergetool creates a temporary file for merging, but git-difftool
> does not. Since git-diff tools is not meant for merging anything, it
> may seem that there is no problem. However, some merge tools (such as
> ediff) do not like when the merge target is the same as one of the
> files to be compared. I use the following emacs snippet by Theodore
> Tso:
> 
> http://kerneltrap.org/mailarchive/git/2007/7/2/250505
> 
> With that emacs code, ediff refuses to do a diff with the way that
> difftool is done now. I do not have a patch, but it seems that a
> simple fix would be to copy the code that creates temporary files from
> mergetool.

The real fix would be to adjust the ediff snippet for difftool support.

As you said yourself, git-difftool is not meant for merging files, so
there is no reason to open more than 2 files at all.

The built-in difftools 'emerge' and 'ecmerge' still seem to open LOCAL,
REMOTE and MERGED. This should be fixed, so that they don't open MERGED
any more, but I don't have emacs installed, so I shouldn't try it
myself.

Oh, and LOCAL shouldn't be copied to a temporary file in the first
place, because people don't use git-difftool in read-only mode only.

Markus
