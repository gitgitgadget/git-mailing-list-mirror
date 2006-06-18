From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Sun, 18 Jun 2006 04:47:19 -0700
Message-ID: <7vzmga1y9k.fsf@assigned-by-dhcp.cox.net>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	<8aa486160606150426q19b0a661s@mail.gmail.com>
	<7vk67gbbe9.fsf@assigned-by-dhcp.cox.net>
	<20060618112404.GA2446@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi <sbejar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 13:47:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrvkS-0004fW-9z
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 13:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWFRLrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Jun 2006 07:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWFRLrV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 07:47:21 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:7842 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932177AbWFRLrU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 07:47:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618114720.PYTY6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 07:47:20 -0400
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060618112404.GA2446@diana.vm.bytemark.co.uk> (Karl
	=?iso-8859-1?Q?Hasselstr=F6m's?= message of "Sun, 18 Jun 2006 13:24:04
 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22073>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> GNU stow doesn't move installed programs, it just maintains symlinks
> to them. You install programs under /usr/local/stow/foo-4.7.11, and
> stow sets up symlinks to them under /usr/local. (So for example,
> /usr/local/bin/foo would be a symlink to
> /usr/local/stow/foo-4.7.11/bin/foo.) This gives you the ability to
> nuke an installed program cleanly. And it just works, pathwise, since
> the program remains in its original location.

Thanks for the explanation.

If that's the case, I think it makes the original problem Santi
brought up a non-issue.  In this sequence:

        make prefix=3D/home/santi/usr
        make install prefix=3D/home/santi/usr/stow/git
        cd /home/santi/usr/stow/
        stow -v git

the building phase could have used the same prefix as the
install phase uses, and git can find its subprograms in
gitexecdir (=3D ~/usr/stow/git/bin) just fine.  It probably is
even slightly more efficient since it does not have to go
through the symlink stow installs.
