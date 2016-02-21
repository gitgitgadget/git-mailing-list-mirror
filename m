From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] t9200: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 23:43:45 +0000
Message-ID: <20160221234345.GB14382@river.lan>
References: <20160219193310.GA1299@sigill.intra.peff.net>
 <cover.1456075680.git.john@keeping.me.uk>
 <42c95c23bffcbb526aaae302f80667867d164876.1456075680.git.john@keeping.me.uk>
 <CAPig+cQkcUPD5+0rUPkKCcJSzRC0NkuRYKHmW54eZ041PqaqmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:44:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdfZ-0007Ni-5y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbcBUXoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:44:00 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:50370 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbcBUXoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:44:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4E5D5CDA5CD;
	Sun, 21 Feb 2016 23:43:59 +0000 (GMT)
X-Quarantine-ID: <dNTYMgLBTSaN>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dNTYMgLBTSaN; Sun, 21 Feb 2016 23:43:58 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E7037CDA56D;
	Sun, 21 Feb 2016 23:43:47 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQkcUPD5+0rUPkKCcJSzRC0NkuRYKHmW54eZ041PqaqmQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286851>

On Sun, Feb 21, 2016 at 04:15:31PM -0500, Eric Sunshine wrote:
> On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
> > GNU grep 2.23 detects the input used in this test as binary data so it
> > does not work for extracting lines from a file.  We could add the "-a"
> > option to force grep to treat the input as text, but not all
> > implementations support that.  Instead, use sed to extract the desired
> > lines since it will always treat its input as text.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> > @@ -35,7 +35,7 @@ exit 1
> >  check_entries () {
> >         # $1 == directory, $2 == expected
> > -       grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
> > +       sed -ne '\!^/!p' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
> 
> This works with BSD sed, but double negatives are confusing. Have you
> considered this instead?
> 
>     sed -ne '/^\//p' ...

What do you mean double negatives?  Do you mean using "!" as an
alternative delimiter?  I find changing delimters is normally simpler
than following multiple levels of quoting for escaping slashes, although
in this case it's simple enough that it doesn't make much difference.
