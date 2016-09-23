Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FB2207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 15:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035389AbcIWPS4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 11:18:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965055AbcIWPSw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 11:18:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A38C3B5C5;
        Fri, 23 Sep 2016 11:18:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3qHRhehXcIvn
        n2+l7Na2QPkl0fQ=; b=ubafgQ8dlytlUeveTwWvYWw8M9cRYCyberlxllDKGdRr
        tdfLUMXjOqfwsPDFfNoXOUKKbu5fPXZUlxM8jDJo4D8QEQPcxD9KGqis3/wliSa4
        JWcvX0n/QoZXbF6fsU32W6uctv5qlluSKElhYNf3UbTCxTTzjNd+ZwxHP8i4+7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=quw1Ba
        1cShFqFhX4gKkmFHKFrkUMUj0vNdENV4zP9wqDex7ZQKq2tldbBwp2QrZpG/kHyG
        0b/CzMdqGzHfjaTSb9+mfOuR59WYXz7A77IrDCkb49lk5p7dDZifeoBpulUlUZXF
        9zqUnsvVy6bSHvZM1ltVXNZQm8kom16hap2Ck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 731BB3B5C4;
        Fri, 23 Sep 2016 11:18:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E618B3B5C3;
        Fri, 23 Sep 2016 11:18:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH v2 4/3] init: combine set_git_dir_init() and init_db() into one
References: <xmqqbmzf6e0r.fsf@gitster.mtv.corp.google.com>
        <20160923111206.8596-1-pclouds@gmail.com>
Date:   Fri, 23 Sep 2016 08:18:47 -0700
In-Reply-To: <20160923111206.8596-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Fri, 23 Sep 2016 18:12:06 +0700")
Message-ID: <xmqqzimy1w6g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07A83F7E-81A1-11E6-8745-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  I think a separate commit for this is better than combining back to
>  2/3 so we can explain the problem properly (without making 2/3 commit
>  message even longer)
>
>  Not sure if you want to s/contains/contain/ in 2/3 by yourself or I
>  should resend the whole series. Let me know.

OK, I just amended it before applying this on top.

> +	flags |=3D INIT_DB_EXIST_OK;
> +	return init_db(git_dir, real_git_dir, template_dir, flags);

I do not think of anything better, but EXIST_OK does not sound
grammatical.  "REINIT" is not quite it--we are merely allowing
the function to re-init if there already is a repository.  And
OK_TO_REINIT is a bit too long.  Let's take the patch as-is for
now.

Thanks.

