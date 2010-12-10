From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] config: add core.sharedconfig
Date: Fri, 10 Dec 2010 08:29:55 +0700
Message-ID: <AANLkTikAwvsb_rLc45ZTuTHEqYV78dAZCdgw-1f+D1+B@mail.gmail.com>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
 <1291907388-9068-4-git-send-email-pclouds@gmail.com> <7vwrnig6gr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:30:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQroe-00010q-1T
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742Ab0LJBa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 20:30:27 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53918 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757720Ab0LJBa0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 20:30:26 -0500
Received: by wyb28 with SMTP id 28so2922659wyb.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WALRX9STZBOwPq/29IGGMISpqzyyHgJkGvjQ1fTGfB0=;
        b=t4pzOT795SyWjVV1wTuonBUhYa+vWE8tL4SFFgWt6tZG+gs+OiUWYx4CDLFon02vSi
         7gZUkVkA15u6Sx8JICYmDHyYHW8B5o/300GSrQOvWQGlZdMTDjrb5VjttSd4L70Fk/qL
         Emu2ROBffPOpP/xEmz1vRoxTa65QeYtkKpN6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NJMzgOFrLQBOs6afJ5Rk+VZE3whwu5LEOegKfAiU8iCH5S06wfPKCbjTXv4xbsUGgh
         xgCLj3zxhI2mJ1G/1Dc7H+gqMN1iKNZr1/LmCR7rlvx8yczxztn88jF8/yM+bsr7IZov
         Y98mCd9/GQGeZ+RCTZ9dO16G8tBr1tttvqKnI=
Received: by 10.216.24.134 with SMTP id x6mr1403568wex.34.1291944625246; Thu,
 09 Dec 2010 17:30:25 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 9 Dec 2010 17:29:55 -0800 (PST)
In-Reply-To: <7vwrnig6gr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163375>

2010/12/10 Junio C Hamano <gitster@pobox.com>:
>> @@ -910,6 +918,12 @@ int git_config(config_fn_t fn, void *data)
>>
>> =C2=A0 =C2=A0 =C2=A0 repo_config =3D git_pathdup("config");
>> =C2=A0 =C2=A0 =C2=A0 if (!access(repo_config, R_OK)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_config_from_file(get=
_shared_config, repo_config, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (core_shared_config) =
{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret +=3D git_config_from_sha1(fn, core_shared_config, data);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 found +=3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>
> What is the point of this "found++" when you will increment it for fi=
nding
> the repository-local configuration anyway?

It seems that every time a config source is used, found++. So I
increase it because there's is another source used, a blob.

> I originally liked what the first two tried to do, but think about th=
e use
> case. =C2=A0How would this whole thing work?
>
> =C2=A0- The user clones from the project to get a repository with a w=
orking
> =C2=A0 tree;
>
> =C2=A0- The user somehow learns that s/he can run one command to get
> =C2=A0 project-wide preference of the project:
>
> =C2=A0 =C2=A0 $ git config core.sharedconfig refs/remotes/origin/conf=
ig:git.config
>
> =C2=A0- Everything hopefully should work the way project wishes in th=
at blob,
> =C2=A0 unless the end user later overrides them by adding different s=
ettings
> =C2=A0 to .git/config.
>
> How is that different from:
>
> =C2=A0- The user clones from the project to get a repository with a w=
orking
> =C2=A0 tree;
>
> =C2=A0- The user somehow learns that s/he can run one command to get
> =C2=A0 project-wide preference of the project:
>
> =C2=A0 =C2=A0 $ ./setup-project-preference.sh
>
> =C2=A0 Typically, such a ./setup-project-preference.sh script would o=
nly
> =C2=A0 consist of a series of "git config $foo $bar", so any user who=
 can say
> =C2=A0 "git config core.sharedconfig $foo" should be able to use it a=
s well.
>
> =C2=A0- Everything should work the way project wishes with the settin=
gs made to
> =C2=A0 .git/config by the script, unless the end user later overrides=
 them by
> =C2=A0 modifying settings in .git/config.

The shared config can be updated automatically (after fetching, of
course). Remote setup for a small team, for example, can benefit from
this. Every time a new member joins, somebody adds new remote to the
shared config and pushes out. Everybody else will have it.

> One minor difference is that some configuration variables are additiv=
e,
> and you cannot subtract from them with your approach.

You can't subtract some keys from $HOME/.gitconfig by modifying
$GIT_DIR/config either. I mean, that could be addressed in a general
way, not specific to shared config.
--=20
Duy
