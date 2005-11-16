From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito and --exclude vs --exclude-per-directory
Date: Wed, 16 Nov 2005 11:01:50 -0800
Message-ID: <7vd5l08li9.fsf@assigned-by-dhcp.cox.net>
References: <20051116093630.GA2783@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 20:07:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcSXb-0004lR-GD
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 20:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbVKPTBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 14:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVKPTBx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 14:01:53 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64250 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030430AbVKPTBw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 14:01:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116190037.KIPX20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 14:00:37 -0500
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20051116093630.GA2783@diana.vm.bytemark.co.uk> (Karl
	=?iso-8859-1?Q?Hasselstr=F6m's?= message of "Wed, 16 Nov 2005 10:36:30
 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12040>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> [Note: this experiment was done with git 0.99.9g and Cogito 0.15.1, s=
o ]
>
> It seems that --exclude patterns always take precedence over
> --exclude-per-directory patterns.
>
> Is this the intended behavior?

Yes, we had a lengthy discussion on this before ls-files
acquired the exclude patterns.

Documentation/git-ls-files.txt "Exclude Patterns" summarizes the
precedence rule, and it was done that way to allow command line
users to override what are in individual per-directory pattern
files per-invocation basis.  That is, --exclude-per-directory is
to store project defaults, and --exclude is for end-users to
specify override per-invocation.  --exclude-from has the lowest
precedence to give overall default.  The example in the
documetation has a a good illustration.

	* --exclude-from contains '*.[oa]' to catch generic
          "uninteresting" files.

	* --exclude-per-directory files contain patterns to
          catch files that are built by the Makefile in the
          directory.

        * --exclude specifies whatever the user feels like for
          the particular invocation.

If I were writing a Porcelain, I would probably install default
exclude list in /usr/lib/MyPorcelain/exclude file and point at
the file with --exclude-from.  I may also be tempted to check
$HOME/.MyPorcelain/exclude file and add it to give defaults per
user, but I do not do Porcelains, so...
