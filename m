From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 08:29:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605090822150.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
 <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE> <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
 <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE> <Pine.LNX.4.64.0605081905240.6713@iabervon.org>
 <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
 <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE> <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
 <e3p5om$djs$1@sea.gmane.org> <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 17:31:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdUA7-0000TN-DI
	for gcvg-git@gmane.org; Tue, 09 May 2006 17:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWEIPaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 11:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWEIPaF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 11:30:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751400AbWEIPaD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 11:30:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k49FTptH009732
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 08:29:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k49FTocg012523;
	Tue, 9 May 2006 08:29:50 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19840>



On Tue, 9 May 2006, Johannes Schindelin wrote:
> 
> Okay, to summarize what people proposed (and that I remember):
> 
> 1) [branch."AnY+String"]

If we really change the syntax, I would oppose the ".". I realize I may 
have used it myself, and I think it would be good _internally_, but I 
think the syntax would be

	[branch "Any+String"]

which looks a lot more readable. Ie just a space (or, perhaps, "any 
combination of spaces and tabs").

> 4) [branch.just/allow-slashes/and-dashes]

Same here. If we break old parsers anyway, the "." has no redeeming 
value. You'd use it when _scripting_ stuff, but not anywhere else.

So in both cases, the above would turn into the _variable_ called 
"branch.Any+String/and-dashes.<key>" internally, and things that used "git 
repo-config" would say it that way, but the config file format should be 
human-readable.

We already do that human-readability thing. We say

	[core]
		name = Linus  Torvalds
		email = random

but we turn it internally into

	core.name  ->	"Linus Torvalds"
	core.email ->	"random"

and that's also the format you use for "git repo-config". Similarly, 
having

	[branch "master"]
		remote = git://....

in the config file should - for exactly the same reasons - be turned 
_internally_ into the association

	branch.master.remote    ->    git://...

and for exactly the same reason you'd just use

	git repo-config set branch.master.remote "git://..."

on the command line.

IOW, we _already_ do not match the internal and command line with the 
actal human-readable syntax.

			Linus
