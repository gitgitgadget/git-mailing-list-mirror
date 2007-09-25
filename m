From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 16:46:53 +0200
Message-ID: <86ve9y6bvm.fsf@lola.quinscape.zz>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site> <7vlkav71bv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709251249450.28395@racer.site> <46F90C95.5060903@viscovery.net>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?Pine.LNX.4.64.07?= =?ISO-8859-1?Q?09251439070.2839?=
	=?ISO-8859-1?Q?5@race=04r.site>?= <46F91879.6030301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 17:01:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBuW-0000uN-VS
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbXIYPBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbXIYPBH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:01:07 -0400
Received: from main.gmane.org ([80.91.229.2]:37005 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbXIYPBG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:01:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IaBmI-0002MI-8u
	for git@vger.kernel.org; Tue, 25 Sep 2007 14:52:46 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 14:52:46 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 14:52:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:dHN8lj5tnNFoS13bbsIRPPSF+Og=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59133>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Schindelin schrieb:
>> Hi,
>>
>> On Tue, 25 Sep 2007, Johannes Sixt wrote:
>>> How about:
>>>
>>> 	eval "$author_script"
>>> 	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
>>> 	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
>>> 	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
>>> 	$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
>>>
>>> and if you dislike that, put the two questionable lines in parenthesis.
>>
>> That looks ugly.  I'd rather have something like
>>
>> 	eval "$USE_OUTPUT $author_script git commit -F \"$MSG\" $EDIT_COMMIT"
>>
>> but I'm not quite certain if that is enough, what with the funny
>> characters people put into path names these days ($MSG points to
>> "$DOTEST"/message).
>
> I, too, find it ugly, but I think it's the most readable way to do
> it. Your version is certainly underquoted.

Proper quoting in my book would be

eval "$USE_OUTPUT $author_script git commit -F" '"$MSG"' "$EDIT_COMMIT"

(I am not sure I am correct about $EDIT_COMMIT, not having looked at
its definition).

Important is the double quotation of $MSG to keep it as a single argument.

> I poked around a bit, but one major obstacle is that the assignments
> in $author_script are on separate lines, which you would have to
> splice into a single line before you can insert them in the eval.

Hm?  Why?  Newlines separate assignments just as reliable as spaces
do.  They are primarily special to the tty as line separators, not the
shell as such.

-- 
David Kastrup
