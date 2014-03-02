From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 24/27] prune: strategies for linked checkouts
Date: Sun, 2 Mar 2014 07:01:23 +0700
Message-ID: <CACsJy8CbE0VH_2bAH3weokuHVMUor9es7bgT7rWFi28fJjZ36w@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com> <1393675983-3232-25-git-send-email-pclouds@gmail.com>
 <5312151B.6080605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 01:02:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJtrQ-0007yW-8B
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 01:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbaCBABz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 19:01:55 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:64468 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbaCBABz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Mar 2014 19:01:55 -0500
Received: by mail-qc0-f172.google.com with SMTP id i8so2369845qcq.17
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5gFSKtSUWhZnSLD+v3afOAqs4Vkst5H+ziyRdhVl3iA=;
        b=GH6yF4O811XRkLSFUvLWaciNKuWpNBYGZE+YrLNbCmRdnVdznWMG0plUQ7N58u25Yb
         cwRgNtqnZMB/Y96a3RddEZw4BLprpCuO2Ckre1G3bT7WTE5DmNuKikGP1efaHGxlnwuJ
         OeuaGGz7g5Zuty6uu9oV+vR/g8kfpLeK0rs+ANnHacG90N1yD/W1AZjPhdeGpouonqv6
         e+wVM7XAzkZuRhrBcMIPUdGQC5q2A/06EYHHy7QWww06EyAXVAkXXRx9wVwRttL6Z0TP
         C3KjxiRexEIzM1loNnYliyTyeOP1d5/cxzFVS1NotbJhjFbfzE3hFLaUxarnB1LiskG1
         dJJw==
X-Received: by 10.229.112.5 with SMTP id u5mr5331066qcp.3.1393718514287; Sat,
 01 Mar 2014 16:01:54 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 1 Mar 2014 16:01:23 -0800 (PST)
In-Reply-To: <5312151B.6080605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243114>

On Sun, Mar 2, 2014 at 12:12 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2014-03-01 13.13, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> []
>>
>> +static dev_t get_device_or_die(const char *path)
>> +{
>> +     struct stat buf;
>> +     if (stat(path, &buf))
>> +             die_errno("failed to stat '%s'", path);
>> +     /* Ah Windows! Make different drives different "partitions" */
>> +     if (is_windows())
>> +             buf.st_dev =3D toupper(real_path(path)[0]);
>> +     return buf.st_dev;
>
> Is this only related to Windows ?

Yes. At least the treatment is Windows specific. If st_dev =3D=3D 0 in
other cases, then we have to deal with them case-by-case.

> Do we have other file systems, which return st_dev =3D=3D 0 ?
> Should we check that path[0] !=3D '/', or better !is_dir_sep(path[0])=
 ?
> Do we need has_dos_drive_prefix() ?

real_path() returns an absolute path, so we're guaranteed its first
character is the drive letter, right? (I tried to confirm this by
reading read_path_internal, but it's a bit complex, and I don't have
Windows machine to quickly test it out)

>
> As a first suggestion, would this be better:
>
>> +     if (!buf.st_dev)
>> +             buf.st_dev =3D toupper(real_path(path)[0]);
>
> (End of loose thinking)



--=20
Duy
