From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Thu, 26 Jun 2008 14:23:44 +0200
Message-ID: <86k5gcs7u7.fsf@lola.quinscape.zz>
References: <20080624222105.GA24549@dervierte>
	<1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
	<7vwskea2ik.fsf@gitster.siamese.dyndns.org>
	<48620C1A.6000509@panasas.com>
	<alpine.DEB.1.00.0806251109380.9925@racer>
	<486220CE.3070103@viscovery.net>
	<alpine.DEB.1.00.0806251334060.9925@racer>
	<20080625135100.GF20361@mit.edu> <vpqy74scsln.fsf@bauges.imag.fr>
	<alpine.DEB.1.00.0806261308420.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 14:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqWx-0004ey-Ts
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYFZMX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 08:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYFZMXz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:23:55 -0400
Received: from main.gmane.org ([80.91.229.2]:46531 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbYFZMXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:23:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBqW0-0007mH-HX
	for git@vger.kernel.org; Thu, 26 Jun 2008 12:23:52 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 12:23:52 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 12:23:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:hFrkl1Ft9cTxm3C0Rt2pC0HmsPE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86446>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 26 Jun 2008, Matthieu Moy wrote:
>
>> Theodore Tso <tytso@mit.edu> writes:
>> 
>> > for i in $*
>> 
>> Detail: you meant "$@", your version isn't whitespace-robust.
>
> In that case, you'd have to quote the variables in "$prefix$i" and "> $i", 
> too.

Yes for the first, no for the second I think.  But it would do no harm
in the second case, either.  Certainly makes it less shell-dependent.

In fact, just tried it with bash and dash:

dak@lisa:/tmp$ zup="a b  c"
dak@lisa:/tmp$ echo x > $zup
bash: $zup: ambiguous redirect
dak@lisa:/tmp$ echo x > "$zup"
dak@lisa:/tmp$ rm "$zup"
dak@lisa:/tmp$ dash
$ zup="a b  c"
$ echo x > $zup
$ ls -l "$zup"
-rw-r--r-- 1 dak dak 2 2008-06-26 14:18 a b  c
$ 

Dash gets it right.  Bash just talks nonsense.  "ambiguous redirect" is
not a useful message at all.  There is nothing ambiguous here.

Anyway, bash is prevalent enough to warrant the quoting.

-- 
David Kastrup
