From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: git-daemon: path validation, export all option
Date: Tue, 27 Sep 2005 09:30:31 +0100
Organization: Computing Service, University of Cambridge, UK
Message-ID: <1127809831.28407.6.camel@imp.csi.cam.ac.uk>
References: <4338AACC.1050305@zytor.com>
	 <7vslvr6t1u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 10:31:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKAro-0006P5-UW
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 10:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVI0Ias (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 04:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVI0Iar
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 04:30:47 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:151 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964860AbVI0Iar (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 04:30:47 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from imp.csi.cam.ac.uk ([131.111.10.57]:49366)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:465)
	with esmtpsa (LOGIN:aia21) (SSLv3:RC4-MD5:128)
	id 1EKArA-0003VQ-1H (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Tue, 27 Sep 2005 09:30:32 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslvr6t1u.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9381>

On Mon, 2005-09-26 at 21:19 -0700, Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > A first attempt to make git-daemon a bit more suitable for kernel.org 
> > use: it allows the user to specify a whitelist of directories, rejects 
> > paths which have . or .. in them (to avoid bypassing the whitelist), and 
> > allows for an --export-all option.
> >
> > Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> 
> I understand the motivation behind --export-all and directory
> whitelist and these changes look good.  Thanks.
> 
> > +	if ( ok_paths && *ok_paths ) {
> > +		int ok = 0;
> > +...
> > +	}
> > +
> > +	return 1;		/* Path acceptable */
> > +}
> 
> A microNit.  You could lose 'int ok' and return 1 directly where
> you assign 1 to it and break.
> 
> > -	chdir(".git");
> 
> I am unsure about this removal of "minor convenience feature".
> Although I do not think git-daemon is widely used on the field,
> this change breaks existing setup if there is any.

Please drop this one line change.  It certainly breaks my personal
setup.  And all git tools are happy with being given the "master"
directory or the "master/.git" so there is no reason for git-daemon not
to accept that, too.

If hpa really can't live with the chdir, maybe we could add a
"--strict-git-paths" option or something that will not do the chdir?  It
would be only a few lines of code in git-daemon to parse the option and
then the chdir would become

if (!strict_git_paths)
	chdir(".git");

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
