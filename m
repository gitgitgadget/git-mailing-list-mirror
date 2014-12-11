From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] commit: ignore assume-unchanged files in "commmit <file>" mode
Date: Thu, 11 Dec 2014 23:23:33 -0000
Organization: OPDS
Message-ID: <35EB570A2A994662AA2E89910ECE9668@PhilipOakley>
References: <1417732931.20814.16.camel@segulix> <1417776974-6537-1-git-send-email-pclouds@gmail.com> <1418093090.19104.1.camel@segulix>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9rgio_Basto?= <sergio@serjux.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:23:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzD57-0000cy-SV
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 00:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965383AbaLKXXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2014 18:23:34 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:13783 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934114AbaLKXXd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 18:23:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AowkAPslilROl3QYPGdsb2JhbABZgwZSWIMFgypsvluFaAQCgRUXAQEBAQEBBQEBAQE4IBuEBwUBAQEBAwgBARkECwEFHgEBIQsCAwUCAQMVAQICAgUhAgIUAQQIEgYHAxQGARIIAgECAwGIBwMVCcFWhlOKDA2FUAEKAQEBHoEhiGmDQBOBMWSCby6BEwWNf0yCcoNugk+KHzqFToQOPjCBA4FAAQEB
X-IPAS-Result: AowkAPslilROl3QYPGdsb2JhbABZgwZSWIMFgypsvluFaAQCgRUXAQEBAQEBBQEBAQE4IBuEBwUBAQEBAwgBARkECwEFHgEBIQsCAwUCAQMVAQICAgUhAgIUAQQIEgYHAxQGARIIAgECAwGIBwMVCcFWhlOKDA2FUAEKAQEBHoEhiGmDQBOBMWSCby6BEwWNf0yCcoNugk+KHzqFToQOPjCBA4FAAQEB
X-IronPort-AV: E=Sophos;i="5.07,560,1413241200"; 
   d="scan'208";a="19189912"
Received: from host-78-151-116-24.as13285.net (HELO PhilipOakley) ([78.151.116.24])
  by out1.ip02ir2.opaltelecom.net with SMTP; 11 Dec 2014 23:23:28 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261306>

=46rom: "S=C3=A9rgio Basto" <sergio@serjux.com> Sent: Tuesday, December=
 09,=20
2014 2:44 AM
> On Sex, 2014-12-05 at 17:56 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
>> In the same spirit of 7fce6e3 (commit: correctly respect=20
>> skip-worktree
>> bit - 2009-12-14), if a file is marked unchanged, skip it.
>>
>> Noticed-by: S=C3=A9rgio Basto <sergio@serjux.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  builtin/commit.c                         |  2 +-
>>  t/t2106-update-index-assume-unchanged.sh | 10 ++++++++++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index e108c53..ee3de12 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -252,7 +252,7 @@ static int list_paths(struct string_list *list,=20
>> const char *with_tree,
>>  if (!ce_path_match(ce, pattern, m))
>>  continue;
>>  item =3D string_list_insert(list, ce->name);
>> - if (ce_skip_worktree(ce))
>> + if (ce->ce_flags & (CE_VALID | CE_SKIP_WORKTREE))
>>  item->util =3D item; /* better a valid pointer than a fake one */
>>  }
>>
>> diff --git a/t/t2106-update-index-assume-unchanged.sh=20
>> b/t/t2106-update-index-assume-unchanged.sh
>> index 99d858c..dc332f5 100755
>> --- a/t/t2106-update-index-assume-unchanged.sh
>> +++ b/t/t2106-update-index-assume-unchanged.sh
>> @@ -21,4 +21,14 @@ test_expect_success 'do not switch branches with=20
>> dirty file' \
>>  git update-index --assume-unchanged file &&
>>  test_must_fail git checkout master'
>>
>> +test_expect_success 'commit <paths> ignore assume-unchanged files' =
'
>> + : >anotherfile &&
>> + git add anotherfile &&
>> + echo dirty >anotherfile &&
>> + git commit -m one -- file anotherfile &&
>> + git diff --name-only HEAD^ HEAD >actual &&
>> + echo anotherfile >expected &&
>> + test_cmp expected actual
>> +'
>> +
>>  test_done
>
>
> works great many thanks,
>
Junio: Given that this patch avoids the user surprise that the `commit=20
=2E` and `commit -a` produced unexpectedly different effects, should it=
=20
also be included in the --assume unchanged patches? Or is the test=20
inappropriate?

I'm guessing that there will still be other potential 'gotcha' code=20
paths that would still produce surprise though.

Philip=20
