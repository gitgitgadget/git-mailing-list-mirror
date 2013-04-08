From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 08 Apr 2013 09:48:13 +0200
Message-ID: <5162763D.5030708@web.de>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com> <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com> <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com> <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de> <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com> <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com> <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:02:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPK96-0002Am-BX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934340Ab3DHHsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 03:48:33 -0400
Received: from mout.web.de ([212.227.17.11]:56872 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab3DHHsc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 03:48:32 -0400
Received: from [192.168.178.41] ([91.3.157.185]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LmLac-1UxtOh1gn4-00ZFkI; Mon, 08 Apr 2013 09:48:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:MqxZ9m4ThjBuJZJnZzMZCN7kYWcFPZd7L0e//zjfbNa
 GADo4OL7u1MAzFCZSx1V6Z2xow2Qh7bmNtMZ+kK8Nx5dR6EgTo
 Tqr4pogIczJe2TfFiXENjbHvYGJjdQEGyM2cUf9ZFmntyO+UHE
 YIiZb8WDrpT6UZ/TjHvb9b0hlWXpgDQ1Hi4QWsFdmV6H/wtNqL
 cBUGNrgK5WJ0MrDxg4K+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220405>

Am 07.04.2013 23:30, schrieb Ramkumar Ramachandra:
> Jonathan Nieder wrote:
>> What's stopping the core object code of git parsing .gitmodules?

Just to clarify that: git core already does that. A "git grep
gitmodules_config" shows it is parsed by some git core commands:
checkout, commit, the diff family and fetch. Others will follow
in the recursive update series. And "git mv" support will teach
that command to manipulate the .gitmodules file (and I hope that
a patch teaching "git rm" to remove the section from .gitmodules
will be accepted in the near future).

> Nothing, except that it's perversely unnatural for object parsing code
> to parse something outside the object store.

Hmm, at least the unstaged .gitmodules file has to be parsed from
the file system. And Heiko's current work on parsing .gitmodules
directly from the object store will help here too, right?

>> How does this compare to other metadata
>> files like .gitattributes and .gitignore?
> 
> .gitignore and .gitattributes are parsed in dir.c, where git "treats"
> worktree paths.  It's quite nicely integrated.

And .gitmodules is parsed in submodule.c where Git treats
.gitmodules entries. So I don't see a problem here, what am I
missing?
