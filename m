Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B8C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352765AbiD1V7K convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Apr 2022 17:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352697AbiD1V6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 17:58:55 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6404EDD8
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 14:55:38 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23SLtXnj029425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Apr 2022 17:55:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com> <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g> <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com> <CAPUEsph+p-fD8vMOMU4Djkc8cFUmm=9JVFdgaxkQ4-CpKZgnCA@mail.gmail.com> <000801d85b40$ac11ec80$0435c580$@nexbridge.com> <CAPUEspgcd1CYTfL=ug3WtnOrJscWbyQXeF-2SQ_24KcCTkuRkA@mail.gmail.com>
In-Reply-To: <CAPUEspgcd1CYTfL=ug3WtnOrJscWbyQXeF-2SQ_24KcCTkuRkA@mail.gmail.com>
Subject: RE: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
Date:   Thu, 28 Apr 2022 17:55:28 -0400
Organization: Nexbridge Inc.
Message-ID: <000f01d85b4a$af8c3aa0$0ea4afe0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEhoH1klsquz/XrUeoh6UIeie+nGgNSFEhJAdygO20BcR/rTQHiUZcMAngeyfgBGrLMqwDSjnBurgwVb4A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 28, 2022 4:56 PM, Carlo Arenas wrote:
>On Thu, Apr 28, 2022 at 1:43 PM <rsbecker@nexbridge.com> wrote:
>> I tried to find is_root in POSIX but could not. Do you have a reference? It is not in
>bash 4.3.48, which is on our older system.
>
>my bad; is_root is a helper function i provided as part of this file; the latest version
>which should work in your posix system AND was specifically written to hopefully
>not break with NON-STOP based on what you told us about it looks like (hand
>edited and not tested) :
>
>is_root() {
>  id -u >u
>  id -u root >r
>  cmp u r
>}

This is about as portable as I can find and works even in ksh. It could be optimized.

is_root() {
  id -u >u
  id -u root >r
  cmp -s u r
  if [ $? -ne 0 ]; then
    echo 0
  else
    echo 1
  fi
}

if [ `is_root` -ne 0 ]; then
        echo root
else
        echo Not root
fi

