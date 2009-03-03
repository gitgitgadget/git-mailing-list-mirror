From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Tue, 03 Mar 2009 17:25:48 +0100
Message-ID: <863aduo9o3.fsf@lola.quinscape.zz>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
	<7viqmrn98i.fsf@gitster.siamese.dyndns.org>
	<76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
	<alpine.LNX.1.00.0903021323180.19665@iabervon.org>
	<76718490903021407u215fb769g656a8fdc20e622e5@mail.gmail.com>
	<7v1vtfmtwj.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0903021746140.19665@iabervon.org>
	<7vsklvlcyy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 17:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXTH-0005F7-UV
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248AbZCCQ0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbZCCQ0A
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:26:00 -0500
Received: from main.gmane.org ([80.91.229.2]:60688 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079AbZCCQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:25:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LeXRM-0001Z2-2G
	for git@vger.kernel.org; Tue, 03 Mar 2009 16:25:56 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 16:25:56 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 16:25:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:fHfpu0TYDegWplkZsmHekNWha/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112110>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> The issue, in my case, is importing from a system where branches contain 
>> projects instead of projects containing branches (and everything is a 
>> single namespace). So I want to match an insane (for us) LHS with a sane 
>> RHS to get stuff into reasonable shape. I don't really care about any 
>> patterns where the branch identifier is multiple components, but I 
>> wouldn't be surprised if somebody did.
>
> Isn't this just getting more and more insane?  Is this really worth
> supporting, I have to wonder...
>
>> Oh, and it looks like "?" is reserved and currently unused, so we could 
>> have * match one or more full path components, and ? match partial path 
>> components.
>
> Well, "?" is not allowed exactly because it often is used to match a
> single character by things like for-each-ref.

Let me present a use case where the current matching rules have changed
working well at some point of time.

We have a product called dsp which sits in Subversion under the top
server repository as

dsp/{trunk,branches,tags}

Then we have projects that have a structure including

projekte/some-project/{trunk,branches,tags}/dsp

which usually is an external link to dsp/trunk.  However, sometimes a
project needs its own local variations of dsp, in which case
projekte/some-project/trunk/dsp becomes a properly populated copy of
dsp/trunk.

Now in git, I want to track those non-externals as branches of the dsp
checkout: that way I get cherry-picking and merging and stuff like that.
To have this work out, I need to have the dsp git project pulling stuff
from any projekte/some-project/trunk/dsp as a branch called
some-project.

I had a git-svn configuration at one point of time that did that, but
the matching rules have changed since then.

So in this case, the existing Subversion structure (which makes quite
good sense) makes wildcards in non-terminal positions desirable.

-- 
David Kastrup
