From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Thu, 20 Jul 2006 11:55:53 +0200
Message-ID: <20060720095553.GA10920@1wt.eu>
References: <20060719214025.GA10997@1wt.eu> <7vd5c1jkc3.fsf@assigned-by-dhcp.cox.net> <20060720093044.GA10824@1wt.eu> <44BF507A.4080801@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 11:56:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3VGN-0002g3-Ii
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 11:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWGTJz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 05:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWGTJz6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 05:55:58 -0400
Received: from 1wt.eu ([62.212.114.60]:57100 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1030252AbWGTJz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 05:55:58 -0400
To: Rogan Dawes <discard@dawes.za.net>
Content-Disposition: inline
In-Reply-To: <44BF507A.4080801@dawes.za.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24026>

On Thu, Jul 20, 2006 at 11:44:26AM +0200, Rogan Dawes wrote:
> Willy Tarreau wrote:
> >+int git_tar_config(const char *var, const char *value)
> >+{
> >+	if (!strcmp(var, "tar.umask")) {
> >+		if (!strcmp(value, "user")) {
> >+			tar_umask = umask(0);
> >+			umask(tar_umask);
> >+		} else {
> >+			tar_umask = git_config_int(var, value);
> 
> Looks like you forgot:
>    			umask(tar_umask);

not at all : we don't want to change the process's umask, but set the
mask that will be used to position file modes in the output archive.

The reason for umask(tar_umask) above is because you cannot read the
process umask without changing it, so you have to do it twice with a
dummy value first.

> >+		}
> >+		return 0;
> >+	}
> >+	return git_default_config(var, value);
> >+}
> 
> Or else move it to just before the "return 0;" line.
> 
> Rogan

Regards,
Willy
