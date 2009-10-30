From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 02/19] Allow fetch to modify refs
Date: Fri, 30 Oct 2009 11:16:48 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910301110120.14365@iabervon.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>  <1256839287-19016-3-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300151450.14365@iabervon.org> <fabb9a1e0910300522je3d76aep160d87fe302f8779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-957073245-1256915808=:14365"
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 16:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3tET-0003bP-8l
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 16:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbZJ3PQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 11:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbZJ3PQq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 11:16:46 -0400
Received: from iabervon.org ([66.92.72.58]:40748 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932417AbZJ3PQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 11:16:44 -0400
Received: (qmail 3064 invoked by uid 1000); 30 Oct 2009 15:16:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2009 15:16:48 -0000
In-Reply-To: <fabb9a1e0910300522je3d76aep160d87fe302f8779@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131709>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-957073245-1256915808=:14365
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Fri, 30 Oct 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Thu, Oct 29, 2009 at 22:56, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >> +++ b/builtin-clone.c
> >> @@ -526,8 +526,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >>
> >>               refs = transport_get_remote_refs(transport);
> >>               if (refs) {
> >> -                     mapped_refs = wanted_peer_refs(refs, refspec);
> >> -                     transport_fetch_refs(transport, mapped_refs);
> >> +                     struct ref *ref_cpy = wanted_peer_refs(refs, refspec);
> >> +                     mapped_refs = ref_cpy;
> >> +                     transport_fetch_refs(transport, ref_cpy);
> >
> > Just drop this hunk; the change doesn't actually do anything. Otherwise,
> > the patch matches what I have.
> 
> Am I missing something? I thought we need this hunk since mapped_refs
> is const, and transport_fetch_refs takes a non-const argument?
> 
> builtin-clone.c: In function ‘cmd_clone’:
> builtin-clone.c:531: warning: passing argument 2 of
> ‘transport_fetch_refs’ discards qualifiers from pointer target type

Ah, actually, mapped_refs should just be made non-const; unlike "refs", 
it's set from wanted_peer_refs(), which returns a non-const value.

	-Daniel
*This .sig left intentionally blank*
--1547844168-957073245-1256915808=:14365--
