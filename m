From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 07 Aug 2007 15:18:10 +0200
Message-ID: <f99rei$ou$1@sea.gmane.org>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 15:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIOxB-0003H2-Iw
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 15:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760353AbXHGNS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 09:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757819AbXHGNS0
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 09:18:26 -0400
Received: from main.gmane.org ([80.91.229.2]:52250 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbXHGNSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 09:18:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIOwy-0003KY-Ut
	for git@vger.kernel.org; Tue, 07 Aug 2007 15:18:16 +0200
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 15:18:16 +0200
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 15:18:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <f99nm6$9vi$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55253>

>>>  100% (2295/2295) done
>>> Resolving 1793 deltas...
>>>  100% (1793/1793) done
>>> : not a valid SHA1b870df7cde1e05ee76d1d15ea428f
>>> fatal: Not a valid object name HEAD

As Mark Levedahl assumed by e-mail, the problem is with Cygwin's binary 
vs. text mount mode feature. Thanks Mark.

I'm running on NTFS and I did try the "binary mount" stuff before "git 
clone" by issuing

mount -bc /cygdrive

but I overlooked that this command only affects /cygdrive paths, and I 
did clone into a non /cygdrive path. So cloning to a /cygdrive mounted 
path works now.

I wonder if this happens because git never passes "b" to any fopen() 
calls (as there is no such thing like opening a file in binary mode 
under Linux, because files are always opened "binary"). If fopen() 
safely ignores the "b" option under Linux, I think it should always be 
specified so Cygwin's git will work with text mode mounts when compiled 
from the original git sources.

-- 
Sebastian Schuberth
