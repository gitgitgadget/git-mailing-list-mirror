From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 1/1] bisect: add support for bisecting bare repositories
Date: Wed, 10 Aug 2011 09:12:50 +1000
Message-ID: <CAH3Anrr1eDuG9WNGb168ekMUnRcfEu4TPnGcSnh9TwLpvVMkBw@mail.gmail.com>
References: <1312855914-610-1-git-send-email-jon.seymour@gmail.com>
	<7vty9qsdhp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 01:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqvUj-0005pt-VX
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 01:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034Ab1HIXMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 19:12:52 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41965 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab1HIXMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 19:12:51 -0400
Received: by vxi9 with SMTP id 9so415549vxi.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 16:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QMdW6pgDOGLGE3xDa5Oj9enFQYL5fX0SclWCRpXpioc=;
        b=YO2EL0Zs0IwENHZQ93Z73NsifWzft6w8lEjSWzHKXoDkyRT6jFTE9Rpjzey8+UchWh
         PVMebAIlpCMCk1zvZx9CYNozyAGv5jBSBCWlaRyb5uX7cdRc4Qo+r4PRae6KCTwVN5k6
         8vH93H8A/Im/mTNT4zcqlFc+QIAGtE5fRjlm0=
Received: by 10.52.108.102 with SMTP id hj6mr2669965vdb.198.1312931570750;
 Tue, 09 Aug 2011 16:12:50 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Tue, 9 Aug 2011 16:12:50 -0700 (PDT)
In-Reply-To: <7vty9qsdhp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179050>

On Wed, Aug 10, 2011 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> This extension to js/bisect-no-checkout adds support for bisecting b=
are repositories.
>>
>> It does this by relaxing the requirement that git bisect is invoked =
in a repository with a working tree and by defaulting to --no-checkout =
in the case of a bare repository.
>>
>> Two tests are included to demonstrate this behaviour.
>
> I'd wrap the long line myself but next time please be careful.
>
>> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.=
sh
>> index 4fb7d11..62125ec 100755
>> --- a/t/t6030-bisect-porcelain.sh
>> +++ b/t/t6030-bisect-porcelain.sh
>> @@ -592,6 +592,37 @@ test_expect_success 'erroring out when using ba=
d path parameters' '
>> =C2=A0 =C2=A0 =C2=A0 grep "bad path parameters" error.txt
>> =C2=A0'
>>
>> +test_expect_success 'test bisection on bare repo - --no-checkout sp=
ecified' '
>> + =C2=A0 =C2=A0 git clone --bare . bare.nocheckout &&
>> + =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd bare.nocheckout &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git bisect start --no-ch=
eckout &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git bisect good $HASH1 &=
&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git bisect bad $HASH4 &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git bisect run eval \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=3D1 | wc -l) =
=3D 0" \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 >../nocheckout.log &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git bisect reset
>> + =C2=A0 =C2=A0 ) &&
>> + =C2=A0 =C2=A0 grep "$HASH3 is the first bad commit" nocheckout.log
>> +'
>
> git-bisect does not have any cd_to_toplevel so with a working tree yo=
u can
> run a bisection from a subdirectory, it seems. I wonder what would ha=
ppen
> if you did "cd bare.nocheckout/objects" or something silly like that.
>
> Just wondering...
>

Well, nothing obviously breaks...

expecting success:
	git clone --bare . bare.silly &&
	(
		cd bare.silly/objects &&
		git bisect start &&
		git bisect good $HASH1 &&
		git bisect bad $HASH4 &&
		git bisect run eval \
			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=3D1 | wc -l) =3D=
 0" \
			>../../silly.log &&
		git bisect reset
	) &&
	grep "$HASH3 is the first bad commit" silly.log

Cloning into bare repository bare.silly...
done.
Bisecting: 0 revisions left to test after this (roughly 1 step)
[3de952f2416b6084f557ec417709eac740c6818c] Add <3: Another new day for
git> into <hello>.
3de952f2416b6084f557ec417709eac740c6818c is the first bad commit
