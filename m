Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0548C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbiDZPkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiDZPkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 11:40:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4681BEB4
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 08:37:04 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2EEF41929A3;
        Tue, 26 Apr 2022 11:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WaPriIhGUH52L+is4Qv+a+FXB+oH85fsJztncy
        sYJnE=; b=lcqYZMC22deXtd/amx0muy5cDw7QlLTOq1gn/cHH6OF2rtqfrzm2W8
        fMV3ZND5+rs2ldvRS9vnMBvuimsAfeh9XpGL33lD+D+OS/4Ay4gZNZHDvbkbS7w2
        WGTfR30+w7oadK0MX/OUToaMkxlGGrxtebhvkJFJXENd88k7xVBhg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27BD61929A2;
        Tue, 26 Apr 2022 11:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D7B319299F;
        Tue, 26 Apr 2022 11:37:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
        <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
        <xmqqczh73hns.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2204261726460.355@tvgsbejvaqbjf.bet>
Date:   Tue, 26 Apr 2022 08:36:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2204261726460.355@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 26 Apr 2022 17:30:12 +0200 (CEST)")
Message-ID: <xmqqk0bbsvok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6E0314E-C576-11EC-92A6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 23 Apr 2022, Junio C Hamano wrote:
>
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>> >> guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
>> > ...
>> > There has also been added an escape hatch of allowing "*" for the
>> > permitted safe directories. but do check the updated manuals, and the
>> > git mailing list archive (update the search in the above link).
>>
>> In this particular case, I do not think '*' is needed, but you need
>> to be careful here.  Whose configuration are you suggesting to add
>> such an entry?  Yourself?  ~root/.gitconfig?
>
> One relatively simple work-around might be to call `sudo chown root .`
> before running `sudo make install`, but of course this would require the
> `rm -rf` to be run via `sudo`, too.

chown root may make it owned by nobody4, though ;-)

> Do we want to make use of the environment variable `SUDO_UID` that is set
> by `sudo`?

"run this command under 'sudo'" would be a social engineering attack
we do not want to defend against, so I am OK with that, but then
allowing

    sudo "GIT_SAFE_DIRECTORIES=. make install"

does not look too bad, either.



