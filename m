From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Tue, 19 Jun 2012 09:05:40 -0400
Message-ID: <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
	<7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgy7t-0001zm-J3
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 15:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2FSNFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 09:05:41 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40178 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2FSNFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 09:05:41 -0400
Received: by gglu4 with SMTP id u4so4571247ggl.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Z4h8K6F1Gx0kwkPRiffYuH7bOBL4Yg3MxOdtcRZC9/M=;
        b=Fzv0Otpcv25kHNzzqsC1v1VUqz9vweoSDE+NZh/62rBN+/J0Y4Jl/mK0pUaLNJ5FP3
         gc94Ruhq41F1dKrjTaXwMnZr+fafD77IIEI358Z3O67Nbt6IAW8JqM2Lrvkz12Zp6PsW
         sNpC8Nodee90YlsF0dqfC0LlMQhjex/RHUs1zGCwJquMAKIV28N+W3o9gsxg1kLpYZYi
         DeFYdMoEfAQlW6GDiaQ/Z/8TdkuPr8qvwVkQvu/+qzKSwcSW6AAaASL3FII7tqcC3dhz
         KeYXyYkh1RsUcRC70h7oXdzR8YLyyWvZ/H/2HQvqjnS685X5dup7zxn+TV4/J32MsUnp
         RxfQ==
Received: by 10.50.40.194 with SMTP id z2mr975168igk.67.1340111140280; Tue, 19
 Jun 2012 06:05:40 -0700 (PDT)
Received: by 10.231.84.147 with HTTP; Tue, 19 Jun 2012 06:05:40 -0700 (PDT)
In-Reply-To: <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200199>

On Mon, Jun 18, 2012 at 4:09 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> When running 'git diff --quiet <file1> <file2>', if file1 or file2
>> is outside the repository, it will exit(0) even if the files differ.
>> It should exit(1) when they differ.
>> - =C2=A0 =C2=A0 exit(revs->diffopt.found_changes);
>> + =C2=A0 =C2=A0 int result =3D diff_result_code(&revs->diffopt, 0);
>> + =C2=A0 =C2=A0 exit(result);
>> =C2=A0}
>
> Decl-after-stmt.

Will eliminate intermediate variable in v4.  Thanks to both you and
Jeff for pointing this out.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "1 1" > a &&
>
> Please drop extra SP between ">" and "a".

Will fix in v4.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add . &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit -m 1
>> + =C2=A0 =C2=A0 ) &&
>> + =C2=A0 =C2=A0 mkdir -p test-outside/no-repo && (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd test-outside/no-repo =
&&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "1 1" >a &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "1 1" >matching-fil=
e &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "1 1 " >trailing-sp=
ace &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "1 =C2=A0 1" >extra=
-space &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "2" >never-match
>> + =C2=A0 =C2=A0 )
>
> The inspiration of using CEILING comes from the existing t7810-grep
> test, and I would have preferred if you used the same non/git for a
> non-git repository for easier greppability ("git grep CEIL t/" to
> notice the use of the technique and then "git grep non/git t/" to
> verify, for example).

Okay.  I still need the non/git directory to be outside the test
repo's path, so the new layout will be:

    $TRASH_DIRECTORY/
        test-outside/
            repo/
            non/git/

This adds an extra layer to the non git paths, but won't cause any prob=
lems.


>> +test_expect_success 'git diff, one file outside repo' '
>> + =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_CEILING_DIRECTORIES=3D=
"$TRASH_DIRECTORY/test-outside" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export GIT_CEILING_DIREC=
TORIES &&
>
> Do you even need these two lines for this test? =C2=A0your test runs
> inside test-outside/repo that _is_ a git repository, and that
> repository knows that ../no-repo is not part of it already.

You are correct, CEILING does not need to be set for tests where one
file is inside 'test-outside/repo'.

As a side note, I found that these tests fail if a relative path is
used for the file in 'non/git'.  In other words, this passes:

    test_expect_code 0 git diff --quiet a
"$TRASH_DIRECTORY/test-outside/non/git/matching-file"

but this fails:

    test_expect_code 0 git diff --quiet a ../non/git/matching-file

This surprised me, but I have not investigated any further.
