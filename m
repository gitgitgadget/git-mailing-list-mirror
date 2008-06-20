From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 2/3] rebase-i: slight internal improvements
Date: Fri, 20 Jun 2008 10:01:53 +0200
Message-ID: <20080620080153.GC7369@leksak.fem-net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net> <1213929935-15093-3-git-send-email-s-beyer@gmx.net> <485B595B.80608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 10:03:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9bak-0001wN-P9
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 10:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYFTICB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 04:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYFTICA
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 04:02:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:47046 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751548AbYFTICA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 04:02:00 -0400
Received: (qmail invoked by alias); 20 Jun 2008 08:01:58 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp022) with SMTP; 20 Jun 2008 10:01:58 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18omCRazXwovI+PhvK8GqvVgCVQvE6rUYpzXWgFCH
	sBvOBGE2eF145E
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9bZB-0000Rk-8P; Fri, 20 Jun 2008 10:01:53 +0200
Content-Disposition: inline
In-Reply-To: <485B595B.80608@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85603>

Hi,

On Fri, Jun 20, 2008 at 09:16:43AM +0200, Johannes Sixt wrote:
> If by "other slight improvements" you mean ...
> 
> >  mark_action_done () {
> > -	sed -e 1q < "$TODO" >> "$DONE"
> > -	sed -e 1d < "$TODO" >> "$TODO".new
> > -	mv -f "$TODO".new "$TODO"
> > -	count=$(grep -c '^[^#]' < "$DONE")
> > -	total=$(($count+$(grep -c '^[^#]' < "$TODO")))
> > +	sed -e 1q "$TODO" >>"$DONE"
> > +	sed -e 1d "$TODO" >>"$TODO.new"
> > +	mv -f "$TODO.new" "$TODO"
> > +	count="$(grep -c '^[^#]' "$DONE")"
> > +	total="$(expr "$count" + "$(grep -c '^[^#]' "$TODO")")"
> 
> ... this ...
> 
> >  has_action () {
> > -	grep '^[^#]' "$1" >/dev/null
> > +	grep -q '^[^#]' "$1"
> 
> ... and this, etc, then they are not improvements. They make the script
> less portable:

Ok, great to know.

> There are 'grep's that don't have -q,

Well, it's always a little hard to say what is understood by most of the
implementations.  POSIX says, there is grep -q and a few git test
scripts and the Makefile uses it, too.

Ok, so I've looked for a list "the least common denominator of shell
commands you can use to be portable" on the net and found the 
GNU Autoconf documentation:
http://www.gnu.org/software/autoconf/manual/autoconf-2.57/html_node/autoconf_123.html
Looks like *portable* shell programming is no fun :\

> others write the file name in front of the count,

I did not really change anything that's related to the count, btw.


Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
