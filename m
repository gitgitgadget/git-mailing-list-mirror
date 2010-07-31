From: Elijah Newren <newren@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Sat, 31 Jul 2010 16:36:10 -0600
Message-ID: <AANLkTin4XbVzwj7M86uTvXxJ_qEfzoyNrJgf3U8u=WdH@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
	<AANLkTi=8u5VROYQygAXoCS4c+eAoEoP8V4t5rJ=wXL8q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 00:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfKfC-0000gM-Bs
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 00:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab0GaWgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 18:36:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40591 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab0GaWgM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 18:36:12 -0400
Received: by wwj40 with SMTP id 40so2692522wwj.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LJSXue17aLnBMmvbgf73aGk8Vv86rCgRFwGKG2ZmGzc=;
        b=wZgESxkxO6J0xTvtHwpjRCAnO4Z5as9VZWGFyqZOlgyiD/Eq3UJqavhmuN4ZX5qhg2
         ZbZAMrbcow5LwuJBzajFV4//C56Pa1a2soUqN//3WQDhkXkEk7k5fYW33WA4wjszgrXv
         pgyKVDURJ6Bojlq77CVFgD2PMTz/WT4ac5uG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tmMaP8nlxkKAKgDwcInikFR7UmyIZtRTnI24eTPGLbSvJ+9axnXYnua2d6byBnogjs
         eK37jJRpyJnK5cuL7ABgGhLmwLVG10bSfPKNx9ngSTFD0399tLpZM+baEWwJLIsBEe7v
         Ve6lCp2qZoswFa1IUWl6a4pn5YNf+rjSArLk0=
Received: by 10.216.3.83 with SMTP id 61mr1130667weg.110.1280615771062; Sat, 
	31 Jul 2010 15:36:11 -0700 (PDT)
Received: by 10.216.132.8 with HTTP; Sat, 31 Jul 2010 15:36:10 -0700 (PDT)
In-Reply-To: <AANLkTi=8u5VROYQygAXoCS4c+eAoEoP8V4t5rJ=wXL8q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152343>

Hi,

2010/7/27 Elijah Newren <newren@gmail.com>:
> 2010/7/27 Avery Pennarun <apenwarr@gmail.com>:
>> Note that if you happen to want to implement it in a way that you'll
>> also get all the commit objects from your submodules too (which I
>> highly encourage :)) then downloading the trees is the easiest way.
>> Otherwise you won't know which submodule commits you need.
>
> Makes sense. =C2=A0Seems like a good reason to include all the trees.

Actually, having thought about it more, I don't see the reason for
getting all the commit objects from submodules (unless those
submodules are at paths specified for download).  If a user has
specified that they just want the Documentation subdirectory, why
would it matter if the submodule under src/widgets was downloaded?
They don't want to do anything with any of its contents, so I don't
see why they'd needs its trees or commits.  Am I missing something?


Also, I'm rethinking the download-all-commits aspect too.  This is
partially due to Nguy=E1=BB=85n's stats (and special usecases like
translators), partially because of security issues (it has already
been stated that only including stuff meant to be public is an
important security concern for clone[1], and commit logs for changes
completely outside specified paths might be considered non-public
data[2]), and partially because it reinforces my whole rev-list
limiting args idea (it makes it really clear that 'git log' should
automatically behave like 'git log -- Documentation/' in a sparse
clone of just Documentation/).

[1] e.g. http://article.gmane.org/gmane.comp.version-control.git/115835

[2] This isn't just theoretical either.  I have a couple big important
(to $dayjob and thus me) sparse-clone usecases in this situation and
have for a few years, but gave up on it thinking it wouldn't be
possible with sparse clones.  I instead wrote a fast filtering
mechanism using fast-export/fast-import that creates a new repository
and keeps track of the mapping between sha1sums in unfiltered and
filtered repos, allowing changes to be grafted between the two.  Kind
of a pain, and suboptimal for a few reasons.  It'd be really nice if I
could replace this stuff with sparse clones, but can't do that if
commit logs corresponding to changes completely outside the sparse
paths are included.
