Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360BE1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 12:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfJ2Mjf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 08:39:35 -0400
Received: from st43p00im-ztbu10073701.me.com ([17.58.63.183]:35949 "EHLO
        st43p00im-ztbu10073701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729134AbfJ2Mje (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Oct 2019 08:39:34 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2019 08:39:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1572352403; bh=eArbg3t6stCLycaAzoJrMrhikYHyarVAEW986ksG8BM=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=giN3wVJMoQDVxuL8E6nenFS5JBBMxsaTWFuSy79bfJvqy61uH9aU+DPy/C3Knv/Y4
         lUnhl7+PHprtmhO2QnRnzMonkvXR7gPJLmRJDAyEtkO43ew0m+y1m1+HxLMH9A2IAi
         Ju/6RqW/V5TTkiK+LwSu9pJin+noX14Oupmv/uygoFdQgiyKHJSRQYBIN+LwpPp/SV
         dSbWTmHB7ElW5L36y9mcI0u3fAY5FaFkxO1PTXlKCGg7pwrC2RJFQE9aVBcYTfFnJk
         dtp8QS900sNduRvfn/JW9gfgr3P3P2G8F4mOLNv/tcwMrTMFTs8GtnrjMU/xRNxyWP
         H79S2aqG8ZaxA==
Received: from [192.168.1.127] (unknown [192.222.216.4])
        by st43p00im-ztbu10073701.me.com (Postfix) with ESMTPSA id 805D04C0EAF;
        Tue, 29 Oct 2019 12:33:23 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/1] worktree: teach "add" to ignore submodule.recurse config
From:   Philippe Blain <philippe.blain@me.com>
In-Reply-To: <xmqqtv7ta9lz.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 29 Oct 2019 08:33:21 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <85CAC41A-A0EA-4E22-BC22-F57A59D76678@me.com>
References: <pull.430.git.1572196585.gitgitgadget@gmail.com> <xmqqtv7ta9lz.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910290124
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

That indeed makes the trick. Thanks!=20
Should I send a separate patch series with this patch ?  How would that =
work ? "Signed-off by" me and "Based-on-patch-by" you ?

Philippe.

> Le 27 oct. 2019 =C3=A0 22:26, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> I am not sure if the compiler needs fixing in this case, but the
> following may work it around.
>=20
> builtin/merge.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/merge.c b/builtin/merge.c
> index e2ccbc44e2..0746f11df2 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -826,9 +826,12 @@ static void prepare_to_commit(struct commit_list =
*remoteheads)
> 			strbuf_commented_addf(&msg, "\n");
> 		}
> 		strbuf_commented_addf(&msg, _(merge_editor_comment));
> -		strbuf_commented_addf(&msg, _(cleanup_mode =3D=3D =
COMMIT_MSG_CLEANUP_SCISSORS ?
> -			scissors_editor_comment :
> -			no_scissors_editor_comment), comment_line_char);
> +
> +		if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS)
> +			strbuf_commented_addf(&msg, =
_(scissors_editor_comment));
> +		else
> +			strbuf_commented_addf(&msg, =
_(no_scissors_editor_comment),
> +					      comment_line_char);
> 	}
> 	if (signoff)
> 		append_signoff(&msg, ignore_non_trailer(msg.buf, =
msg.len), 0);

