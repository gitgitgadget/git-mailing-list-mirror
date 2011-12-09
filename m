From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 9/9] revert: simplify communicating command-line arguments
Date: Sat, 10 Dec 2011 00:41:47 +0530
Message-ID: <CALkWK0m_6yGuyLt-VqvRZkAiDoSxES8KeNzeXaejYRCpW=HAOg@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-10-git-send-email-artagnon@gmail.com> <20111209190236.GA20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:12:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5rk-00079l-5h
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab1LITML convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 14:12:11 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:65320 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1LITMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 14:12:10 -0500
Received: by wgbds13 with SMTP id ds13so3792409wgb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FS2IScBkbIVf6D042Rz6lvUo9wTuCCRqcXFQpjEaIEc=;
        b=ZbpEWq4b6ucq8fErrI4pHp78EjZVd52J9Ogg6V8rfz0vIGPPGRALMeopu/r/aC5WzJ
         k7Fy9Pqsm7NnGLAlvgHzbVyC+SOTZlklXC41ubGmkGtWKHXT59nZAULYTgSrY/Eq7GdZ
         wu2dQ5jVnzuXu5DbHH4Dz9gBJjFdZcViozY1Q=
Received: by 10.216.131.146 with SMTP id m18mr733943wei.97.1323457928369; Fri,
 09 Dec 2011 11:12:08 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 11:11:47 -0800 (PST)
In-Reply-To: <20111209190236.GA20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186666>

Hi,

Jonathan Nieder wrote:
> [...]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Jonathan Nieder <jrnieder@g=
mail.com>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Ramkumar Ramachandra <artag=
non@gmail.com>
>
> and Junio can add his sign-off below that when applying some version
> to his tree. =C2=A0Bonus points if you mention what tweaks you made w=
hen
> you are not just passing it on.

True, the signoff-chain does look like quite a mess now :P
[rr: minor improvements, tests] should be fine.

>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -414,4 +414,15 @@ test_expect_success 'mixed pick and revert inst=
ructions' '
>> +test_expect_success 'commit set passed through --all' '
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 test_expect_code 1 git cherry-pick --all &&
>> + =C2=A0 =C2=A0 git cherry-pick --continue
>> +'
>
> What does this test mean? =C2=A0"git cherry-pick --all" should report=
 a
> spurious conflict, and then --continue will clean it up automagically
> and all will be well?

This one's actually quite interesting.  "git cherry-pick --all" first
tries to apply everything from "intial" to "yetanotherpatch" (both
inclusive) -- its first "git commit" invocation returns 1, refusing to
create an empty commit.  Then when we say "--continue", it notices
that the worktree and index are clean, removes "initial" from the
instruction sheet and executes everything else as usual.  This is
something we should attempt to fix in the future: I think the Right
Way starts with creating an API for "git commit".

Thanks.

-- Ram
