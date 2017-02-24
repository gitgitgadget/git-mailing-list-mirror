Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257E0201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 22:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbdBXWIU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 17:08:20 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:18102 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdBXWIT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 17:08:19 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id hO2CcFYkQgKsthO2CcZRyF; Fri, 24 Feb 2017 22:08:17 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=kquRS4nWwJHmo7G3Cn4A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <29A09E4EDB1F4F4D9E77E67A7A8A33FF@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
        <sschuberth@gmail.com>,
        "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
References: <20170223122346.12222-1-pclouds@gmail.com> <20170224131425.32409-1-pclouds@gmail.com> <20170224131425.32409-2-pclouds@gmail.com>
Subject: Re: [PATCH v6 1/1] config: add conditional include
Date:   Fri, 24 Feb 2017 22:08:16 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfMIQAbSDU4ukL5fuKBKl05wCAuibEeS2SdIf3nu4wN7IZSI2ovgAhuXK8VQtE902XgSM4T9koCs22Xa+WzP4a+gpig+fYVh47KhJlM8HHxiGoL7kPjji
 tmFGIVr+rtmxkyqx5OcuLUrgUX9VnGmSPiL4pQkzYfeJq+5d9jd0/n6+L8myV1KKZ4qL2hH692E62K5Khq9xF00/Qof+he+8X4MmhuEi+Rm6U/62OWPFKsul
 mt05P/3eZ+6rPH06DNzrX+JxCjN1R1kgQRobZ5EhQ9jk+543zbreWGbwvKDSEoxEn/NJMQHxadjR9TPvSOpBzJURyk9zQzuM3wTEatUco9UApIr+Hc2X3UtZ
 eFKElwqN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Nguyễn Thái Ngọc Duy" <pclouds@gmail.com>
> Sometimes a set of repositories want to share configuration settings
> among themselves that are distinct from other such sets of repositories.
> A user may work on two projects, each of which have multiple
> repositories, and use one user.email for one project while using another
> for the other.
>
> Setting $GIT_DIR/.config works, but if the penalty of forgetting to
> update $GIT_DIR/.config is high (especially when you end up cloning
> often), it may not be the best way to go. Having the settings in
> ~/.gitconfig, which would work for just one set of repositories, would
> not well in such a situation. Having separate ${HOME}s may add more
> problems than it solves.
>
> Extend the include.path mechanism that lets a config file include
> another config file, so that the inclusion can be done only when some
> conditions hold. Then ~/.gitconfig can say "include config-project-A
> only when working on project-A" for each project A the user works on.
>
> In this patch, the only supported grouping is based on $GIT_DIR (in
> absolute path), so you would need to group repositories by directory, or
> something like that to take advantage of it.
>
> We already have include.path for unconditional includes. This patch goes
> with includeIf.<condition>.path to make it clearer that a condition is
> required. The new config has the same backward compatibility approach as
> include.path: older git versions that don't understand includeIf will
> simply ignore them.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> Documentation/config.txt  | 61 +++++++++++++++++++++++++++++
> config.c                  | 97 
> +++++++++++++++++++++++++++++++++++++++++++++++
> t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++
> 3 files changed, 214 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 015346c417..6c0cd2a273 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -91,6 +91,56 @@ found at the location of the include directive. If the 
> value of the
> relative to the configuration file in which the include directive was
> found.  See below for examples.
>
> +Conditional includes
> +~~~~~~~~~~~~~~~~~~~~
> +
> +You can include one config file from another conditionally by setting

On first reading I thought this implied you can only have one `includeIf` 
within the config file.
I think it is meant to mean that each `includeIf`could include one other 
file, and that users can have multiple `includeIf` lines.


> +a `includeIf.<condition>.path` variable to the name of the file to be
> +included. The variable's value is treated the same way as `include.path`.
> +

--
Philip 

