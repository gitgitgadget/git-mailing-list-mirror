From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 09:03:15 +0200
Message-ID: <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJOYG-00024r-OU
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbXHJHEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbXHJHEu
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:04:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:42305 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564AbXHJHEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:04:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7A72QBD012302;
	Fri, 10 Aug 2007 09:04:43 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1103e.pool.einsundeins.de [77.177.16.62])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7A72PBX023742
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 09:02:25 +0200 (MEST)
In-Reply-To: <20070810053158.GJ24573@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55510>


On Aug 10, 2007, at 7:31 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> mingw only contains tclsh84 but not tclsh. This causes
>> the Makefile in git-gui to fail on the creation of
>> lib/tclIndex. Therefore git gui decides to take the slow
>> path of sourcing the files in lib explicitly but this failes
>> because they are sourced before git-version is defined.
>> Therefore blame.tcl reports the error mentioned above.
>>
>> Johannes (or someone else from the msysgit team),
>> We should modify mingw to contain the symlink to tclsh.
>> Or something similar, at least 'tclsh' should be there.
>>
>> Shawn,
>> The fallback mechanism of sourcing files from lib is broken.
>> Either git-version must be defined before sourcing them, or
>> the auto_index must always work.
>
> *ouch*.  Yea, that happened when the git-version proc was introduced.
> It doesn't get declared until after we have sourced everything,
> but the things we are sourcing want it to be declared.
>
> The short-term workaround is the obvious thing of just making
> sure the auto_index works in the Makefile.  I'll try to reorder
> things in git-gui so that the "source everything fallback" is
> done only after git-version is declared.  Though that might be
> difficult as that codepath assumes error_popup has been declared
> and that's in something we are sourcing.

Marius, Johannes,
I really think the right way to fix this would be to include
tclsh.exe in mingw. I tried to push a commit to mob but failed
to do so (see separate mail on submodule to the list).

btw,
I recognized that '.' is included in the PATH in /etc/profile.
I don't think this is a good idea. At least it bit me once when
I expected to run /bin/git but instead /git/./git was chosen.
Shouldn't we remove '.' from the PATH?

	Steffen
