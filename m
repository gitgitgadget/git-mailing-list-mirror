From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv8 08/10] fast-import: Proper notes tree
	manipulation using the notes API
Date: Thu, 26 Nov 2009 11:33:23 -0800
Message-ID: <20091126193323.GU11919@spearce.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net> <1258681154-2167-9-git-send-email-johan@herland.net> <20091126024655.GR11919@spearce.org> <200911261210.48138.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 20:33:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDk5q-0007Pp-3M
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbZKZTdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbZKZTdR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:33:17 -0500
Received: from george.spearce.org ([209.20.77.23]:51052 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbZKZTdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:33:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 711FB3842F; Thu, 26 Nov 2009 19:33:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200911261210.48138.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133825>

Johan Herland <johan@herland.net> wrote:
> BTW, while we're on the topic, this whole code is only present because I 
> assume it's not possible to edit the fast-import tree structure _while_ 
> traversing it. Is this assumption correct, or are there ways to get 
> around maintaining a separate edit list that is applied to the tree 
> structure afterwards?

IIRC you can actually edit the tree while you are walking through it.
You just have to watch out for the fact that a struct tree_content
can be reallocated (and thus moved in memory) if the entry_capacity
was too small for the new entry_count when inserting a new entry.

tree_content_set() handles this in its API by taking a struct
tree_entry* rather than a struct tree_content*.  This way if the
tree has to expand during the set and gets reallocated we can return
the new tree pointer to the caller through the struct tree_entry
tree field.

-- 
Shawn.
