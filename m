From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Thu, 18 Aug 2005 02:30:36 +0200
Message-ID: <20050818003036.C53FD353BF9@atlas.denx.de>
References: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 02:32:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5YJR-00019A-Gr
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 02:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVHRAbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 20:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVHRAbE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 20:31:04 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:14289 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751397AbVHRAbC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 20:31:02 -0400
Received: from fwd31.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1E5YJ0-0007dZ-00; Thu, 18 Aug 2005 02:30:50 +0200
Received: from denx.de (rPdSsmZHQeXIMmPMfWi-SIkHD2-CFBxKMdblQfbu46nDPPnZLoVI0i@[84.150.124.164]) by fwd31.sul.t-online.de
	with esmtp id 1E5YIo-1vOndQ0; Thu, 18 Aug 2005 02:30:38 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 25E2D42DE1; Thu, 18 Aug 2005 02:30:37 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id C53FD353BF9;
	Thu, 18 Aug 2005 02:30:36 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Sat, 30 Jul 2005 01:00:34 PDT."
             <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net> 
X-ID: rPdSsmZHQeXIMmPMfWi-SIkHD2-CFBxKMdblQfbu46nDPPnZLoVI0i@t-dialin.net
X-TOI-MSGID: 10089715-eeaf-497a-94be-97175ce16558
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net> you wrote:
> Introduce a new file $GIT_DIR/info/grafts (or $GIT_GRAFT_FILE)
> which is a list of "fake commit parent records".  Each line of
> this file is a commit ID, followed by parent commit IDs, all
> 40-byte hex SHA1 separated by a single SP in between.  The
> records override the parent information we would normally read
> from the commit objects, allowing both adding "fake" parents
> (i.e. grafting), and pretending as if a commit is not a child of
> some of its real parents (i.e. cauterizing).

How exactly is this used?

I gave up trying to have CVS  merges  autimatically  recognized  upon
import, and tried to follow Matthias Urlichs' advice to fake it using
the grafts file.

I have this situation:

Branch point (actually this is the inital import into CVS):

Commit:	0b666f81da14bf46cada222856762f7fd6641c26
Child:  9956b03b956994bb4e2cee4161f3626bcfd71924 (Das U-Boot: Universal Boot Loader)
Child:  7309612797ed5e6b3b20027e28bca970b4f6b8fd (Initial revision)


End of branch to merge (in CVS 1.1.1.1):

Commit:	d9af3c87df93e1a8126b1a52adf8db978e9a0d40
Parent: 0bb9c6d97b195bd0efcdda02f109e6d1519074a9 (Das U-Boot: Universal Boot Loader)
<no child>


This is the commit where I would like to show the  branch  merged  in
(before; this is the first real commit in CVS):

Commit:	24ee89b97a49826ea800b4a6c0d5c0769328e317
Parent: de180e6daa529dc78668c99bdf17a9cdd440782d (Initial revision)
Child:  699b13a6064e642280caffaa83c10b359a6c1114 (* Fix mdelay() on TRAB - this was still the debugging version with)


I tried with a grafts file like this:

24ee89b97a49826ea800b4a6c0d5c0769328e317 de180e6daa529dc78668c99bdf17a9cdd440782d d9af3c87df93e1a8126b1a52adf8db978e9a0d40


The display in gitk --all gets changed a bit (before the  branch  was
the  leftmost  line,  now  it's  the rightmost one), but it's still a
dangling head, and the selected  "merge  point"  (commit  24ee89)  is
still  displayed  with  just  one parent (de180e) - I would expect to
also see d9af3c listed as parent, and the branch merging in here?

Am I missing something?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Programmer's Lament: (Shakespeare, Macbeth, Act I, Scene vii)
        "That we but teach bloody instructions,
        which, being taught, return to plague the inventor..."
