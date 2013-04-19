From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 19 Apr 2013 19:08:56 +0200
Message-ID: <51717A28.5040106@web.de>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com> <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com> <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com> <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de> <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com> <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com> <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com> <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com> <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com> <CALkWK0m9QmZaSDruY=+2F-Kkw+fd6E1TYC
 TBpVQHRJrzq2VjCQ@mail.gmail.com> <BCD944518C304D7D9809346DD899B68F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTEoP-0002EP-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab3DSRJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:09:12 -0400
Received: from mout.web.de ([212.227.17.11]:58490 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab3DSRJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:09:08 -0400
Received: from [192.168.178.41] ([91.3.191.33]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MJCAc-1UVycw2vc2-002pXE; Fri, 19 Apr 2013 19:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <BCD944518C304D7D9809346DD899B68F@PhilipOakley>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:GFSxGmYmGRkew1/bFCL3K7wPQcOcQMOBLoY0RQ4dXMT
 EnW6/RkkXq1JNPrKELiP4J1UnW1YWTiXfGWmUjSs7gJAGGr9J/
 f7HTMUi4Gl+SHCkpYdMVuR2gOIia7HzWn7x1b84xSG0FYgFaVq
 X41a2WEu6Q+GWzN/UjT4yqqVogQSz8+IMIAbTOpvHyo+gqMWCA
 HtEfKzX9hHbUNldH4cQRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221779>

Am 18.04.2013 01:17, schrieb Philip Oakley:
> Would it be possible to summarise the key points and proposals of where the subject is now?

Here you go, time to post our third iteration of the comparison
list, containing two updates:

- "easier coding" was removed from the advantages

- "git submodule foreach" was retired from the disadvantages

As in the two first versions, the issues in parentheses had been
brought up but were dismissed and are only kept for reference
together with the reason why they aren't relevant anymore. Only
those preceded by a '*' are still considered valid.


Advantages:

* Information is stored in one place, no need to lookup stuff in
  another file/blob.

* No need to cd-to-toplevel to change configuration in the
  .gitmodules file, the special tools to edit link information
  will work in any subdirectory.

(It is all but clear that this approach will lead to "easier
coding", some parts of the code - like rm and mv - will profit
from that while others won't, e.g. we have to implement the link
object manipulation tools that are not needed for .gitmodules
and we get another indirection retrieving the submodule commit
from the link object. And then there is the fact that the new
code would have to catch up with functionality already coded
using .gitmodules, like the status/diff ignore and the fetch
flags).

(We currently need a checked out work tree to access the
.gitmodules file, but there is ongoing work to read the
configuration directly from the database)

(While it is easier to merge the link object, a .gitmodules
aware merge driver would work just as well)


Disadvantages:

* Changes in user visible behavior, compatibility problems when
  Git versions are mixed.

* Special tools are needed to edit submodule information where
  currently a plain editor is sufficient and a standard format
  is used.

* merge conflicts are harder to resolve and require special git
  commands, solving them in .gitmodules is way more intuitive
  as users are already used to conflict markers.

* With .gitmodules we lose a central spot where configuration
  concerning many submodules can be stored

("git submodule foreach" becomes harder to implement" is not the
case, as that command currently also walks all tree objects and
does not read the list of submodules from the .gitmodules file)

(When we also put the submodule name in the link object we could
also retain the ability to repopulated moved submodules from
their old repo, which is found by that name)

(That a link object can have no unstaged counterpart that a file
easily has can be fixed by special casing this, e.g. in using a
file in .git/link-specs/)


As no new arguments have been brought up, it all boils down to a
change that'll hurt users badly and won't fix any issue relevant
to them. It'll bring them a flag day after which the .gitmodules
is gone and they'll have to learn new tools to update and merge
the submodule metadata (and not only the users, GUIs have to
follow and implement support for something which currently is a
perfectly normal merge conflict in a file). You'd have to smoke
really weird stuff to even consider such a change under these
circumstances (or you don't care one bit about your users).

> The submodules does need 'fixing', as does agreeing the problem and abuse cases.

Sure, but almost all problems I know about are work tree related,
so changing the internal representation buys us nothing here. It
will not magically do a bisect over submodules or will recursively
update submodule work trees, and all that stuff won't be easier to
code either just because we have to get the information from a new
object instead of a gitlink/.gitmodules combo.

Let's just close this case and get back to working on things that
users will actually profit from.
