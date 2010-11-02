From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Wed, 3 Nov 2010 01:58:52 +0200
Message-ID: <201011030058.53366.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <201010270232.37961.jnareb@gmail.com> <AANLkTinyi22OczYuD4urJKkfh8AzyuZoTzvzAvWa1Bo4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 00:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDQlC-0000zK-CE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 00:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab0KBX7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 19:59:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34290 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab0KBX7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 19:59:04 -0400
Received: by bwz11 with SMTP id 11so71611bwz.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RkVHDhUMzjTiKDAV6SHSL60MoORKwXyXuePjBLbv264=;
        b=L+rhIUGc6tfsspPBsk8o0boS8FRpAKZuKyT1LgK5YlRQdJJaQV/M2hZMCIyL7Uyh7X
         NplQ7F78ORmsAYPM1qTObSgrph0GZg0kKJFGFKioppIRGV88B5ey7YPfL5bmT5CUmFlQ
         ChyacZNA+h1LGDXk7CCfraz5gJty7c8HbMOO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OuMj7YG9vNZgnLZbcRXDChYIKu7XQHl1Wg+bZO20M3J66jJKePlS2JIntYTZye/Zzk
         v1K3Czllh3b1Pjx4RnuLn2mrZCQVQ0GfZNmx0yzwOG98ZB4o1kKVzTAWvS0etzFWtG8+
         2LOstKwBT0pVrS872uGXDdGyPD8N9jlfYtJTw=
Received: by 10.204.113.18 with SMTP id y18mr15390000bkp.54.1288742342594;
        Tue, 02 Nov 2010 16:59:02 -0700 (PDT)
Received: from [192.168.1.13] (abve232.neoplus.adsl.tpnet.pl [83.8.202.232])
        by mx.google.com with ESMTPS id t10sm5030830bkj.16.2010.11.02.16.58.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 16:59:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinyi22OczYuD4urJKkfh8AzyuZoTzvzAvWa1Bo4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160566>

On Tue, 2 Nov 2010, Giuseppe Bilotta wrote:
> 2010/10/27 Jakub Narebski <jnareb@gmail.com>:
>> On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:
>>
>>> In remote and summary view, display a block for each remote, with t=
he
>>> fetch and push URL(s) as well as the list of the remote heads.
>>>
>>> In summary view, if the number of remotes is higher than a prescrib=
ed
>>> limit, only display the first <limit> remotes and their fetch and p=
ush
>>> urls, without any heads information and without grouping.

>> I guess that we can always implement more fancy limiting in the futu=
re
>> (e.g. taking into account total number of displayed remote heads).
>=20
> The limiting seems to be the most debatable part of this patch 8-)

I think that untill this feature gets into gitweb we can only guess
as to what kind of limiting would look and behave best on RL cases.
=20
>>> +#
>>> +# It is possible to limit the retrieved remotes either by number
>>> +# (specifying a -limit parameter) or by name (-wanted parameter).
>>
>> I don't quite like limiting when generating, and would prefer do lim=
iting
>> on display, especially if not doing limiting would not affect perfor=
mance
>> much (git command invoked doesn't do limiting, like in case of
>> git_get_heads_list / git_get_tags_list or *most important* parse_com=
mits).
>>
>> Especially if it complicates code that much (see below).
>>
>> Not doing limiting here, in git_get_remotes_list (or just git_get_re=
motes)
>> would also make API simpler; the single optional argument would be n=
ame of
>> remote we want to retrieve.
>=20
> Hm. By the same token, there would be no need to do the limiting even
> when trying to get information about a single remote, meaning we coul=
d
> make the sub totally parameter-less. OTOH, this would make the callin=
g
> routine quite more complex (since it would have to check if the key i=
s
> there, and then select that single key etc), much more so than
> limiting the number of displayed heads.=20

True, we have to balance complexity in generating function vs. complexi=
ty
in display code.

> I'll take the numerical limiting off the routine.

You meant here limiting number of remotes returned (except of case of
limiting to single remote), isn't it?

>>> +
>>> +# Takes a hash of remotes as first parameter and fills it by addin=
g the
>>> +# available remote heads for each of the indicated remotes.
>>> +# A maximum number of heads can also be specified.
>>
>> All git_get_* subroutines _return_ something; this looks more like f=
ill_*
>> function for me.
>=20
> I'm not particularly enamored with _get_, fill will do

We have fill_from_file_info, fill_project_list_info; I think=20
fill_remote_heads would be a good name.
=20
>>
>>> +sub git_get_remote_heads {
>>> + =A0 =A0 my ($remotes, $limit) =3D @_;
>>> + =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
>>> + =A0 =A0 my @remoteheads =3D git_get_heads_list($limit, @heads);
>>> + =A0 =A0 foreach (keys %$remotes) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 my $remote =3D $_;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D [ grep {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $_->{'name'} =3D~ s!^$rem=
ote/!!
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } @remoteheads ];
>>> + =A0 =A0 }
>>> +}
>>
>> We could remove limiting number of heads shown per remote also from =
here,
>> but this time 1.) the $limit parameter is passed down to git_get_hea=
ds_list
>> which in turn uses $limit as parameter to git command =A02.) it does=
n't
>> simplify code almost at all:
>>
>> +sub fill_remote_heads {
>> + =A0 =A0 =A0 my $remotes =3D shift;
>> +
>> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
>> + =A0 =A0 =A0 ## A QUESTION: perhaps it would be better to pass @rem=
oteheads as parameter?
>> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads);
>> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'} =
=3D~ s!^$remote/!! } @remoteheads ];
>> + =A0 =A0 =A0 }
>> +}

I now think that passing limit to fill_remote_heads (like you have) mig=
ht
be a good solution (contrary to what I wrote earlier).

>> A QUESTION: perhaps it would be better to pass @remoteheads as param=
eter?
>> I wonder if won't end up with calling git_get_heads_list multiple ti=
mes...
>> well, the improvement can be left for later. =A0Answering this quest=
ion
>> should not affect accepting this patch series.
>=20
> I'm not sure I actually understand the question. Who should we pass
> @remoteheads to?

I meant here passing @remoteheads or \@remoteheads, i.e. result of call
to git_get_heads_list, to fill_remote_heads (as one of parameters). =20
I was worrying, perhaps unnecessarily, about calling git_get_heads_list
more than once... but I guess that we did it anyway.

>>> +
>>> + =A0 =A0 my $urls =3D "<table class=3D\"projects_list\">\n" ;
>>> +
>>> + =A0 =A0 if (defined $fetch) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($fetch eq $push) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_ur=
l("URL", $fetch);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_ur=
l("Fetch URL", $fetch);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_ur=
l("Push URL", $push) if defined $push;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 } elsif (defined $push) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_url("Push URL", $p=
ush);
>>> + =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 $urls .=3D format_repo_url("", "No remote=
 URL");
>>> + =A0 =A0 }
>>> +
>>> + =A0 =A0 $urls .=3D "</table>\n";
>>
>> I'm not sure about naming this variable $urls...
>=20
> I'm open to suggestions. $urls_table ?

It is better.
=20
>> Though I am not sure if it is good public API. =A0Perhaps it is...
>=20
> The alternative would be to have git_remote to handle the single
> remote case, and possibly even have the action name be 'remote' rathe=
r
> than 'remotes' in that case.

We might want to have 'remote' as alias to 'remotes' anyway.

Though what you propose, having separately 'remotes' for list of all
remotes, and 'remote' + name of remote, might be a good idea.
=20

Thank you on diligently working on this feature.

--=20
Jakub Narebski
Poland
