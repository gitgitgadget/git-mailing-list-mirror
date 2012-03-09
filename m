From: Brodie Rao <brodie@sf.io>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Thu, 8 Mar 2012 16:08:31 -0800
Message-ID: <CAJjwD-2BLYqNkb+uZqf448eFsqGEXUGuLHE3+YVi-njZGTQvuw@mail.gmail.com>
References: <1331165362-78065-1-git-send-email-brodie@sf.io>
	<4F58F063.4060600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Mar 09 01:08:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5nNw-0005SE-0S
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 01:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab2CIAId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 19:08:33 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46876 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab2CIAIb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 19:08:31 -0500
Received: by pbcun15 with SMTP id un15so1996015pbc.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 16:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitheap.org; s=google;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6zWsRS5yoe3x2gq989WSwItv/9ORQKAckCh0rLDHn4g=;
        b=aLDUxYkp8GpgWn6yP30VfB7qqh/u4VtkbaQTrxZtcD+qBky45wHEfEEgl9lccVPeJK
         0LJib74WB06nTbMQwTrhFtxue2r/PThVFVlT5cuskqqAlzXHm1oYp9jeCSHHeCYPi0H8
         HU1Qshq4CziXJDy7uh/u9v7YupbGEiMFJ30oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=6zWsRS5yoe3x2gq989WSwItv/9ORQKAckCh0rLDHn4g=;
        b=Qv7bx6kVEeaA5GGCl7wsZd6ZU7q6qIeUZ9ofkbSG90ibySFHQMYx4N0tcwSkI2Agzr
         3Sh9r7P3JvNLNEbfwVDtNglNZXyfZ7kj4rTnkIaGYbuHYnai47LM+iG1RGSUfEJqp5xw
         dFwy8CRAvba+2Xo1+Mx0l3B9Pst6W8PDsVVsGtAqBNTv22wXsTdV5BcEm5IZ6w6bOpky
         vRXYgG1hV9FKr6TakmxRcp2SHcTSzheivfHrYXvB7XC8iPY7eZASf8xsUZTGGyS5PcKX
         KU7VTFdsioyaAT4sCzzEYpLpBgBn78aNXU7gp7AIVsgTEYpkPl+jDedPF4HHF4shFo4y
         uoPg==
Received: by 10.68.130.103 with SMTP id od7mr1182456pbb.66.1331251711346; Thu,
 08 Mar 2012 16:08:31 -0800 (PST)
Received: by 10.142.179.13 with HTTP; Thu, 8 Mar 2012 16:08:31 -0800 (PST)
X-Originating-IP: [70.35.42.138]
In-Reply-To: <4F58F063.4060600@lsrfire.ath.cx>
X-Google-Sender-Auth: 0T7lKb-eRZImF_v3SEtbmKqrgbM
X-Gm-Message-State: ALoCoQmJrkFeP+yxYwVJhDaX7qTp3/QpsOweLccMJ8M9V4+GcpWp3tVvXo3grXqXuUOcuVgkGgPd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192666>

On Thu, Mar 8, 2012 at 9:46 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.03.2012 01:09, schrieb Brodie Rao:
>
>> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
>> index 527c9e7..404786f 100755
>> --- a/t/t5000-tar-tree.sh
>> +++ b/t/t5000-tar-tree.sh
>> @@ -360,4 +360,20 @@ test_expect_success GZIP 'remote tar.gz can be
>> disabled' '
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0>remote.tar.g=
z
>> =C2=A0'
>>
>> +test_expect_success \
>> + =C2=A0 =C2=A0'git archive with an empty tree and a prefix' \
>> + =C2=A0 =C2=A0'git rm -r .&&
>> + =C2=A0 =C2=A0 git commit -m empty&&
>> + =C2=A0 =C2=A0 git archive --format=3Dtar --prefix=3Dempty/ HEAD> =C2=
=A0e1.tar&&
>> + =C2=A0 =C2=A0 "$TAR" tf e1.tar'
>> +
>> +test_expect_success \
>> + =C2=A0 =C2=A0'git archive with an empty tree and no prefix' \
>> + =C2=A0 =C2=A0'git archive --format=3Dtar HEAD> =C2=A0e2.tar&&
>> + =C2=A0 =C2=A0 test_must_fail "$TAR" tf e2.tar'
>
>
> This test fails for me, i.e. tar does not complain about the empty ar=
chive
> (GNU tar 1.25). =C2=A0Perhaps use git archive -v to generate a list o=
f entries?

Whoops. I only ran the test with BSD tar, which apparently isn't
tolerant of the empty archive git-archive is generating. It'd probably
be better to omit the tar invocation in that test and just confirm
that git-archive doesn't blow up.

>
>
>> +
>> +test_expect_success \
>> + =C2=A0 =C2=A0'git archive on specific paths with an empty tree' \
>> + =C2=A0 =C2=A0'test_must_fail git archive --format=3Dtar --prefix=3D=
empty/ HEAD foo'
>> +
>> =C2=A0test_done
>> -- 1.7.9.2
>>
>
