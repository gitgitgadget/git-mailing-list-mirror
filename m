Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CEC61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 09:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCEJcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 04:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCEJcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 04:32:09 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C602E12071
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 01:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1678008723; i=l.s.r@web.de;
        bh=E4xa0EBEpfaWjTd3ZfZNJ9XpDoACBLaCxB9XrjfSruw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=R1BG/PspL3gP477GHPAVl8tCPymuyySLzoAKX+b5PQvL5Yjx/pjPEKjc25Se5LS0j
         9S/kNWGB2A41BEXqo1uYdCf5dUAweASny/8AqYxJh45OtxC5q4Lph+RZmusZAsYsKO
         C+sma1u2sZIGxb62DJLYxoCD2cKI2pBGcbP9cVypHrVr+Ib8q+svwhc3cz69JbuWtN
         ejJuBfkn0BPHGu1G8rN2XoZmacTuns8pIL20+RKcPPKXaFPu85NpEax4jo/XAqXgTV
         HpT3WzouRUxi625wXfAZCsjkjumFZTRUvHb8JFmpZXtyBzPrlYy1ypkHcCtxQydwBw
         UepWBfBzYYRmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMpCS-1ppBg70eRQ-00J15d; Sun, 05
 Mar 2023 10:32:03 +0100
Message-ID: <c91db499-fa26-b902-3ab8-14c52959482f@web.de>
Date:   Sun, 5 Mar 2023 10:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: Bug in git archive + .gitattributes + relative path
To:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
 <566c2d09-5e18-49c9-fc7c-7b92d1d7c198@mpsd.mpg.de>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <566c2d09-5e18-49c9-fc7c-7b92d1d7c198@mpsd.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4CmdlM6rBEjajeqjPWMhSsX/psp+/TdppSQUI+/B7xveAs7EMZA
 n+D4axnI1rOAnoqT/Jk/bOAs/Yqp3OtWrbQ8UxcYiEi/1ugOKdqXtlZKKsYRGK4fqRvHmdy
 662UjB8rk0AVPiC/9OabSLa0G7zy+mi3L602PNUnKEMTvvbIWi2k+a2fIGD5GfmGbrl+o63
 37ZLINNbYmeIGFASQX9Ew==
UI-OutboundReport: notjunk:1;M01:P0:ZAX1kCCFBqs=;/FrO5T8LnaNUctxdOKTvralSAIF
 4RCCbGziVHToZniiPGpo+TIgf5OSD6FeiVeEX1CMnNmEjsKs6PAKNbDBWHTaZaCicF0v8RtVe
 JbT1G49zRD8O45uijK61AMFeBy9cQGLH2tbnwU3Aeuh+AYoUmc/W1Ti/BcdOAbZDcE4KZidzp
 wI9V8pvVUmM2DnSMTd0PM9XX3xeHYTTmZ6PESHqqk9dgr9fbx74sJm040Xp9CtzWRrc42Pp3H
 5PRvA16nKBBPsVp5+8b0gdS/HidYcuF2cNDAWhsg/HtKcpoQXG5/ZpfMyVQdeWSshkSGC2UjX
 JgDlLo0WqpIMWgpoXf4F8kda/fPFw+5vcm5V+M33VFpzN+oiIlqZ0qLyopxCQyund9YwfiCbC
 X6CWgfePre3oPWOSemdFMIEQKxGgR5JUPIEteznTLHK2vPMEXh8kqv48NileSD6L8mOQQmhsY
 fnCJQPU7TSVC0b6aVPDu2rmmNwyXxwCEd0KFExkvpwfhv4VLCHXZ1AX6vuLMJTU6vfFVpGAY7
 AQvAaWJnst2AS11QyBr/Q5Fk7MT7JFc8GSyitP986CzJ4OAAIjbG5aF6273GaUBK5OZ69whtv
 ZWZOcrMllzAV+AdJNZHaBHyAg3Zj6vqUedO0p02SspZhn9izKYZSTJOd8SluJ8tyQhHWTuS/T
 +f1413AB+51Skrq9VFkItKyJ9K7LAdCVV9Ptt84qJUsp0/n/9HqvugoHEftHZw1EarGMxlIIV
 DQF7LUKPf+TG2jPbjhAAVK0Qypq9M5qvAhwLBCK5pHwcnBMrHjhHksrACkJg0Q71Wco4bryjN
 94NcbMYOlv+7T9h3vimoFOdzQU0YFHSvSVnI8BRpAC2Eq18y5chupPkgQUaZGGxWSA6O9uAzG
 iKAyTQDeFQGGQNbqSjmMKUAW8Dbp2CWvNr+B+mDO7CVQvxLHKsZeDfpSsTFlfF2GClykLSsek
 iYvmuQwRTY0ZGy355XMK81L/clA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.03.23 um 16:11 schrieb Cristian Le:
> I should have explained more thoroughly, I have tried to work around
> by doing a `git archive` and then extracting and re-compressing after
> fixing the paths, but this does not preserve the owner and timestamp
> of the original `git archive`, nor can I use the current
> implementation of their tar fixer to correct these since the headers
> are different. I do not have enough expertise to know what headers
> need to be set, how to set the timestamps and so on.

GNU tar has the options --owner, --group and --mtime that allow you to
specify arbitrary values for these fields when archiving, no header
tinkering needed.  That said, tarring with git archive, untarring and
retarring with GNU tar is overly complicated and horrible when git
archive can do the whole job itself.

> I don't know if the `gzip -n -c` could do a better job at that,

That just compresses tar files to tgz (or tar.gz) format and does not
affect any tar headers.

> but we would still
> not be able to use it as is because we would want the correctly
> generate `export-subst` files, for example for a project built with
> `setuptools_scm` that injects the version of the python package from
> the last tag:
>
> https://github.com/pypa/setuptools_scm#git-archives

Note that git archive allows injecting extra files with the options
 --add-file and --add-virtual-file.  Could that feature perhaps be used
instead of export-subst?

>> There it was introduced along with a script that changes the mtime
>> of archive entries from the current time to the commit timestamp by
>> https://github.com/spacewalkproject/spacewalk/commit/34267e39d472.
> Thanks for pointing me to this. From your understanding, if we only use =
the git commit directly, we would in principle not need the whole tar fixe=
r (https://github.com/rpm-software-management/tito/blob/91ef962220ec515472=
2760dbbd982bed032ee484/src/tito/tar.py#L28-L60 and https://github.com/rpm-=
software-management/tito/blob/91ef962220ec5154722760dbbd982bed032ee484/src=
/tito/common.py#L871-L890)? If there is no crucial information in the head=
er that is different between the `git archive` and the `tar`/`gzip` with a=
ppropriate `mtime`, `mode` and maybe others, maybe there is some hope in f=
ixing this locally.

The tar fixer was rewritten in Python in the meantime and I didn't look
it it closely, but if it only sets the mtime of all archive entries to
the commit date then it's not needed when giving git archive a commit
or tag instead of a tree.

> I'll be looking forward to `--strip-components`, but just to confirm
> my reading of the email, the intent is to have it working with
> `export-subst` right?
That option would work the same regardless whether git archive is given
a tree, commit or tag, and it doesn't care about attributes or file
contents.  It would be especially helpful when giving a commit or tag
and a pathspec, and export-subst needs a commit or tag.  So in short:
Yes. :)

Ren=C3=A9
