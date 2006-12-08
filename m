X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Light-weight checkouts via ".gitlink"
Date: Sat, 9 Dec 2006 00:40:17 +0100
Message-ID: <200612090040.17169.Josef.Weidendorfer@gmx.de>
References: <200612082252.31245.Josef.Weidendorfer@gmx.de> <200612082354.34488.Josef.Weidendorfer@gmx.de> <200612090024.17065.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 23:40:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612090024.17065.jnareb@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33769>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GspKN-0006r2-BJ for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761277AbWLHXkY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761279AbWLHXkY
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:40:24 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:36242 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1761277AbWLHXkW (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 18:40:22 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 5A1CA79C; Sat,  9
 Dec 2006 00:40:21 +0100 (MET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Saturday 09 December 2006 00:24, Jakub Narebski wrote:
> > That is not possible:
> > .gitignore file has its own meaning inside of the light-weight
> > checkout aka submodule, as this directory is the root directory of
> > a git checkout.
> 
> I have forgot about that. Right.
> 
> The only possibility would be to use GIT_DIR/info/excludes with path
> to submodule, and this conflict with the ability to rename and move
> submodules.

Yes. This whole .gitlink thing more or less is about trying to
avoid as far as possible any path configuration in the supermodule
which would have to be changed when the user moves or even deletes
the submodule. Exactly for the latter, we want the GITDIR for submodules
better be separate.

> >> GIT_DIR = path to base git repository
> >> it is equivalent to setting the following:
> >> 
> >> GIT_INDEX_FILE = path to index file
> >> GIT_OBJECT_DIRECTORY = path to object directory
> >> GIT_HEAD_FILE = path to HEAD file
> >> GIT_REFS_DIRECTORY = path to refs directory
> > 
> > AFAIK the latter two do not exist yet, or do they?
> 
> They do not exist; perhaps they should for completeness.

Actually, I am fine with allowing them in .gitlink. This makes
the whole thing much more flexible.

> [...] 
> > It is enough if GITDIR and NAME is given. With GITDIR_REAL after the
> > smart lookup, e.g. GIT_INDEX_FILE would default to $GITDIR_REAL/external/$NAME
> > and so on.
> 
> Not $GITDIR_REAL/submodules/<name>/index (or modules instead of
> submodules)?

Ooops, yes.
I am not actually sure what's the best name here: "external", "submodule", ... ?
I thought the the SVN name also fits for the submodule case. The submodule
is independent, and possibliy comes from an external git repository.

> >> NAME = name
> >> should match "name subdirectory" entry in modules file in superproject.
> > 
> > Yes.
> > This would be in my next proposal about how to build the submodule support
> > on light-checkouts ;-)
> 
> I have thought that with "each submodule as separate repository" approach
> to submodules the modules file would have module name and either
> subdirectory in which submodule resides, or GIT_DIR of submodule. And
> this file could be generated on checkout... which doesn't survive closer
> scrutiny.

Of course, that is a more simple approach. But I think the .gitlink thing
really is more flexible without being more complex.

> > Ah, yes, I see. Perhaps this makes sense with absolute paths:
> > 
> > 	/home/user/repos/.../linux
> 
> You mean that the above means to check the following paths:
> 
>   /home/user/repos/linux
>   /home/user/linux
>   /home/linux
>   /linux

No.

> not the searching subdirectories of /home/user/repos for linux
> directory (there can be many)?

Yes. But you can scratch this.

