From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Fri, 16 Feb 2007 01:48:52 -0500
Message-ID: <20070216064852.GF28894@spearce.org>
References: <Pine.LNX.4.64.0702151838250.20368@woody.linux-foundation.org> <11716079211954-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 07:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHwty-0006vm-06
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 07:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423264AbXBPGs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 01:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423268AbXBPGs5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 01:48:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46867 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423264AbXBPGs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 01:48:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHwtr-00040M-1Q; Fri, 16 Feb 2007 01:48:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3A89820FBAE; Fri, 16 Feb 2007 01:48:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <11716079211954-git-send-email-mdl123@verizon.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39892>

Mark Levedahl <mdl123@verizon.net> wrote:
> +        # update only if non-fastforward
> +        local=$(git-rev-parse --verify "$ref^0" 2>/dev/null)
> +        if test -n "$local"  ; then
> +            mb=$(git-merge-base $local $sha1)
> +            if test "$mb" != "$local" ; then
> +                echo "Not applying non-fast forward update: $ref"
> +            else
> +                ok=1
> +            fi
> +        else
> +            ok=1
> +        fi
> +    else
> +        #forced, accept non-fast forward update
> +        ok=1
> +    fi
> +    if test -n "$ok" ; then
> +        echo "updating: $ref to $sha1"
> +        git-update-ref -m "git-unbundle update" $ref $sha1

What about passing $local as the final argument to update-ref,
so that the ref won't be modified if someone changed it while
an unbundle was running?  Sure its mostly a manual operation,
but imagine running it on a bare repository while someone else
is pushing into it...

-- 
Shawn.
