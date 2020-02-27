Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0231C3F37E
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8844C24656
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pascalroeleven.nl header.i=@pascalroeleven.nl header.b="XF4R3XXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbgB0OKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:10:20 -0500
Received: from web0081.zxcs.nl ([185.104.29.10]:56934 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388515AbgB0OKT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 09:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YOA7p65KlMwLqQZir3GEz5/dRGgGqMOHtrGxoXrzv0g=; b=XF4R3XXxWrxtKg8vFAaoNZhkf9
        cp6xOMvWyohxyJnCUYUQlA+WJRr7WtClYqjIAv0fV0US8Zh90EDC5L8Eu78JW2tpbt5ag1wZjYaLZ
        fgX5kCRoadxzcUnNplv4Dxy7/L8ds9/qykUJyQVrR+Q2C0+5Nkm9DGhO6CT7rkIgSmJUkSUoJiW9p
        ILk6rlonRnOfkulNNJWzg6GIpI3wT7Xq7N2the4Su7f5AG1oIrt7wx/Ewkd2WKFkB9cq6joA2FKXZ
        HbCdnAkeX5GNIA6J9ibPO6PJQOc75VGRsaJslF2kAGpKCQB7IkQYV/N/Qafe7emvXZAcgaLHR+hOn
        Q9K2mSZw==;
Received: from spamrelay.zxcs.nl ([185.104.28.12]:54742 helo=mail-slave01.zxcs.nl)
        by web0081.zxcs.nl with esmtp (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1j7Jrl-003dZY-Ft; Thu, 27 Feb 2020 15:10:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Feb 2020 15:10:17 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-remote: don't use '-h' for options
In-Reply-To: <20200227130833.GA10339@danh.dev>
References: <b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl>
 <20200227130833.GA10339@danh.dev>
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <03985e4099e82f04709d5ea9ca2a56a6@pascalroeleven.nl>
X-Sender: dev@pascalroeleven.nl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-02-27 14:08, Danh Doan wrote:
> On 2020-02-27 12:42:18+0100, dev@pascalroeleven.nl wrote:
>> The '-h' option for ls-remote will never be reached as the argument is
>> already processed by the git wrapper before passed on to ls-remote.
>> The ls-remote help text will therefore be displayed instead of the
>> '--heads' option.
> 
> No, git ls-remote still see '-h'
> 
> - 'git ls-remote -h' will show short help.
> - 'git ls-remote -h <remote>' and 'git ls-remote --heads <remote>'
>   will show the same output
> 
> See also:
> https://lore.kernel.org/git/xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com/
> 
> xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com

You are right, I didn't test with <remote>. Thanks for pointing me to 
the old discussion.

Because '--heads' can be used without a remote, and '-h' is advertised 
as the shorthand equivalent, they should produce exactly the same 
output. And they don't. The discussion aside if you should use '-h' for 
anything at all except showing help, in my opinion if an option is 
listed as an alias for another option, they should produce the same 
result for all (or in this case the lack of) parameters.

In my case I looked into the documentation, used '-h' exactly as 
described ('<refs>' is optional) and it didn't produce the output as 
described. If you ask me, either the code or the documentation should be 
changed.
