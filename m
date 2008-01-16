From: Wayne Davison <wayne@opencoder.net>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 14:33:33 -0800
Message-ID: <20080116223333.GB17142@blorf.net>
References: <478D79BD.7060006@talkingspider.com> <alpine.LNX.1.00.0801152305050.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFGqP-00059y-5Q
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbYAPWdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758409AbYAPWdg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:33:36 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:36352 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758403AbYAPWdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 17:33:35 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id B50AB762F; Wed, 16 Jan 2008 14:33:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0801152305050.13593@iabervon.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70756>

On Tue, Jan 15, 2008 at 11:13:58PM -0500, Daniel Barkalow wrote:
> export GIT_DIR=/somewhere-else.git
> 
> Note that this only really works if you've only got one repository; 
> there's no good way to have the repository information outside of the 
> working directory and still have which repository you're using depend on 
> which directory you're working in.

If you use zsh as your shell, put this chpwd function in .zprofile or
.zshrc:

chpwd() {
    local gitbasedir=/var/local/git
    local subdir=$gitbasedir$PWD
    while [[ ! -d $subdir ]]; do
	subdir=${subdir:h}
    done
    if [[ -d $subdir/.git ]]; then
	export GIT_DIR=$subdir/.git
	export GIT_WORK_TREE=${subdir/$gitbasedir/}
    else
	unset GIT_DIR GIT_WORK_TREE
    fi
}

Then, for each /path/.git dir, move it to /var/local/git/path/.git
(creating any needed parent dirs).  On every change of directory in
the shell, the variables GIT_DIR and GIT_WORK_TREE will be either
updated or cleared.  If you ever move a work-tree dir, you'll need
to remember to move the .git dir in the /var/local/git hierarchy.

..wayne..
