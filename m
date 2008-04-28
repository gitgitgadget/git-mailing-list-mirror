From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 21:28:37 +0200
Message-ID: <20080428192837.GB21950@cuci.nl>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org> <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 21:29:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZ2W-0001yL-N5
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934709AbYD1T2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934661AbYD1T2j
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:28:39 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:46263 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934633AbYD1T2i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:28:38 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 47FE8545E; Mon, 28 Apr 2008 21:28:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080428190047.GG26880@genesis.frugalware.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80594>

Miklos Vajna wrote:
>Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> > Isn't the problem that git-daemon loses its connection to the syslog 
>> > daemon when logrotate sighups syslog?

No.

>Right, but logrotate could send SIGHUP to git-daemon as well.

It could, but that's the reason one uses the openlog(3) interface to
syslog, to centralise logfilemanagement and *not* having to deal with
the intricacies of logfile rotation and the like.  So it doesn't need
to.  When you need logfile rotation, you're better off with using
openlog(3), and doing that the proper way means *NOT* closing and
reopening that everytime.

>> I have no idea, but other programs must have the same problem.  I should 

They don't.  Your patch fixes the wrong problem.  Please don't fix
something that wasn't broken in the first place.

>> have shown some diligence and researched that.  Will do so now.

>I don't say that just one example justifies me, but here is an example:
>icald (google://openlog+sighup 2nd result) does this.

N.B. I've never had to close and reopen the openlog(3) syslog interface
in any of the daemons I've written.
The example you refer to of icald is where it directly writes to a
logfile, which is *not* what this patch was about, so please do not use
it as justification.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
