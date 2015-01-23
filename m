From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: git index containing tree extension for unknown path
Date: Fri, 23 Jan 2015 07:23:45 +0100
Message-ID: <CAENte7jr6mjz_xCuWpYKW7VzNcYhqEi5Nf_8JdDtyM46pVnfDg@mail.gmail.com>
References: <CAENte7gqKpqr=ENOEN_3s3Fz6gc-Kt70OJyZojbgwhR7YVX6Zg@mail.gmail.com>
 <xmqqr3unx40n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:24:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEXfC-0000O2-0A
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 07:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbbAWGYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 01:24:09 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:65205 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbAWGYI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 01:24:08 -0500
Received: by mail-wi0-f169.google.com with SMTP id bs8so951707wib.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 22:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qE9NxNHgDlUVYp5ibYNjBzQ3Hn4qgfNQ7iATPb2fDyI=;
        b=Ob2gvNYZJxxE0nMl9vVE9b2LCBtpIPzspaP7abzGqzHgNE0DyXvEcen3tvyi6sbeqN
         GfANGUxd0EQL9kpJ2iA96ZGwGf5/YV0yM7lmGw6ZRfAl8RYgRoHL0u1wK5flpdCTbQTB
         kktqOpmh7a/g37+R8y6yi3iR0viDmcIqIkY6y9ZBJCdRLxvF6CXz3i6LM9sx8IlIZXzw
         /Oj1KLJKQK+qrveHl8q/shO1/yJTXCctRpmk/oYTLPp8v6ujvmSM1h3ntpbFWfJ3tfOH
         LCVJf3NgAFgM1I1oJVlSIivKjHuue44UbCxomdUoGNNUiGUY8DF/PU3CZf1+8iu3ADYs
         OntQ==
X-Received: by 10.180.98.3 with SMTP id ee3mr505454wib.12.1421994246038; Thu,
 22 Jan 2015 22:24:06 -0800 (PST)
Received: by 10.27.148.3 with HTTP; Thu, 22 Jan 2015 22:23:45 -0800 (PST)
In-Reply-To: <xmqqr3unx40n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262902>

Thanks for the explanation. In my case it seems we have an invalid
index. I modified the gin script [1] to inspect the index and found
valid cached trees in the index for pathes for which the index has no
entries. Will try to find out who/how the index was corrupted.

[1] https://raw.githubusercontent.com/chalstrick/gin/master/gin

Output of the script

> gin.py
[header]
  signature = DIRC
  version = 2
  entries = 1

[entry]
  entry = 1
  ctime = 1421834321.9923096
  mtime = 1420815554.0
  dev = 2049
  ino = 658461
  mode = 100644
  uid = 1000
  gid = 1000
  size = 42
  sha1 = 6c6909e2b92e763e890a9a42695680762802a50a
  flags = 14
  assume-valid = False
  extended = False
  stage = (False, False)
  name = .gitattributes

[extension]
  extension = 1
  signature = TREE
  size = 103

[cachedTree]
  name =
  entryCnt = 2
  subtreeCnt = 1
  id = f59374e16868ce8385b4ee602c737f917da4af1b

[cachedTree]
  name = a
  entryCnt = 1
  subtreeCnt = 1
  id = 4b5e60c30485a91ee60bd869ecc3b4d2b892fc3f

[cachedTree]
  name = b
  entryCnt = 1
  subtreeCnt = 1
  id = 50bd519cc418878d4b0ffc27348afd710c188d6d

[cachedTree]
  name = c
  entryCnt = 1
  subtreeCnt = 0
  id = 2b230fa0f3d19b497d3dd24e835691e3a921657f

[checksum]
  checksum = True
  sha1 = 124680d4dec4758ee1ae28f546659d282952ebff
Ciao
  Chris
Ciao
  Chris


On Wed, Jan 21, 2015 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Halstrick <christian.halstrick@gmail.com> writes:
>
>> Is it allowed that the git index contains a tree extension mentioning
>> patch 'x/y/z' while the only entry in the index is a '.gitattributes'
>> files in the root?
>
> Depends on the definition of "mention", but it is not unexpected
> that you see "x", "y", and "z" in the cache-tree extension as
> invalidated nodes after you do something like this:
>
>         rm -fr test &&
>         git init test &&
>         cd test
>         mkdir -p x/y/z &&
>         >x/y/z/1 &&
>         git add x &&
>         git write-tree && # cache-tree is fully valid
>         mv x/y/z x/y/a &&
>         git add x # cache-tree invalidated
>
> "z", if appears, should still know that "y" is its parent and "y",
> if appears, should still know that "x" is its parent.  All of the
> three should say they have been invalidated by showing a negative
> entry-count and show the "correct" subtree count that appear in the
> extension (i.e. if "z" is there as an invalidated leaf, it should
> say "-1 0" to indicate an invalidated entry by a negative entry count,
> with zero subtrees, and "y" would show "-1 1" to indicate an
> invalidated entry with one subtree, namely "z", etc.).
>
>
