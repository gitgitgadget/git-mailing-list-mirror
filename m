From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 07 Aug 2007 17:27:22 +0200
Message-ID: <46B88F5A.9040801@gmail.com>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 17:27:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIQy9-0006bR-R9
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 17:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbXHGP1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 11:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbXHGP1e
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 11:27:34 -0400
Received: from main.gmane.org ([80.91.229.2]:40938 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbXHGP1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 11:27:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIQy3-0000jw-OK
	for git@vger.kernel.org; Tue, 07 Aug 2007 17:27:31 +0200
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 17:27:31 +0200
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 17:27:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070807145825.GO21692@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55264>

>> Now on a normal UNIX system open(2) *always* by definition does
>> binary IO.  But Cygwin's text mount option tries to make UNIX
>> programs DOS-friendly by making all files treated as text, even if
>> it supposedly doing binary IO via open(2).
>>
>> I think its a mis-feature of Cygwin.  Git has no way (that I know
>> of) to defend itself from this, other than to tell the user to make
>> sure they only store a Git repository in a location that is mounted
>> with the binary flag.
> 
> Cygwin, like Windows' own open(2) simulation, defines an O_BINARY to pass
> as a flag to open(2).  I once got Git half-working on Cygwin text-mode
> mounts by doing a horrible hack approximating:
> 
> #define open(name, flag, ...) \
> 	open(name, (flag) | O_BINARY, ## __VA_ARGS__)
> 
> But it only half worked.  Eventually it managed to corrupt itself again,
> and worse, the test suite was completely hopeless, as all shell activity
> still results in text-mode files.

Something like that would have been my suggested work-around, too. 
Unfortunate to hear this alone won't fix the problem. I've spotted 
several fopen() calls in git where "b" is not explicitly used. Maybe 
fixing those, too, would to do it.

-- 
Sebastian Schuberth
