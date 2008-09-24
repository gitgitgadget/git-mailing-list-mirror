From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Partial tree export and merging
Date: Wed, 24 Sep 2008 08:13:47 -0700
Message-ID: <20080924151347.GP3669@spearce.org>
References: <ACF330629DFB034AB290061C320F43460836E082@GOEMAILBE02.europe.mahr.lan> <48D9FACB.20901@mahr.de> <48DA476F.1070700@mahr.de> <20080924143945.GN3669@spearce.org> <48DA5737.4030909@mahr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@mahr.de>
To: Heiko Voigt <heiko.voigt@mahr.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:17:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiW4w-0001gM-JE
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYIXPNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbYIXPNs
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:13:48 -0400
Received: from george.spearce.org ([209.20.77.23]:55153 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYIXPNr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:13:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2FC803835F; Wed, 24 Sep 2008 15:13:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48DA5737.4030909@mahr.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96646>

Heiko Voigt <heiko.voigt@mahr.de> wrote:
> Shawn O. Pearce schrieb:
>> Once the history is split into a new "doc+html" repository have
>> developers _only_ edit the docs/html in the doc+html repository,
>> don't make more edits in the source code repository.
>
> The problem with committing into 2 repositories (only merging from one  
> side) is that the docs/html also contain localization files which make  
> it hard to work/test the code because localization strings are initially  
> added by the developers. They would then have to change in the 2nd repo  
> and pull for testing.

I can see how that would be difficult.

In think you are faced with either restructuring your tree so that
the docs/html/localization files are all under a single subdirectory,
or you have to keep splitting down the repository with something like
filter-branch (or your own tools) to update the localization tree.

Doing the latter risks more merge conflicts for developers when they
pull changes back from the localization team.  Usually a developer
doesn't want to d3eal with merge conflicts from doc writers, and
they really don't want to deal with them in localized files if they
can't read/write that language.

>> You can use git-submodule or git-merge with the subtree strategy
>> to pull changes from the doc+html repository into the main source
>> repository.
>
> Would git submodule work with this kind of layout? Same folders  
> containing different files. I thought submodules only work with  
> subdirectories which are itself a git repo.

You are correct, a submodule requires that everything in that
directory be part of that submodule.  If your source tree has the
"submodule files" spread all over, intermingled with sources,
you can't use submodule to manage them.

Typically the recommendation is to organize your source tree more
by functional responsibility, so you can delegate all files under
a single directory to the docs team.  The project scales better to
more staff, and its easier to avoid merge conflicts.

-- 
Shawn.
