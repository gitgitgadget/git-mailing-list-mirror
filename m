From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: small downloads and immutable history (Re: clone breaks replace)
Date: Sat, 15 Jan 2011 00:27:41 -0500
Message-ID: <4D31304D.2000102@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <201101112048.57326.j6t@kdbg.org> <20110111195107.GA18714@sigill.intra.peff.net> <201101112100.32083.j6t@kdbg.org> <4D2CBC1A.9000302@cfl.rr.com> <20110111205043.GA19928@burratino> <4D2CFD0A.1060901@cfl.rr.com> <20110114205308.GA15286@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 06:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdyg3-00078x-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 06:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813Ab1AOF1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 00:27:46 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:60847 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1AOF1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 00:27:45 -0500
X-Authority-Analysis: v=1.1 cv=pepdxKapwHuwCZNFD5uob2wvham6E+RljB0uXw08FdQ= c=1 sm=0 a=cwXoRqF8dMcA:10 a=8nJEP1OIZ-IA:10 a=JmtI77n5PKyEllQSDapvNg==:17 a=dX7TRuhO_G6B5jG2SnMA:9 a=aYkt-U_4jlsSHbbOZXf7OsF6VvYA:4 a=wPNLvfGTeEIA:10 a=JmtI77n5PKyEllQSDapvNg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 184.91.189.177
Received: from [184.91.189.177] ([184.91.189.177:38311] helo=[192.168.1.3])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 32/9E-19545-D40313D4; Sat, 15 Jan 2011 05:27:44 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110114205308.GA15286@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165134>

On 01/14/2011 03:53 PM, Jonathan Nieder wrote:
> Ah, I forgot the use case.  If you are using this to at long last get
> past the limitations (e.g., inability to push) of "fetch --depth",
> then yes, rewriting existing history is bad.

I'm not really talking about using --depth, but more of the project 
deciding to truncate the history in the central repository.

> So what's left is some way to make the "have" part of transport
> negotiation make sense in this context.  I'll be happy if it happens.

Good point.  Whether local history is short because of --depth or 
replace records, the same problem arises; the negotiation needs to be 
able to exclude older objects that are not present locally, rather than 
assuming that the client has the entire history if it has any at all. 
It seems like this should just require sending the server and end point 
in addition to a start point.  In other words, not just send ID of the 
most recent commit, but also the oldest that it has on hand, so that the 
server can be sure that it does not deltafy against objects prior to 
that commit.
