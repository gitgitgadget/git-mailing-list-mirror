From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am: "Patch fragment without a header"
Date: Mon, 06 Feb 2006 19:20:52 -0800
Message-ID: <7vwtg73ld7.fsf@assigned-by-dhcp.cox.net>
References: <43E80D23.4070007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 04:21:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6JPX-0006rI-4N
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 04:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWBGDU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 22:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBGDU4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 22:20:56 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28302 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932446AbWBGDU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 22:20:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207031743.VCVG20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Feb 2006 22:17:43 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43E80D23.4070007@zytor.com> (H. Peter Anvin's message of "Mon,
	06 Feb 2006 18:59:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15679>

"H. Peter Anvin" <hpa@zytor.com> writes:

> git-am from git-1.1.6 refuses to apply the following two patches,
> whereas patch(1) sees nothing wrong with them...

Linus would have said "Say No to MIME".  I am a bit too busy
right now so if you are inclined to take a look, the problem is
in mailinfo.

It tries to do a limited form of MIME and fails.  The problem is
that it does not handle different content transfer encodings
used in the same message.  The first part of the multipart (log
message) does this:

    Content-Type: text/plain; charset=iso-8859-1; format=flowed
    Content-Disposition: inline
    Content-Transfer-Encoding: quoted-printable

and it then switches to:

    Content-Type: text/plain; charset=us-ascii
    Content-Disposition: inline; filename=klibc-add-luks-to-fstype-v2

    Index: klibc/usr/kinit/fstype/fstype.c
    ===================================================================
    --- .....

in the second part.  The mailinfo splits them alright but it
still thinks it needs to help with quoted printable, and ends up
eating these ===== marks and spitting out garbage.
