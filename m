From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the
 meta-pacakge to git-all.
Date: Sat, 16 Feb 2008 23:57:28 -0800
Message-ID: <7vskzs2exj.fsf@gitster.siamese.dyndns.org>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 08:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQeQ6-0007Pe-7e
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 08:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbYBQH6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 02:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbYBQH6H
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 02:58:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbYBQH6D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 02:58:03 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2270A3F74;
	Sun, 17 Feb 2008 02:58:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 1D09F3F71; Sun, 17 Feb 2008 02:57:56 -0500 (EST)
In-Reply-To: <1203100163-17509-1-git-send-email-krh@redhat.com> (Kristian
 =?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 15 Feb 2008 13:29:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74100>

Thanks for updates to the spec file, but I need a bit of help
here on two problems.

If I understand you correctly, it should now create "git"
package, instead of "git-core", that contains the really core
parts, and other pieces such as "git-svn" and friends will stay
pretty much the same.  In addition, the new "git" package will
also say "this provides git-core, so install this when the user
asks to install git-core".

Where does "git-all" you talked about in your message come into
the picture?  The "make rpm" procedure produced these files for
me:

Wrote: /home/junio/rpms/SRPMS/git-1.5.4.2-1.src.rpm
Wrote: /home/junio/rpms/RPMS/i386/git-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/git-svn-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/git-cvs-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/git-arch-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/git-email-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/git-gui-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/gitk-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/perl-Git-1.5.4.2-1.i386.rpm
Wrote: /home/junio/rpms/RPMS/i386/git-debuginfo-1.5.4.2-1.i386.rpm

After I throw in these 9 i386.rpm files in my local yum
repository and say "yum install git-all", I get "No Match for
argument: git-all".  This is problem #1.

"yum install git" and "yum install git-core" do not give such an
error but the latter gives quite a bunch of errors ("yum install
git" goes alright).  This is problem #2.

Note that I want to make sure that the upgrade to go smoothly,
so I populated both 1.5.4 RPM and 1.5.4.2 RPM in the repository,
which is to emulate what we do on k.org machines.

The errors start like this.  It looks to me that "Provides:
git-core" is not being honored.

Dependencies Resolved

=============================================================================
 Package                 Arch       Version          Repository        Size
=============================================================================
Installing:
 git-core                i386       1.5.4-1          local             3.6 M
Installing for dependencies:
 git                     i386       1.5.4.2-1        local             3.6 M
 perl-Git                i386       1.5.4.2-1        local              14 k

Transaction Summary
=============================================================================
Install      3 Package(s)
Update       0 Package(s)
Remove       0 Package(s)
Total download size: 7.3 M
Is this ok [y/N]: y
Downloading Packages:
Running Transaction Test
Finished Transaction Test


Transaction Check Error:   file /usr/bin/git conflicts between attempted installs of git-1.5.4.2-1 and git-core-1.5.4-1
  file /usr/bin/git-add conflicts between attempted installs of git-1.5.4.2-1 and git-core-1.5.4-1
  file /usr/bin/git-am conflicts between attempted installs of git-1.5.4.2-1 and git-core-1.5.4-1
  ...
