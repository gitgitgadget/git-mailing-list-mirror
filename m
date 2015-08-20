From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-p4: fix faulty paths for case insensitive systems
Date: Thu, 20 Aug 2015 09:17:20 -0400
Message-ID: <CAPig+cQ8P8BDBGCNprN4GLtZbP0MHdj08LNw2WEJ87K5Ws1AHg@mail.gmail.com>
References: <1440014686-63290-1-git-send-email-larsxschneider@gmail.com>
	<1440014686-63290-2-git-send-email-larsxschneider@gmail.com>
	<55D55EC9.6050002@web.de>
	<917E3751-4BC8-4034-9101-30C77426D81C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>,
	torarvid@gmail.com, ksaitoh560@gmail.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 15:17:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSPik-0007DN-5w
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 15:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbbHTNRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 09:17:22 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35137 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbHTNRV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2015 09:17:21 -0400
Received: by ykbi184 with SMTP id i184so36706027ykb.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=eIb5O2MKsIXu504Cidw7oii/ldfOKQXBbbnBpmAW7Jo=;
        b=DKasxxMgYJXoFh1glnbdtbCVtqMTAcJ8YukEIB394qoCtsVp7cupEb3vC9/2tipgZx
         t1JHrw7xAyvYUF/u6L3YwQRxr6y6x4eNM8XlLvrgc8IFCx0Ye3HqeWAKe8oAZJH6xypc
         9AQ+aTT/TEjK2ySoiD8aFg/1HyRbMJxfNwH5qO2pyduaMl9dUSnFSfiTicktLjEn4q/P
         SctE6ofo1hxVMGGPvZat3MZk9XyCEwmbZSxZeHitUhxeG1eMC93IMcBBX6t1FQF10NFF
         c7WoPAOuLLVAB4dfgrf4BkHCw+7XXcxEosY0htTEwkOcrOFIFOJavNYczIxsowfmkdxD
         Qy+w==
X-Received: by 10.170.202.194 with SMTP id t185mr3251704yke.90.1440076640558;
 Thu, 20 Aug 2015 06:17:20 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 20 Aug 2015 06:17:20 -0700 (PDT)
In-Reply-To: <917E3751-4BC8-4034-9101-30C77426D81C@gmail.com>
X-Google-Sender-Auth: GhZRR97jvX9f4yCLnXkBFyqGJ-c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276237>

On Thu, Aug 20, 2015 at 3:16 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 20 Aug 2015, at 06:59, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>> On 08/19/2015 10:04 PM, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> +            find . | grep two/File2.txt &&
>> Should we make sure that two/File2.txt exist?
>> Then the "find | grep" feels like overkill.
>> The line
>> test -f  two/File2.txt &&
>> could do the same (or do I miss something ?)
> That=E2=80=99s what I did first. However, I am running OS X with HFS =
in
> case-insensitive mode (the default). Consequently =E2=80=9Ctest -f=E2=
=80=9D
> doesn=E2=80=99t care about the case. That=E2=80=99s why I used =E2=80=
=9Cgrep=E2=80=9D.

This explanation may deserves to be recorded as an in-code comment to
make the next person who modifies the test code aware of the issue.

>>> +            git ls-files > lines &&
>> and here
> I really want to make sure only one file ends up in the repo.
>
>>> +            test_line_count =3D 1 lines

A more idiomatic way (in Git tests) to check both the file case and
the file count would be:

    cat >expect <<-\EOF &&
    two/File2.txt
    EOF
    git ls-files >actual &&
    test_cmp expect actual

>>> +    )
>>> +'
>>> +
>>> +test_expect_success 'Clone the repo WITH path fixing' '
>>> +    client_view "//depot/One/... //client/..." &&
>>> +    git p4 clone --fix-paths --use-client-spec --destination=3D"$g=
it" //depot/one &&
>>> +    test_when_finished cleanup_git &&
>>> +    (
>>> +            cd "$git" &&
>>> +            find . | grep TWO/file1.txt &&
>>> +            find . | grep TWO/File2.txt &&
>>> +            find . | grep TWO/file3.txt &&
>> Not sure about the find | grep here either.
> See answers above.
>
>>> +            git ls-files > lines &&
>>> +            test_line_count =3D 3 lines

Likewise:

    cat >expect <<-\EOF &&
    TWO/File2.txt
    TWO/file1.txt
    TWO/file3.txt
    EOF
    git ls-files >actual &&
    test_cmp expect actual

>>> +    )
>>> +'
>>> +
>>> +# It looks like P4 determines the path case based on the first fil=
e in
>>> +# lexicographical order. Please note the lower case "two" director=
y for all
>>> +# files triggered through the addition of "File0.txt".
>>> +test_expect_success 'Add a new file and clone the repo WITH path f=
ixing' '
>>> +    client_view "//depot/... //client/..." &&
>>> +    cd "$cli" &&
>>> +
>>> +    mkdir -p One/two &&
>>> +    > One/two/File0.txt &&
>>> +    p4 add One/two/File0.txt &&
>>> +    p4 submit -d "Add file" &&
>>> +    rm -rf One &&
>>> +
>>> +    client_view "//depot/One/... //client/..." &&
>>> +    git p4 clone --fix-paths --use-client-spec --destination=3D"$g=
it" //depot/one &&
>>> +    test_when_finished cleanup_git &&
>>> +    (
>>> +            cd "$git" &&
>>> +            find . | grep two/File0.txt &&
>>> +            find . | grep two/file1.txt &&
>>> +            find . | grep two/File2.txt &&
>>> +            find . | grep two/file3.txt &&
>>> +            git ls-files > lines &&
>>> +            test_line_count =3D 4 lines

And:

    cat >expect <<-\EOF &&
    two/File0.txt
    two/File2.txt
    two/file1.txt
    two/file3.txt
    EOF
    git ls-files >actual &&
    test_cmp expect actual

>>> +    )
>>> +'
>>> +
>>> +test_expect_success 'kill p4d' '
>>> +    kill_p4d
>>> +'
>>> +
>>> +test_done
>>> --
