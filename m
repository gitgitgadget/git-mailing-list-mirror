From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Thu, 13 Oct 2005 23:59:09 -0700
Message-ID: <7vll0wvb2a.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
	<87mzlgh8xa.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
	<87ek6s0w34.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
	<87slv7zvqj.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
	<877jcjmdmq.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
	<87vf02qy79.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:00:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQJXK-0008Gl-D5
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVJNG7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 02:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVJNG7M
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 02:59:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10156 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750847AbVJNG7L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 02:59:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014065845.FEPL24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 02:58:45 -0400
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87vf02qy79.fsf@penguin.cs.ucla.edu> (Paul Eggert's message of
	"Wed, 12 Oct 2005 13:26:02 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10103>

Paul Eggert <eggert@CS.UCLA.EDU> writes:

> Here is the proposed format.  Each file name is a string of bytes, in
> one of the following two formats:
>
> A.  A nonempty sequence of ASCII graphic characters (i.e., bytes in
>     the range '!' == '\041' through '~' == '\177').  The first byte
>     cannot be '!' == '\041' or '"' == '\042'.  Leading '"' is used for
>     (B) below, and leading '!' is reserved for future extensions.
>
> B.  A nonempty C-language character string literal, with the following
>     restrictions and modifications:
>
>     B1.  No multibyte character processing is done.  Members of the
>          string literal are treated as bytes, not characters.  Null
>          bytes are not allowed, and '"' == '\042', '\\' == '\134' and
>          '\n' == '\012' are allowed only if properly escaped as shown
>          below; but all other bytes are allowed.
>
>     B2.  No trigraph processing is done (e.g., ??/ stands for three
>          bytes, not one).
>
>     B3.  No line-splicing is done (i.e., backslash-newline is not allowed).
>
>     B4.  Only the following escape sequences are allowed.
>
>            \" \\ \a \b \f \n \r \t \v
>            \XYZ  (where X, Y, and Z are octal digits, X <= 3, and
>                   at least one of the digits is nonzero)

Just to let you know, I am slowly converting apply.c to accept
this format, and also diff.c to produce this.  I did not
personally like the missing double quotes around what I did
anyway, although it was easier to code.
