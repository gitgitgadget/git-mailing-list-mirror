From: Pete Wyckoff <pw@padd.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Sun, 23 Jan 2011 09:14:17 -0500
Message-ID: <20110123141417.GA6133@mew.padd.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 23 15:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ph0i4-0001Lf-45
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 15:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054Ab1AWOOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 09:14:21 -0500
Received: from honk.padd.com ([74.3.171.149]:38345 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab1AWOOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 09:14:21 -0500
Received: from mew.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 3D411138;
	Sun, 23 Jan 2011 06:14:20 -0800 (PST)
Received: by mew.padd.com (Postfix, from userid 7770)
	id 14B7720875; Sun, 23 Jan 2011 09:14:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110121222440.GA1837@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165425>

peff@peff.net wrote on Fri, 21 Jan 2011 17:24 -0500:
> cat >$HOME/local/bin/huge-clean <<'EOF'
> #!/bin/sh
> 
> # In an ideal world, we could actually
> # access the original file directly instead of
> # having to cat it to a new file.
> temp="$(git rev-parse --git-dir)"/huge.$$
> cat >"$temp"

Just a quick aside.  Since (a2b665d, 2011-01-05) you can provide
the filename as an argument to the filter script:

    git config --global filter.huge.clean huge-clean %f

then use it in place:

    $ cat >huge-clean 
    #!/bin/sh
    f="$1"
    echo orig file is "$f" >&2
    sha1=`sha1sum "$f" | cut -d' ' -f1`
    cp "$f" /tmp/big_storage/$sha1
    rm -f "$f"
    echo $sha1

		-- Pete
