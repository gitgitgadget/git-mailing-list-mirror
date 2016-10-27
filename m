Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59EF620193
	for <e@80x24.org>; Thu, 27 Oct 2016 23:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034331AbcJ0X0Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 19:26:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59989 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034145AbcJ0X0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 19:26:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD2E44BE03;
        Thu, 27 Oct 2016 19:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Tpf8BXOMX5kF1UXgin7+dwR+/c=; b=b9qZjg
        J1WOlSs7CT0Jv5NMFcHQo5SYxThVAP4mu6+p/vacFuzUCeBVYne9zgB0RKD97G9g
        X/EocKyYYTVHa9du9axCdnPXwv/6g0xd/kuiCf1FtGJO40OTTQZOUIQoR7nF7MzF
        Zh+ftEyprMKkvE1uGAKQYkEw0+4ZRoHStCpRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NbLyU9RUCpPL56AXCau1NgRCNhv0vOvr
        yneeg9r9y9KHOIYQ4zEQAA/1JIbhanEIqWQYDjTSBCSYSSt8B1A9enQGat9X84TU
        Kd3/aOKjc/e8nqjv5WoNwQQLUBbL4azcpysMB9XkvgJ3tfIU/LzsAzo4KhtFZNc8
        X7+sTicgQeY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4D334BE02;
        Thu, 27 Oct 2016 19:26:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 519904BE01;
        Thu, 27 Oct 2016 19:26:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] recursively grep across submodules
References: <20161027223834.35312-1-bmwill@google.com>
Date:   Thu, 27 Oct 2016 16:26:20 -0700
In-Reply-To: <20161027223834.35312-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 27 Oct 2016 15:38:29 -0700")
Message-ID: <xmqqk2ct4bmr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C57C804E-9C9C-11E6-BD14-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> As for the rest of the series, it should be ready for review or comments.

Just a few brief comments, before reading the patches carefully.

 * It is somewhat surprising that [1/5] is even needed (in other
   words, I would have expected something like this to be already
   there, and my knee-jerk reaction was "Heh, how does 'git status'
   know how to show submodules that are and are not initialized
   differently without this?"  

   The implementation that reads from the config of the current
   repository may be OK, but I actually would have expected that a
   check would be "given a $path, check to see if $path/.git is
   there and is a valid repository".  In a repository where the
   submodules originate, there may not even be submodule.$name.url
   entries there yet.

 * It is somewhat surprising that [4/5] does not even use the
   previous ls-files to find out the paths.  Also it is a bit
   disappointing to see that the way processes are spawned and
   managed does not share much with Stefan's earlier work, i.e.
   run_processes_parallel().  I was somehow hoping that it can be
   extended to support this use case, but apparently there aren't
   much to be shared.

Thanks.
