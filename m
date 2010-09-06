From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] tree-walk: actually move tree_entry_interesting() to tree-walk.c
Date: Tue, 7 Sep 2010 08:20:06 +1000
Message-ID: <AANLkTi=+iga89znGPgOV14+Z9AZ0qbzJJbN1wNAum=qX@mail.gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
	<1283748429-31076-4-git-send-email-pclouds@gmail.com>
	<AANLkTinV+Bo_EijJU2q5GVG=jr9GFAuQGo5KQpvf0K-V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 00:20:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osk35-0008K9-BY
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab0IFWUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:20:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab0IFWUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 18:20:08 -0400
Received: by wwj40 with SMTP id 40so7155595wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pJHSpXQH+C5d2Pwf3LNFFxwJEJBezc9x5XJ/Rc2oR7s=;
        b=dcPDZhTEk9EN7Dd+gaGZJy4nIfowZCj8qiCv6m7dP2PIYzQimbA0nnJWdtbVcocbIw
         UhpKkKL0YOHLFCxKdud9yTxBDeCUR/vN2T+Z8B89zmw9CezhAMDJ7yDodo86XLTcJnpA
         l3OsDVO2BysWnwqXDQJC5b73HNwwY9XBbaHec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w2Yy7qR03NT/JyeJdl4Nz/p4iCqf0dkN/bNYyNgurqOFkaCf4PR/y+gEsuvmTgZnxn
         He6AqdrX7jY5wkli1U9y2PqJCFnbuFl+Lo182jHkb+5f1iJwzCjXY9DHQuSKlHFsW/SX
         pdElWPQ4bpQhF7eumTMJkCpml/qKQzHroQeB4=
Received: by 10.227.127.194 with SMTP id h2mr436391wbs.74.1283811607118; Mon,
 06 Sep 2010 15:20:07 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Mon, 6 Sep 2010 15:20:06 -0700 (PDT)
In-Reply-To: <AANLkTinV+Bo_EijJU2q5GVG=jr9GFAuQGo5KQpvf0K-V@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155634>

2010/9/7 Elijah Newren <newren@gmail.com>:
> 2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> This function can be potentially used in more places than just
>> tree-diff.c. This patches removes struct diff_options dependency fro=
m
>> the function, and moves it to tree-walk.c.
>>
>> No functionality change intended.
>
> Thanks for working on this. =C2=A0I like having the declaration of
> tree_entry_interesting() moved to tree_walk.h, at the very least. =C2=
=A0The
> change to make tree_entry_interesting() take an entry instead of a
> tree_desc makes sense too.
>
> I'm unsure about replacing the diff_options with paths + pathlens +
> nr_paths -- that might be exposing too much implementation detail in
> the API. =C2=A0In particular, I'm worried that if we try to add suppo=
rt for
> negated pathspecs or globs or regexes to tree_entry_interesting(),
> then we'll need to pass different data to this function and update an
> awful lot of callers.
>
> Perhaps we should make a new struct containing paths + pathlens +
> nr_paths, make tree_entry_interesting() take such a struct, modify
> diff_options have such a struct instead of the current three paths,
> pathlens, and nr_paths fields, and modify diff_tree_setup_path()s to
> take such a struct instead of a diff_options* (and perhaps move
> diff_tree_setup_paths() out of diff.h and tree-diff.c into some other
> file(s)?).
>
> Thoughts?

You're right again. Perhaps something like struct exclude_list from dir=
=2Eh?

struct pathspec_list {
	int nr;
	int alloc;
	struct pathspec {
		const char *path;
		int pathlen;
		int flags;
	} **paths;
};

Hmm.. or just use struct exclude_list, with diff_options.path{s,len}
becoming exclude_list.base{,len}. exclude_list.pattern can be used for
glob/regex matching (if we are ever going to support that).
--=20
Duy
