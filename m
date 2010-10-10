From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 09/10] [RFC] tg-patch: use ui diff when pager is active
Date: Sun, 10 Oct 2010 10:04:46 +0200
Message-ID: <AANLkTikO0bVgwezMP0HT7z1WL68z4hURx3Gb2qVsqw2P@mail.gmail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
	<0fd777939e0ca49b6e0013ab667cadbfae55e879.1286524446.git.bert.wesarg@googlemail.com>
	<20101009204348.GO29673@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun Oct 10 10:05:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4qtw-0003vs-4e
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 10:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab0JJIEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 04:04:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43801 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab0JJIEq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 04:04:46 -0400
Received: by iwn6 with SMTP id 6so2063092iwn.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=safHc1WT3hTL0EkVZlXOlQIBjIW5XVo/jm6nxnas8Rw=;
        b=Fw56bDbiej3QX6cZFm7+szao529w8qL/5MacA8dyGWndt4FIuGlnLtv8+IzCc9EB1s
         iCo4uDg8neFCLuwfc+JF6bcb3GnkePKzxaZUg6mGNW0aPcxlx8jn6buMF1cRqSduZ9mX
         tkjp+yvMOdiGyMoSdBTF596Q+48J2qALb+2lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VBBTYR0xK5VNtLhasYnu7J7T/HdNjbQSF++WsSHAZgNdLDJhlm4n5StKVAENxxVm6Z
         ca4GahMxenIr/xKTi4uwl79O2QenmzYhkT1usbkE+Oufk8Zgu5lJDfrQEAZcs8WvV+TP
         LmafCQOr5rEQ+B7X2FmCEhlEHX29bcAADvaI4=
Received: by 10.231.11.197 with SMTP id u5mr2626371ibu.41.1286697886130; Sun,
 10 Oct 2010 01:04:46 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Sun, 10 Oct 2010 01:04:46 -0700 (PDT)
In-Reply-To: <20101009204348.GO29673@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158650>

2010/10/9 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
>
>
> On Fri, Oct 08, 2010 at 09:58:07AM +0200, Bert Wesarg wrote:
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> can you tell me the motivation for this patch again? =C2=A0It should =
go into
> the commit log, too.

My motivation is, that diff-tree should be used to generate patches
meant for submission (or non-human consumption). But for pure human
inspection some 'eye-candy' effects could take considerations. Like
color, renames, mnemonicprefix, or noprefix. External diff driver or
word-diff. All these are in effect by using the diff command, when
configured in your git config file. diff-tree does not honor these
configure options but its possible to give them as command line
options too. Selecting the plumbing or ui diff driver is best done
automatically, in my opinion, and the active pager is my best bet that
a human will consume the output. I will probably add an overwrite
command switch (to enable ui mode even without an active pager, I
sometimes pipe the output for inspection into my editor) shortly.

I don't know if this is suitable for the commit log. If so I will try
to fit it in.

Bert

>
> Thanks
> Uwe
>
>> ---
>> =C2=A0tg-patch.sh | =C2=A0 =C2=A07 ++++++-
>> =C2=A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/tg-patch.sh b/tg-patch.sh
>> index 9def6e5..dcce672 100644 tg-patch.sh
>> --- a/tg-patch.sh
>> +++ b/tg-patch.sh
>> @@ -70,7 +70,12 @@ t_tree=3D$(pretty_tree "$name" $head_from)
>> =C2=A0if [ $b_tree =3D $t_tree ]; then
>> =C2=A0 =C2=A0 =C2=A0 echo "No changes."
>> =C2=A0else
>> - =C2=A0 =C2=A0 git diff-tree -p --stat $b_tree $t_tree
>> + =C2=A0 =C2=A0 # use the ui diff command when the pager is active
>> + =C2=A0 =C2=A0 diff_command=3Ddiff
>> + =C2=A0 =C2=A0 [ "x$GIT_PAGER_IN_USE" =3D "x1" ] ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff_command=3Ddiff-tree
>> +
>> + =C2=A0 =C2=A0 git $diff_command -p --stat $b_tree $t_tree
>> =C2=A0fi
>>
>> =C2=A0echo '-- '
>> --
>> 1.7.1.1067.g5aeb7
>>
>>
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Uwe Kleine-K=C3=B6nig =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
