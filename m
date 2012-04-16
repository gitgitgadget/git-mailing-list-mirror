From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last change
Date: Mon, 16 Apr 2012 22:06:49 +0200
Message-ID: <201204162206.50631.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl> <201204141516.02719.jnareb@gmail.com> <20120416101242.GK17753@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsCQ-0000gb-IW
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab2DPUGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 16:06:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56286 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2DPUGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:06:53 -0400
Received: by wgbdr13 with SMTP id dr13so5630022wgb.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=YTZtZnGNH0RiNYwlNnxkjjAMqFqIaDY4fvkPDIW2aiA=;
        b=Sn2dMCwvICkYHrZMjrcd52zrENfHc1VvXU1yinHwIfaIlArgzQtnozAqgM+oDF3fXT
         LefOS45ZDl5488nsPOxhqG6CR4FM4lk2LunPP3Jkc5h9OcCFgZXvaOlP59suCone3AOh
         XY1ZWos63LK8a5PYyttnvg7s0bv1vnEbbIJDmX0hH1Hew7peBx1fkOaHaj8fy/VNhcxJ
         TY95oTKyKKJz+rw4HisC+ISL76yNgcTB3YubaS8aWKL9AWgRit5pS0Nq31Dxr+FHUIU6
         EWFfJpBRaSeQ5rz3Hni6AGaacwtgd8Ghm4gN6udbruCE+8gsm2vT4KvgYhlyY0UaEp8D
         o1tA==
Received: by 10.180.89.98 with SMTP id bn2mr391198wib.22.1334606811701;
        Mon, 16 Apr 2012 13:06:51 -0700 (PDT)
Received: from [192.168.1.13] (aedx242.neoplus.adsl.tpnet.pl. [79.186.101.242])
        by mx.google.com with ESMTPS id ca3sm21810387wib.6.2012.04.16.13.06.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 13:06:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120416101242.GK17753@camk.edu.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195683>

On Mon, 16 Apr 2012, Kacper Kornet wrote:
> On Sat, Apr 14, 2012 at 03:16:01PM +0200, Jakub Narebski wrote:
>> On Wed, 4 Apr 2012, Kacper Kornet wrote:
>>> On Wed, Apr 04, 2012 at 04:31:42PM +0200, Jakub Narebski wrote:
>>>> On Wed, 4 April 2012, Kacper Kornet wrote:
>>>>> On Wed, Apr 04, 2012 at 01:12:01AM +0200, Jakub Narebski wrote:
>>>>>> On Tue, 3 Apr 2012, Kacper Kornet wrote:
[...]=20
>>>> But the fact that it also saves a fork (a git command call) per re=
pository
>>>> reminds me of something which I missed in first round of review, n=
amely
>>>> that generating 'age' and 'age_string' fields serve also as a chec=
k if
>>>> repository really exist.
>>>>=20
>>>> So either we document this fact, or use some other way to verify t=
hat
>>>> git repository is valid.
>>>=20
>>> I think that git_project_list_body always works with the list retur=
ned
>>> by git_get_projects_list. And git_get_projects_list validates if th=
e
>>> path is a git repository. So it should not be a problem. Please cor=
rect
>>> me, if I am wrong.
>=20
>> If $projects_list points to plain file, git_get_projects_list() just
>> gets list of projects (and project owners) from $projects_list file
>> by reading and parsing this file.  No verification that repository
>> exists is done.
>=20
> I think that even in this case check_export_ok is called. But there i=
s
> still the problem you have mentioned below.

True, somehow I missed the fact that check_export_ok() is called to
check if it looks like repository and if it is to be exported in both
cases ($projects_list a directory or a file).

>> If $projects_list points to directory (which is the default), then
>> git_get_projects_list() scans starting from $projects_list directory
>> for somtehing that _looks like_ git repository with check_head_link(=
)
>> via check_export_ok().  But you still can encounter something that
>> looks like git repository (has "HEAD" file in it), but isn't.
>>=20
>> So we would probably want to have said variable or set of variables
>> describe three states:
>=20
>> * find date of last change in repository with git-for-each-ref calle=
d
>>   by git_get_last_activity(), which as a side effect verifies that
>>   repository actually exist. =20
>>=20
>>   git_get_last_activity() returns empty list in list context if repo
>>   does not exist, hence
>>=20
>>   	my (@activity) =3D git_get_last_activity($pr->{'path'});
>>   	unless (@activity) {
>>   		next PROJECT;
>>   	}
>>=20
>> * verify that repository exists with "git rev-parse --git-dir" or
>>   "git rev-parse --verify HEAD", or "git symbolic-ref HEAD", redirec=
ting
>>   stderr to /dev/null (we would probably want to save output of the
>>   latter two somewhere to use it later).
>>=20
>>   That saves I/O, but not fork.

Actually if you look at the footer of projects list page with 'timed'
feature enable you see that for N projects on list, gitweb uses 2*N+1
git commands.  The "+1" part is from "git version", the "2*N" are from
git-for-each-ref to get last activity (and verify repository as a
side-effect)...

=2E..and from call to "git config" to get owner (unconditional check fo=
r
`gitweb.owner` override), description (if '.git/description' file got
deleted), if applicable category (file then config), if applicable ctag=
s
(file(s) then config).

So we can rely on "git config" being called, no need for separate
verification.  My mistake.  (Though it might be hard to use this fact.)


Well, with proposed option to remove 'owner' field we would have someti=
mes
to verify repository with an extra git command...

>> * don't verify that repository exists.
>=20
>> Though perhaps the last possibility isn't a good idea, so it would b=
e
>> left two-state, as in your patch.=20
>=20
> My tests show that forks are also a bottleneck in my setup.

What do you mean by "my tests" here?  Is it benchmark (perhaps just usi=
ng
'timed' feature) with and without custom change removing fork(s)?  Or d=
id
you used profiler (e.g. wondefull Devel::NYTProf) for that?

>                                                             On the ot=
her=20
> hand I think that I can trust that my projects.list contains only val=
id
> repositories. So I would prefer to have a don't verify option. Or the=
re
> is a possibility to write perl function with the same functionality a=
s
> is_git_directory() from setup.c and use it to verify if the directory=
 is a
> valid git repo.

Well, we can add those checks to check_export_ok()... well to function
it would call.

is_git_repository from setup.c checks that "/objects" and "/refs"
have executable permissions, and that "/HEAD" is valid via validate_hea=
dref
which does slightly more than (now slightly misnamed) check_head_link()
from gitweb...

=2E..or that DB_ENVIRONMENT i.e. GIT_OBJECT_DIRECTORY environment varia=
ble
is set, and path that it points to has executable permissions.  I don't
think we have to worry about this for gitweb.


I'll try to come up with a patch to gitweb that improves repository
verification, and perhaps a patch that uses the fact that "git config"
succeeded to verify repository.

--=20
Jakub Nar=C4=99bski
