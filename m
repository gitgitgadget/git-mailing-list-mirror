From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v4 6/6] completion: add public _GIT_complete helper
Date: Mon, 7 May 2012 22:57:08 +0200
Message-ID: <CAMP44s2H1Fn-wY9bBnsjVUgE5ZRM4q-kOAtSHTm=tb1ku2xCvA@mail.gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
	<1336353800-17323-7-git-send-email-felipe.contreras@gmail.com>
	<7vbolz6cs9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 22:57:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRUzb-00088i-F5
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 22:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457Ab2EGU5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 16:57:10 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33806 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189Ab2EGU5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 16:57:09 -0400
Received: by eaaq12 with SMTP id q12so1533777eaa.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WCus6ct1hNlFGDsuw8AozlqGvhjQbAlpE7sDEkYbcfM=;
        b=wvI5qPgXA+z5VvsTtx4lu5qeJIjsbCFigGddvvnSzCMWwjG/xmje6Ho04RXXteGNTt
         KpVmvjHlMouRPaGv95p8UKUKrPvoJOjoKv6umTcuwkAuJ0gelkJrCghCeH8N/9bdNqGc
         sCOAgYAn+o64VDQ7ywtKriPuZ95LNvKXj/W9Ib8NVwaK8Uo8SEfLj6voysypJGZVceEO
         T9NR3GDOVChxCvkM70gXPWO/7+sshehlfVO+bC7xG3wtZMTdmHt/cTfx2P/+e7/qV5Qo
         zHEs3umUfzeyyINTaHQ3cSKhpyZOiQ2X4+mkVrsoYiHVs/sAwrHrBnQdvomi7omzKUxd
         BzxA==
Received: by 10.14.96.6 with SMTP id q6mr410672eef.6.1336424228145; Mon, 07
 May 2012 13:57:08 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Mon, 7 May 2012 13:57:08 -0700 (PDT)
In-Reply-To: <7vbolz6cs9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197305>

On Mon, May 7, 2012 at 8:56 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So that users can easily define aliases, such as:
>>
>> =C2=A0_GIT_complete gf git_fetch
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 10 +++++-----
>> =C2=A0t/t9902-completion.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 ++++++++-
>> =C2=A02 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 049110e..2b7ef02 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2678,6 +2678,7 @@ _gitk ()
>>
>> =C2=A0__git_func_wrap ()
>> =C2=A0{
>> + =C2=A0 =C2=A0 local cmd=3D"${1#git_}" cmd_pos=3D1
>> =C2=A0 =C2=A0 =C2=A0 if [[ -n ${ZSH_VERSION-} ]]; then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emulate -L bash
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setopt KSH_TYPESET
>> @@ -2695,8 +2696,7 @@ __git_func_wrap ()
>> =C2=A0 =C2=A0 =C2=A0 _$1
>> =C2=A0}
>>
>> -# this is NOT a public function; use at your own risk
>> -__git_complete ()
>> +_GIT_complete ()
>
> If it is now a public function, please have some description as to ho=
w to
> use it for people who find this in the tarball extract.

This is RFC, I'm not planning to push for this, I truly have given up o=
n it.

> I am guessing that
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0_GIT_complete frotz git_fetch
>
> is a way to declare that 'git frotz' wants the same kind of completio=
n as
> 'git fetch' command, but I am not sure, as if it were the case it str=
ikes
> me somewhat odd that it is not "_GIT_complete frotz fetch".

Yeah, I think that would be nicer, but one would need to take into
consideration the git/gitk cases.

Hopefully somebody else would pick this up and go through the eternal
nitpicking.

Cheers.

--=20
=46elipe Contreras
