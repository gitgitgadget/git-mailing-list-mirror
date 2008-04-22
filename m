From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 22 Apr 2008 16:55:11 +0200
Message-ID: <200804221655.11914.Josef.Weidendorfer@gmx.de>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <46dff0320804220659j66dea3fehc2a9bdcdc0371025@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 17:04:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoK1A-0000Pu-54
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 17:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764576AbYDVPB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 11:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764620AbYDVPB4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 11:01:56 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.12]:46400 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758459AbYDVPBz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 11:01:55 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Apr 2008 11:01:54 EDT
Received: from dhcp-3s-59.lrr.in.tum.de (unknown [131.159.35.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.in.tum.de (Postfix) with ESMTP id 490896969;
	Tue, 22 Apr 2008 16:55:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <46dff0320804220659j66dea3fehc2a9bdcdc0371025@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80127>

On Tuesday 22 April 2008, Ping Yin wrote:
> On Tue, Apr 22, 2008 at 6:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >  It does not help motivating me reviewing the series that the overall tone
> >  of it is to ignore .git/config more and make .gitmodules take more active
> >  role, either.  I have already said number of times why that is not a good
> >  idea and why it is against the overall submodule design.
> 
> I summarize junio's points that says $GIT_DIR/config is authoritative.
>
> [...]
> 
> Any others?

A reason you did not mention is security:
You never want your .git/config to be changed behind your back, which
effectivly is the case when using the versioned .gitmodules information
(similar problem as with a .gitconfig in-tree).

Another one:
From a design point of view, submodule URLs are project meta information
unrelated to source history. So, actually, I think it was wrong to put
submodule URLs (even hints only) into the versioned .gitmodules files (*).

The main reason for .gitmodules is to store submodule information which
has to be in sync with commits, such as a submodule name related to some
path where the submodule happens to be checked out in a given commit, and
also related to some config entry holding the URL to allow for fetch/pull.
The idea is that submodules have an identity in the supermodule (in contrast
to files in git), such that related configuration keeps valid when moving
submodules around. This needs simultanous adjusting the path attribute in
.gitmodules when a submodule is moved.

Josef

(*) IMHO, it would be far better if such project meta/policy information could
be in its own history (e.g. branch "gitconfig" to allow for easy propagation
at clone/fetch time). However, any such configuration should need
explicit interaction by the user to take over project config into the
local git config (e.g. via a "git config merge gitconfig:config" after
inspecting via "git show gitconfig:config").
