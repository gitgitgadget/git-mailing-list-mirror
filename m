From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Wed, 13 Apr 2011 20:24:44 +0700
Message-ID: <BANLkTikKyJb283ZTaX0q=BYkCtp_48Yocg@mail.gmail.com>
References: <4DA59B27.50506@ge.infn.it> <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net>
 <BANLkTimubmaV437LvdG8QcmFFjyWujQRzw@mail.gmail.com> <4DA5A228.2040105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matej Batic <matej.batic@ge.infn.it>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:33:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA0Bp-00044r-Ou
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 15:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab1DMNcs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 09:32:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39483 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab1DMNcr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 09:32:47 -0400
Received: by bwz15 with SMTP id 15so572703bwz.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=rqK1P0S05l7h4lsxzipojCltmoeAOb1aa5La0fQBEyc=;
        b=NB51IaOaZdlsPaclS8F6VOiB7LqblIuMtGDIKOFCgIzBDxlOpwmEXaPQ3+p4vg8qaP
         h9CRq9YsvltQVXmMkGavXDaJxIjGpUq9aPlC1/JBiFCDI1FaHjFbXDDGxcLzLZgGfAdV
         hVj8u4Z4en1qWcQuY5tKM7dn8OG+Rw7bVXXPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=a7WEU+8O11oQiyGkL6t0i2w2g+JWaz7NEczwEkHokMRI/tdLTtHzmOInhjlg3AdbAo
         kLpPsfUsIb3wpEpvj7Fr2RRP1UOs2j8FBZNyYXLgefBgH9VxF7eFM9r2dTfKFhrP2cqi
         4UBYBtazsAClv0oK5OVXik/tVanTjqIRVt1y8=
Received: by 10.204.20.143 with SMTP id f15mr2555898bkb.173.1302701561792;
 Wed, 13 Apr 2011 06:32:41 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Wed, 13 Apr 2011 06:24:44 -0700 (PDT)
In-Reply-To: <4DA5A228.2040105@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171457>

On Wed, Apr 13, 2011 at 8:16 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 13.04.2011 15:12:
>> On Wed, Apr 13, 2011 at 8:05 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D run_command_v_opt(alias_argv, RUN_USING_SHELL);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strbuf_addstr(&sb, "GIT_CWD=3D");
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (subdir)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&sb, subdir);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env[0] =3D sb.buf;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 env[1] =3D NULL;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D run_command_v_opt_cd_env(alias_argv, RUN_USING_SHELL=
, NULL, env);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strbuf_release(&sb);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (ret >=3D 0) =C2=A0 /* normal exit */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(ret);
>>
>> subdir can be NULL. I'm not sure if it can be empty string though. M=
ay
>
> I'm pretty sure that my "if (subdir)" would catch that...

Yes. I skimmed too quick and realized after sending my email.

>> need a check and set it to '.' so "cd $GIT_CWD" does not go back to
>> $HOME.
>
> Well, with the current implementation you get empty or the subdir so
> that you can easily "test -n $GIT_CWD". If you want to cd around you =
can
> do "cd ./$GIT_CWD" unconditionally. I think this is more useful than
> having a "." there.

In that case should the variable have a another name? CWD/PWD is
usually absolute path. "cd ./$GIT_CWD" looks odd to me. Or you can
getcwd() and set $OLDPWD.
--=20
Duy
