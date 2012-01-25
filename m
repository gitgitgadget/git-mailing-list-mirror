From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Wed, 25 Jan 2012 01:39:11 +0000
Message-ID: <CAOpHH-UxD37v7N3U9A0c_MnzSjOcF6eJCx2WdHRKf2CFoYy_tg@mail.gmail.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com> <7vehutd59p.fsf@alter.siamese.dyndns.org>
 <CAOpHH-Wcf3innjA4LS0TMrLzEwbQzfZmHssxSBYvv4v7UMfi1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 02:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rprq1-0004fL-CY
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 02:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab2AYBjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 20:39:44 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40230 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755467Ab2AYBjn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 20:39:43 -0500
Received: by lagu2 with SMTP id u2so424369lag.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 17:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=trWzdF58u9sQwqihUQQe/IQtmIHZzXzP/Nq0JxstAXE=;
        b=NFtRO9vztvYCmByJHet+H6fgYZqwUO98//+EpPOkyLG6GXQv7LSjUYqBc0tShgPnoh
         XbsrmdJic77CHAD0tFl6qcn/7Jz6qQzs8YpR+X0G4UVtFM9Qx3y6LZzw68gTm8YYSalm
         bvZ58DxM0HS2CVFYETPf6uuxVloAuCfl0ZdoI=
Received: by 10.112.24.169 with SMTP id v9mr3842669lbf.64.1327455582250; Tue,
 24 Jan 2012 17:39:42 -0800 (PST)
Received: by 10.152.105.179 with HTTP; Tue, 24 Jan 2012 17:39:11 -0800 (PST)
In-Reply-To: <CAOpHH-Wcf3innjA4LS0TMrLzEwbQzfZmHssxSBYvv4v7UMfi1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189091>

On Mon, Jan 23, 2012 at 1:53 PM, Vitor Antunes <vitor.hda@gmail.com> wr=
ote:
> On Sat, Jan 21, 2012 at 4:54 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Vitor Antunes <vitor.hda@gmail.com> writes:
>>
>>> +test_expect_success 'git-p4 add complex branches' '
>>> + =A0 =A0 test_when_finished cleanup_git &&
>>> + =A0 =A0 test_create_repo "$git" &&
>>> + =A0 =A0 (
>>> + =A0 =A0 =A0 =A0 =A0 =A0 cd "$cli" &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 changelist=3D$(p4 changes -m1 //depot/...=
 | cut -d" " -f2) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 changelist=3D$(($changelist - 5)) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 integrate //depot/branch1/...@$changel=
ist //depot/branch4/... &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 submit -d "branch4" &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 changelist=3D$(($changelist + 2)) &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 integrate //depot/branch1/...@$changel=
ist //depot/branch5/... &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 submit -d "branch5"
>>
>> That's a strange quoting convention. Why are "branch4" and "branch5"
>> enclosed in double quotes while "integrate" and "submit" aren't?
>> (rhetorical: do not quote these branch names without a good reason).
>
> There is no reason that I can remember to have those enclosed in doub=
le
> quotes. Will double check in my local branches at home tonight. Anywa=
y,
> expect a fix for this in v3.

I now see why I added the quotes. The -d option is used to input the
description of the commit, which can contain spaces and other special
characters. Admittedly they are not required in this case, but from a
consistency point of view I would prefer to keep them. Is this
acceptable?

>>> +# Configure branches through git-config and clone them. git-p4 wil=
l only be able
>>> +# to clone the original structure if it is able to detect the orig=
in changelist
>>> +# of each branch.
>>> +test_expect_success 'git-p4 clone complex branches' '
>>> + =A0 =A0 test_when_finished cleanup_git &&
>>> + =A0 =A0 test_create_repo "$git" &&
>>> + =A0 =A0 (
>>> + =A0 =A0 =A0 =A0 =A0 =A0 cd "$git" &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git config git-p4.branchList branch1:bran=
ch2 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git config --add git-p4.branchList branch=
1:branch3 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git config --add git-p4.branchList branch=
1:branch4 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git config --add git-p4.branchList branch=
1:branch5 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 "$GITP4" clone --dest=3D. --detect-branch=
es //depot@all &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git log --all --graph --decorate --stat &=
&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 git reset --hard p4/depot/branch1 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file1 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file2 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 test_path_is_file file3 &&
>>> + =A0 =A0 =A0 =A0 =A0 =A0 grep -q update file2 &&
>>
>> Do you really need to use "-q" here? =A0Wouldn't it help if you wrot=
e it
>> without it while debugging tests with "sh ./t9801-*.sh -v"?
>
> Makes sense.
>
> Thank you for the helpful comments.
> Vitor

Apparently I've hit "Reply" instead of "Reply all" before, so I'll keep
the full quote of my previous email for future reference.

Vitor
