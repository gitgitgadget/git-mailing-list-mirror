From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fast-import issues with monotone
Date: Mon, 8 Sep 2008 15:36:01 -0700
Message-ID: <20080908223601.GB14448@spearce.org>
References: <94a0d4530809081530p60ff8692qbf9c314516d03869@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 00:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcpM7-0005m5-Q0
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 00:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYIHWgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 18:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbYIHWgD
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 18:36:03 -0400
Received: from george.spearce.org ([209.20.77.23]:53273 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbYIHWgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 18:36:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 31A4E3835C; Mon,  8 Sep 2008 22:36:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <94a0d4530809081530p60ff8692qbf9c314516d03869@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95312>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> I'm stuck with yet another issue while trying to export a mtn
> repository, so I thought on sharing the list of issues:
> 
> a) directory rename/deletes are indistinguishable from files

Hmm.  I had thought fast-import allowed you to rename or delete a
directory by just name its path.  Internally it should be cascading
those operations to all of the contained children.
 
> b) file mode changes are just like any other operation (you don't get
> the mode at each revision)
> 
> This means the file mode needs to be tracked all the time. Also, it
> means the file contents (blob) needs to be tracked because sometimes
> the only change in the file is the mode.

Ow.  I could see a special case being introduced into the language as
placeholders for the fields, telling gfi not to replace the data if
it is already present.  Probably not even a very difficult patch
to add.  E.g. make "-" a placeholder for both mode and content
SHA-1/mark.

> For these two issues the only viable solution is to keep track of the
> whole tree of each revision. Does it makes sense to do that? Or would
> it make more sense to modify fast-import to allow more delta-oriented
> operations?

Most frontends do keep track of everything.  The CVS->Git and
CVS->SVNish->Git keep track of everything just so they can order
things across files to form commits/changesets.

-- 
Shawn.
