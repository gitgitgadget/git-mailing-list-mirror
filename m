From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] fast-import: add special '-' blob reference to use
	the previous one.
Date: Sun, 21 Dec 2008 14:33:35 -0800
Message-ID: <20081221223335.GF17355@spearce.org>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com> <1229825502-963-2-git-send-email-felipe.contreras@gmail.com> <20081221221149.GB17355@spearce.org> <7vlju9kvyg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWsw-00030r-DQ
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYLUWdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYLUWdg
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:33:36 -0500
Received: from george.spearce.org ([209.20.77.23]:51990 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbYLUWdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:33:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1AD4838200; Sun, 21 Dec 2008 22:33:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vlju9kvyg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103726>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Hmph, so if create a new path with a blob of "-" the repository
> > will be corrupt because the zero id was used and error was produced.
> >
> > Actually I think you have the same bug in the prior patch with the
> > mode being inherited.  I wonder if we shouldn't put error checking
> > in too to validate that versions[0] describes a file entry.
> 
> Why are these patches necessary?
> 
> The proposed commit message describes what it does, but does not give hint
> to even guess being able to use this new feature helps in what situation.
> As far as I can see, these changes allow the exporter to say "this aspect
> of the new data is the same as the previous one", but I thought that the
> way in which fast-import works already revolves around "you have this
> tree, and the next tree is different from it in this and that way."  Why
> does one need be able to mention "this is the same as the previous one"
> explicitly in the first place?

Hmm.  Actually, imagine you were dumping from git-diff output style
stream into a fast-import stream.

If a file changes only content, the mode is shown in the index line.
Yay us.  But what if the index line wasn't present in the diff? You
don't know the prior mode of the file, but you do have its content.

If a file changes only mode, we get no content hints in the diff.
How do you send that into fast-import without making the frontend
keep track of every path's current mode?

Though I agree, these details should be described in the commit
messages, not left as an exercise for the maintainer to make up.

-- 
Shawn.
