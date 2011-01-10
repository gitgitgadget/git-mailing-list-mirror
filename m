From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] submodule: fix relative url parsing for scp-style origin
Date: Mon, 10 Jan 2011 18:05:12 +0100
Message-ID: <201101101805.13251.trast@student.ethz.ch>
References: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch> <20110110164801.GA7714@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 18:05:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcLBK-0005yY-2q
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 18:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab1AJRFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 12:05:17 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:11868 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360Ab1AJRFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 12:05:15 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 18:05:13 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 10 Jan
 2011 18:05:13 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc8-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110110164801.GA7714@burratino>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164883>

Jonathan Nieder wrote:
> Thomas Rast wrote:
> > +			case "$remoteurl" in
> > +			*/*)
> > +				remoteurl="${remoteurl%/*}"
> > +				;;
> > +			*:*)
> > +				remoteurl="${remoteurl%:*}"
> > +				sep=:
> > +				;;
> 
> What happens to
> 
> 	url = ssh://example.com:1234
> 	url = ftp://ftp.example.com

Neither specifies a repo, unless you count "the default dir on the
remote side" (do we support that?).  The existing code would have
snipped at the / and constructed something like ssh:/otherrepo.

> 	url = /local/path/with/a/colon:in:it
> 	url = git://example.com/path/with/a/colon:in:it

These work fine because the first case arm is "do we still have a
slash?", and thus takes precedence over the colon splitting.

> 	url = simple.subdir.of.cwd

That's caught by the outer 'case':

		case "$url" in
		../*)
			url="${url#../}"
			# ... what we're discussing here
			;;
		./*)
			url="${url#./}"
			;;
		*)
			break;;

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
