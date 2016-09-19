Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5D3A2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 16:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbcISQMQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 12:12:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54868 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751579AbcISQMP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 12:12:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E6E73FE77;
        Mon, 19 Sep 2016 12:12:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DNtXTpgTSZs3re97r5KjfhCfyWo=; b=ABl9tZ
        uzsQhgl0GqxyeXI5HjOI2S+i9UUWXSPd1SM9O08AfgcjuInW/x0P6JBuTEMvBEFg
        pikQAjbRCwDWul1ssin3NEQzIZREv6naQxV1WMdISn89eiFCeAOCfsWwOC3I6lCL
        uY9qX+b1loLVFiMJdHSehgG54gt+04Sd6E8rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WbW3FO1ed3Y9vZX4kGOkW7W7uTfmFd6e
        hDi4zz58Itg84N27GWQjfxJTXM0DneHRVOdo2st2eWRvUKafom2IvUl30WQJMWZY
        KKzJx6+RWVeCb9U6NhVykVOorZbPKi+SlH+qUrKQEptTkZudnEf8AQeqyqe+bGwf
        40nzKB0A7cM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1777A3FE75;
        Mon, 19 Sep 2016 12:12:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91A393FE74;
        Mon, 19 Sep 2016 12:12:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
        <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
Date:   Mon, 19 Sep 2016 09:12:11 -0700
In-Reply-To: <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Mon, 19 Sep 2016 15:46:35 +0200")
Message-ID: <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D387EDCC-7E83-11E6-8FEB-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> It can be read that
>> 
>> $ git cherry-pick maint next
>> 
>> would pick two single commits, while
>> 
>> $ git cherry-pick maint next ^master
>> 
>> could implicitly be read as
>> 
>> $ git cherry-pick maint next --do-walk ^master

You can read it as "master..next maint" that does force walking.

>> Clearly that's not what is intended, which is
>> 
>> $ git cherry-pick --do-walk maint next ^master

I do not see the distinction betwee the above two you seem to be
trying to make.  Care to explain?

>> but it is open to interpretation as to where in the command line the caret
>> range prefix's --do-walk (to countermand the --no-walk) should applied.

I do not think it can be position dependent.  Philip probably has a
confused notion that "rev-list A..B C..D" is somehow a union of set
A..B and C..D?

>> If the user did want just the single commit at the tip of maint, and then
>> the range master..next, what would be their command line, and also, how
>> would the man page warn against false expectations?

Yeah, this can show us that all of the have is coming from that
exact confusion I suspected Philip has.  We need to clarify in the
documentation that rev-list set operation does *NOT* have union of
multiple sets to unconfuse the readers.

