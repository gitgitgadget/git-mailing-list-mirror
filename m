From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH v2 1/2] convert: fix normalization of foreign idents
Date: Mon, 13 Sep 2010 00:06:39 +0200
Message-ID: <yf9d3siiplc.fsf@chiyo.mc.pp.se>
References: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
	<E1Ot4NP-0002xn-Nc@chiyo.mc.pp.se>
	<7vmxrqjvf6.fsf@alter.siamese.dyndns.org>
	<yf9hbhuisla.fsf@chiyo.mc.pp.se>
	<7vd3sid4bo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 00:07:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuuhU-0000L0-Cx
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 00:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab0ILWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 18:06:43 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:59885 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab0ILWGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 18:06:43 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 1BF9AD265;
	Mon, 13 Sep 2010 00:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1284329201; bh=tppuroBAzxMMrZA92WVXCaUOQ4QdzBTJHIXuwroAP9A=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m/m1zn9EC8rJ6EXsLin3kgg2dSO7SrcwsAWiP
	AxPsffjsxLYJqXi7rDudRnEbtabaIOG1Td6qxTZpWk4pxlP0lnQL5GxOG3+mtGsMt1d
	/FrY+dgitwEZWweJ815YOiwYKL0TmymE8VijLq+t2+leAXxOVWPB9T/C/jAXO3VmURA
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Ouuh5-0004V4-Bv; Mon, 13 Sep 2010 00:06:39 +0200
In-Reply-To: <7vd3sid4bo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun, 12 Sep 2010 14:44:59 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156060>


Junio C Hamano <gitster@pobox.com> writes:

> Imagine there isn't any "$Id$" (or "$ident$" as it was originally known)
> expansion in git.  You can implement it easily using a smudge/clean pair,

Sorry, but here I have to go off a little at a tangent.  Yes, you
could implement the ident-expansion currently provided by git as a
smudge/clean pair.  However, you could not implement an ident which
actually puts something more useful (such as the id of the commit
where the file was last modified) into the id string by using
smudge/clean.  I know, because I tried to do just that.  ;-)
The reason:  smudge/clean do not get the pathname, so they are not
able to query any information about the file from the repository.
I might submit a patch adressing this issue later.


> and the smudge and clean should be conditionally applied in the codepath
> you touched using exactly the same logic as your patch uses, no?
>
> That is what I meant.  It smells wrong to make this "sometime we do,
> sometimes we don't" as a special case for "$Id$".  Specifically, the
> parameter name "normalize_foreign_ident" feels wrong; the concept that the
> parameter tries to convey covers much wider than just "foreign ident", no?

Ok, I think I follow where you are going.  _If_ we say that clean
(and smudge?) should be able to run in different "modes", with
cleaning for a commit being such an mode, then this ought to be
triggered by the same parameter, yes.  The parameter name describes
what the parameter does now, but not necessarily what it would do in a
possible future where such new concepts as modal clean scripts have
been introduced.

Generally, I'm kind of wondering if the parameters of convert_to_git
wouldn't be better off just specifying a mode (like the, perhaps also
slightly mis-named, write_object paremeter to index_mem) rather than
trying to micro-manage specific features like they have before.  Was
that what you had in mind?


  // Marcus
