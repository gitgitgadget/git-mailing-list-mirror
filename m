From: David Kastrup <dak@gnu.org>
Subject: Re: Can someone explain this git-blame/git-rev behavior to me?
Date: Mon, 16 Jul 2007 18:38:56 +0200
Message-ID: <867ip05mn3.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 18:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IATbP-00082L-90
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 18:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192AbXGPQjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 12:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759598AbXGPQjL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 12:39:11 -0400
Received: from main.gmane.org ([80.91.229.2]:36369 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066AbXGPQjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 12:39:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IATbG-0003LL-AR
	for git@vger.kernel.org; Mon, 16 Jul 2007 18:39:06 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 18:39:06 +0200
Received: from J.Sixt by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 18:39:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:IQ7KCzIcDz+uyzdrfQeReu98CFU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52686>

--=-=-=


Oops, I accidentally sent the following mail in private.  So I have to
forward back to the list (don't have the original):


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

Message-ID: <469B9843.835B5356@eudaptics.com>
Date: Mon, 16 Jul 2007 18:09:39 +0200
From: Johannes Sixt <J.Sixt@eudaptics.com>
To: David Kastrup <dak@gnu.org>
Subject: Re: Can someone explain this git-blame/git-rev behavior to me?
References: <86sl7oaasx.fsf@lola.quinscape.zz>
		<469B71A5.D5299A80@eudaptics.com> <86ps2s736g.fsf@lola.quinscape.zz>
MIME-Version: 1.0

David Kastrup wrote:
> 
> Johannes Sixt <J.Sixt@eudaptics.com> writes:
> 
> > David Kastrup wrote:
> 
> >> [nonsense not really related to the problem he has been seeing]
> 
> > [Johannes replied with a reasonable analysis]
> 
> Ok, scratch that.  I got completely confused.  Here is the gist of the
> problem that kicked me, this time boiled down to the actually relevant
> part:
> 
> I am looking for a descendant of tags/v1.4.4-rc1~72 with regard to
> contrib/emacs/vc-git.el by scanning the output of the first command
> in the following pipeline:
> 
> git-rev-list --parents HEAD ^tags/v1.4.4-rc1~72 -- vc-git.el|git-name-rev --stdin|fgrep tags/v1.4.4-rc1
> 
> This gives:
> 4de0f9f9b6ed1731de00b67952504e5a783f54a4 (tags/v1.5.0-rc0~31) 1259404c7e5cd88b7f6692986469cd20cbfacdad (tags/v1.4.4-rc1~71)
> 1259404c7e5cd88b7f6692986469cd20cbfacdad (tags/v1.4.4-rc1~71) b4aee09e610567529dc619d7324dc2fe85a11db5 (tags/v1.4.4-rc1~72) 0abc0260fa3419de649fcc1444e3d256a17ca6c7 (tags/v1.4.3.2~6)
> 
> And this looks like it would tell us that tags/v1.4.4-rc1~72 has with
> regard to vc-git.el a child tags/v1.4.4-rc1~71 and a grandchild of
> tags/v1.5.0-rc0~31.
> 
> Now if I instead do
> git-rev-list --parents HEAD -- vc-git.el|git-name-rev --stdin|fgrep tags/v1.4.4-rc1
> 
> 4de0f9f9b6ed1731de00b67952504e5a783f54a4 (tags/v1.5.0-rc0~31) b4aee09e610567529dc619d7324dc2fe85a11db5 (tags/v1.4.4-rc1~72)
> b4aee09e610567529dc619d7324dc2fe85a11db5 (tags/v1.4.4-rc1~72) 474a90fef9ebcdedee041b2def4b9a98b94cd146 (tags/v1.4.3.2~8)
> 
> I get to see that the child of tags/v1.4.4-rc1~72 is actually
> tags/v1.5.0-rc0~31, skipping tags/v1.4.4-rc1~71 which presumably did
> not change vc-git.el.
> 
> So the ^tags/v1.4.4-rc1~72 specification caused an additional mention
> of tags/v1.4.4-rc1~71 even though, with regard to vc-git.el, it would
> be equivalent to tags/v1.4.4-rc1~72.
> 
> So is there a way I can get the information of the second call without
> the performance loss of going through the entire history?

You better send the question again, this time to the list. I'm certainly
not the one who can answer this or even solve it.

It seems that there is an unwanted interaction between --parents and
history simplification at the edge commits. I don't think that there
will be an easy solution.

-- Hannes


--=-=-=



So anybody has an idea how to go about this?

-- 
David Kastrup

--=-=-=--
