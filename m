From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-gui: properly check for a bare repo
Date: Wed, 18 Feb 2009 13:53:12 -0800
Message-ID: <20090218215312.GO22848@spearce.org>
References: <1234144850-2903-1-git-send-email-giuseppe.bilotta@gmail.com> <1234144850-2903-2-git-send-email-giuseppe.bilotta@gmail.com> <20090218171639.GE22848@spearce.org> <cb7bb73a0902181347k6ae479b4v84e2ea8a9f6639dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZuNV-0007Ep-QN
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbZBRVxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZBRVxO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:53:14 -0500
Received: from george.spearce.org ([209.20.77.23]:40778 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZBRVxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:53:13 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EF579381FF; Wed, 18 Feb 2009 21:53:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0902181347k6ae479b4v84e2ea8a9f6639dc@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110583>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> On Wed, Feb 18, 2009 at 6:16 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > This doesn't work as you expect.  Its a chicken-and-egg problem.
> > We haven't read the config yet because we aren't sure that the
> > $_gitdir really is a git directory.  Consequently, core.bare is
> > always false.
> 
> Isn't the config loaded on line 1053?

No, that line is only run if there is no git repository here and
we are opening the repository selection wizard.  The load_config
is to pull in the user's ~/.gitconfig.
 
> Better ways to work around the issue?

Break down and run the fork command here.  We already ran two
git-rev-parse calls at 1049,1050.  One more here during startup
isn't going to kill the world.

The only problem is, you need to watch out for the git version.
AFAIK git-gui still runs on git 1.5.0.  Any option added since should
be used only if its known to exist, or if there is a fallback that
works almost as good.

Or, we need to up our minimum version around line 842, and in the
messages above in 756, 787, 789, 791, and their translations...

-- 
Shawn.
