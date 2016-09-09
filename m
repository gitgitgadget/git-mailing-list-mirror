Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C2B207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 22:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755473AbcIIWez (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 18:34:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55053 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753554AbcIIWes (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 18:34:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB8103BC0E;
        Fri,  9 Sep 2016 18:34:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wOlJrm0LnBmblkIVHHdfkTYHsMg=; b=uWEC4m
        XVAoOZ7nT6pvEAPMmhWb32GUsdo5UtANZG4gKW3aAe4sLVx9QzuX+7onilCtZNv/
        EEuf7dh708I1ctUPaRs+sU2BkAvDXOIbwvkzwEW//7JVg0Zzqioq7ZBh0o9ebB4y
        4xKsNh9Af9FgrFUv97rY/9qVEL9a3GTBDeceA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZE8yR0kC7Ejg3l3aB3NQ/RuE7dPCtOvd
        C852aTZ6uT2VtmJ78cTRo2cBUwTKlmwaK9xNtWX5LmErwqGbzYOvhBKYsgxM3Au8
        FmNkkaWwVS+DGbT48yAgqBNrWI/Fv3WNxuy+Oul/FB/ErXP1+tFUbAcfpFexEatW
        rLSpiF26efk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2B033BC0D;
        Fri,  9 Sep 2016 18:34:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 567F23BC0C;
        Fri,  9 Sep 2016 18:34:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     john smith <wempwer@gmail.com>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: How to simulate a real checkout to test a new smudge filter?
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
        <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
        <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
        <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com>
        <CAKmQUfafCP6ZwUm7Ec5n2PzvNzBHnFWEJL1usMTFB6Ef0m=8pw@mail.gmail.com>
Date:   Fri, 09 Sep 2016 15:34:44 -0700
In-Reply-To: <CAKmQUfafCP6ZwUm7Ec5n2PzvNzBHnFWEJL1usMTFB6Ef0m=8pw@mail.gmail.com>
        (john smith's message of "Sat, 10 Sep 2016 00:03:26 +0200")
Message-ID: <xmqqwpik8zy3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C4F387C-76DD-11E6-A89F-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

john smith <wempwer@gmail.com> writes:

> So it seems that clean filter is only run when checking out paths but
> not when checking out branches.  Is my thinking correct?

If the new branch you are going to and your current branch record
different contents for a path, that path will have to be checked out
to the working tree, and smudge will be involved in the process to
turn the "clean" contents stored in a Git object needs to be smudged
for use in the outside world.  If both branches have the same
contents, then there is no need to overwrite the path in the working
tree with the same thing, so it is not touched.

The clean and smudge operations should look _only_ at the contents
they are filtering, and nothing else, and the clean/smudge filtering
mechanism is designed to support that use case.  It is not designed
to do things like embedding the name of the branch that is being
checked out into the result.

