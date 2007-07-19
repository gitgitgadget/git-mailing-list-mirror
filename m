From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 14:38:42 +0200
Message-ID: <86bqe8a7ql.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <86zm1sbpeh.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 14:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBVHX-0007O8-Il
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756483AbXGSMi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jul 2007 08:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756435AbXGSMiz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:38:55 -0400
Received: from main.gmane.org ([80.91.229.2]:49602 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996AbXGSMiz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:38:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBVHM-0005HU-P2
	for git@vger.kernel.org; Thu, 19 Jul 2007 14:38:48 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:38:48 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 14:38:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:7+lz8O6MbmKUdPJnHS3f53p4uWY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52984>

David Kastrup <dak@gnu.org> writes:

> Although it would be natural to have
> core.adddirs: false
> be equivalent to
> core.excludefile: .
>
> And so it might be possible to actually not need a separate
> core.adddirs option at all, technically.

To followup on myself here:

A project such as the linux kernel which presumably does not want to
have directories tracked will put the single pattern
=2E
into its top-level .gitignore file.  That is all.  At least if it does
not confuse current versions of git to do ugly things.

A separate option core.adddirs is still necessary because
man gitignore
states:

       When deciding whether to ignore a path, git normally  checks  gi=
tignore
       patterns from multiple sources, with the following order of prec=
edence:

       =C2=B7  Patterns read from the file specified by the configurati=
on  variable
          core.excludesfile.

       =C2=B7  Patterns read from $GIT_DIR/info/exclude.

       =C2=B7  Patterns  read  from  a .gitignore file in the same dire=
ctory as the
          path, or in any parent directory, ordered from the deepest su=
ch file
          to  a file in the root of the repository. These patterns matc=
h rela=E2=80=90
          tive to the location of the  .gitignore  file.  A  project  n=
ormally
          includes  such  .gitignore  files in its repository, containi=
ng pat=E2=80=90
          terns for files generated as part of the project build.

The priority for "core.adddirs", however, should be below that so that
preferences set in the repository's .gitignore files take precedence.
So core.excludesfile seems to be the wrong place.

A project with the policy of always tracking directories would place
!.
into its top-level .gitignore file.

--=20
David Kastrup
