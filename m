From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 17/22] entry.c: optionally checkout newly cloned submodules
Date: Thu, 24 May 2007 15:28:36 +0200
Organization: eudaptics software gmbh
Message-ID: <46559304.611B83B@eudaptics.com>
References: <11799589913153-git-send-email-skimo@liacs.nl> <11799589931860-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 15:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDMy-0007AT-TE
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693AbXEXN2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757733AbXEXN2L
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:28:11 -0400
Received: from main.gmane.org ([80.91.229.2]:55941 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757693AbXEXN2J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:28:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrDMJ-0004f2-D4
	for git@vger.kernel.org; Thu, 24 May 2007 15:28:03 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 15:28:03 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 15:28:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48260>

skimo@liacs.nl wrote:
> +static const char *relativize_path(const char *path, const char *dest)
> +{
> ...
> +}

I really get a head ache when I try to understand the purpose of this
function. A comment or two telling what it's trying to do would really
be helpful. But...

> +int attach_submodule(const char *submodule)
> +{
> +       struct stat st;
> +       const char *submodule_dir, *dest;
> +
> +       submodule_dir = git_path("submodules/%s/.git", submodule);
> +       if (lstat(submodule_dir, &st))
> +               return error("submodule '%s' unavailable", submodule);
> +
> +       dest = mkpath("%s/.git", submodule);
> +       submodule_dir = relativize_path(submodule_dir, dest);
> +
> +       return symlink(submodule_dir, dest);
> +}

I don't like this. Symlinks are a major nuisance on Windows (MinGW
port). Can't we just have this repo itself at this place instead of the
symlink?

-- Hannes
