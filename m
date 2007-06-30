From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Sat, 30 Jun 2007 15:33:10 +0200
Message-ID: <20070630133310.GB2866@steel.home>
References: <20070628105208.GA11105@liacs.nl> <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com> <20070629083108.GA14747@liacs.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Sat Jun 30 15:33:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4d4h-0003qY-Eb
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 15:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbXF3NdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 09:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbXF3NdN
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 09:33:13 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:48452 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872AbXF3NdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 09:33:12 -0400
Received: from tigra.home (Fc956.f.strato-dslnet.de [195.4.201.86])
	by post.webmailer.de (klopstock mo58) (RZmta 7.6)
	with ESMTP id p01ab1j5U9Bwpc ; Sat, 30 Jun 2007 15:33:10 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 58F37277BD;
	Sat, 30 Jun 2007 15:33:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2F23DC164; Sat, 30 Jun 2007 15:33:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070629083108.GA14747@liacs.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzA3k6g==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51215>

Sven Verdoolaege, Fri, Jun 29, 2007 10:31:08 +0200:
> +		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
> +		case "$head_sha1" in
> +		'ref: refs/'*)
> +			;;

And what do you do if the HEAD is a reflink on something not in refs/?
Like "ref: tmp"? Yes, it is unlikely, but is not forbidden.

How about "[0-9a-f]*)" instead:

               case "$head_sha1" in
               [0-9a-f]*)
                       git-http-fetch $v -a "$head_sha1" "$1" ||
                       rm -f "$GIT_DIR/REMOTE_HEAD"
                       ;;
               esac
