From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree
	manipulation
Date: Mon, 7 Dec 2009 18:01:34 -0800
Message-ID: <20091208020134.GC17588@spearce.org>
References: <1260185254-1523-1-git-send-email-johan@herland.net> <1260185254-1523-2-git-send-email-johan@herland.net> <20091207164130.GD17173@spearce.org> <200912080244.30390.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 03:01:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHpOi-0004vf-R0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 03:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbZLHCBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 21:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935397AbZLHCBf
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 21:01:35 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:35673 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934933AbZLHCBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 21:01:30 -0500
Received: by ywh36 with SMTP id 36so4970256ywh.15
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 18:01:37 -0800 (PST)
Received: by 10.150.24.34 with SMTP id 34mr9732281ybx.239.1260237697000;
        Mon, 07 Dec 2009 18:01:37 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 9sm2241558ywe.56.2009.12.07.18.01.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 18:01:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200912080244.30390.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134803>

Johan Herland <johan@herland.net> wrote:
> > If we're here, isn't it likely that *all* notes are in the wrong
> > path in the tree, and we need to move them all to a new location?
> > If that's true then should we instead just build an entirely new
> > tree and swap the root when we are done?
> 
> Hmm. Not always. In your earlier scenario where we add 2,000,000 notes in a 
> single commit, the current code would need to rewrite 255 of them from 
> fanout 0 to fanout 2, and 65,535 of them from fanout 1 to fanout 2. But the 
> vast majority (1,934,465) would not require rewriting (having been added at 
> the correct fanout initially). However, if we build a new tree (by which I 
> assume you mean tree_content_remove() from the old tree and 
> tree_content_set() to the new tree for every single note (and non-note)), we 
> end up processing all 2,000,000 entries.

Well, by processing here you mean we wind up looking at them, only
to determine they are in the correct place already and skipping past.

I guess I see your point though.  We're fairly bounded on how many
we might need to move, probably only 65,535, and the rest will be
at the right position so we're mostly just iterating through to
confirm they don't have to be moved.
 
> I'm not sure I get the details here. How can we avoid doing the 
> _remove()/_set() from/to the old/new tree for every tree_entry? In other 
> words, how do we avoid removing and re-setting the 2,000,000 notes in the 
> above example?

You can't.  But I realize now what you are saying... for the vast
majority of the notes we only need to validate they are in the
correct path.

-- 
Shawn.
