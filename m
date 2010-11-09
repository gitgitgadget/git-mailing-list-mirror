From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t1020-subdirectory: test alias expansion in a subdirectory
Date: Tue, 9 Nov 2010 08:29:07 +0700
Message-ID: <AANLkTikwTwNDLhQU7mtKxTYHBUVQzw9tuVzSZy3utSLM@mail.gmail.com>
References: <627dc7921dc64a16063e77d542cf9edb22631ddd.1289205059.git.git@drmicha.warpmail.net>
 <20101108102056.GA12366@do> <7v7hgnpnp8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 02:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFd1l-0006xH-2D
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 02:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104Ab0KIB3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 20:29:31 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62276 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab0KIB3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 20:29:30 -0500
Received: by wwi18 with SMTP id 18so203826wwi.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 17:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OetfZ/WA4z7niO8+UEGYERnU4C4wBDjCTe7IWHMeNFs=;
        b=jgjMzEN6mWsgkFk4iRobI3Ryp01sm6+CIGHkL3a+/f7f8NOVizVPBGRtGVDTQmj7l7
         imG1rf+XiPfM2IvW/niyF6+w4ZY6Q2ChptbYpU6Tg8r0O1BK+9Q4H3Su5m/QeHxyL9lh
         YC1dTmRxyKQY0J/ah+TseuJo/l2Sb3INN8vio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RNUcmAXAlhxqWGG63AlxIyNvHjnpdLtwt0ZEU/ltJMvNbRRyGuxOvVGM+oMvhIFCVS
         3J8ayHNopaicbdcD5iDEqJrhGFkgwKwR/E1tcy2o8Yegjgkq9gILKeBZLmyGZPZAf0Jx
         ZKO55gIAuerb1FobDUgnEFJwsqpECZXsBE33g=
Received: by 10.216.58.209 with SMTP id q59mr134193wec.41.1289266169045; Mon,
 08 Nov 2010 17:29:29 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 8 Nov 2010 17:29:07 -0800 (PST)
In-Reply-To: <7v7hgnpnp8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161008>

On Tue, Nov 9, 2010 at 3:25 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Mon, Nov 08, 2010 at 09:32:03AM +0100, Michael J Gruber wrote:
>>> Add a test for alias expansion in a subdirectory of the worktree.
>>>
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>>
>>> ---
>>> =C2=A0 =C2=A0 65f3a9e (Remove all logic from get_git_work_tree(), 2=
010-11-01) breaks this test,
>>> =C2=A0 =C2=A0 which is why I am adding it.
>>
>> How about squashing this in?
>>
>> --8<--
>> Subject: Allow set_git_work_tree() to be called more than once
>>
>> Usually one of the setup functions is called once. However alias
>> handling code needs to look ahead in $GIT_DIR/config for aliases. So
>> set_git_work_tree() may be called twice: once when alias is searched=
,
>> once when the actual command is run.
>>
>> Loosen the condition and let it through. We can stricten it back whe=
n
>> alias handling is fixed.
>
> Sounds like sweeping something under rug.
>
> Without this hack, alias does not work, but if your plan is to rework=
 this
> part right when alias is fixed, then what's the point of loosening it=
?
> Either way your alias is broken, no?
>
> Shouldn't it at least make sure that the function is giving a consist=
ent
> picture to the outside world between the time it was called for the f=
irst
> time and the second time? =C2=A0E.g. =C2=A0the second time around new=
-work-tree must
> be the same as whatever was given the first time, or something.

Right. Will do that.
--=20
Duy
