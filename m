From: Kevin Ballard <kevin@sb.org>
Subject: Re: git-reflog bails if branch points to bad commit
Date: Thu, 23 Sep 2010 14:57:15 -0700
Message-ID: <6532E729-31B8-44D3-A26A-780DDD784703@sb.org>
References: <F628129C-56AE-4BB5-9227-4282763C5B7E@sb.org> <AANLkTimzQ5Jdw5oqiE17859YBiM0EQ6fnTp5+x6JR48k@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 23:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oytn9-0004Iw-H8
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab0IWV5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 17:57:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34479 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab0IWV5R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 17:57:17 -0400
Received: by pzk34 with SMTP id 34so463628pzk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:57:17 -0700 (PDT)
Received: by 10.142.186.11 with SMTP id j11mr1965960wff.29.1285279037543;
        Thu, 23 Sep 2010 14:57:17 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id o9sm1402602wfd.16.2010.09.23.14.57.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Sep 2010 14:57:16 -0700 (PDT)
In-Reply-To: <AANLkTimzQ5Jdw5oqiE17859YBiM0EQ6fnTp5+x6JR48k@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156918>

On Sep 23, 2010, at 1:35 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Thu, Sep 23, 2010 at 20:13, Kevin Ballard <kevin@sb.org> wrote:
>=20
>> Attempting to use `git reflog show foo` or `git log -g foo` will
>> bail with "bad object: foo" if the tip commit of foo is
>> invalid. This seems incredibly non-useful. Why should reflog care if
>> foo points to a valid commit? This bug prevents reflog from being
>> used in a time of great need, which someone just ran into on the
>> #git IRC channel. Their power cut out and they ended up with a
>> corrupt commit on the tip of their branch, and they simply could not
>> view the reflog, which would have enabled them to roll the branch
>> back to a previous commit. Does anybody know why reflog has this
>> behavior?
>=20
> As you say the repository is probably corrupted, and recovering from
> that may be hard, not much you can do with corrupted data.
>=20
> Can this person provide a tar-ed copy of the repository so we can loo=
k
> at it and be of help, instead of speculating?

The person's problem was eventually resolved by finding another clone o=
f the repository and using it to identify the bad object. However, I wa=
s able to trivially reproduce the reflog problem by making a very simpl=
e history, then modifying the ref itself to point to a bad hash (I mere=
ly incremented the hash by 1). At this point, attempting to say `git re=
flog show foo` was complaining "fatal: Bad object foo" even though the =
reflog itself is perfectly valid, and in fact the only problem in the e=
ntire repository is the ref currently points to a hash that doesn't exi=
st in the object database.

-Kevin Ballard