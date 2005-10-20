From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revamping the git protocol
Date: Thu, 20 Oct 2005 10:17:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510201001460.3369@g5.osdl.org>
References: <43571DA1.6030907@zytor.com> <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net>
 <20051020091245.GY30889@pasky.or.cz> <Pine.LNX.4.64.0510200924110.3369@g5.osdl.org>
 <4357CB57.3070802@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 19:22:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESe3A-0007R3-K1
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 19:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVJTRRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 13:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVJTRRt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 13:17:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932493AbVJTRRs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 13:17:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9KHHZFC019076
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 10:17:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9KHHYH7031373;
	Thu, 20 Oct 2005 10:17:34 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4357CB57.3070802@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10370>



On Thu, 20 Oct 2005, H. Peter Anvin wrote:
> 
> git over ssh seems to be the obvious choice.

Yes, but Petr is right that there might be room for some lighter-weight 
"gits" secure protocol. One that doesn't necessarily require a whole user 
ID thing.

For example, let's say that you're not the maintainer of your machine, but 
you're in an environment where you are allowed to run daemons as yourself 
(at a university, for example). And you have a group of people who want to 
work together at a project, but they don't want to give write permissions 
to the world or their bigger group (group "student").

And git itself _does_ actually support that, already. You can use the 
standard "ssh:" thing (or just "hostname:pathname"), and the GIT_SSH 
environment variable to set up any tunnelling program you want. Then you 
can authenticate any way you want (and encrypt or not, whatever)..

So if somebody is in this situation, maybe we could have an example tunnel 
client/server thing that does this.

This is unrelated to the git protocol itself, although the "pack over 
ssh/tunnel" obviously uses all the same stuff for the actual transfer.

(It might also be worthwhile to have .git/config specify what program to 
use, so that you don't need a global environment variable. It might even 
be per-host, ie we could have git-send-pack and git-fetch-pack understand 
config language like

	[connect]
		program=[server.uni.edu]:mytunnel

or something. It shouldn't even be hard to do. Certainly simpler than 
doing a good authenticating tunnel).

		Linus
