From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 1/2] Suggest use of "git add file1 file2" when there is nothing to commit.
Date: Sat, 6 Jan 2007 14:33:32 +0100
Message-ID: <17823.42284.620000.476920@lapjr.intranet.kiel.bmiag.de>
References: <20061216025309.GA19955@spearce.org>
	<1168029891.11130.18.camel@ibook.zvpunry.de>
	<7virfldryw.fsf@assigned-by-dhcp.cox.net>
	<7vodpcae9s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 06 14:34:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Bga-00057k-Rp
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 14:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAFNeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 08:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbXAFNeH
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 08:34:07 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:34556 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXAFNeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 08:34:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 19DD43AF21;
	Sat,  6 Jan 2007 14:34:02 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08189-09; Sat, 6 Jan 2007 14:34:01 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 48E533AF20;
	Sat,  6 Jan 2007 14:33:59 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 5CDDF3ADC8;
	Sat,  6 Jan 2007 14:33:58 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16149-01; Sat, 6 Jan 2007 14:33:53 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id AA1FB3ADC6;
	Sat,  6 Jan 2007 14:33:36 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodpcae9s.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36087>

Junio C Hamano writes:
 > Junio C Hamano <junkio@cox.net> writes:
 > 
 > > Michael Loeffler <zvpunry@zvpunry.de> writes:
 > >
 > >> Am Freitag, den 15.12.2006, 21:53 -0500 schrieb Shawn O. Pearce:
 > >> ...
 > >>> +		printf("%s (%s)\n",
 > >>> +			s->amend ? "# No changes" : "nothing to commit",
 > >>> +			use_add_msg);
 > >>>  }
 > >> I don't like the new 'nothing to commit (use "git add ... message")'
 > >> message. I use git status very often to see if there is something to
 > >> commit, but now there is always this annoying "use git add ..." message.
 > >
 > > I tend to not like _ANY_ change at all, but I've learned to wait
 > > and see if I get used to it when I see something that annoys me
 > > initially, to see if the annoyance is because what it does is
 > > truly wrong or it is because what it does is merely different
 > > from what I am used to.
 > >
 > > So I've been trying it out myself as one of the guinea pigs on
 > > this one as well.
 > >
 > > So far, my judgement is that this is of the better kind; it is
 > > easy to get used to, and once you get used to it, it is easily
 > > ignorable.
 > 
 > How about doing this?
 > 
 > -- >8 --
 > git-status: squelch "use 'git add file...'" message when unneeded
 > 
 > Add a field in wt_status to record if there are any uncached
 > changes, and use it to decide when there is no point to add the
 > "use 'git add'" message.

Commit 6e458bf63f48fb7d15cb70ad7c7b7b71915d94a2 in next is already
doing exactly that. Or am I missing something?
