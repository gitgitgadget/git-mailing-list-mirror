From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Fri, 06 Jul 2007 09:06:27 +0200
Organization: eudaptics software gmbh
Message-ID: <468DE9F3.B4489CDE@eudaptics.com>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site>
	 <20070705135824.GB5493@sigill.intra.peff.net> <Pine.LNX.4.64.0707051636240.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 09:06:15 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6htI-0005Am-B3
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 09:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760020AbXGFHGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758413AbXGFHGF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 03:06:05 -0400
Received: from main.gmane.org ([80.91.229.2]:50085 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760008AbXGFHGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 03:06:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I6ht6-0002H4-A7
	for git@vger.kernel.org; Fri, 06 Jul 2007 09:05:56 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 09:05:56 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 09:05:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51727>

Johannes Schindelin wrote:
> -       sed -e '1,/^$/d' <../commit | \
> -               eval "$filter_msg" | \
> -               sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
> -                       $parentstr > ../map/$commit
> +       (sed -e '1,/^$/d' <../commit |
> +               (eval "$filter_msg" ||
> +                die "msg filter failed: $filter_msg" 2>&3) |
> +               (sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
> +                       $parentstr > ../map/$commit ||
> +                die "commit filter failed: $filter_commit" 2>&3)) 3>&1 |
> +        grep . && die

You introduce a handful of new forks and an exec. Isn't an intermediate
file much cheaper?

-- Hannes
