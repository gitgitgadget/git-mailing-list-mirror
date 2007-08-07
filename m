From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Documentation/Makefile: remove cmd-list.made before redirecting to it.
Date: Tue, 07 Aug 2007 12:29:23 +0200
Message-ID: <868x8n8wos.fsf@lola.quinscape.zz>
References: <86vebsby27.fsf@lola.quinscape.zz>
	<7vlkcn97ll.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 12:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIMJu-0007us-Rb
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 12:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbXHGK3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 06:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757061AbXHGK3n
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 06:29:43 -0400
Received: from main.gmane.org ([80.91.229.2]:38107 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245AbXHGK3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 06:29:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIMJj-0004ao-HG
	for git@vger.kernel.org; Tue, 07 Aug 2007 12:29:35 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 12:29:35 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 12:29:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <7vlkcn97ll.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 06 Aug 2007 23\:33\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:wP5PWACmUSo0OvajRPQ73Bj6Vac=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55241>

Junio C Hamano <gitster@pobox.com> writes:

> Although I understand that it would be a problem if you built as
> root earlier, which would have left files unmodifyable by you, I
> think this is getting out of hand.  The cmd-list.perl script itself,
> for example, does "creat in $out+, if the contents have changed from
> the last round then rename $out+ to $out" sequence in order to avoid
> unnecessary rebuild of files that depend on the generated command
> list.  If it is interrupted in the middle while running as root, and
> then you try to do another build, I suspect "creat in $out+" part
> would fail.

No, creat is only interested in the directory permissions.  It is
open(..., O_TRUNC) that causes the problem.  There are not many
programs that actually use that for their output files, but shell
output redirection is one of them, and some editors tend to do this as
well in order to easily preserve permissions.

There are no other shell output redirections to an undeleted file in
the Makefile.

-- 
David Kastrup
