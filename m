From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Wed, 28 May 2008 11:12:30 +0200
Message-ID: <8aa486160805280212u742a311gef61676870af147@mail.gmail.com>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
	 <alpine.DEB.1.00.0805271151430.30431@racer>
	 <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
	 <alpine.DEB.1.00.0805271411520.30431@racer>
	 <7vwslfzd0i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 11:14:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Hj0-0008UW-0R
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 11:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYE1JMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 05:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbYE1JMq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 05:12:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:62013 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbYE1JMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 05:12:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1896403ywe.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=imk6V8ZLrtpU4wM7uHLXDm3B6a4FJUdDYI3SDxkR8W4=;
        b=XPtAGRHjkOdao85eTsRkrKMmAk8AiklqKZDUADzt6rSfJ3mYe2m93JN9UK8/sYlWHssaZluRgLzyvxaZZHSa81vQlj0b5hFkqKogX8/bYZGXQyHBxCdfQu+Js9ec4LHNBVs/NcVGGzia16fIZiFaTa76nTsfYKAhrZ3iy7wANxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eVwNDwuzlJmr6V7m53KfYkOnNpXqK8ctP4u+kg8TdTu4ucgOQqT0IKz+iyeUGYiQ9aGsCrBCRQPPNrtvnU6qlvxPiG25g2voZQ2zS4UQvSxUQsp1Ee2p/tM/6bbf6xRygzPOZOSD0EkJhfAn7PYfrks3zbn8YNu4CeauOvVK1I8=
Received: by 10.150.212.12 with SMTP id k12mr5863181ybg.228.1211965951056;
        Wed, 28 May 2008 02:12:31 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Wed, 28 May 2008 02:12:30 -0700 (PDT)
In-Reply-To: <7vwslfzd0i.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83081>

On Tue, May 27, 2008 at 10:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> But a problem I see with the patch as an implementation of "git-what" is
> that some commands use other commands as their internal implementation
> details.  For example, when you are in the middle of a "git rebase"
> session, which might be using "git am" as its internal implementation
> detail, if you ask the "are you in the middle of doing something, and if
> so how can I continue?" question (which is what the "git-cmd --what" is
> all about) to "git am", before you ask the same question to "git rebase",
> "am" could say "Yeah, I have applied a few patches successfully but gave
> control back to the user to resolve conflicts while applying this patch",
> which may be a truthful statement from "git am"'s point of view, but is
> not a useful information from the end user's point of view, as all s/he
> typed was "git rebase".  In addition, if Porcelain X uses Porcelain Y as
> its internal implementation, the series of commands that need to be
> followed to continue from a particular sequence point might be different
> between the case where the toplevel request was Y and the case where it
> was X.  Not just X needs to know that it uses Y, Y also needs to know that
> the toplevel command the end user gave could be X which called it and
> behave differently.  So a nice "each command knows what its doing"
> separation cannot really solve everything in practice.

This is the job of the git-what, so it first call "git rebase --what"
and then "git am --what", and the individual "git cmd --what" can be
declared internal.

>
> In other words, "git-X --what" could give a guidance to the "I've done X,
> now what can I do?" situation, but it by itself cannot be used as a basis
> of "git-what" to answer "I'm totally lost and I do not know what I was
> doing.  Where was I and what should I do next?"  question.

I think it does, it is exactly what my patch does, IMHO.

Santi
