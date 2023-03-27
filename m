Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C2DC6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 18:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC0SAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 14:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0SAG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 14:00:06 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FEEC
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679939997; i=l.s.r@web.de;
        bh=ePN78ILeclwz7V0BselNYnjaAUGevV8/k8TtbZy0qs0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=uKanFT8D2SgN+7RZTFkug3SPR4MVJlYAH2zHylOYaUb7YKDqVUZFmvnAcqCX4XQhQ
         OQxKjidBHAZKvGbOpTh8GnLdCviggqu7dk7AEmfBaMNjiuSTzvb8lTNkFus6KoLtK/
         Tl9OJvOyci2k2fL3RZ+5Dfc8Djbao9mAaW3Xyi6KKH9YDcLB5E8b2rKTms9zR9STof
         LpNmFZ02aHcK34xOLkEi3wrlpDWSJ5O6jY3Lea7MywdbWv6GD0Ai2r9mreCPNaZ782
         0tObNQAGRCgf8v/QDngbQlUR3rjLzOyYlXsk+vOT3TYXBZVLTa+8rAQwsIc0vB0uS6
         lF/e4xxB1MFAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1pxIcj35Ia-00Y8tk; Mon, 27
 Mar 2023 19:59:57 +0200
Message-ID: <a47f8172-a8d0-abe8-09a8-f31b9e19b1a1@web.de>
Date:   Mon, 27 Mar 2023 19:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] t5000: use check_mtime()
Content-Language: en-US
To:     Andrei Rybak <rybak.a.v@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <233edbbe-35c1-9b5b-7578-4c70c6d24449@web.de>
 <5e53c8be-92b7-82e0-e204-a0cbfdffc529@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <5e53c8be-92b7-82e0-e204-a0cbfdffc529@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uFU7B+gV5opW32m1omp2u0vH6z1XiAIsVK8AJnvdE9sdDuhSNAc
 d+q0qNTAcIU9JYmYQOBPSj4vSBpNXpHAuhW+qrlDYwYU/jUrZShsQh931cfU9Ist8mbwVPY
 t9RilQ1ZCY4ct34LQ5FXxfm8qRXFfANbBGJNABuCHubGCUtYSvlzPTQsX2zkfK5e8aSNUfV
 prqM1SZIROo5dvepNHoWQ==
UI-OutboundReport: notjunk:1;M01:P0:vQnuYFa5thk=;PYG5rGN1lyckxzzD5CoMlUTJUof
 BI42ySxMdWBwbyeG1LImUnVfXeUc6jS7llgtFhqAnYeyv3KJzNwf8W41uRWzVLY+FgIRK98YF
 ADYxIqQQ+yFuMe6qBeeZaTCw+rRYmCpzejFWHyfxMAZzZy5G84uzOBSpl1j9EvvKg/oApVnlh
 syfSJD9Teln+kHKoK9vMiu1j0Zahv8X84kefIZizmSdETBzoC/6ZnQpc17o+QyFBYS1UVjVUp
 hJP1krpdWEsHWjrrWDSqOkOhGlEvG/PS+i7KcsumXVdWcvSBLayzY1lLhdIiBArsTPemxUhon
 +m6lT6KG9S3DpyaL1S0sonP8CC2V9wrf4jaW+fFQP0dY9xtEDKxCo+t5jEFEe3B4E3CpIPqvV
 MlVD2vuToij6Hr+pw4cfeNgycWS9DPK/7JV32EKwmnE2nHRNFf9wqYFcIjjv1h35A0QjlgIGG
 s+aScLhdGOe4v9ymeCnKp/iKoFOgcfHmcQazuR0H0W/NhVtUQnORwTFOCbWU8oucUzJ+17Gpo
 UoDbDPW0hbQLlB0VIe99ieR3n0WzwJX/e2foPZPr+bOHbUCrwpozaIh158Q7nFv0mPoGg/h+i
 7K7X7Xuoq+mI02Eh73X/NpjoIlf3cpwOUAzcBZgnJNNFSipmv0D2bVEi5wuCxPh2wB5Tv8ruO
 rIOu7piFYIEciTu+PgCho8aLcdtmkLgjO628sLHMb7YRncbf63T012oWd0I+c/guKc2d1htzK
 G84RZQix+TkfUoKx5aD2vBDeSnYwU7s75mfi6jdrON6f+Rnyx7ACl+M856cWScOELvTWgYSnH
 49P8PirWBuEa28DnGXxpLbLhYqrJkIm9L6AmBJTVbpAmLAybsjFs4jMTD2BiHeecl8ZtzJTv9
 3Dhe4QP7cPnWJvO04u9r+bjGgQ4uonpe5xw+oJ3uzOJpGLgvP1VBqaQHbpAFbnlZvmMMYWcWi
 kRg0Q7qkEvisWPQvIE/4WwUkBWQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.03.23 um 14:53 schrieb Andrei Rybak:
>
> The only tangentially related nitpick is to the function check_mtime(),
> which doesn't follow the code style for Shell scripts -- a space is miss=
ing
> before parentheses.=C2=A0 Same for almost all the other helper functions=
 in test
> files related to git-archive:
>
> =C2=A0=C2=A0=C2=A0 $ git grep -E '^[a-z_]+[(][)]' t/t500*
> =C2=A0=C2=A0=C2=A0 t/t5000-tar-tree.sh:get_pax_header() {
> =C2=A0=C2=A0=C2=A0 t/t5000-tar-tree.sh:check_tar() {
> =C2=A0=C2=A0=C2=A0 t/t5000-tar-tree.sh:check_added() {
> =C2=A0=C2=A0=C2=A0 t/t5000-tar-tree.sh:check_mtime() {
> =C2=A0=C2=A0=C2=A0 t/t5001-archive-attr.sh:test_expect_exists() {
> =C2=A0=C2=A0=C2=A0 t/t5001-archive-attr.sh:test_expect_missing() {
> =C2=A0=C2=A0=C2=A0 t/t5002-archive-attr-pattern.sh:test_expect_exists() =
{
> =C2=A0=C2=A0=C2=A0 t/t5002-archive-attr-pattern.sh:test_expect_missing()=
 {
> =C2=A0=C2=A0=C2=A0 t/t5003-archive-zip.sh:check_zip() {
> =C2=A0=C2=A0=C2=A0 t/t5003-archive-zip.sh:check_added() {
> =C2=A0=C2=A0=C2=A0 t/t5004-archive-corner-cases.sh:make_dir() {
> =C2=A0=C2=A0=C2=A0 t/t5004-archive-corner-cases.sh:check_dir() {
> =C2=A0=C2=A0=C2=A0 t/t5004-archive-corner-cases.sh:build_tree() {
>
> compare to:
>
> =C2=A0=C2=A0=C2=A0 $ git grep -E '^[a-z_]+ [(][)]' t/t500*
> =C2=A0=C2=A0=C2=A0 t/t5000-tar-tree.sh:tar_info () {
> =C2=A0=C2=A0=C2=A0 t/t5001-archive-attr.sh:extract_tar_to_dir () {
>
>
> Quote from Documentation/CodingGuidelines:
>
> =C2=A0=C2=A0=C2=A0 - We prefer a space between the function name and the=
 parentheses,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and no space inside the parentheses. The =
opening "{" should also
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be on the same line.
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (incorrect)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 my_function=
(){
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (correct)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 my_function=
 () {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>

Care to send a patch?

There's more by the way:

   $ git grep -c '^[a-zA-Z0-9_]*()' t/*.sh | awk -v FS=3D: '{c[substr($1,1=
,4)]+=3D$2} END {for (x in c) print x "*.sh:" c[x]}'
   t/t0*.sh:16
   t/t1*.sh:35
   t/t2*.sh:3
   t/te*.sh:2
   t/t3*.sh:22
   t/t4*.sh:23
   t/t5*.sh:68
   t/t6*.sh:11
   t/t7*.sh:40
   t/t8*.sh:1
   t/t9*.sh:31
   t/li*.sh:26

Personally I'd like to avoid wasting space and the second form looks odd
to me, which turned me into a repeat offender out of negligence, I
guess.  Anyway, since we have a documented rule (that came about by
majority vote of code lines IIUC) we should follow it.

Ren=C3=A9
