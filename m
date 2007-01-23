From: Junio C Hamano <junkio@cox.net>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Mon, 22 Jan 2007 16:44:02 -0800
Message-ID: <7v3b62r2r1.fsf@assigned-by-dhcp.cox.net>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net> <45B5535E.2000808@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 01:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H99lh-0006cz-9R
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 01:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbXAWAoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbXAWAoG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 19:44:06 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45876 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbXAWAoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 19:44:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070123004403.IOJV15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 19:44:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EQkM1W00Q1kojtg0000000; Mon, 22 Jan 2007 19:44:21 -0500
To: hanwen@xs4all.nl
In-Reply-To: <45B5535E.2000808@xs4all.nl> (Han-Wen Nienhuys's message of "Tue,
	23 Jan 2007 01:14:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37473>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> if you need another example where this is happening, the anongit
> repo for lilypond seems to have gotten in this state as well,
>
> [hanwen@haring tmp]$ git clone git://git.sv.gnu.org/lilypond.git
> Initialized empty Git repository in /tmp/lilypond/.git/
> fatal: protocol error: bad line length character
> fetch-pack from 'git://git.sv.gnu.org/lilypond.git' failed.

With my debugging patch applied to peek-remote:

        $ git-peek-remote git://git.sv.gnu.org/lilypond.git
        error: protocol error: bad line length character
        <<<<<
        env: 
        >>>>>
        fatal: protocol error: bad line length character

So somebody says "env:" immediately followed by an EOF to the
stdout when upload-pack is invoked via git-daemon.

The first thing that happens in the fetch/clone/peek-remote
protocol is reading from the server side, so unfortunately there
is no way to debug any further without having an access to their
server.
