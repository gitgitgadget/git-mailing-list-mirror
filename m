From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Thu, 4 Nov 2010 12:41:57 +0200
Message-ID: <201011041141.58334.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <201011030058.53366.jnareb@gmail.com> <AANLkTi=8Qz3bFCc1qocpOqsCdSWtwUHQDiwkS7H2ypad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 11:42:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDxGn-0001zx-5F
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 11:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab0KDKmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 06:42:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56035 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab0KDKmG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 06:42:06 -0400
Received: by bwz11 with SMTP id 11so1505406bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Q+PhqZkz2r2C/ue05rufO651SL9B87e9h9VTjs+GSPw=;
        b=WC/RpQT8uJxlQkx6zKdjUijipGwRTF4T9L6Y0rwvweYdlJUO9KCrgRhYA3Jp7z+vTg
         0i3VS5owGZb/0w7QxP6f9PEjlk8UtGo6rSQlNHNBGhZL1eP+rZfm815iJ6vPMbRccbce
         Ns9Mb7iJTipllxkI4e2Mi2WvJRnCB9Hxj21eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wCzXX6vfiwJZ3XXRIbIzBHfAwvwaPYUSWKUF1cjHBepdSi8+nR/wZqMhfTK3egU2BI
         teewhw8QXCxR6+xbJIDI9xj6lu2v8JIjIlUNcRSt8+6kgDYu2M8VsSFc3kJQpaqOd0Kc
         DTzFm4lqIOXr37TYcN0kSgbhnPJ2880wjdDts=
Received: by 10.204.117.195 with SMTP id s3mr461429bkq.203.1288867324353;
        Thu, 04 Nov 2010 03:42:04 -0700 (PDT)
Received: from [192.168.1.13] (abvz101.neoplus.adsl.tpnet.pl [83.8.223.101])
        by mx.google.com with ESMTPS id a25sm6534586bks.20.2010.11.04.03.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 03:42:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=8Qz3bFCc1qocpOqsCdSWtwUHQDiwkS7H2ypad@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160715>

On Wed, 3 Nov 2010, Giuseppe Bilotta wrote:
> On Wed, Nov 3, 2010 at 12:58 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Tue, 2 Nov 2010, Giuseppe Bilotta wrote:
>>> The limiting seems to be the most debatable part of this patch 8-)
>>
>> I think that untill this feature gets into gitweb we can only guess
>> as to what kind of limiting would look and behave best on RL cases.
>=20
> I think that in most cases there won't be any need for limiting.
> Public cases of lots of remotes with lots of branches are, I suspect,
> rare.

It's not about _public_ cases; I think that it is in very rare cases
that public repository would want to display remotes and remote-trackin=
g
branches.

I think remote_heads feature is more important for _local_ use, for
example browsing one own repository using git-instaweb.  In such cases
number of remotes and of remote-tracking branches might be large (I hav=
e
11 remotes, not all active, and 58 remote-tracking branches).

BTW. would next version of this series include patch to git-instaweb
enabling 'remote_heads' feature for it (gitweb_conf function)?

>>>> +sub fill_remote_heads {
>>>> + =A0 =A0 =A0 my $remotes =3D shift;
>>>> +
>>>> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
>>>> + =A0 =A0 =A0 ## A QUESTION: perhaps it would be better to pass @r=
emoteheads as parameter?
>>>> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads=
);
>>>> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'=
} =3D~ s!^$remote/!! } @remoteheads ];
>>>> + =A0 =A0 =A0 }
>>>> +}
[...]
>>>> A QUESTION: perhaps it would be better to pass @remoteheads as par=
ameter?
>>>> I wonder if won't end up with calling git_get_heads_list multiple =
times...
>>>> well, the improvement can be left for later. =A0Answering this que=
stion
>>>> should not affect accepting this patch series.
>>>
>>> I'm not sure I actually understand the question. Who should we pass
>>> @remoteheads to?
>>
>> I meant here passing @remoteheads or \@remoteheads, i.e. result of c=
all
>> to git_get_heads_list, to fill_remote_heads (as one of parameters).
>> I was worrying, perhaps unnecessarily, about calling git_get_heads_l=
ist
>> more than once... but I guess that we did it anyway.
>=20
> I'm still not sure I follow. git_get_heads_list only gets called once=
,

Ah, that's all right then.  I was worring that it is called more than
once in one request by gitweb.

> with all the remotes/<remotename> pathspecs as a single array
> argument. This _does_ mean that when the total number of remote heads
> is greater than the limit some remotes will not display complete
> information in summary view. The real issue here is, I think, that
> there is no trivial way to tell which remotes have incomplete
> information and which don't, meaning that in the subsequent
> git_remote_block calls we'll have no way to provide visual feedback
> (the ellipsis) when some heads are missing.

Errr... shouldn't we leave limiting number of heads to fill_remote_head=
s,
which can do limiting per remote (with each remote having up to $limit
remote-tracking branches / remote heads), instead of having=20
git_get_heads_list do it?

Something like this:

+sub fill_remote_heads {
+       my ($remotes, $limit) =3D @_;
+
+       my @heads =3D map { "remotes/$_" } keys %$remotes;
+       my @remoteheads =3D git_get_heads_list(undef, @heads);
+       foreach my $remote (keys %$remotes) {
+               $remotes->{$remote}{'heads'} =3D
+                       [ grep { $_->{'name'} =3D~ s!^$remote/!! } @rem=
oteheads ];
+		$remotes->{$remote}{'heads'} =3D
+			[ @{$remotes->{$remote}{'heads'}}[0..$limit-1] ]
+			if (@{$remotes->{$remote}{'heads'}} > $limit);
+       }
+}

Though perhaps it will be more clear with if as statement, not as modif=
ier:

+sub fill_remote_heads {
+       my ($remotes, $limit) =3D @_;
+
+       my @heads =3D map { "remotes/$_" } keys %$remotes;
+       my @remoteheads =3D git_get_heads_list(undef, @heads);
+       foreach my $remote (keys %$remotes) {
+               $remotes->{$remote}{'heads'} =3D
+                       [ grep { $_->{'name'} =3D~ s!^$remote/!! } @rem=
oteheads ];
+		if (@{$remotes->{$remote}{'heads'}} > $limit) {
+			$remotes->{$remote}{'heads'} =3D
+				[ @{$remotes->{$remote}{'heads'}}[0..$limit-1] ]
+		}=09
+       }
+}


>>>> Though I am not sure if it is good public API. =A0Perhaps it is...
>>>
>>> The alternative would be to have git_remote to handle the single
>>> remote case, and possibly even have the action name be 'remote' rat=
her
>>> than 'remotes' in that case.
>>
>> We might want to have 'remote' as alias to 'remotes' anyway.
>>
>> Though what you propose, having separately 'remotes' for list of all
>> remotes, and 'remote' + name of remote, might be a good idea.
>=20
> I hope you don't mind if I opt to leave these refinements for later ;=
-)

Not a problem.  For backward compatibility we would have to accept
'remotes/<remote>' in addition to more correct 'remote/<remote>', but
this is not a problem.

--=20
Jakub Narebski
Poland
