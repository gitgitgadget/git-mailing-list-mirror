From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Migrating SVN to Git, and preserve merge information
Date: Wed, 11 Apr 2012 13:13:16 +0200
Message-ID: <CA+gHt1DPSkbwyXzt4SHL=1btLJW8mVYrWORU8Wk2riW4v+SCvA@mail.gmail.com>
References: <4F844F33.5000004@nekoconeko.nl> <4F84BAE2.5090803@pileofstuff.org>
 <4F8531B3.9030501@nekoconeko.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>, git@vger.kernel.org
To: Nick Douma <n.douma@nekoconeko.nl>
X-From: git-owner@vger.kernel.org Wed Apr 11 13:13:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHvUk-0004mS-IO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 13:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757426Ab2DKLNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 07:13:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55110 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627Ab2DKLNi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 07:13:38 -0400
Received: by bkcik5 with SMTP id ik5so556816bkc.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 04:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=obB3Xw5b92njzhtgWYdcoCKf2hBAgAi75k1Jw2NJKzU=;
        b=So00htnymOlf8hJt8pNft6Ibbi3Qik0lYHfQ99PpSQEce1TgUK7BxE4nXMuRl4vois
         B5V7teLb0IZignvgRGuSZYeIDbOQuLI+eWCanhsxSBJBpkd9ycNy942JTtsRrvA8mpfD
         WbLDE0m/veRZXzM21wV90mQ8PYx1QbCD2v4z/M2YVM3tHtzO/p01n+OPt4raEtFZHwNj
         WZoWfB2V7bPMesjQQjoye77knWiM9JJHOZ8y3cCY/zTtfrP8tC/Z9EAeMWz4WMlXxxSK
         m/p7RF/AB4olBAXnvhu6XIcDQIsKTDgEBBsr5Q+pMGRJefMy2IGyFk6T0hkozESAXjhT
         m6gA==
Received: by 10.204.155.147 with SMTP id s19mr5899253bkw.140.1334142816590;
 Wed, 11 Apr 2012 04:13:36 -0700 (PDT)
Received: by 10.205.120.15 with HTTP; Wed, 11 Apr 2012 04:13:16 -0700 (PDT)
In-Reply-To: <4F8531B3.9030501@nekoconeko.nl>
X-Gm-Message-State: ALoCoQnQNN0L+jN4U+7yOCRTNlv+QFPeb2dlT4we/yTN/oXIuBgV5RRomiB00njSjcFKosfZnpqx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195165>

On Wed, Apr 11, 2012 at 9:24 AM, Nick Douma <n.douma@nekoconeko.nl> wro=
te:
> Hi Andrew,
>
> On 11-04-12 00:57, Andrew Sayers wrote:
>> Would I be right in thinking that a commit like "Merged r100,r101,r1=
02
>> from trunk" will create three grafts? =A0If so, that might be the pr=
oblem.
>
> One SVN 'merge' commit will generate one graft. The graft itself will
> contain all revisions mentioned in the merge commit, and whatever the
> original git parent was before the graft.

This graft does not represent the SVN =B4merge=B4. There are two types =
of
SVN =B4merges=B4, and you are describing the cherry-pick one. So you ha=
ve
to represent them as such, as cherry-pick. And a cherry-pick in git is
just a normal commit, it just happens to apply to a different branch
(commit), it normally has the same commit message (except some people
prefer to add "(cherry pick from commit ...)". And I think this is
just what you are looking for.

So, I would recommend you to just rewrite the SVN commit id with git
commit sha1. Only in the case where you have a real merge (rev XXX:
Merge all history up to rXXX-1 from trunk), you use the graft
approach.

>
>> Git differentiates between "merges" (which include every commit up t=
o
>> and including the specified one) and "cherry-picks" (which just incl=
ude
>> the specified commit), whereas SVN calls both of these "merges". =A0=
Grafts
>> are a way of creating "merges" rather than "cherry-picks" (which git
>> doesn't have any metadata for), and it's not at all easy to get "mer=
ge"
>> data out of SVN in the general case. =A0Having said that, it's often=
 a
>> good enough heuristic to pick the highest revision number mentioned =
in
>> the commit message and pretend it's a merge.
>
> The way we 'merged' in SVN was indeed more like cherry-picking, but I=
'm
> looking to display this information as a merge in Git. I also would l=
ike
> to include all revisions if possible.

But git needs a meaningful history!! If you use merges to represent
cherry-picks it will confuse some of the git tools.

If the question is to "display this information" in a meaningful way
just use the approach outlined above.

>
> The real problem I seem to be having is not completely understanding =
how
> Git grafts work, because I think I'm hitting some kind of limitation =
or
> bug, or just not using it right.

If gitk --all freeze theres is definitly a bug somewhere. I don=B4t
really know, but maybe the problem is that some parents in your grafts
are descendent of the others.

Anyway, we need a minimal method to reproduce it.

HTH,
Santi
