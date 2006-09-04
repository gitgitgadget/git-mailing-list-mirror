From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 04 Sep 2006 22:03:12 +1200
Message-ID: <44FBF9E0.9050800@catalyst.net.nz>
References: <11573485523752-git-send-email-martin@catalyst.net.nz>	<20060904090833.GF17042@admingilde.org>	<7vveo4nfbg.fsf@assigned-by-dhcp.cox.net> <7vr6ysneor.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Sep 04 12:03:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKBIV-0004Uu-Hd
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 12:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWIDKDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 06:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWIDKDQ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 06:03:16 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:9626 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751311AbWIDKDP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 06:03:15 -0400
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.5])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GKBIN-0003lN-Cq; Mon, 04 Sep 2006 22:03:11 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6ysneor.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26412>

Junio C Hamano wrote:

> In other words...

Can't be offline 2 hs to read a book... ;-) Actually, I had thought the 
pack reading code would focus on filenames following pack-<id>.pack 
pattern and corresponding idx files, and that .tmp-* was safe to have 
there. My bad.

BTW, I think there's a small error.

...

> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -24,8 +24,10 @@ do
>  	shift
>  done
>  
> -rm -f .tmp-pack-*
>  PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
> +PACKTMP="$GIT_DIR/.tmp-$$-pack"
> +rm -f "$PACKTMP"-*
> +trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15

Your packtmp includes $$ which means that rm -f "$PACKTMP" will only 
clear out old packs only if the pid of the old-and-probably-dead process 
matches ours... and then a hyphen.

so instead I propose...

+trap 'rm -f "$GIT_DIR/.tmp-*-pack"' 0 1 2 3 15

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------

-- 
VGER BF report: U 0.900798
