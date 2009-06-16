From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Tue, 16 Jun 2009 20:48:00 +0200
Message-ID: <200906162048.00849.markus.heidelberg@web.de>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de> <200906160153.28018.markus.heidelberg@web.de> <e5bfff550906152310m1dc92bf7vf73fdb8f925e2fb7@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 20:48:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGdht-0007he-5g
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 20:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761572AbZFPSry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757607AbZFPSry
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 14:47:54 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45997 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbZFPSrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 14:47:53 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2722D100313CB;
	Tue, 16 Jun 2009 20:47:55 +0200 (CEST)
Received: from [89.59.71.89] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MGdhK-0001Ik-00; Tue, 16 Jun 2009 20:47:54 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e5bfff550906152310m1dc92bf7vf73fdb8f925e2fb7@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/eAMqG10WAz9m5UYm+7LWwJlX1SjD4gEM2V6Fo
	U2kmwWGitU7nSXhWh3oVqzLN+rcE3RQa3slq3uP/B4ItbtVY65
	Kzke3fk8zjky/43x3Ueg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121701>

Marco Costalba, 16.06.2009:
> On Tue, Jun 16, 2009 at 00:53, Markus
> Heidelberg<markus.heidelberg@web.de> wrote:
> >
> > Yes, it works. Thanks. Would it make sense and be possible to fix it
> > directly in ListView::getSelectedItems()?
> 
> Another reason is that is Git::formatPatch() that needs the rows to be
> ordered, so has a sense to do it there where is needed.

ListView::mouseMoveEvent() needs it as well, I just tested
cherry-picking revisions per drag-and-drop and it was applied in the
wrong order.

I have never used stgit, but isn't MainImpl::ActPush_activated() and
MainImpl::ActPop_activated() affected in the same way?

> Of corse if
> other places of QGit requires that the rows returned by
> ListView::getSelectedItems() should be ordered then we can move the
> ordering in ListView::getSelectedItems() as you suggest, or, even
> better, move the ordering in ListView::getSelectedItems() but from
> there call a new helper function Git::sortShaByIndex() that does the
> work and is defined in git.cpp because should use internal information
> like the index and call directly the sha database.
> 
> Yes, a possible cleanup / reformat job could be to:
> 
> - Add a new public helper function Git::sortShaByIndex() defined in git.cpp
> 
> - Call from ListView::getSelectedItems() when we get the list of sha
> user as select
> 
> - Document ListView::getSelectedItems() always returns a list of ordered sha's

I guess this is the right solution.

> > BTW, a nice way to see the created git-format-patch command without
> > modifying the sources is to use a directory with spaces, which is not
> > handled correctly by qgit.
> >
> 
> 
> ????
> 
> I cannot test now, but this seems a bug.

I was not clear enough, but yes, it's a bug - with a usable side effect :)

Markus
