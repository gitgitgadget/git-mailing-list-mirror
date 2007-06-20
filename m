From: David Kastrup <dak@gnu.org>
Subject: Re: Stupid quoting...
Date: Wed, 20 Jun 2007 10:59:23 +0200
Message-ID: <86tzt3ovbo.fsf@lola.quinscape.zz>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org> <86ir9l1ylc.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706190156110.4059@racer.site> <86sl8owfqj.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706191048570.4059@racer.site> <86645kutow.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706200307070.4059@racer.site> <7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com> <86y7ifoykt.fsf@lola.quinscape.zz> <f5ap5r$sj7$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 11:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0w2i-0003SX-3u
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 11:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbXFTI7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 04:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbXFTI7y
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 04:59:54 -0400
Received: from main.gmane.org ([80.91.229.2]:40641 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbXFTI7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 04:59:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0w2P-0007vr-Nu
	for git@vger.kernel.org; Wed, 20 Jun 2007 10:59:41 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:59:41 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 10:59:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:erPyTtq+DjCdXofyniEvQGhN6J4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50551>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, ls(1) has its --quoting-style=WORD option, why shouldn't
> git-diff and friends (including git-format-patch) have the same? And
> we could change the default later on...

Because interpreting a diff means interpreting both file names as well
as contents.  It does not make much sense to use different forms of
escaping (\01a and similar) here, though in the diff command line,
some additional quoting might be called for.

It is also worth noting that bash's echo -e can interpret octal
escapes only when they start with \0, and the quoted 3-character forms
of 0x00-0x1f incidentally do start in this manner.  There is still
potential for misinterpretation if an escaped character is immediately
followed by a digit.  Since octal ASCII digits are in the range 060 to
067, one can get around this problem by continuing to escape
characters until one hits a non-octal-digit.  So there is at least a
reasonable builtin way for bash scripts to translate the three-digit
octal escapes for 0x00 to 0x1f uniquely into the proper corresponding
strings.

With regard to escaping: unless used unarmored in Email (a bad idea)
or on a terminal, it might be easiest (for post-processors) to
completely refrain from escaping (in effect ignoring the
non-printability of characters) and just apply a minimal level of
quoting on the file names.

-- 
David Kastrup
