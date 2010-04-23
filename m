From: Jonathan Nieder <jrnieder@gmail.com>
Subject: The index (Re: Please default to 'commit -a' when no changes were
 added)
Date: Fri, 23 Apr 2010 05:39:19 -0500
Message-ID: <20100423103919.GA19811@progeny.tock>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <20100422155806.GC4801@progeny.tock>
 <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
 <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
 <20100422222723.GB12000@progeny.tock>
 <87iq7ittq6.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Brewster <adambrewster@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Tor Arntsen <tor@spacetec.no>,
	Tomas Carnecky <tom@dbservice.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 12:41:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5GKC-0003ku-1V
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 12:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab0DWKjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 06:39:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49372 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab0DWKjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 06:39:13 -0400
Received: by gwj19 with SMTP id 19so2660462gwj.19
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zJ/GF/KgHOE3AlEdnEjBYgWV/RJ4bgIcmTtTtpGnTTg=;
        b=hfYqIBq8Ho8Hww+xHFnGp/vuoqVGO7nvxb6HXvCfK0R+jj80y6EMZI7noRm84Kmwuh
         kdlaoulFuWCj2cGSz5YEk2hgQWu4jBuKf8hCpzc0Rl7FXxE7VNLH8xON/oCn2q0LMwvc
         F3yEXcX9dAYDzUNQ9R73suFq0w8nJX6tZnAvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OPzKJGKZBHsGBvoR6bq6rS+sF0SwZVkAfeRxb5UPUqN/jrsqgr4oNHep8Ee5lA4DLF
         j7lfWICepzg9KHbEoY9IMfjHFz7klsLkameRJEt/SnLIAFWv9Nq25as0WHIUGWu3k8PL
         B/jNNf/cARq7hdHXNZIAXOX9wO7VLAqO7t8IM=
Received: by 10.101.207.34 with SMTP id j34mr1444135anq.74.1272019145083;
        Fri, 23 Apr 2010 03:39:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm662588iwn.13.2010.04.23.03.39.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Apr 2010 03:39:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87iq7ittq6.fsf@frosties.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145608>

Goswin von Brederlow wrote:

> Other RCS use an index of files they track. Git uses an index of patc=
h
> chunks to commit. Same name, totaly different concept.

What you say is correct in terms of how some people use the tools.
But underneath, the index is a cache that tracks the content of all
files.  To make the index not match the work tree is to deliberately
let it go stale (or to cheat and poison it, or whatever).

I am making an assumption about other version control systems and it
is probably wrong for some.  Here is the logic: suppose I

 1. Make some changes to files.
 2. Invoke =E2=80=9Cvcs commit=E2=80=9D
 3. Pull out the power plug.

What happens?  If the version control system is sane, then either the
entire commit takes place or nothing visible happens; because
otherwise, the result is that I screwed everyone over.  The easiest
way to implement this is to make =E2=80=9Cvcs commit=E2=80=9D two steps=
:

 1. Prepare the proposed changes in a staging area.
 2. Atomically commit them.

Traditionally, =E2=80=9Catomically=E2=80=9D means =E2=80=9Cwith a lock,=
 on the remote server
which has a steady power supply=E2=80=9D.

In particular, the index I am talking about tends to be on the _remote_
machine.  Making it local leads to a lot of improvements.

Early in the design of git=E2=80=99s user interface, it took some time =
to
figure out how visible to make the index [1].  Personally I am happier
with the modern approach of letting people dirty the index if they
want to, but if you believe that is wrong, maybe you would like to
look at the Cogito scripts for inspiration [2].  There are still many
lessons to learn from them, I suspect.  More importantly, it might be
fun or interesting.

Hopefully that is a little clearer.
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/780/focus=3D=
918
As you can see, cogito, the most widely used front-end in early
history, did hide the index from the user.
[2] http://git.or.cz/cogito/
(warning: they have not been maintained for a while)
