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
	by dcvr.yhbt.net (Postfix) with ESMTP id 27FFA1F731
	for <e@80x24.org>; Sat, 10 Aug 2019 21:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfHJVQQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 17:16:16 -0400
Received: from mout.web.de ([212.227.17.12]:33931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfHJVQP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 17:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565471768;
        bh=a3AWb+okiUrAAywzZUxNewNcylBeiju/5OY/hsaLUhM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YxZjudXNEdpFTnYnBF+zA6xFANozqagK9uIEckCoV4mA8j9PtzTxj3jcIOpjQCFvC
         S6h50ahuWwjBuN6MlKpM7wpijYgQRnAeSfiBb2R6e9YIlbeaOpBD89Kkd4X1z/aKGM
         3pXKlHJ42ZJhyB0MZYEYdw7bADzH0+IH9y7lyMQM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbQGO-1hdvP93T3k-00IkH5; Sat, 10
 Aug 2019 23:16:07 +0200
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no
 crashes
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        michal.kiedrowicz@gmail.com
References: <20190807213945.10464-1-carenas@gmail.com>
 <20190809030210.18353-1-carenas@gmail.com>
 <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
 <d239326e-11c3-5875-13a8-f4123baea6eb@web.de>
 <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <CAPUEspjVMbjdgBrW3qS3jwbd2ZfqMinfgGiasEZGwyZB-1c+QA@mail.gmail.com>
 <d8e55007-27bd-fcac-c918-bb712ec1bb8b@web.de>
 <CAPUEsph+hjU2UstL=YW-2qKC3pGJrOwaw+VCiHH74HZ2=oupig@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e127a2d0-7ce4-71af-3d91-8b5515af2dc8@web.de>
Date:   Sat, 10 Aug 2019 23:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEsph+hjU2UstL=YW-2qKC3pGJrOwaw+VCiHH74HZ2=oupig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5QV7DqXrFwkBQRUHLkNmeK+c/j2+ptSlNsE3/B1ckWXOea/uBAC
 Yx2EDtFmzCl01m0z94EeEtoDzxjxdhCjMYwQifqvxISHNGpJ6LXX4h2iRSAOt5yZ2vEM1LY
 TgE6Daj/fGDi3+eEhBbuDXBFz07XeI2HDqFjCHOHqaMQjWkv96qGxmQap2HzmC78nrDBI4/
 jp7Nx1r+bqED8roS5OzUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jsyTzQmIjG4=:hlkOhWT71zXu7LPSHcHjhS
 Y0nSf4khaP+5uLxFGYM5UY9rh9m7/I7chok0kZFs6YdY4JQmQRYH/Pph2asD33ne3NK1Hil0d
 +OWzrOPqou5lLCEy1fFny/BtyJZf4BTXz8uBksGvzp0CJ4SVa9Iz+ZKtYGH2118qi66ujz5eQ
 erM0fu3gWuoXqFGT2eowv4fJ8BVZ3qnTLQk+us4H5AOtbBn5gk7sAeE6W/xqMtMvjjDC23apa
 Cmid1CUwk0AVhPTJ5Wel7N4fV9IGuvNWk8/r9xhLRJouW+LH47ejAY4oDaFMw4Dc/NIunJ6HT
 oIQubjVN3kJH/sWyfk4aQsicZbcsbkrHrsMopusam8HsH3nuMSrx6Llxp9f6wmx4em1K8yT9n
 ZhGJ+oKfiM/88zeBu/pXI2AsKcqbHmvZCfnEBuSe2R5M3jbosY0ccwRSi/eJPEwfAPjgCLRa4
 FPYGYPCSLuxmIpPqvEqCctRFa9dOUC1Hy7LlLjy1mkiAV2xQlAgNPch1kGI/S3vygYIXBlySc
 4xj7KG6IS9TrwI9XCP02q8IwJlPl9W8kXAggqC2giypuO6Xcrap8bKhm0d+NtW2JAD0ePHDZP
 f8udDKOn8KVpWVLQZyXUGdf3qVaWAg0Jfm9tyuL4YMMGTrbpoViGpxasjiBthn858DSXlVA4a
 qYimdud09Tpw0FRTdrcYVtNYzMMITaTuqkYfu4fgi5Lw+/nOipcJZdurl2h5pdgOLigv5k/Mf
 EzDzfiULGiFGaU7oxf13utFNWLZX5fXWgW2MeeleuXq2y3k8IwUcCPjqy10Ig/fYeYfcgbF7P
 fY9Kcx9e1F+IKedEbUWN0Fqji6Jb+4Szt3cOLZ2N2QDpuSOIb7D9teL59dzUXLBc25tAONrHu
 WtO3rvBSoDPaOqpUxdSGWwFVYHGnrcrS4w75s5uAX+hTXVTlaJ6+K0whfLXWAjonF2eXQa3j3
 KHOTrPu7OpXUzVrOD2zCSMhgNy0uKQMBWqWQ1g6o8mmyW3Iw8NrB5kduUYhPz8Q0FvrS8bZXk
 yVb+Ne0hzeivnGA8EpEw34sYK5UUXRPNE9pZqvZEekCKdo1BApWIe3odnavhGOLdknn4xl4EU
 SIl0B4koVhHmPmTL1wacw5YacFH5rDArJzOkpD75m/Jly/d9+jqY2+NH+57wFghetCWJTj7WO
 se0CQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.19 um 14:40 schrieb Carlo Arenas:
> On Sat, Aug 10, 2019 at 12:57 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> I don't understand why my performance is lower by factor 2.5 than yours
>> for all perl regex tests except 7820.15 (your 7820.4), where my system
>> is two times faster.  Debian Testing, GCC 9.1.0, i5-9600K, 16GB RAM.
>
> interesting; did you also see at most 100% of one CPU being used?

For 7820.15 yes -- 100% of a single core, the rest idling.  The other
tests had only brief sequential phases, if at all, and used all cores.

Ren=C3=A9

