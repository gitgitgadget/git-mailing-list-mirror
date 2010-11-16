From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 01/10] add: do not rely on dtype being NULL behavior
Date: Tue, 16 Nov 2010 09:18:04 +0700
Message-ID: <AANLkTikkArsu=NLJWQcP61uf3yrQmdxRQtB+3AmC9tHQ@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-2-git-send-email-pclouds@gmail.com> <20101115121415.GB14729@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 03:18:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIB7w-0005wK-2L
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193Ab0KPCS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 21:18:27 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50213 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759180Ab0KPCS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 21:18:26 -0500
Received: by wwa36 with SMTP id 36so210309wwa.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 18:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MB+NznEgEBHFFNWU221Ng+CfEn/RdybAZdmJO7c9vqg=;
        b=Vx/esxDuF746kDp+zEjb1SSyNllLr4Bk7guOFN4D6fcjBMoj/WtTfuj4cB3LZ8juZI
         vMKarPe/dZqsrh2AEDSl5ct0Nh7cvJae78BsAdegKD9Zd9vFGiKzzZa5cOey6OEdvl2k
         Td1Z63Bu1qriynOeTpSWrU5T/WiuOQBiblvcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bsQjgkDc9HxcZdEZQW8MMC2Xa9Mj3I4JXVECThQq/y+XtTIbtgsIFDwHUWseYbYqQ3
         SuVCUhNZagJ99d6HXRAJ81RYblo7/BtuLbNTYikrUwesAtNW1IFqq8u5JaaR6oUIKmpt
         Q1h6NZfQLVRCEaB4DNtDQwgUIhHK7o4jvh7UI=
Received: by 10.216.175.73 with SMTP id y51mr4525499wel.41.1289873904861; Mon,
 15 Nov 2010 18:18:24 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 15 Nov 2010 18:18:04 -0800 (PST)
In-Reply-To: <20101115121415.GB14729@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161529>

On Mon, Nov 15, 2010 at 7:14 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Commit c84de70 (excluded_1(): support exclude files in index -
>> 2009-08-20) added support for excluded() where dtype can be NULL. It
>> was designed specifically for index matching because there was no
>> other way to extract dtype information from index. It did not suppor=
t
>> wildcard matching (for example, "a*/" pattern would fail to match).
>>
>> The code was probably misread when commit 108da0d (git add: Add the
>> "--ignore-missing" option for the dry run - 2010-07-10) was made
>> because DT_UNKNOWN happens to be zero (NULL) too.
>>
>> Do not pass DT_UNKNOWN/NULL to excluded(), instead pass a pointer to=
 a
>> variable that contains DT_UNKNOWN. The real dtype will be extracted
>> from worktree by excluded(), as expected.
>
> Could you rephrase this in a way that contrasts current and desired
> behavior? =C2=A0Is it like this?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The "git add --ignore-missing --dry-run" c=
odepath is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0interpreting .gitignore incorrectly, unlik=
e "git add". =C2=A0For
> =C2=A0 =C2=A0 =C2=A0 =C2=A0example:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ test -e foo =
|| echo missing
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0missing
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ echo foo/ >>=
=2Egitignore
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ mkdir bar
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add --ig=
nore-missing --dry-run foo; echo $?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The following =
paths are ignored by one of your .gitignore files:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0foo/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Use -f if you =
really want to add them.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: no file=
s added
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0128
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add --ig=
nore-missing --dry-run bar/foo; echo $?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0In the original use case (preparing to add=
 a submodule) the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0behavior of the first command is correct, =
second incorrect.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If the entry to be added was a regular fil=
e, it would be the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0other way around.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The cause: the --ignore-missing code passe=
s DT_UNKNOWN as the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dtype_ptr argument to excluded() which hap=
pens to equal zero
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(NULL) and accidentally triggers the "matc=
h pathspecs in index
> =C2=A0 =C2=A0 =C2=A0 =C2=A0only" codepath (see c84de70, excluded_1():=
 support exclude
> =C2=A0 =C2=A0 =C2=A0 =C2=A0files in index, 2009-08-20) that is unfort=
unately a bit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0primitive.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Surely what was really wanted is to check =
paths against the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0index and work tree, defaulting to "regula=
r file".
>
> Wait --- that's not true. =C2=A0In the "git submodule add" case, we r=
eally
> want to default to (or even better, force) "directory".

Hmm.. get_index_dtype() would return DT_DIR if the submodule exists in
index. If it does not it must be a directory in worktree, right?
Call flow: excluded_from_list() -> get_dtype() -> get_index_dtype()
--=20
Duy
