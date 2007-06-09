From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH 10/10] Sparse: fix a "symbol 'weak_match' shadows an earlier one" warning
Date: Sat, 09 Jun 2007 01:07:28 -0700
Message-ID: <7vr6olh7pb.fsf@assigned-by-dhcp.cox.net>
References: <4669D7BC.3060607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jun 09 10:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwvz1-0008PK-LN
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 10:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500AbXFIIHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 04:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759440AbXFIIHe
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 04:07:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64040 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757234AbXFIIHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 04:07:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070609080730.PHGW7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Jun 2007 04:07:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9L7U1X00D1kojtg0000000; Sat, 09 Jun 2007 04:07:29 -0400
In-Reply-To: <4669D7BC.3060607@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Fri, 08 Jun 2007 23:27:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49560>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  connect.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index da89c9c..d4051dd 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -179,7 +179,6 @@ static int count_refspec_match(const char *pattern,
>  	for (weak_match = match = 0; refs; refs = refs->next) {
>  		char *name = refs->name;
>  		int namelen = strlen(name);
> -		int weak_match;
>  
>  		if (namelen < patlen ||
>  		    memcmp(name + namelen - patlen, pattern, patlen))

This one is an obvious bug.  Essentially, it makes weak matches
ignored.  Unfortunately this has been hiding a larger bug in the
caller of this function.  I am refactoring the mess right now.
