From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Fri, 4 Sep 2009 11:40:20 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909041114440.28290@iabervon.org>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 17:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjatq-00017w-Gt
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 17:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847AbZIDPkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 11:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756671AbZIDPkU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 11:40:20 -0400
Received: from iabervon.org ([66.92.72.58]:55859 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631AbZIDPkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 11:40:19 -0400
Received: (qmail 27163 invoked by uid 1000); 4 Sep 2009 15:40:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 15:40:20 -0000
In-Reply-To: <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127737>

On Fri, 4 Sep 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Fri, Sep 4, 2009 at 04:13, Daniel Barkalow<barkalow@iabervon.org> wrote:
> > Instead of trying to make http://, https://, and ftp:// URLs
> > indicative of some sort of pattern of transport helper usage, make
> > them a special case which runs the "curl" helper, and leave the
> > mechanism by which arbitrary helpers will be chosen entirely to future
> > work.
> 
> I'm sorry, I missed a few emails I think :(. Would you mind explaining
> why we chose to special-case the curl helpers instead of the symlink
> scheme?

It turns out that the method used to form URLs that use a helper doesn't 
generalize well to other cases, because it interferes with the ssh-style 
locations. Instead, some different mechanism needs to be made up to handle 
arbitrary handlers that git doesn't know about. Since we want to keep 
supporting "http://something", that'll have to be a special case anyway, 
and so we might as well handle it by having git know what helpers to use 
for things that we've always supported, and use a single descriptive name 
for the helper that handles that collection of URLs.

As of this version, the idea is that there will be three ways helpers get 
selected:

 - git selects a helper based on the URL being something traditionally 
   supported internally; that is, git recognizes the URL and knows what to 
   run, if possible, to handle it

 - git uses the "vcs" option if it is set

 - something with the URL that we don't understand well enough yet to 
   design, but which doesn't seem to be possible to fit in as a single 
   rule with the first item.

	-Daniel
*This .sig left intentionally blank*
