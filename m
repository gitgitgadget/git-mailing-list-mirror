From: David Kastrup <dak@gnu.org>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Thu, 09 Aug 2007 10:43:46 +0200
Message-ID: <868x8lnlml.fsf@lola.quinscape.zz>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
	<1185851481271-git-send-email-eclesh@ucla.edu>
	<20070731040510.GD12918@filer.fsl.cs.sunysb.edu>
	<87bqdhnotj.fsf@hubert.paunchy.net> <86r6mdp1e1.fsf@lola.quinscape.zz>
	<18071eea0708090122h79dec205j4528f4dfd7aab588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 10:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3cu-00011Q-FD
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 10:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764819AbXHIIoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 04:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764649AbXHIIoM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 04:44:12 -0400
Received: from main.gmane.org ([80.91.229.2]:47623 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764138AbXHIIoL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 04:44:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJ3ce-00006J-E7
	for git@vger.kernel.org; Thu, 09 Aug 2007 10:44:00 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 10:44:00 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 10:44:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:E9LkNmIVYULTNHqy3XOVUBpIpJ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55427>

"Thomas Adam" <thomas.adam22@gmail.com> writes:

> On 09/08/07, David Kastrup <dak@gnu.org> wrote:
>>     sed -i -e "s,^\($p[[:space:]]*.*\)\$,\1 #$x," "$series"
>>
>> and that's fine.
>
> I'm surprised to see 'sed -i' being at all, it's certainly non-portable.

Yes.  Neither is [[:space:]].  The above actually is pretty much
equivalent to

      $(RM) "$series+"
      sed "/^$p/s/\$/ #$x/" "$series" >"$series+"
      $(MV) "$series+" "$series"

Which is probably not what was intended (the whole [[:space:]]
construct is irrelevant).  More likely it was intended to do something
like

      $(RM) "$series+"
      sed "/^$p[ 	]/s/\$/ #$x/" "$series" >"$series+"
      $(MV) "$series+" "$series"

or if $p can contain slashes but not commata,

      $(RM) "$series+"
      sed "\,^$p[ 	],s,\$, #$x," "$series" >"$series+"
      $(MV) "$series+" "$series"

Note that the included tab character will get safely from any shell to
any sed.

-- 
David Kastrup
