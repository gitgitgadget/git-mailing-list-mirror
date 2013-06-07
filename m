From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Fri, 7 Jun 2013 22:51:53 +0530
Message-ID: <CALkWK0mbVgJHRoNXNkc6n7==-H+caNqvzrzUwspS_Eq2sMfJbg@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-7-git-send-email-artagnon@gmail.com> <20130603192555.GK2192@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul0N4-0003Xc-K1
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603Ab3FGRWe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 13:22:34 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56294 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab3FGRWd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 13:22:33 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so11280361iec.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nlgfHDqutQ4+wwnF3HijBEsKICWijXMGjSQGSCqAUKY=;
        b=o7AwhLsemABPhJSp5Ll/77UiFL6LJaypBVzeyzYLdGphcoLreDRWHOPAv78P3iNG7/
         2ybr88Ejyg4YZC0beTbPQwW4DJs2Ibin1beruCis7QPIGVI3DuXjtJvXr2NFQW0jFlfN
         Mu0HJxZScz0FJc9XlTjrgcya2aR4jarCJ6N526q+LHiVVcRuYh5FdmHSiZ2crY+b8Frj
         6WPTZvT4QQdIe0HpdXDj/aKEEV4ILxoxgeRuY1PqRHfJKFdVtWjQmckI8qx6gPXA10J7
         ACB5C3OrBXx3Q7ii6ydRpt7jYVqIJFSi5VAZqIrP4Cf4ghcQMJcQYbC3uRd/HbgLYVfJ
         X0oA==
X-Received: by 10.50.141.230 with SMTP id rr6mr1674233igb.89.1370625753513;
 Fri, 07 Jun 2013 10:22:33 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 10:21:53 -0700 (PDT)
In-Reply-To: <20130603192555.GK2192@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226652>

SZEDER G=C3=A1bor wrote:
> Well, people out there might have completion scriplets for their
> aliases or custom git commands which use __git_complete_file().
> Removing this function would break those scripts.

What is the advantage of using __git_complete_file() over
__git_complete_revlist_file()?  Isn't it just a misleading alias?

> Arguably the name of __git_complete_file() could describe better what
> the function does, or what it did, i.e. it used to provide completion
> for the master:Doc<TAB> notation.  But that's only the name.  Since
> both git ls-tree and git archive understand this notation, calling th=
e
> helper for master:Doc<TAB> in their completion functions is not
> misleading at all.

But __git_complete_revlist_file() provides all this and more, no?

> Now, __git_complete_revlist_file() provides completion both for this
> master:Doc<TAB> notation and for revision ranges, i.e. for
> master..n<TAB> and master...n<TAB>.  However, since neither git
> ls-tree nor git archive accept revision ranges, calling
> __git_complete_revlist_file() in their completion function would be
> misleading.

Yeah, they accept tree-ish'es.  Isn't __git_complete_file() still a
horrible name?

  $ git ls-tree HEAD:Documentation

What file?  There's already a __git_complete_index_file(), which is
properly named and used by the ls-files family.  If anything, we
should write a new __git_complete_treeish() function that does what
__git_complete_revlist_file() does, except that it doesn't complete
revision ranges, right?  Frankly, I don't know if it's worth the
additional trouble: we do spurious completions all over the place, and
we haven't clamped down on any of that.

  $ git log HEAD:Doc<TAB>

Note how log doesn't even error out.

> git show is special, as it understands both the master:Doc<TAB>
> notation and revision ranges, and even the combination of the two, so
> calling __git_complete_revlist_file() there would indeed be better.

It just accepts any revspec with pathspec filtering, like many many
other commands.
