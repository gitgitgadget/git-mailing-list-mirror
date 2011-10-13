From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 11:28:46 -0700
Message-ID: <7vzkh44ug1.fsf@alter.siamese.dyndns.org>
References: <loom.20111013T094053-111@post.gmane.org>
 <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
 <20111013145924.2113c142@ashu.dyn.rarus.ru>
 <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
 <loom.20111013T152144-60@post.gmane.org>
 <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
 <loom.20111013T171530-970@post.gmane.org>
 <1318525486.4646.53.camel@centaur.lab.cmartin.tk>
 <loom.20111013T193054-868@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:28:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQ1X-0001nv-7e
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893Ab1JMS2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:28:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755854Ab1JMS2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:28:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 603584F41;
	Thu, 13 Oct 2011 14:28:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YqkIzYuOYeXidIoe8rQk39kelyg=; b=ACj2jx
	l7CSKTl2asir7VfxtPfvjMEobkgpX8//m82QRJTmc3g5WonwbngYk3+1cxjktrC4
	akGoHNjUmUPRu+fmMQ5/Ep5Pl3H/gYxsx4ElADsu4i/vE5n46u38kFvTz+KT659S
	GQfstyMWLxFo5gNdC7FTIKX1SdLneV755Mmz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BUpJYnPwqqgydhYcdNtTnXD7Gr1hc05b
	Iz4ePPw8HIDqR2IG7wO/io3gepsqED8JlmGKAFG7Sy56xiY8R1Zn9Ld2CxjVR0z/
	wW4Ml2ELEPMd3dTPK3GRNon3xUjbkt3DDbL6NOcxvy5GJvxWLxHiRmmgWRflRzoH
	2Lv+pH6Qvp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5739C4F40;
	Thu, 13 Oct 2011 14:28:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E05CC4F3E; Thu, 13 Oct 2011
 14:28:47 -0400 (EDT)
In-Reply-To: <loom.20111013T193054-868@post.gmane.org> (arqon@gmx.com's
 message of "Thu, 13 Oct 2011 18:19:26 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30EEB430-F5C9-11E0-B86E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183506>

arQon <arqon@gmx.com> writes:

> ..., in the absence of either of those flags, git
> WILL preserve the worktree by refusing to switch until that potentially-
> harmful situation is resolved by the user.

Perhaps you can prepare a documentation patch to make it clear that git
WILL preserve the LOCAL CHANGES to the working tree?

As it would already be clear to anybody reading this thread so far, local
changes made to the working tree do not belong to any particular branch.
They are floating on top, and it is up to the user what to do with these
floating changes when they conflict with the differences between the
branches you are switching across (i.e. you cannot switch so you need to
clean up by either committing, stashing, or deciding not to switch and
instead complete the work before you switch), and when they do not
conflict with the differences between the branches you are switching
across (i.e. you will carry them to the new working tree. It may be that
you made these changes and then realized that they do not belong to the
goal the current branch aims to achieve and that is why you decided to
switch to another branch, in which case you do not have to do anything
special in order to continue to work and complete it to commit to the
switched branch. It may be that you made these changes but needed to tend
to unrelated business on an unrelated branch and that is why you switched,
in which case you would want to clear them away, which is exactly what
stash was invented for).
