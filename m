From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Mon, 20 Sep 2010 01:02:21 +0200
Message-ID: <201009200102.22960.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <201009171854.03476.jnareb@gmail.com> <AANLkTinkikwt5cUxuXECfeQrKZthu271U82F3ebSrEmd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:02:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxSuD-0000i9-AZ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab0ISXC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:02:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56099 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab0ISXC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:02:26 -0400
Received: by bwz11 with SMTP id 11so3912703bwz.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hTnXN7TMucxJTe49CDefhjLtduBz35pEYAuKxF13Zug=;
        b=ER3ESjTIMZddM1yjgz29tSxBB59sW56xSmdE/8dwO46y3lkyGO3bG4t18u614vd/vn
         TlFMyFQtBEP296UxDJwVheMWdAsoKJbnfXqADd99K816T2J+AoWqWhpPL+Axe6caHAvu
         ncnGBmRft1GdAoZ6tD4O2dyYm06MDmAYKmlUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DTHmfOpr7+K5ILWUJHsis7MjKaAnmb5OkuxnHI0AYTt3m/t1QfGUO9rzhji03GmNil
         2H0FjgN/SDtjuYPPnKQvSgQTrsbIA8ACV/C/3stKKT5hTj0C3Jcn+xtgJ7Jt3L28JClf
         iWirnShuPeF6/nTgx5XTJYxndwfB3tvHJeYaE=
Received: by 10.204.79.223 with SMTP id q31mr6187042bkk.92.1284937344729;
        Sun, 19 Sep 2010 16:02:24 -0700 (PDT)
Received: from [192.168.1.13] (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id 11sm5913902bkj.11.2010.09.19.16.02.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:02:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinkikwt5cUxuXECfeQrKZthu271U82F3ebSrEmd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156519>

On Sun, 19 Sep 2010, Giuseppe Bilotta wrote:
> On Fri, Sep 17, 2010 at 6:54 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 92551e4..66b5400 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -2758,6 +2758,16 @@ sub git_get_last_activity {
>>> =A0 =A0 =A0 return (undef, undef);
>>> =A0}
>>>
>>> +sub git_get_remotes {
>=20
> [snip]
>=20
>>> + =A0 =A0 my @remoteheads =3D git_get_heads_list($limit, 'remotes')=
;
>>> + =A0 =A0 return (\@remotes, \@remoteheads);
>>
>> Why do you want for git_get_remotes() to also return remote-tracking
>> branches (refs/remotes/)? =A0Those are separate issues, and I think =
it
>> would be better API for git_get_remotes() to provide only list of
>> remotes, i.e.
>>
>> =A0+ =A0 =A0 return @remotes;
>>
>> Especially that we might want in the summary view to only list remot=
es,
>> without listing remote-tracking branches.
>>
>> That would require more changes to the code.
>=20
> This is kind of the main issue with this patch. What do we want to do
> with the remotes list in summary view and the remotes view? We
> basically have three possibilities:
>=20
> (1) we can make the remotes list in summary view be a 'reduced
> remotes' view: this would make it behave the most similarly to the
> other components of summary view
> (2) we can make the remotes list be much more stripped down, by only
> listing the remotes and possibly some summarizing property such as th=
e
> number of branches in it or when it was last updated
> (3) we can make the remotes list be just a copy of the full remotes v=
iew.
>=20
> The third option is surely the easiest to implement. The second optio=
n
> with _only_ a list of remotes (no extra info) is also very easy to
> implement _and_ fast to render. The second option with extra info, or
> the first option, on the other hand, require the retrieval of some
> additional data which, maybe due to my limited knowledge of git,
> essentially means retrieving _all_ the remote heads and then doing th=
e
> filtering in gitweb. But once we're getting all the information, why
> not display it all? isn't it faster to just display all of it, in
> which case we go back to option 3?

When thinking about how display information about remotes and
remote-tracking branches in 'summary' view, we have to consider that
this view is meant to be what it says: a *summary*.  That is why both
the 'heads' and the 'tags' section displays only 15 items.

Without grouping remote heads the natural solution was to simply repeat
what we used for 'heads' subsection, namely limit displaying to 15
remote-tracking branches in 'remotes' subsection of the 'summary' view.

With grouping it is more complicated.  We can limit number of remote
head *per remote*, we can limit number of remotes... but what makes
IMVHO least sense is limit number of remote heads *then* do grouping.


The solution (1) i.e. limiting number of remote heads per remote, with
or without limiting number of remotes behaves, as you wrote, most
similarly to other components of 'summary' view.  On the other hand
with large number of remotes, and large number of remote heads in those
remotes it might be too large for a *summary* view.

The solution (3) i.e. displaying only list of remotes (perhaps limited
to 15 remotes) is simple and fast to render.  On the other hand it offe=
rs
least information and might be too little in the case of single remote.

>=20
> If we go with option 3, it does make sense to get all remote names an=
d
> all remote branches at once, and thus to make the git_get_remotes()
> call do all of the work.

Not if subroutine is called git_get_remotes(), IMVHO.  Perhaps
git_group_remotes()?
=20
>>> @@ -4991,6 +5001,19 @@ sub git_heads_body {
>>> =A0 =A0 =A0 print "</table>\n";
>>> =A0}
>>>
>>> +sub git_remotes_body {
>>> + =A0 =A0 my ($remotedata, $head) =3D @_;
>>> + =A0 =A0 my @remotenames =3D @{$remotedata->[0]};
>>> + =A0 =A0 my @allheads =3D @{$remotedata->[1]};
>>
>> Why not
>>
>> =A0+ =A0 =A0 my ($remotenames, $allheads, $head) =3D @_;
>>
>> Beside, isn't it $remote_heads and not $allheads?
>=20
> I think it's a leftover name choice from the first version of the
> patch. Can change.

O.K.

>>> + =A0 =A0 foreach my $remote (@remotenames) {
>>
>> It would be then
>>
>> =A0+ =A0 =A0 foreach my $remote (@$remotenames) {
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 my @remoteheads =3D grep { $_->{'name'} =3D=
~ s!^\Q$remote\E/!! } @allheads;
>>
>> Should we display remote even if it doesn't have any remote heads
>> associated with it?
>>
>> By the way, it would be place where we could limit number of
>> remote-tracking branches displayed in each remote block.
>=20
> But does it make sense to reduce the number of displayed branches
> after we got the information about all of them? I think it depends on
> what summary view is intended to do exactly.

Right.  But I think limit then group is not a very good choice from
all other available.
=20
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git_begin_group("remotes", $remote, "remo=
tes/$remote",$remote);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@remoteheads, $head);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git_end_group();
>>
>> This would have to be modified with change to git_begin_group() /
>> / git_end_group().
>=20
> Of course.
>=20
>> BTW isn't it premature generalization? =A0It is only place AFAIKS th=
at
>> uses git_*_group() subroutines.
>=20
> It's the only current use but I believe that, since it's factored out
> now already and since it may be used in other views too (think:
> grouping heads or tags by prefix) it might make sense to keep it this
> way.

If it could be used for other blocks (like 'readme', or 'heads',
or 'tags') itself it would be even better.
=20
>>> + =A0 =A0 }
>>> +
>>> +}
>>> +
>>> =A0sub git_search_grep_body {
>>> =A0 =A0 =A0 my ($commitlist, $from, $to, $extra) =3D @_;
>>> =A0 =A0 =A0 $from =3D 0 unless defined $from;
>>> @@ -5137,7 +5160,7 @@ sub git_summary {
>>> =A0 =A0 =A0 # there are more ...
>>> =A0 =A0 =A0 my @taglist =A0=3D git_get_tags_list(16);
>>> =A0 =A0 =A0 my @headlist =3D git_get_heads_list(16, 'heads');
>>> - =A0 =A0 my @remotelist =3D $remote_heads ? git_get_heads_list(16,=
 'remotes') : ();
>>> + =A0 =A0 my @remotelist =3D $remote_heads ? git_get_remotes(16) : =
();
>>
>> No change of git_get_remotes() does only one thing: returning list
>> of remotes.
>=20
> See above about what should git_get_remotes() do. Even better, I was
> thinking about git_get_remotes() returning a hash (mapping remote
> names to the heads from that remote)

Wouldn't it be then named git_group_remotes() or something like that?

If remote doesn't have remote-tracking branches associated with it
(e.g. push-only remote, or remote predating separate remotes layout)
the value would be undef for given remote as key in hash.
=20
> So the big question (which essentially determines the functionality
> provided by this last patch in the set) is: what do we want to do in
> summary view?

--=20
Jakub Narebski
Poland
