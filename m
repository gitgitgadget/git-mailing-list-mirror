From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Sat, 10 Dec 2011 00:17:31 +0530
Message-ID: <CALkWK0kYMttjVgEee3KQaLXOQX86+YnZrm8GsKfu2zjEi_RoYg@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323430158-14885-1-git-send-email-artagnon@gmail.com> <1323430158-14885-4-git-send-email-artagnon@gmail.com>
 <7v8vmlfuw1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@mgmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 19:48:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5UF-0005vp-1W
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 19:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab1LISry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 13:47:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62832 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab1LISrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 13:47:53 -0500
Received: by wgbdr13 with SMTP id dr13so6185778wgb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3przQ6tO804ki8WypZ3BmVGXapSALzCDf5FSX56QwbY=;
        b=mxBgExLuvwIjrn/8FMjhU3n+MzKBrLM2dwmlqt+EA5MK/Vk1C2D6YNASPlOzoI8xwJ
         8jgRIgV6kkLXiiSOdft3ZVGfVn36r6rX11FyfruypaOACtuj+RFtFAJBxuPZMASp7ki8
         pnD0OT6e8t6iVidgePivF4KuDEIvBc0zsNdBI=
Received: by 10.216.14.209 with SMTP id d59mr729627wed.112.1323456472199; Fri,
 09 Dec 2011 10:47:52 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 10:47:31 -0800 (PST)
In-Reply-To: <7v8vmlfuw1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186662>

Hi,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> In testing, a common paradigm involves checking the expected output
>> with the actual output: test-lib provides a test_cmp to show the dif=
f
>> between the two outputs. =C2=A0So, use this function in preference t=
o
>> calling a human over to compare command outputs by eye.
>>
>> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>> =C2=A0t/t1006-cat-file.sh | =C2=A0119 ++++++++++++++++++++++++------=
---------------------
>> =C2=A01 files changed, 56 insertions(+), 63 deletions(-)
>>
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index d8b7f2f..5be3ce9 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -144,10 +119,13 @@ tag_size=3D$(strlen "$tag_content")
>>
>> =C2=A0run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_prett=
y_content" 1
>>
>> -test_expect_success \
>> - =C2=A0 =C2=A0"Reach a blob from a tag pointing to it" \
>> - =C2=A0 =C2=A0"test '$hello_content' =3D \"\$(git cat-file blob $ta=
g_sha1)\""
>> +test_expect_success "Reach a blob from a tag pointing to it" '
>> + =C2=A0 =C2=A0echo_without_newline "$hello_content" >expect &&
>> + =C2=A0 =C2=A0git cat-file blob "$tag_sha1" >actual &&
>> + =C2=A0 =C2=A0test_cmp expect actual
>> +'
>>
>> +test_done
>> =C2=A0for batch in batch batch-check
>> =C2=A0do
>> =C2=A0 =C2=A0 =C2=A0for opt in t s e p
>
> What is that test_done about?

:facepalm: crept in while testing -- I often (temporarily) use a
test_done after the test I want to inspect so the others aren't
unnecessarily executed hiding the error.

Thanks for catching this.

-- Ram
