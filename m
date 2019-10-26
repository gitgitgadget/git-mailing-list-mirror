Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED971F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 07:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfJZHsK (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 03:48:10 -0400
Received: from mout.web.de ([212.227.15.4]:43807 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJZHsK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 03:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572076079;
        bh=od8nGAdp2UJt9hIbk8y/v7A6s9YImwMUZSw0Dr99w7o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XKKtWb9ow6G5kOS2/Qk4ba/QDdEj3jd9YaZh5wkrtNvELoOIjiHWfowpn6CJtNkIH
         PUq6Se4AYeOwwYitHgayzOSkP3UKF7JjFX/ui5a9fpxIVuohVIoaan1MbJTHA2y4kK
         iE0tv6Mqy33LvJWNnGXokf8MAWlGLGp44pKz3fbs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mbdf3-1igdAI2CPN-00J6FP; Sat, 26
 Oct 2019 09:47:59 +0200
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from
 complete_action()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-6-alban.gruin@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <67c98856-55dc-df95-c4a6-61f1af85c480@web.de>
Date:   Sat, 26 Oct 2019 09:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190925201315.19722-6-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z4TKK1Z/g6+KFfw1S10ufqztwW0nINAGykr/Z/w/re1c3/PJh6K
 W5F6xpYVQe1uibEgf7kHBJoSsFJWQftZtp22hOZ0rdb5qN+NIZMS0bDH/TO3DWzhePwNWmu
 LdEk5w3LmI1ilFpVIane6yN1K0Peomgl19MVn+5ewEX5lAAqlXBDnZu1UyRTrB3V5uzZBCQ
 +Sd9dzB6U6+jIEGgA89rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fc/SVeMJ7lo=:6XEI304JpxZmZSL3YoOnGd
 U3RwIUyxLMjIA+1dbTw4dg/Gq5I0rqPSW1uzPiNED6Y1die4cPkCmoZV4j6gYCntNQwK5vs0+
 nxo5F9D/JvJKQd0mXsMLljqEcqMMNZ8h0mX7pXzLqO9FI2Qa0WcrREDo4gKv/CxK+aeDGfG/s
 4zncoozLfPiwBZuTHxjgHr/qLTjvwrW8ec7h3Jp2g1T921MwoFghALESeCRAUgFegdm8Tdceq
 t/jtHir7ZI94wjkSjc+N0iBdC+PEGVSxyQxP9MqW8Ns0P4vogtD5tw8KESzUGPln9TOni2ycb
 Y7x4eftSYgDQx8kJryx4jjuOxTzKmWWWzPeH0Q+OoXLlfEZzE0R4gYgSBAdgAablYQz9D+MOv
 d2Rx99vq3Vhx/JDK2tsPnfPIukBGuKS51XcNp+mX1chh0mHcHQ9HWB6dDUH64Cn6won9+C2LZ
 ve/6LKe8mGkHcW1TaCtEKpRkq2tLnzovnfKHg7qFpBNwQGif6AreFzrwW74JMRV71UuhzbkpW
 xtL1yevBl41duXuyvXNCoxuke1oPDCm/LRqG/phEqs4zs2lhlUnv0iAzIz9ugswLzZylFOftj
 Qx9oU60uKPmRMxTAMFovXUR+d7+OwH7YORxWtp80COJt8hssgzUwGk5DgpINHeK9e3fQ7Dzw1
 woF5VZNSEW94iOjvyHE+iwpQuozRoKWgsChVkZsQrA45M3WJ+ePagnOSTGBzAd0FUt1Or+wW0
 dldWKluXpbEYWrxw8zUYcIBnlE+FTvFp5z9WkLJ5sxVf3aLj0uk4E2H372GkSltFDIhF4E2h5
 KP+1zT2PabpxIbG5HgcgMuos5JBdqA45+2mJcZDbs/PmBLwycpu6KAHCPts1FixkTrAoi6nWE
 NCBGUtuux/D+ntPenIUBimJLxEJKt/UPMSBZZqfVK9c8sLsxCjJH+EzkEuaZwDA1pT0Iz6Ypa
 FtvERuKz+WROmctjex3YtGsZvoscD7DduE9auikWq4NxBs9UddK8GPOdwLrh9uZAcaE1yES+R
 uwGvRvnz1e/OY4hZPBYJLszQuKSAVchw1d5MChONfGSGBQF9jhbM76dSG8fQq4XRl0w+pPSIK
 wBX3JhSSVX+nUG/LTb8f5SS6jlX+E1AVJyVhrw4Hxz/x3yw8qOM6OJeHfUUNMW880oHM0Buyf
 GFA7kRppNT5NVKxhhzofF4LEIxS1GZ1F0Z+NAQfc1SAtrBqzmPv1Ijask0eS9kep51OqUFOZw
 k6OW/WUE1XfFdLY3+md1Dp7FRddFHGwJdFZXX6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.09.19 um 22:13 schrieb Alban Gruin:
> Currently, complete_action() calls sequencer_continue() to do the
> rebase.  Even though the former already has the todo list, the latter
> loads it from the disk and parses it.  Calling directly pick_commits()
> from complete_action() avoids this unnecessary round trip.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index ec7ea8d9e5..b395dd6e11 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5140,15 +5140,17 @@ int complete_action(struct repository *r, struct=
 replay_opts *opts, unsigned fla
>  		return error_errno(_("could not write '%s'"), todo_file);
>  	}
>
> -	todo_list_release(&new_todo);
> -

Moving this call down leaks new_todo on error...

>  	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
>  		return -1;

... here ...

>
>  	if (require_clean_work_tree(r, "rebase", "", 1, 1))
>  		return -1;
... and here.  Perhaps set res to -1 and jump to the end?

>
> -	return sequencer_continue(r, opts);
> +	todo_list_write_total_nr(&new_todo);
> +	res =3D pick_commits(r, &new_todo, opts);
> +	todo_list_release(&new_todo);
> +
> +	return res;
>  }
>
>  struct subject2item_entry {
>

