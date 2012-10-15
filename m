From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add format-patch options to send-email
Date: Tue, 16 Oct 2012 01:37:35 +0200
Message-ID: <CAMP44s07iydg0aMDQMTX7qh4Kk8w--sp1DtmTUeu=95WzAXfRQ@mail.gmail.com>
References: <1350231243-13485-1-git-send-email-felipe.contreras@gmail.com>
	<20121015224857.GA2156@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 01:37:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNuEF-0007QH-5z
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 01:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab2JOXhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 19:37:36 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60339 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab2JOXhg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 19:37:36 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so5560622obb.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2yBC3cGfSbV32lZDunfyci7a9LyvqqeMbvgCXvSY7B4=;
        b=Ao5XHwfWAOgAV5+ajPZRWZ+sWc22QgNDVGPjq9NTknr1io/JDERWakmP/UhEuaL5Bz
         M6gR89PlE0J03cmRjToHBP/gzlGJdDwFp1krOp9ARlMy7kXc9ICH+KtD2gmpXd6hCsvT
         9K1uXF+RGPLk0CMogEg5o4rwRCy6h7iwpmiPH2FuiRS2Jc2WzRr+wjSQK/QanEl6r6wV
         +WUH7izynMW6/RDAhZmXkfIt7QEx50pztzpRvGmC043x+1sIuRK/nFIgkhU7qR+jJ7QE
         IdySjZEsyyZs2/pyKAlYWkWACiZOD/OzCACnoGgp7jChtc4JvrYHiK3SUgcbL5MOqgxM
         RUCA==
Received: by 10.182.10.6 with SMTP id e6mr10893621obb.16.1350344255539; Mon,
 15 Oct 2012 16:37:35 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Mon, 15 Oct 2012 16:37:35 -0700 (PDT)
In-Reply-To: <20121015224857.GA2156@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207787>

On Tue, Oct 16, 2012 at 12:48 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

>> @@ -1559,11 +1559,12 @@ _git_send_email ()
>>                       --signed-off-by-cc --smtp-pass --smtp-server
>>                       --smtp-server-port --smtp-encryption=3D --smtp=
-user
>>                       --subject --suppress-cc=3D --suppress-from --t=
hread --to
>> -                     --validate --no-validate"
>> +                     --validate --no-validate
>> +                     $__git_format_patch_options"
>>               return
>>               ;;
>>       esac
>> -     COMPREPLY=3D()
>> +     __git_complete_revlist_file
>
> While send-email accepts a rev-list, it doesn't accept
> 'HEAD:Documentation', does it?  So __git_complete_revlist() would be
> better here, because that makes the intent clear.

Then _git_send_email should be fixed first. I'm simply doing the same
as _git_send_email.

>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 92d7eb4..c4b6c13 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -146,6 +146,22 @@ test_expect_success '__gitcomp - suffix' '
>>       test_cmp expected out
>>  '
>>
>> +setup_repository ()
>> +{
>> +     mkdir "$1" && (
>> +     cd "$1" &&
>> +     git init &&
>> +     test_tick &&
>> +     git commit --allow-empty -m "Initial"
>> +     )
>> +}
>> +
>> +test_expect_success 'prepare' '
>> +     setup_repository one &&
>> +     git clone one test &&
>
> Why are these new repositories needed?

Because otherwise 'git send-email ma' wouldn't succeed.

>> +     cd test
>
> This 'cd' makes all subsequent tests to be executed in a different
> repository than previously, which breaks 'checkout completes ref
> names'.

I don't know which test you are talking about, it's not on my repo,
and all the completion test pass with this patch.

Cheers.

--=20
=46elipe Contreras
