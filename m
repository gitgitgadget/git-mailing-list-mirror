From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at
	EOL
Date: Wed, 25 Jun 2008 20:14:22 +0200
Message-ID: <20080625181422.GC4039@steel.home>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZWb-0001sW-Nk
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 20:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbYFYSOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYFYSOZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:14:25 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:55960 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYFYSOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:14:25 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf4EbVSQ==
Received: from tigra.home (Fad8f.f.strato-dslnet.de [195.4.173.143])
	by post.webmailer.de (fruni mo30) (RZmta 16.45)
	with ESMTP id n051bak5PHh84y ; Wed, 25 Jun 2008 20:14:23 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 222EC277BD;
	Wed, 25 Jun 2008 20:14:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 09A7A56D2A; Wed, 25 Jun 2008 20:14:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86315>

Christian Holtje, Tue, Jun 24, 2008 21:21:22 +0200:
> diff --git a/t/t7503-template-hook--pre-commit.sh b/t/t7503-template- 
> hook--pre-commit.sh

Your patch has long lines wrapped.

> diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
> index b25dce6..335ca09 100644
> --- a/templates/hooks--pre-commit
> +++ b/templates/hooks--pre-commit
> @@ -55,8 +55,14 @@ perl -e '
>  	if (s/^\+//) {
>  	    $lineno++;
>  	    chomp;
> -	    if (/\s$/) {
> -		bad_line("trailing whitespace", $_);
> +	    if (/\r$/) {
> +		if (/\s\r$/) {
> +		    bad_line("trailing whitespace", $_);
> +		}
> +	    } else {
> +		if (/\s$/) {
> +		    bad_line("trailing whitespace", $_);
> +		}

You coud just strip the trailing (cr)lf, instead of chomp:

  	if (s/^\+//) {
  	    $lineno++;
- 	    chomp;
+	    s/\r?\n$//so;
 	    if (/\s$/) {
 		bad_line("trailing whitespace", $_);

Makes for a shorter patch and less code.
