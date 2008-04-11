From: Gabriel <g2p.code@gmail.com>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Fri, 11 Apr 2008 20:35:01 +0200
Message-ID: <20080411203501.7095b866@localhost>
References: <20080409101428.GA2637@elte.hu>
	<1207869946-17013-1-git-send-email-g2p.code@gmail.com>
	<alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 11 20:36:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkO6Z-0006Z6-J0
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 20:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760169AbYDKSfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 14:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760077AbYDKSfX
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 14:35:23 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:13459 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760045AbYDKSfW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 14:35:22 -0400
Received: by fk-out-0910.google.com with SMTP id 19so695034fkr.5
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:sender;
        bh=bJ0PN7RsCX2uDc2leRz3GOMSOAqUJbWHJ0wZ0hi+coY=;
        b=QK1LO9m5YfR3eCnusv6af4g8OtQwUxEHJOMsANZcZnVVuDbSkA/1uZ9HXpaUaD51JMcclAYTLoEj/9bQraKRNHIn2JfsrOk/L2jLMr1ao55rcWNIgd7d0xwqPUeDlIEBVGE3pzTWGg61z/DmF3BhhQxxYjKkYomYKGwfb0RIcQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:sender;
        b=GQeUDlVud2gBzSdi25kWO3ekOvBCAug2OgmKFk22dY+T/MaPF6rYOBZiJrn174AiCo/HekscsAT8w2Ngrvqoxc4YGOXMLoJDSHLb57jV3lIauEPaEz3zZgkOiBryyIEbaFf5TK827jhofFhfPcKH8Fj8pZCkj9y52QsQAB4kk+o=
Received: by 10.82.113.10 with SMTP id l10mr877789buc.55.1207938918334;
        Fri, 11 Apr 2008 11:35:18 -0700 (PDT)
Received: from localhost ( [88.162.203.35])
        by mx.google.com with ESMTPS id n10sm4400454mue.18.2008.04.11.11.35.13
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Apr 2008 11:35:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
X-Mailer: Claws Mail 2.10.0 (GTK+ 2.12.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79284>

Le Fri, 11 Apr 2008 16:21:45 +0100 (BST),
Johannes Schindelin <Johannes.Schindelin@gmx.de> a =C3=A9crit :

> Hi,
Hi

> On Fri, 11 Apr 2008, Gabriel wrote:
>=20
> > +	else {
> > +		printf ("Added remote repository `%s' without
> > fetching it.\n"
> > +			"Before accessing the branches of this "
> > +			"remote, run `git fetch %s' "
> > +			"or `git remote update'.\n", name, name);
>=20
> Is this really, really necessary?  I was quite happy when a few
> people made Git less chatty, recently.

Not necessary, but a real usability improvement.

I think the transcript that started the thread makes it clear that
having "git remote add" not fetching is not the right default.
The user wants to use a remote repository, and has learned these are
called "remotes". So he does not have too much trouble
finding/remembering the command "git remote add <name> <url>". Now with
the user's goal in mind, it makes no sense to add a remote and then not
fetch it, because the user definitely wants to do something with the
remote. By not fetching it, we are surprising the user (this is
apparent in the transcript), maybe we are making him go through some
documentation, and he will have to go through a mental
checklist "did I add the remote? yes. did I fetch it? yes" later on.

The best solution is a patch that makes --fetch default to yes for git
remote add and discuss that.

In case the remote wasn't fetched, adding some documentation at a place
where it _will_ be needed does no harm. This is not an operation as
frequent as git status or git checkout, so the three lines it takes in
a terminal aren't expensive. A more experienced user that usually runs
"git remote add -f", will not see it either.

--=20
Gabriel
