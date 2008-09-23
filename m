From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 14:58:58 -0700
Message-ID: <20080923215858.GL3669@spearce.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <20080923153148.GI3669@spearce.org> <20080923171209.GP21650@dpotapov.dyndns.org> <20080923190637.GJ3669@spearce.org> <20080923200456.GR21650@dpotapov.dyndns.org> <20080923201739.GK3669@spearce.org> <20080923212858.GU21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 00:00:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFvT-0000wL-I2
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 00:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbYIWV67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbYIWV67
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:58:59 -0400
Received: from george.spearce.org ([209.20.77.23]:57447 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYIWV66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:58:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 369743835F; Tue, 23 Sep 2008 21:58:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080923212858.GU21650@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96607>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> I am not sure that I understand what you are trying to do here.
...
> Did you mean this:
...
> if (have_git_dir()) {
> 	git_config(git_cygwin_config, NULL);
> 	cygwin_stat_fn = native_stat ? cygwin_stat : stat;
> 	cygwin_lstat_fn = native_stat ? cygwin_lstat : lstat;
> }

Err, yes, something more like that.
 
> > > static int cygwin_stat_choice(const char *file_name, struct stat *buf)
> > > {
> > > 	init_stat();
> > > 	return (*cygwin_stat_fn)(file_name, buf);
> 
> change the above line to:
> 	return (cygwin_stat_fn ? cygwin_stat_fn : stat) (file_name, buf);

Right.
 
> so init_stat may be called a few times outside of git directory and then
> use the default cygwin function, and once we enter to it then load the
> configuration option and act accordingly.

Yup, exactly.  Sorry I wasn't being very clear earlier.

-- 
Shawn.
