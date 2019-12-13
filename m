Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C1C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8766224671
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ft2PzKjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLMVMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:12:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53090 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMVMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:12:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00384A9223;
        Fri, 13 Dec 2019 16:12:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5nM5XZek7g06g5pJZDmqFQfRIvA=; b=ft2PzK
        jlN4tqZxW9wuA7jLQ8Xyf5lZtSJcv3pODxzSMlNYjqxzCiAtl2s09wsD4lw3G35t
        ku9nNurzsXGe6jjXW7u3dwmRR0dpthse/yt6aQHqb9Q3HSff6mAJTIKw3WJA2OcW
        Dtn1cRa9iw7Y3vOoTnvUBdscgbg3gez9CxPRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ffhKbiDy4aRVg+ViWP+XAbDlWkgChAqS
        gAOnQ45hLp3EfflkpvCsHR7NisA711o01Ox20oDBc15SgdzCs7rSu9+rfauf71Mh
        Q3K0nVcqsZUbCX8rps5cz5SKm98Rqg9QgZviFU9FlALlbk5QyDy9jV37EnIn9X3T
        rMuLeyzM930=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DECA8A9222;
        Fri, 13 Dec 2019 16:12:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02815A921E;
        Fri, 13 Dec 2019 16:12:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 05/15] bugreport: add uname info
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-6-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:12:01 -0800
In-Reply-To: <20191213004312.169753-6-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:02 -0800")
Message-ID: <xmqqmubwhqvy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3618BC1C-1DED-11EA-951F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> The contents of uname() can give us some insight into what sort of
> system the user is running on, and help us replicate their setup if need
> be. The domainname field is not guaranteed to be available, so don't
> collect it.

It was surprising to me that we do use "struct utsname" somewhere in
the system ;-) ... so at least we know this is just as portable as
the remainder of Git, which is good.

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/bugreport.c b/bugreport.c
> index 59d8b5a3af..9c69e3fa34 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -8,12 +8,25 @@
>  static void get_system_info(struct strbuf *sys_info)
>  {
>  	struct strbuf version_info = STRBUF_INIT;
> +	struct utsname uname_info;
>  
>  	/* get git version from native cmd */
>  	strbuf_addstr(sys_info, "git version:\n");
>  	list_version_info(&version_info, 1);
>  	strbuf_addbuf(sys_info, &version_info);
>  	strbuf_complete_line(sys_info);
> +
> +	/* system call for other version info */
> +	strbuf_addstr(sys_info, "uname -a: ");
> +	if (uname(&uname_info))
> +		strbuf_addf(sys_info, "uname() failed with code %d\n", errno);
> +	else
> +		strbuf_addf(sys_info, "%s %s %s %s %s\n",
> +			    uname_info.sysname,
> +			    uname_info.nodename,
> +			    uname_info.release,
> +			    uname_info.version,
> +			    uname_info.machine);
>  }
>  
>  static const char * const bugreport_usage[] = {
