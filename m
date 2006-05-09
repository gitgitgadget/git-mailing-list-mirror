From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 19:07:08 -0400
Message-ID: <BAYC1-PASMTP0585D8EE00CAB2D1AD8361AEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	<7virogc90u.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	<7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	<BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	<BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
	<e3p5om$djs$1@sea.gmane.org>
	<Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
	<BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
	<BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>
	<7vu07y252m.fsf@assigned-by-dhcp.cox.net>
	<20060509184519.5a707231.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 01:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdbNO-0002JZ-Jz
	for gcvg-git@gmane.org; Wed, 10 May 2006 01:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWEIXMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 19:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWEIXMU
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 19:12:20 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:7040 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932068AbWEIXMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 19:12:19 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 May 2006 16:12:18 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 82328644C28;
	Tue,  9 May 2006 19:12:17 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060509190708.4ee6656e.seanlkml@sympatico.ca>
In-Reply-To: <20060509184519.5a707231.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 23:12:18.0892 (UTC) FILETIME=[04D890C0:01C673BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 9 May 2006 18:45:19 -0400
sean <seanlkml@sympatico.ca> wrote:

> > How does a program (not a script, but git_config() users) get
> > that value and parse it?  
> 
> The same way they do now.  For instance git-repo-config processes
> the config file using the same get_config() + callback as usual.  The
> only issue is that they should no longer cast everything to lower first.

Junio,

Sorry I see what you're driving at; how does a program break the section
name into it's constituent pieces.  I glossed over this issue because
it's exactly the same between Linus' proposal and mine.   The answer is,
they really can't, with either proposal.

All you can count on (by convention) is that there is an initial segment
that is terminated by a period; and a final segment that starts with a
period, and everything in between is an opaque unit.

    section.<random string>.keyname   value

Although the initial "section." isn't currently enforced (but easily
could be).  Actually i didn't yank out the bit from config.c that
validates the keyname, so without an additional patch the only way
to enter the extended names is by manual editing of the .git/config.

Sean
