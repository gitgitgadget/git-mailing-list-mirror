From: =?utf-8?Q?Micha=C3=ABl_Fortin?= <fortinmike@gmail.com>
Subject: Re: Weird output of git status in pre-commit hook when providing a pathspec on commit
Date: Wed, 4 Feb 2015 17:45:51 -0500
Message-ID: <FBB67809-5585-4D53-BF55-53248FD1369F@gmail.com>
References: <80E24BA2-84FE-47FC-A5C0-D291E3C63BD5@gmail.com> <20150203163235.GA9325@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 23:46:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ8hr-0008I3-5C
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 23:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966772AbbBDWpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2015 17:45:55 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:41502 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965179AbbBDWpy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Feb 2015 17:45:54 -0500
Received: by mail-qg0-f49.google.com with SMTP id e89so3681218qgf.8
        for <git@vger.kernel.org>; Wed, 04 Feb 2015 14:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0XYNwESd7rui72lKDZAX4klBFLqtihT34rxK0UNkfVc=;
        b=JaLbtdONWLAcwavhNiur3CHyBWljLei8d8v348rdInwXqpYQUfGD07Fm4GZEhXjVoS
         J04fHPdb800QjHdgY9H59WaN6zO/VTbI6vLPzGBX37Npt6GJm1gsj2g6OI9F8qEkcGKm
         QxQlrvD09FdsaO8IUH+ljVE6mGUpKrP9FM+9IA4TpSK91Pzw41jjdrBeZH/bLX8krOyP
         do+jiwekvaJb+NZro8WY3rwgKgXTbItmCPMh+d6fn+KT+uyoDnWFmcIx67QBV9XS2aIK
         Vubq+xHJ414o/kfcU0Gb8k1l1R/KPaXZQU37/Poak3X35enHuvJGw8dpxPaDb5PJpnRk
         G6/Q==
X-Received: by 10.140.32.5 with SMTP id g5mr1267817qgg.83.1423089953030;
        Wed, 04 Feb 2015 14:45:53 -0800 (PST)
Received: from [172.20.10.2] (out-pq-196.wireless.telus.com. [216.218.29.196])
        by mx.google.com with ESMTPSA id n4sm3073841qac.30.2015.02.04.14.45.51
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Feb 2015 14:45:52 -0800 (PST)
In-Reply-To: <20150203163235.GA9325@peff.net>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263360>

Interesting!

Thanks for the info; unsetting git environment variables as you suggest=
ed fixes my issue on OS X (and Linux I suppose). I=E2=80=99m going to t=
ry this on Windows soon. Would that work as-is on Windows, or would I n=
eed to unset the vars using some other Windows-specific syntax?

Yes, I looked at the documentation for =E2=80=9C-C", and =E2=80=9C-o". =
Because this issue is triggered by the use of =E2=80=9C-o=E2=80=9D, may=
be the appropriate place to mention this behaviour would be in the docu=
mentation for =E2=80=9C-o=E2=80=9D? I don=E2=80=99t know.

Thanks again,

Micha=C3=ABl Fortin
www.irradiated.net

> On Feb 3, 2015, at 11:32 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Feb 03, 2015 at 08:14:06AM -0500, Micha=C3=ABl Fortin wrote:
>=20
>> Repo1 has the following pre-commit hook:
>>=20
>> #!/bin/bash
>> git -C "../Repo2" status --porcelain
>>=20
>> I then commit in Repo1 using the following (this is actually ran by =
a
>> GUI, I have no control over the commands themselves):
>>=20
>> git add --force -- MyNewFile
>> git commit -m "My message" -o -- MyNewFile
>=20
> Because the commit command uses "-o", git must use a temporary index
> file to stage the commit. It sets GIT_INDEX_FILE in the environment, =
and
> then runs your hook.
>=20
> When the hook runs "git -C" it moves into another repository, but the
> GIT_INDEX_FILE in the environment takes precedence over the local ind=
ex
> found in that repository. So you see a HEAD and working tree from Rep=
o2,
> but the index from Repo1.
>=20
> This is a specific case of a more general problem. If you were to run
> git like:
>=20
>  git --git-dir=3D/path/to/.git commit ...
>=20
> you would have similar problems. You would have $GIT_DIR set in the
> environment, and would see the HEAD from Repo1, but the working tree
> from Repo2.
>=20
> In other words, moving into another git directory from inside a hook =
is
> not as easy as just going there. You also need to clear any state fro=
m
> the environment. E.g., by adding this to the top of your hook:
>=20
>  unset $(git rev-parse --local-env-vars)
>=20
> Should "-C" (or "--git-dir") make this easier by doing it for you? I'=
m
> not sure it is a good idea. It is right now valid to do:
>=20
>  GIT_INDEX_FILE=3D/path/to/index.tmp git -C /path/to/repo ...
>=20
> which would break if we cleared git variables. OTOH, maybe using "-C"
> (instead of chdir-ing yourself) is a good indication that you want th=
at
> cleared. I dunno. It is probably too late at this point, as we would =
be
> subtly breaking backwards compatibility. Perhaps it would make more
> sense to add a new option, so you could do:
>=20
>  git --reset-git-vars -C ../Repo2 status --porcelain
>=20
> But this is a fairly obscure use case, and the rev-parse invocation
> above is not so bad. I think it is more about knowing that you need t=
o
> use it, rather than the pain of typing it. And I am not sure how to m=
ake
> that more clear. Is there a specific place in the documentation you
> looked and might have been warned? Maybe the description for "-C" sho=
uld
> cover this.
>=20
> -Peff
