From: David Brown <git@davidb.org>
Subject: Re: preserving mtime
Date: Sun, 18 Nov 2007 10:47:24 -0800
Message-ID: <20071118184724.GA494@old.davidb.org>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se> <20071117182236.GD23659@blorf.net> <20071118084511.GC16863@glandium.org> <46a038f90711180134j411bb9c9uf2476f564f9abb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Mike Hommey <mh@glandium.org>, Wayne Davison <wayne@opencoder.net>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 19:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItpBV-0003AT-2y
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbXKRSri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbXKRSrh
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:47:37 -0500
Received: from mail.davidb.org ([66.93.32.219]:33841 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbXKRSrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:47:37 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1ItpAy-0000B6-J4; Sun, 18 Nov 2007 10:47:24 -0800
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Mike Hommey <mh@glandium.org>, Wayne Davison <wayne@opencoder.net>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90711180134j411bb9c9uf2476f564f9abb6@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65383>

On Sun, Nov 18, 2007 at 10:34:55PM +1300, Martin Langhoff wrote:

>I do hope anyone doing those things is _very_ aware that the mtime
>metadata has a specific meaning -- when did this specific file in this
>filesystem last change -- and is used by many tools in that sense. You
>are trying to use it for something else. Lots of things will break.
>
>Like incremental backups, for example.

'mtime' does _not_ have the specific meaning of 'when did this specific
file last change'.  That is the 'ctime' field.  'mtime' is also updated
when a file is modified, but can be changed by the user.  Many utilities
restore mtime to older values, including tar.

Any competent backup program would use 'ctime' for incremental backups,
unless they don't mind missing a vast majority of files on many machines.

The main thing I've seen mess up backup software is if the mtime is set
into the future.

However, it will make 'make' very confusing, since it uses the mtime to
determine if files are out of date.  If moving to an older version of a
file causes the file to become older, make won't recompile.  This is
arguably a defect in make, but that is how it works.

Preserving mtime definitely should not be a default.

David
