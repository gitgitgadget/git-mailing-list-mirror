From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Mon, 04 Jun 2007 09:18:50 +0200
Organization: eudaptics software gmbh
Message-ID: <4663BCDA.F1BADDD8@eudaptics.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 09:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv6pJ-00033k-OI
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXFDHR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbXFDHR6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:17:58 -0400
Received: from main.gmane.org ([80.91.229.2]:40687 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbXFDHR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:17:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hv6p3-00056l-Vq
	for git@vger.kernel.org; Mon, 04 Jun 2007 09:17:49 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 09:17:49 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 09:17:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49071>

Johannes Schindelin wrote:
> 
> This script is derived from Pasky's cg-admin-rewritehist.
> 
> In fact, it _is_ the same script, minimally adapted to work without cogito.
> It _should_ be able to perform the same tasks, even if only relying on
> core-git programs.
> 
> All the work is Pasky's, just the adaption is mine.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Hopefully-signed-off-by: Petr "cogito master" Baudis <pasky@suse.cz>

If you hadn't done that, I'd done it sooner or later. Thanks!

> +       -r)
> +               unchanged="$(get_parents "$OPTARG") $unchanged"
> +               ;;
> +       -k)
> +               unchanged="$(git-rev-parse "$OPTARG"^{commit}) $unchanged"
> +               ;;

These two (-r and -k) together with...

> +# seed with identity mappings for the parents where we start off
> +for commit in $unchanged; do
> +       echo $commit > ../map/$commit
> +done

... this and ...

> +               if [ -r "../map/$parent" ]; then
> +                       for reparent in $(cat "../map/$parent"); do
> +                               parentstr="$parentstr -p $reparent"
> +                       done
> +               else
> +                       die "assertion failed: parent $parent for commit $commit not found in rewritten ones"

... this, means that any simple command like 

  git filter-branch -k orgin/master origin/next new-next

of your git.git clone will fail with the "assertion failed". (I haven't
tried your script, yet, but cg-admin-rewritehist fails.)

I propose that you just get rid of the "seed" stance and don't fail if a
commit cannot be mapped - just use it unchanged (don't forget to adjust
the map() function, too). Then you can get rid of -r and use -k to
specify everything you want under "--not" in the rev-list.

-- Hannes
