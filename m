From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Wed, 3 Nov 2010 08:49:43 +0100
Message-ID: <AANLkTi=8Qz3bFCc1qocpOqsCdSWtwUHQDiwkS7H2ypad@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201010270232.37961.jnareb@gmail.com> <AANLkTinyi22OczYuD4urJKkfh8AzyuZoTzvzAvWa1Bo4@mail.gmail.com>
 <201011030058.53366.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 08:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDY6l-0007J3-SE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 08:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab0KCHuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 03:50:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51217 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab0KCHuF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 03:50:05 -0400
Received: by iwn10 with SMTP id 10so448040iwn.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QrTBsaMsU/jmKL9gZEJQkkQE2my+I+l880qC3XQAcpw=;
        b=o2zkCbxbzo5r6qpjD2lxPCID66tGhKBp9pDo7APOpDWhq2Oe4mTP6Qn9rQRsfo90uf
         I4I0Ar7fxBZxLqsv0giMHC7UMNG+dueuW6O0hjryuoCgDP9r2V/Vr0zMpugPJpHADEe9
         S+wcGB9TPEX7+8A0nJddWqRUemhkDycrofdjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eJvPLgshQUs/vm/lBhtEK+30kItEB3ca5PkxeTPDwSl5HETXk/fjHKSPjKufv7QcRY
         ERJsbLv4c1vhujNHy97CgNIOQKqUCeb+7jrfkqeVbGHlx63NihbO8vMm4Z2rwbkNTGa1
         MTKIr2CYGEMDvdarvzlMSiGIDVNUuVPIbFl84=
Received: by 10.231.34.6 with SMTP id j6mr8437830ibd.93.1288770604315; Wed, 03
 Nov 2010 00:50:04 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Wed, 3 Nov 2010 00:49:43 -0700 (PDT)
In-Reply-To: <201011030058.53366.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160590>

On Wed, Nov 3, 2010 at 12:58 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Tue, 2 Nov 2010, Giuseppe Bilotta wrote:
>> The limiting seems to be the most debatable part of this patch 8-)
>
> I think that untill this feature gets into gitweb we can only guess
> as to what kind of limiting would look and behave best on RL cases.

I think that in most cases there won't be any need for limiting.
Public cases of lots of remotes with lots of branches are, I suspect,
rare.

>> I'll take the numerical limiting off the routine.
>
> You meant here limiting number of remotes returned (except of case of
> limiting to single remote), isn't it?

Yes.

> We have fill_from_file_info, fill_project_list_info; I think
> fill_remote_heads would be a good name.

That's what will be in the next rehash of the patchset

>>> +sub fill_remote_heads {
>>> + =A0 =A0 =A0 my $remotes =3D shift;
>>> +
>>> + =A0 =A0 =A0 my @heads =3D map { "remotes/$_" } keys %$remotes;
>>> + =A0 =A0 =A0 ## A QUESTION: perhaps it would be better to pass @re=
moteheads as parameter?
>>> + =A0 =A0 =A0 my @remoteheads =3D git_get_heads_list(undef, @heads)=
;
>>> + =A0 =A0 =A0 foreach my $remote (keys %$remotes) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $remotes->{$remote}{'heads'} =3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ grep { $_->{'name'}=
 =3D~ s!^$remote/!! } @remoteheads ];
>>> + =A0 =A0 =A0 }
>>> +}
>
> I now think that passing limit to fill_remote_heads (like you have) m=
ight
> be a good solution (contrary to what I wrote earlier).

I hadn't taken it out anyway, so that's good ;-)

>>> A QUESTION: perhaps it would be better to pass @remoteheads as para=
meter?
>>> I wonder if won't end up with calling git_get_heads_list multiple t=
imes...
>>> well, the improvement can be left for later. =A0Answering this ques=
tion
>>> should not affect accepting this patch series.
>>
>> I'm not sure I actually understand the question. Who should we pass
>> @remoteheads to?
>
> I meant here passing @remoteheads or \@remoteheads, i.e. result of ca=
ll
> to git_get_heads_list, to fill_remote_heads (as one of parameters).
> I was worrying, perhaps unnecessarily, about calling git_get_heads_li=
st
> more than once... but I guess that we did it anyway.

I'm still not sure I follow. git_get_heads_list only gets called once,
with all the remotes/<remotename> pathspecs as a single array
argument. This _does_ mean that when the total number of remote heads
is greater than the limit some remotes will not display complete
information in summary view. The real issue here is, I think, that
there is no trivial way to tell which remotes have incomplete
information and which don't, meaning that in the subsequent
git_remote_block calls we'll have no way to provide visual feedback
(the ellipsis) when some heads are missing.

>>> I'm not sure about naming this variable $urls...
>>
>> I'm open to suggestions. $urls_table ?
>
> It is better.

Can do.

>>> Though I am not sure if it is good public API. =A0Perhaps it is...
>>
>> The alternative would be to have git_remote to handle the single
>> remote case, and possibly even have the action name be 'remote' rath=
er
>> than 'remotes' in that case.
>
> We might want to have 'remote' as alias to 'remotes' anyway.
>
> Though what you propose, having separately 'remotes' for list of all
> remotes, and 'remote' + name of remote, might be a good idea.

I hope you don't mind if I opt to leave these refinements for later ;-)

> Thank you on diligently working on this feature.

Thank you for your review.

--=20
Giuseppe "Oblomov" Bilotta
