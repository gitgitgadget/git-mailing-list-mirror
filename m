From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: Re: [PATCH] branch.c: simplify chain of if statements
Date: Mon, 17 Mar 2014 11:46:23 +0000 (UTC)
Message-ID: <loom.20140317T120153-546@post.gmane.org>
References: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com> <CAPig+cTodcfSVmHZeHuAj2kuE_CxuZqZuaNHv33hrhDmQuSmuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 12:50:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPW3d-0007ot-Nz
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 12:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbaCQLuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 07:50:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:38959 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514AbaCQLuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 07:50:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WPW3P-0007Yo-Ev
	for git@vger.kernel.org; Mon, 17 Mar 2014 12:50:03 +0100
Received: from nat-labs-cs.cs.pub.ro ([nat-labs-cs.cs.pub.ro])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:50:03 +0100
Received: from dragos.foianu by nat-labs-cs.cs.pub.ro with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:50:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 141.85.225.204 (Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244245>

Eric Sunshine <sunshine <at> sunshineco.com> writes:

> In fact, this change is not table-driven (emphasis on *driven*). It
> merely moves the strings into a table, but all the logic is still in
> the code. To be table-driven, the logic would be encoded in the table
> as well, and that logic would *drive* the code.
> 
> This is not to say that the code must be table-driven. The GSoC
> microproject merely asks if doing so would make sense. Whether it
> would is for you to decide, and then to explain to reviewers the
> reason(s) why you did or did not make it so.
>
> The if-chain is just sufficiently complex that the print messages may
> actually help the reader understand the logic of the code, so this
> argument seems specious.

I understand now after reading your review. I will try to fix this in a
future attempt.
 
> Matthieu already mentioned [2] that this sort of "lego" string
> construction is not internationalization-friendly. See section 4.3 [3]
> of the gettext manual for details.

I was hoping to get away with using less memory by having only four entries
in the table. I suppose that is not possible. The rebasing check can still
be moved outside of the four if statements and calculate the index
correctly. The strings would then have to be arranged in such a way to make
this work.

Using a multiple-dimension array as suggested in other submissions for this
particular microproject would probably be better, but it has already been done.

> These hard-coded indexing constants (0, 1, 2, 3) are fragile and
> convey little meaning to the reader. Try to consider how to compute
> the index into verbose_prints[] based upon the values of
> 'remote_is_branch' and 'origin'. What are the different ways you could
> do so?

I was going to do something like this: if !remote_is_branch the index goes
incremented by 2, because the first two entries are of no interest and if
!origin, the index is incremented by 1. This would correctly compute the
index. It should also work with the rebasing check if the four
rebasing-specific messages are at the end of the table and when rebasing the
index is set to start at those messages.

The reason I did not go with this is because I would still need the four ifs
in order to keep the bug check part of the code. I might be able to find a
work-around for it on the second attempt.

I have seen N_() used in other code but I wasn't sure what its purpose was.

Thank you very much for the review.
