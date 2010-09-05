From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 06/15] Automatically reuse sparse limiting arguments
 in revision walking
Date: Sun, 5 Sep 2010 17:12:07 +1000
Message-ID: <AANLkTimw89nkui5UdJPu-s5yQ=mP4wtw0tKTZxsq2L4W@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-7-git-send-email-newren@gmail.com>
	<AANLkTik1E=7Uawq-fGXppac3ur-oohq104A5wEgxv8cL@mail.gmail.com>
	<AANLkTi=ywOZfkxfr1Gt3AMMbWDphKjTBudG=E4+xer-P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 09:12:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os9Og-0006uV-Vn
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 09:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab0IEHMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 03:12:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54427 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab0IEHMI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 03:12:08 -0400
Received: by wyf22 with SMTP id 22so1747787wyf.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8MTF+Q6XdL12lLJwfcLZwY90hb2maE/bWgjPJ/58IPk=;
        b=L+O2cSnAySC13EuBz0I/0PzvJfnFapGL5b+hHrZVRToEH6apLoCIlpTh7pUxcfD/5E
         H3FGmad/pPeqk0JXBoKXLkVqpQwnoTHV/yE03CJdgauX2mz/bZwuAt56KNl1Blvjayvy
         U35ikyuy3jIMJQBzBT/l0hR1ReSoaMHsqX+20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mtufk2PxgwP4IJWgRhwgOH2P86HZxs9T5biZp300gGLkvKCyPEVp/nPJE4k2xuRpej
         CCMacDKy6q+3fdPw0G95APBF1kFLRbP5QdQm7/GZSsV3Pfs4jYZEHaPiiRahJh1IAGDC
         y98BfUOCFrh7LT5NdgE1Q0T9jfNIDScaNyBTY=
Received: by 10.216.155.74 with SMTP id i52mr2504635wek.26.1283670727085; Sun,
 05 Sep 2010 00:12:07 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sun, 5 Sep 2010 00:12:07 -0700 (PDT)
In-Reply-To: <AANLkTi=ywOZfkxfr1Gt3AMMbWDphKjTBudG=E4+xer-P@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155445>

On Sun, Sep 5, 2010 at 2:50 PM, Elijah Newren <newren@gmail.com> wrote:
> On Sat, Sep 4, 2010 at 7:58 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.c=
om> wrote:
>> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wr=
ote:
>>> In a sparse repository, by automatically making use of sparse limit=
s
>>> specified at clone time, we can avoid walking uninteresting commits=
 and
>
>>
>> I have a nicer approach here. Instead of modifying setup_revisions()
>> and similar functions, I update get_pathspec() to rewrite the
>> pathspecs from command line in narrow/shallow repos. get_pathspec()
>> currently does some form of rewriting already (prepending prefix).
>>
>> So if you do "git log", get_pathspec() would return "git log -- PATH=
1
>> PATH2...". Will repost my series soon, or I can send that particular
>> patch to you.
>
> Ooh, that's clever. =C2=A0I like it. =C2=A0Do you also do verificatio=
n that any
> paths specified by the user are a subset of the paths the sparse clon=
e
> is limited to? =C2=A0That'd be really nice. =C2=A0Much better than my=
 simple
> dumb "just append" logic.

I do.

> How do you reconcile conflicting needs, though? =C2=A0For most cases,
> whenever the user specifies paths, get_pathspec should make sure thos=
e
> paths are a subset of the sparse paths (throwing an error if they're
> not) and then just use the user-specified ones. =C2=A0However, I thin=
k
> doing this in all cases would break ls-files/cat-file -p, as the
> pathspecs passed to those are not necessarily rooted at the toplevel
> of the repository (and the prefix doesn't correct for that either).

Yes, some commands will just skip the pathspec rewrite. It's up to
those commands to rewrite pathspec themselves.

So get_pathspec() will have pathspec rewrite by default. Other
commands will use another variant of it (i.e. get_pathspec_narrow()),
which allows to skip the rewrite completely.
--=20
Duy
