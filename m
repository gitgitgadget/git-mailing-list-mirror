From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 6/8] config: add core.untrackedCache
Date: Wed, 2 Dec 2015 11:32:50 +0100
Message-ID: <CACBZZX5eQuaYumFcuW6PO_FCrAd3Vqq8gPyg5JeZ4Kk+0YBGRQ@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
 <1449001899-18956-7-git-send-email-chriscool@tuxfamily.org> <565E99F9.2020906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a44ir-0005Wb-2K
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 11:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbbLBKdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 05:33:12 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33478 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbLBKdL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 05:33:11 -0500
Received: by qgea14 with SMTP id a14so28869254qge.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SkcMdz95/xQf01bG4e+Hnu2/nW427VWuGvpIMWlGPbE=;
        b=EeALSpK+kaGF5SkhOBcFTzG7iBrapFL0nnZoD675TbTXMZwDL4WkGNq1ONyrV1mn7S
         xDIniEQa/Tx48Uf5Rh0HuJeDFimQnilVKi3DxwEEn0vDwP1R9ASW1x1z/MfgGq3cnz7Y
         A5iO40monD+Xldp2gIz4ukZhHg0Go+uSyWmW8/bIIWq/u8mMdNMr2c3MGWSpkwH+GIOS
         elG+DLaGeXoqFMJjIwN90u58j2ZdmAAzVE5e4uVzvLm94pGaXEiW8MsAXK+nrLrta+aR
         IzxB69vmg2kGKT/IMlQgksNq+nmEr/vjJTpUye1yTXCdHHJYmD33zPy5eJ/1OYDWNDdq
         vTVQ==
X-Received: by 10.140.143.208 with SMTP id 199mr3085891qhp.84.1449052390329;
 Wed, 02 Dec 2015 02:33:10 -0800 (PST)
Received: by 10.55.43.144 with HTTP; Wed, 2 Dec 2015 02:32:50 -0800 (PST)
In-Reply-To: <565E99F9.2020906@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281886>

On Wed, Dec 2, 2015 at 8:12 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 12/01/2015 09:31 PM, Christian Couder wrote:
>>
>> When we know that mtime is fully supported by the environment, we
>> might want the untracked cache to be always used by default without
>> any mtime test or kernel version check being performed.
>

[Re-arranged some of the quotes for the clarity of my reply....]

[Also: Full disclosure, Christian is working on this for Booking.com,
and I'm managing that project...]

> I always want to test and verify that the untracked cache is working,
> before I rely on it.

Then with this patch you can just not use the core.untrackedCache=3Dtru=
e
option, or with the later patches in this series use "git update-index
--test-untracked-cache && git config core.untrackedCache true".

> I'm not sure if ever "we know" ?
> How can we know without testing ?
> I personaly can not say "I know" in all the different system I am usi=
ng,

Some users of Git can know that their mtime works, just like they know
they deploy it on filesystems where say symlinks work.

The current implementation of turning on this feature needs to be run
on a per-repo basis and without the --force option includes mandatory
tests, which a) makes it inconvenient to deploy across all Git repos
on a set of machines b) Is needlessly paranoid as a default way to
enable it.

>> Also when we know that mtime is not supported by the environment,
>> for example because the repo is shared over a network file system,
>> then we might want 'git update-index --untracked-cache' to fail
>> immediately instead of it testing if it works (because it might
>> work on some systems using the repo over the network file system
>> but not others).
>
> Same here.
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>   Documentation/config.txt               | 10 ++++++++++
>>   Documentation/git-update-index.txt     | 11 +++++++++--
>>   builtin/update-index.c                 | 28 ++++++++++++++++++----=
------
>>   cache.h                                |  1 +
>>   config.c                               | 10 ++++++++++
>>   contrib/completion/git-completion.bash |  1 +
>>   dir.c                                  |  2 +-
>>   environment.c                          |  1 +
>>   wt-status.c                            |  9 +++++++++
>>   9 files changed, 60 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index b4b0194..bf176ff 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -308,6 +308,16 @@ core.trustctime::
>>         crawlers and some backup systems).
>>         See linkgit:git-update-index[1]. True by default.
>>   +core.untrackedCache::
>> +       If unset or set to 'default' or 'check', untracked cache wil=
l
>> +       not be enabled by default and when
>> +       'update-index --untracked-cache' is called, Git will test if
>> +       mtime is working properly before enabling it. If set to fals=
e,
>> +       Git will refuse to enable untracked cache even if
>> +       '--force-untracked-cache' is used. If set to true, Git will
>> +       blindly enabled untracked cache by default without testing i=
f
>> +       it works. See linkgit:git-update-index[1].
>> +
>
> Please no.
> The command line option should always be able to overwrite any settin=
gs
> from a config file.

If we keep this patch and not the rest in this series (which I think
should also be applied) you'd either use the update-index way of
changing the setting, or the config option.

> Sorry, I may missing the big picture here.
> What exactly should be achieved ?
>
> A config variable that should ask Git to always try to use the untrac=
ked
> cache ?
> Or a config variable that tells Git to never use the untracked cache =
?
> Or a combination ?
>
> core.untrackedCache::
>  false: Never use the untracked cache ?
>  true: Always try to use the untracked cache ?
>        Try means: probe, and if the probing fails, record that if fai=
ls in
> the index,
>        for this hostname/os/kernel/path (Don't remember all the detai=
ls)
> unset: As today,

As discussed in the "[RFC/PATCH] config: add core.trustmtime" thread
this feature is IMO needlessly paranoid about enabling itself.

Current state of affairs:

 * Enable on a per-repo basis: git update-index --untracked-cache
 * Disable on a per-repo basis: git update-index --no-cache
 * Enable system-wide: N/A
 * Disable system-wide: N/A

With this patch:

 * Enable on a per-repo basis: git update-index --untracked-cache OR
"git config core.untrackedCache true"
 * Disable on a per-repo basis: git update-index --no-cache OR "git
config core.untrackedCache false"
 * Enable system-wide: git config --global core.untrackedCache true
 * Disable system-wide: git config --global core.untrackedCache false
 * Caveat: The core.untrackedCache config has precidence over "git upda=
te-index"

With the rest of the patches in this series:

 * Enable system-wide & per-repo the same, just tweak
core.untrackedCache either for the local .git or --globally
 * If you want to test things either per-repo or globally just use
"git update-index --test-untracked-cache"
 * If you want something exactly like the old --untracked-cache do:
"git update-index --test-untracked-cache && git config
core.untrackedCache true"

I think applying this whole series makes sense. Enabling this feature
doesn't work like anything else in Git, usually you just tweak a
config option and thus can easily enable things either system-wide or
per-repo (or any combination of the two), which makes both system
administration and local configuration easy.

A much saner UI for the CLI tools if we're going to ship git with
tests for filesystem features is to separate the testing from the
enabling of those features.
