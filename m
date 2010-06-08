From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 16:04:44 +0200
Message-ID: <AANLkTikoHwupz8ZycLKko_gaZcsAnnXjlWIU4qpt-_9T@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<20100608052929.GA15156@coredump.intra.peff.net>
	<AANLkTinxcrIV2TM966EkOC_crR0bHdNllEIdibz4gGjd@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, jrnieder@uchicago.edu,
	git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 16:04:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzQC-0005k4-4w
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 16:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab0FHOEr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 10:04:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39181 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab0FHOEq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 10:04:46 -0400
Received: by wyf28 with SMTP id 28so75873wyf.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=oeN44csMioGriUXygRSom3AVsep1C1jdV4e/yHspqss=;
        b=XUIruX3quXLXNAyiV8Mq1kv83q1xQVwQp+gZOixuagHM0p3AFlWuEorG+OUbN/rPEr
         +ZryMqxEk/lEL1X1lQ1Ao+0wI1pj4t7BTN0uorRkGQArFWD0D+Syx5ozi8blOseXvHZi
         1lHz4lgIsdiza36eFy68BjpA6+OvGWh7RU3mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=FnDbbNy4TKiAXvE9ILSmG/ENpucVTYOxzHyn/T7TIqRWlTNR1WyeT8J/nNXd0T+pvC
         YEQWICaGZLuaoLTPo7dsaKhpnpSyttHX9xLQqfyOhIc6gf5T8720qte6uDrrjPK8LD3D
         bKdjzGuDdYszLis2i6hajLwq+D5yJGBAKJveY=
Received: by 10.227.135.7 with SMTP id l7mr7130682wbt.204.1276005884886; Tue, 
	08 Jun 2010 07:04:44 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Tue, 8 Jun 2010 07:04:44 -0700 (PDT)
In-Reply-To: <AANLkTinxcrIV2TM966EkOC_crR0bHdNllEIdibz4gGjd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148675>

On Tue, Jun 8, 2010 at 2:24 PM, Dario Rodriguez <soft.d4rio@gmail.com> =
wrote:
> On Tue, Jun 8, 2010 at 2:29 AM, Jeff King <peff@peff.net> wrote:
>> On Mon, Jun 07, 2010 at 08:58:08PM -0300, Dario Rodriguez wrote:
>>
>>> Default pager was 'less' even when some systems such AIX and other =
basic
>>> or old systems do NOT have 'less' installed. In such case, git just
>>> does not display anything in pager-enabled functionalities such as =
'git log'
>>> or 'git show', exiting with status 0.
>>>
>>> With this patch, git will not use DEFAULT_PAGER macro anymore, inst=
ead,
>>> git will look for 'less' and 'more' in the most common paths.
>>> If there is no pager, returns NULL as if it's 'cat'.
>>
>> Run-time pager detection seems like a reasonable goal, I guess, but.=
=2E.
>>
>>> -const char *git_pager(int stdout_is_tty)
>>> +static int is_executable(const char *name)
>>> +{
>>> + =A0 =A0 struct stat st;
>>> +
>>> + =A0 =A0 if (stat(name, &st) ||
>>> + =A0 =A0 =A0 =A0 !S_ISREG(st.st_mode))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> +
>>> +#ifdef WIN32
>>> +{ =A0 =A0/* cannot trust the executable bit, peek into the file in=
stead */
>>> + =A0 =A0 char buf[3] =3D { 0 };
>>> + =A0 =A0 int n;
>>> + =A0 =A0 int fd =3D open(name, O_RDONLY);
>>> + =A0 =A0 st.st_mode &=3D ~S_IXUSR;
>>> + =A0 =A0 if (fd >=3D 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 n =3D read(fd, buf, 2);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (n =3D=3D 2)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* DOS executables start =
with "MZ" */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(buf, "#!") ||=
 !strcmp(buf, "MZ"))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st.st_mod=
e |=3D S_IXUSR;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 close(fd);
>>> + =A0 =A0 }
>>> +}
>>> +#endif
>>> + =A0 =A0 return st.st_mode & S_IXUSR;
>>> +}
>>> +
>>> +const char *git_pager(int stdout_is_tty)
>>> =A0{
>>> + =A0 =A0 static const char *pager_bins[] =3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 { "less", "more", NULL };
>>> + =A0 =A0 static const char *common_binary_paths[] =3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 { "/bin/","/usr/bin/","/usr/local/bin/",N=
ULL };
>>
>> ...must we really add code with such ugliness as magic PATHs and DOS
>> magic numbers?
>>
>
> I copied the function 'is_executable' from 'help.c' so we already hav=
e
> such code... :p
>

How about just un-staticifying the version in help.c instead of
duplicating it, then? That way we'd have half the ugliness for this
purpose...

--=20
Erik "kusma" Faye-Lund
