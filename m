From: Sam Hocevar <sam@zoy.org>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 22:04:28 +0100
Message-ID: <20090324210427.GC30959@zoy.org>
References: <49C7FAB3.7080301@brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmDpQ-0000hP-8I
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 22:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbZCXVEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 17:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbZCXVEf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 17:04:35 -0400
Received: from poulet.zoy.org ([80.65.228.129]:37991 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbZCXVEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 17:04:34 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 313BF120266; Tue, 24 Mar 2009 22:04:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49C7FAB3.7080301@brainfood.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114491>

On Mon, Mar 23, 2009, Adam Heath wrote:
> We maintain a website in git.  This website has a bunch of backend
> server code, and a bunch of data files.  Alot of these files are full
> videos.
> 
> [...]
> 
> Last friday, I was doing a checkin on the production server, and found
> 1.6G of new files.  git was quite able at committing that.  However,
> pushing was problematic.  I was pushing over ssh; so, a new ssh
> connection was open to the preview server.  After doing so, git tried
> to create a new pack file.  This took *ages*, and the ssh connection
> died.  So did git, when it finally got done with the new pack, and
> discovered the ssh connection was gone.

   As stated several times by Linus and others, Git was not designed
to handle large files. My stance on the issue is that before trying
to optimise operations so that they perform well on large files, too,
Git should usually avoid such operations, especially deltification.
One notable exception would be someone storing their mailbox in Git,
where deltification is a major space saver. But usually, these large
files are binary blobs that do not benefit from delta search (or even
compression).

   Since I also need to handle large files (80 GiB repository), I am
cleaning up some fixes I did, which can be seen in the git-bigfiles
project (http://caca.zoy.org/wiki/git-bigfiles). I have not yet tried
to change git-push (because I submit through git-p4), but I hope to
address it, too. As time goes I believe some of them could make it into
mainstream Git.

   In your particular case, I would suggest setting pack.packSizeLimit
to something lower. This would reduce the time spent generating a new
pack file if the problem were to happen again.

Regards,
-- 
Sam.
