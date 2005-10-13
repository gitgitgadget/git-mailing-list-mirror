From: Junio C Hamano <junkio@cox.net>
Subject: Re: Usage of isspace and friends
Date: Wed, 12 Oct 2005 23:49:30 -0700
Message-ID: <7vachd6hdx.fsf@assigned-by-dhcp.cox.net>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 08:51:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPwuW-0007AU-2U
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 08:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVJMGtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 02:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVJMGtd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 02:49:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55784 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751499AbVJMGtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 02:49:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013064911.OJJN11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Oct 2005 02:49:11 -0400
To: Morten Welinder <mwelinder@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10063>

Morten Welinder <mwelinder@gmail.com> writes:

> Someone needs to audit the usage of isspace, tolower, and
> friends.  There are things like this in the code:
>
> static int is_dev_null(const char *str)
> {
> 	return !memcmp("/dev/null", str, 9) && isspace(str[9]);
> }
>
> Since str[9] is of type char it should not be used as a argument to
> isspace directly,
> but rather be cast to unsigned char:
>
>     ... isspace((unsigned char)str[9]);

Huh?  isspace is "int isspace(int)".  Presumably standard
integral promotion rules applies here whether char is signed or
unsigned, doesn't it?

The snippet you quoted is from apply.c, and I would say what is
more problematic is that we do not force C locale while parsing
the diff (see another thread -- we would want to process diffs
as byte streams).
