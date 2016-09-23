Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513C1207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 22:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761234AbcIWWxH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 18:53:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63597 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758292AbcIWWxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 18:53:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56DFD406E4;
        Fri, 23 Sep 2016 18:53:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4PMjibMptG2M
        kjg+X6+U4Rol5LQ=; b=WhwttCWbC7vNNmKK4Fz2Gitl20csFWWL0JHZlapF79Ce
        p8ymRGoXGnrI60Y75yw984RiDcs/4GDR+BVOCghRZrBXvbHtCRLI6A2WW/I/fHm2
        Ixg0QWf+qK/g70liJei4DitmE5UtkELCjUUqT/QsWpE7gGeNAnnX/trh44PuhjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ehc7BU
        zoZCkgslr846zoB1nMPsbNki7iQoPeBi9cTyyeFfOxIQedDPJtICVPwHL3aE+Hqs
        ARM3IvzTlEbXcDabgtEyRJtCKkombFn2ezUEoscGiNtcpipSTNxqdRcDW+qlHd6d
        1HH7f0u93RPByQfLqlcfHIlht97Q0zeLHBUKw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E783406E3;
        Fri, 23 Sep 2016 18:53:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C846C406E2;
        Fri, 23 Sep 2016 18:53:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH v2 4/3] init: combine set_git_dir_init() and init_db() into one
References: <xmqqbmzf6e0r.fsf@gitster.mtv.corp.google.com>
        <20160923111206.8596-1-pclouds@gmail.com>
Date:   Fri, 23 Sep 2016 15:53:02 -0700
In-Reply-To: <20160923111206.8596-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Fri, 23 Sep 2016 18:12:06 +0700")
Message-ID: <xmqqshsqz0s1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7CD4EC0E-81E0-11E6-898D-C26412518317-77302942!pb-smtp1.pobox.com
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

I think this 4/3 is not quite enough to fix the damage to the code
caused by 2/3.

Given that

 - set_git_dir_init() is is the only one that sets original_git_dir,

 - create_default_files() is the only one that uses
   original_git_dir, and

 - init_db() is the only one that calls set_git_dir_init() and
   create_default_files()

after 4/3 is applied, we should be able to remove the global
variable 2/3 introduced, make init_db() receive that information as
the return value of set_git_dir_init(), and pass that as a parameter
to create_default_files().
