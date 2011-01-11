From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 15:22:50 -0500
Message-ID: <4D2CBC1A.9000302@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <201101112048.57326.j6t@kdbg.org> <20110111195107.GA18714@sigill.intra.peff.net> <201101112100.32083.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 11 21:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PckjY-0002dv-N2
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 21:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab1AKUWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 15:22:15 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:36512 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab1AKUWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 15:22:14 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=uESSSoDEku2quKX/oFXS2Smn5+55LTFcWFr5T5T8nFs= c=1 sm=0 a=IkcTkHD0fZMA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=CiPDVaCaurLrCfxaBUUA:9 a=IX7WO3jGQWasQqW15kEA:7 a=JC7sW_L6jhvHjMUUv_Ih6Q4OaUQA:4 a=QEXdDO2ut3YA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:2705] helo=[10.1.1.235])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id D4/FF-07087-3FBBC2D4; Tue, 11 Jan 2011 20:22:13 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <201101112100.32083.j6t@kdbg.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164989>

On 1/11/2011 3:00 PM, Johannes Sixt wrote:
> On Dienstag, 11. Januar 2011, Jeff King wrote:
>> I think you missed the first part of this discussion. Phillip is
>> proposing that it should, and I am arguing against it.
> 
> You're right, sorry for the noise. Now I understand this three-word-subject.

What it really comes down to is that you can use replace locally to
modify your history and it works great.  As soon as someone clones from
you though, they don't get the replace and so they end up with a
different history than you see.

I suggested that git-upload-pack should respect replace records by
default, so that people cloning your repository will get the same
replaced history instead of the original.

It seems that the recommended use of replace is to locally append
history back on, after it has been removed upstream with git
filter-branch.  Using filter-branch is bad, so it makes more sense to me
to do the remove with git replace, and then if you want to add it back,
you just have to disable the replace ( and maybe fetch additional objects ).

The one problem that has come up is that when you fetch and tell the
server you have a commit after the replace, it assumes that you also
have the commits prior to the replace and may delta against objects you
do not have.  Fixing that would require informing the server of any
replacements you have, and it being able to use that information to
avoid deltas against objects hidden by the replace.

Does that sound like a pretty good summary to everyone?
