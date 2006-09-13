From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 21:34:24 +0200
Organization: At home
Message-ID: <ee9mff$qd1$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz93a9v9.fsf@assigned-by-dhcp.cox.net> <ee9jv6$ga0$1@sea.gmane.org> <7vbqpja8wz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 13 21:35:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNaVm-0004zb-W3
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 21:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWIMTex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 13 Sep 2006 15:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWIMTex
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 15:34:53 -0400
Received: from main.gmane.org ([80.91.229.2]:31625 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751150AbWIMTew (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 15:34:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNaVC-0004tO-Im
	for git@vger.kernel.org; Wed, 13 Sep 2006 21:34:30 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 21:34:30 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 21:34:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26936>

Junio C Hamano wrote:

> By the way, does gitweb still walk $GIT_DIR/refs hierarchy by
> hand to find out the set of refs? =A0When Linus is done with his
> refs/ work, that way would become unsupported. =A0You would need
> to read from "ls-remote $GIT_DIR".

Still, unfortunately. We could change git_get_references to use
'git ls-remotes $GIT_DIR' (or 'git --git-dir=3D$GIT_DIR ls-remotes .'),
and use git_get_references("refs/heads") in git_heads (and git_summary)=
,=20
and git_get_references("refs/tags") in git_tags. This _could_ be slower
than current implementation. git-show-refs would help a bit, but I'd ra=
ther
have git-show-refs in released version of git before using it in gitweb=
=2E

Moreover, git currently reads appropriate ref directly in
git_get_hash_by_ref, not supporting even symrefs, not to mention packed
refs. One solution would be to add support for symrefs and packed refs
directly in gitweb (Git.pm can help here), another to use git core comm=
and
(git-rev-parse?) but that can make gitweb slower (additional fork).

I hope that Linus work will be left to mature first in 'pu', then in 'n=
ext'
branch... wouldn't refs cache (similar to current index for files) be
better idea?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
