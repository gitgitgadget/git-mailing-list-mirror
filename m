From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Mon, 8 Nov 2010 09:28:45 +0100
Message-ID: <AANLkTimxspcGLnv+F6uKAnFAhUO++iB10b5GxnLVg_v3@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201011030058.53366.jnareb@gmail.com> <AANLkTi=8Qz3bFCc1qocpOqsCdSWtwUHQDiwkS7H2ypad@mail.gmail.com>
 <201011041141.58334.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 09:29:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFN6H-0003fD-Is
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 09:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab0KHI3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 03:29:07 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53742 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0KHI3G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 03:29:06 -0500
Received: by iwn41 with SMTP id 41so3804425iwn.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KkTXMKRLgHTAo2kIvaNCz9yHPVm4W2sIDR0IjJAr9jM=;
        b=Q2sGuuFVo7FMr4BYoYxaspW9MnqsEUiJesk1XLIYdiyRpArNZ0QGNZpuJ5J17OmDcS
         ryxTZ5zxp1FhxgLGP2bMjGY3peJQT8qb6dHtyhGsX5oyiXlIP2hAPBpm29n4xBQyBVIl
         JS10HJp9t341CR8/kSJv2PdCwuG26kKy5sBSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sgkBzxau5gY3/+as9wF8lSl+Gc9xAAFpbwz4SwSl8n5zZXjnC01CiVM4jhGw5XCP0j
         o7o3J075AoKu11TFevqd6g64drUeuWuJCgTgcu63Nj8fdgZmZv2JtyK//TJqwgGbgS1E
         8jAMsYBOEJR10qLkafJcHyo74v1rBdNZTQF8o=
Received: by 10.42.174.2 with SMTP id t2mr3002295icz.104.1289204945698; Mon,
 08 Nov 2010 00:29:05 -0800 (PST)
Received: by 10.231.160.210 with HTTP; Mon, 8 Nov 2010 00:28:45 -0800 (PST)
In-Reply-To: <201011041141.58334.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160913>

On Thu, Nov 4, 2010 at 11:41 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Wed, 3 Nov 2010, Giuseppe Bilotta wrote:
>>
>> I think that in most cases there won't be any need for limiting.
>> Public cases of lots of remotes with lots of branches are, I suspect=
,
>> rare.
>
> It's not about _public_ cases; I think that it is in very rare cases
> that public repository would want to display remotes and remote-track=
ing
> branches.

That's a good point.

> I think remote_heads feature is more important for _local_ use, for
> example browsing one own repository using git-instaweb. =A0In such ca=
ses
> number of remotes and of remote-tracking branches might be large (I h=
ave
> 11 remotes, not all active, and 58 remote-tracking branches).
>
> BTW. would next version of this series include patch to git-instaweb
> enabling 'remote_heads' feature for it (gitweb_conf function)?

I will look into that.

>> with all the remotes/<remotename> pathspecs as a single array
>> argument. This _does_ mean that when the total number of remote head=
s
>> is greater than the limit some remotes will not display complete
>> information in summary view. The real issue here is, I think, that
>> there is no trivial way to tell which remotes have incomplete
>> information and which don't, meaning that in the subsequent
>> git_remote_block calls we'll have no way to provide visual feedback
>> (the ellipsis) when some heads are missing.
>
> Errr... shouldn't we leave limiting number of heads to fill_remote_he=
ads,
> which can do limiting per remote (with each remote having up to $limi=
t
> remote-tracking branches / remote heads), instead of having
> git_get_heads_list do it?
>
> Something like this:
>
> +sub fill_remote_heads {
> + =A0 =A0 =A0 my ($remotes, $limit) =3D @_;
> +
> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads);
> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'} =3D=
~ s!^$remote/!! } @remoteheads ];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ @{$remotes->{$remote}=
{'heads'}}[0..$limit-1] ]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (@{$remotes->{$remot=
e}{'heads'}} > $limit);
> + =A0 =A0 =A0 }
> +}
>
> Though perhaps it will be more clear with if as statement, not as mod=
ifier:
>
> +sub fill_remote_heads {
> + =A0 =A0 =A0 my ($remotes, $limit) =3D @_;
> +
> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads);
> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'} =3D=
~ s!^$remote/!! } @remoteheads ];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (@{$remotes->{$remote}{'heads'}} > $=
limit) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'he=
ads'} =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ @{$re=
motes->{$remote}{'heads'}}[0..$limit-1] ]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}

Either solution is fine, but it would require grabbing all the remote
heads. The real issue here is, I think understanding what is the
purpose of limiting in gitweb. Is it to reduce runtime? is it to
reduce clutter on the screen? In the first case, the limiting should
be done as early as possible (i.e. during the git call that retrieves
the data); in the latter case, is it _really_ needed at all?


--=20
Giuseppe "Oblomov" Bilotta
