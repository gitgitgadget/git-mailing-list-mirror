From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 1/2] stash drops the stash even if creating the branch
 fails because it already exists
Date: Wed, 29 Sep 2010 23:53:32 +1000
Message-ID: <AANLkTim4f75meriCZpvi58WspVTf0LEVQSYh2dxppYB9@mail.gmail.com>
References: <1285673120-43354-1-git-send-email-tom@dbservice.com>
	<1285679992-7638-2-git-send-email-jon.seymour@gmail.com>
	<4CA1EBF3.7090701@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tla@land.ru, gitster@pobox.com
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 15:53:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0x6K-00010m-E7
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab0I2Nxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 09:53:35 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33438 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab0I2Nxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 09:53:34 -0400
Received: by qwh6 with SMTP id 6so538899qwh.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yMbFISj9E85V+i2enkAAfqahJxaTRgpmzrFjTFEcD1c=;
        b=sDFvQfgZvvJYUXID+dH8TU39h0g/5TJNe8nStBBKLIBq5/cuoVhBggt6ynt5axXO+v
         XlmFsPJQMWsjnMqRJersXjkDJBND0fnj33CSR++H8drNd0bfTj2fMRqOFmD7cXD3htRB
         eMJXw/1H1syS8ccKaDRgPL26M8dgC6BW5v6qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B4eieJI64CzH8iTETzRC82tRu0aqJgKuFy/hP0jC6ywOQcP68q1CzUkzVptT1r8PLO
         C0ynA5cdiubWZAmuWj+yRqgd8PKvryuJInVk+OXN6jYdyArXVltpJxJf4MpE9thUv/20
         HCOIQ8/875Q4TS0JrJsNvFJmPC+6pxraKaAcE=
Received: by 10.224.128.13 with SMTP id i13mr1238916qas.151.1285768413659;
 Wed, 29 Sep 2010 06:53:33 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Wed, 29 Sep 2010 06:53:32 -0700 (PDT)
In-Reply-To: <4CA1EBF3.7090701@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157571>

Junio,

Let me know if you want me to re-roll this series with Tomas'
sign-off. I can also add my simplification of the Brian's fix and
another fix I have made to have git stash save/create fail early in
case the index contains merge conflicts.

jon.

On Tue, Sep 28, 2010 at 11:21 PM, Tomas Carnecky <tom@dbservice.com> wr=
ote:
> On 9/28/10 3:19 PM, Jon Seymour wrote:
>> From: Tomas Carnecky <tom@dbservice.com>
>>
>> This bug was disovered by someone on IRC when he tried to 'git stash=
 branch <branch> <stash>'
>> while <branch> already existed. In that case the stash is dropped ev=
en though it isn't
>> applied on any branch, so the stash is effectively lost. I think tha=
t shouldn't happen,
>> so here is a test.
>
> This line was missing from my original patch, sorry about that:
> Signed-off-by: Tomas Carnecky <tom@dbservice.com>
>
>> ---
>> =C2=A0t/t3903-stash.sh | =C2=A0 11 +++++++++++
>> =C2=A01 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index 9ed2396..0f6b2e4 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -545,4 +545,15 @@ test_expect_success 'invalid ref of the form st=
ash@{n}, n >=3D N' '
>> =C2=A0 =C2=A0 =C2=A0 git stash drop
>> =C2=A0'
>>
>> +test_expect_failure 'stash branch should not drop the stash if the =
branch exists' '
>> + =C2=A0 =C2=A0 git stash clear &&
>> + =C2=A0 =C2=A0 echo foo > file &&
>> + =C2=A0 =C2=A0 git add file &&
>> + =C2=A0 =C2=A0 git commit -m initial &&
>> + =C2=A0 =C2=A0 echo bar > file &&
>> + =C2=A0 =C2=A0 git stash &&
>> + =C2=A0 =C2=A0 test_must_fail git stash branch master stash@{0} &&
>> + =C2=A0 =C2=A0 git rev-parse stash@{0} --
>> +'
>> +
>> =C2=A0test_done
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
