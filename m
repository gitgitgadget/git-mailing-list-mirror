From: David Kastrup <dak@gnu.org>
Subject: Re: Efficient way to import snapshots?
Date: Tue, 31 Jul 2007 10:48:38 +0200
Message-ID: <867iohq7q1.fsf@lola.quinscape.zz>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org> <20070730222028.GE64467@nowhere> <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org> <85odht3xd1.fsf@lola.goethe.zz> <87r6mpj9dd.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 10:49:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFnPZ-0007me-FH
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 10:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbXGaIsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 04:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbXGaIsv
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 04:48:51 -0400
Received: from main.gmane.org ([80.91.229.2]:56553 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbXGaIsu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 04:48:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFnPM-00086d-Kr
	for git@vger.kernel.org; Tue, 31 Jul 2007 10:48:48 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 10:48:48 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 10:48:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:mvHB3/h/r0ursGmwFZ9PhTrLZQQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54328>

Florian Weimer <fw@deneb.enyo.de> writes:

> * David Kastrup:
>
>> a) one thread for opendir/readdir at every directory level
>> b) one thread for stating the files in readdir order (more likely to
>>    correspond to the disk layout than sorted order)
>
> Not true for ext3.  You need to sort by the d_ino field.  This also
> tends to be benefit other file systems more than readdir order.

Uh, yes, for stating it would (I actually though alphabetic sort order
here, and that would not likely help).  So we just introduce another
thread a2) that sorts the partial list from a) as long as b) is still
busy stating...  But I guess that a2) would be a thread that will
likely not cause much of a speedup.

-- 
David Kastrup
