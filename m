From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 17:44:37 +0100
Message-ID: <492D7CF5.1020202@drmicha.warpmail.net>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>  <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>  <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>  <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>  <492D6CC3.2050408@drmicha.warpmail.net> <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com> <alpine.DEB.1.00.0811261739110.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ondrej Certik <ondrej@certik.cz>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 17:46:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5NWY-0004pV-KX
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 17:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbYKZQom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 11:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbYKZQom
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 11:44:42 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58742 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbYKZQom (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2008 11:44:42 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D2DE71C880B;
	Wed, 26 Nov 2008 11:44:40 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 26 Nov 2008 11:44:40 -0500
X-Sasl-enc: jSBggGvS65obborp2ZRUI3Lej7AYeS55sEwqfrI28BMK 1227717880
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9B6EE33022;
	Wed, 26 Nov 2008 11:44:39 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <alpine.DEB.1.00.0811261739110.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101746>

Johannes Schindelin venit, vidit, dixit 26.11.2008 17:40:
> Hi,
> 
> On Wed, 26 Nov 2008, Ondrej Certik wrote:
> 
>> I am also trying to make the example simpler. I tried to squash the 
>> first uninteresting ~1500 commits into one, but "git rebase -i" uterrly 
>> fails after squashing about 600 commits. Still investigating.
> 
> 1500... wow.
> 
> The best idea would probably be to just "edit" the first, delete the rest 
> of the 1500, and then 'git read-tree -u -m <last-of-the-1500-commits>"' on 
> the command line (when git rebase stops after the "edit" command).
> 
> rebase -i was _never_ meant for such _massive_ interactions; that's just 
> too much for a shell script.

Or chop the DAG with grafts.

Removing the tags one by one I noticed that for several of them, removal
of the tag increases the number of commits on the connected DAG
component containing master (in the ex/imported repo), and that one
reaches the correct number with still a few tags left in there. Yet, the
topology is wrong in several places; I think all of them can be
attributed to missing parent info (which even creates new roots in some
places).

Looking at the source I suspect that fast-export fails to denote
parenthood in the case of yet unmarked parents (last for-loop of
handle_commit() in builtin_fast_export.c). But I don't really know that
code at all.

Michael

P.S.: That git repo itself is a product of
hg-fast-export|git-fast-import, right?
