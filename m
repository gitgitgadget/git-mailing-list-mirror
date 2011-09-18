From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Branch deletion (Re: [RFC] fast-import: note deletion command)
Date: Sun, 18 Sep 2011 23:55:29 +0200
Message-ID: <CAGdFq_gCVBi1JOsyM=+SVU6HFew_7yaJWaZ-3=AnmDeRkBxntQ@mail.gmail.com>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
 <20110918203506.GG2308@elie> <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
 <20110918211836.GI2308@elie> <CAGdFq_gH=u1BU6k3Z23Lo9mOSE4Rq-6nWU0EE91CQNpxksGw5w@mail.gmail.com>
 <20110918214954.GL2308@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:56:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5PLW-0007Gs-CH
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761Ab1IRV4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 17:56:10 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55357 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab1IRV4J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 17:56:09 -0400
Received: by pzk1 with SMTP id 1so8982791pzk.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k24NOMO/voKBFHE6+3ZzM5jkBZm06cnwJ1njT15qbno=;
        b=tJUtq1UF/fF4nezyML6LEs1ghW3PXKYFzVC76gOD7wSjOMw+YwKaPuJFxmuFU4si8D
         yuYoWtMu+kyjODXWNyK1f7ZxnElBYT7Adz2574t2javK2cO3eIVyv+AUYhWUjIVEqa0S
         rkxaI6WuARTmYVWB+LRXNZNMZAJWQaGqdCnfU=
Received: by 10.68.14.163 with SMTP id q3mr3091224pbc.98.1316382969108; Sun,
 18 Sep 2011 14:56:09 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sun, 18 Sep 2011 14:55:29 -0700 (PDT)
In-Reply-To: <20110918214954.GL2308@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181653>

Heya,

On Sun, Sep 18, 2011 at 23:49, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> By the way, what does the "export" command do in the following
> situation?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git push origin something-big:master
>
> Does it assume the remote-tracking branch for master reflects what's
> available on the other end and send a stream for
> origin/master..something-big, or does it send the entire history of
> something-big?

We have a test case for this actually. It goes like this:

checking known breakage:
	(cd clone &&
	 git push origin new-name:new-refspec
	) &&
	compare_refs clone HEAD server refs/heads/new-refspec

Everything up-to-date
fatal: Needed a single revision
not ok 16 - push new branch with old:new refspec # TODO known breakage


In other words, we don't handle it at all. What we do handle a case
similar to what you say, where we have already pushed part of the
history of some-branch, and in that case we do indeed only push the
needed objects.

--=20
Cheers,

Sverre Rabbelier
