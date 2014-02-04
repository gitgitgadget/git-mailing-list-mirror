From: David Kastrup <dak@gnu.org>
Subject: Re: bug? git push triggers auto pack when gc.auto = 0
Date: Tue, 04 Feb 2014 12:11:12 +0100
Organization: Organization?!?
Message-ID: <87iosvxhdb.fsf@fencepost.gnu.org>
References: <loom.20140204T030158-758@post.gmane.org>
	<CACsJy8Bo4XgA-g2hy+_pVEKLnerL9WNhpWe==zJANmCMdGXuow@mail.gmail.com>
	<loom.20140204T055040-646@post.gmane.org>
	<87r47jxp6k.fsf@fencepost.gnu.org>
	<loom.20140204T094437-148@post.gmane.org>
	<87mwi7xm04.fsf@fencepost.gnu.org>
	<loom.20140204T104753-1@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 12:11:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAdug-0002tj-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 12:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbaBDLLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 06:11:30 -0500
Received: from plane.gmane.org ([80.91.229.3]:35672 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbaBDLL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 06:11:28 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAduX-0002oq-6m
	for git@vger.kernel.org; Tue, 04 Feb 2014 12:11:25 +0100
Received: from x2f46198.dyn.telefonica.de ([2.244.97.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 12:11:25 +0100
Received: from dak by x2f46198.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 12:11:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f46198.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:Eityp1ieV4zZtvbErAIUcQwuKeY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241521>

chris <jugg@hotmail.com> writes:

> Ok, given your full response, I understand how this is being
> conceptualized now, thanks.  However, if you look at it purely from a
> user's perspective who is manually invoking these commands for the
> command's primary purpose, the current behavior is annoying.
>
> If we assume Git is right in implementing that no server async actions
> are executed on behalf of a client action, then this falls under the
> category of an ill-behaved server in my opinion.  Anything a server
> does that is not directly related to fulfilling the requested client
> action is now considered bad behavior as it blocks the client from
> continuing whatever it needs to get on with.  I see such
> implementation in Git as favoring server's needs over clients.

There are no "server's needs" at all.  Git only reacts to client
requests.  It is in the clients' own interest when garbage collection is
periodically done since it improves response time.

It's arguable that it would be nicer to use an incremental compaction
process that hides the periodic costs by distributing them over the
request totality.  That replaces the periodic "why does it have to
garbage collect when _I_ am using it" annoyance with "why is this
generally slow".  There is no net benefit to that approach safe for

a) avoiding complaints of "smart" people who have discovered that they
can speed up git by disabling garbage collection, but eventually find
that git is becoming slow for them but not for others.
b) avoiding these mailing list discussions.

The second benefit could likely be achieved by displaying "Server
unreachable... retrying..." instead of reporting about git gc.

-- 
David Kastrup
