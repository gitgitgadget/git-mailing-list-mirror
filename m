Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3841FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbcGSRGn (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 13:06:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751271AbcGSRGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 13:06:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF6682D26C;
	Tue, 19 Jul 2016 13:06:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uk+I0fUGxKKeFclRWSU114ZJDUQ=; b=M88358
	ag1s5ZZtH0RhDtSV0HNquTVlxiXNr0H3DUneMTXrNu6TZMPHKErmqyiJPiKD1M9r
	CR0vPq+70zko2vx4qi7nyUMJAr6lPXtD4JOPcEReXyL/A7CsoMnfNh30sc0riRm6
	6nbC5wEkbhM40X94g+lSRoo8EVj7rSXBvtucQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vM4gUKViVdf8F3T9YkDZNzX/DrOizIO4
	wNtejwxZsy8qvwVhSYKhQ4YgevUhCJnJ8yWLxwVypf7cyb5n9baxnep/LNBWqmYU
	F5cxZxo7dCTSl+AAAsA+EucWI01J+5VRNaFOCT1G3SZiExKREZC8/kEjfdyOFO0d
	Vp8fQNyIq/o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5B0D2D26B;
	Tue, 19 Jul 2016 13:06:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DFBC2D26A;
	Tue, 19 Jul 2016 13:06:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
	<20160716201313.GA298717@vauxhall.crustytoothpaste.net>
	<alpine.DEB.2.20.1607170949360.28832@virtualbox>
	<20160717142157.GA6644@vauxhall.crustytoothpaste.net>
	<CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
	<CACsJy8CR_fkYL5UYbV1MqiTSe3gTqWfOrA1NOHTw09vZn7Y-Aw@mail.gmail.com>
Date:	Tue, 19 Jul 2016 10:06:38 -0700
In-Reply-To: <CACsJy8CR_fkYL5UYbV1MqiTSe3gTqWfOrA1NOHTw09vZn7Y-Aw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 19 Jul 2016 18:07:35 +0200")
Message-ID: <xmqqk2ghh80x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 290A1496-4DD3-11E6-A120-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Post-shower thoughts. In a tree object, a submodule entry consists of
> perm (S_IFGITLINK), hash (which is the external hash) and path. We
> could fill the "hash" part with all zero (invalid, signature of new
> submodule hash format), then append "/<hashtype>:<external hash>" to
> the "path" part. This way we don't have to update tree object or index
> format. And I suspect the "path" part is available everywhere we need
> to handle submodules already, so extracting the external hash should
> be possible...

Even though that single operation might be possible, do not go
there.  A "pathname" identifies a "path", not its contents, and
"appending crap after path" breaks the data model badly.  Also other
things like merge, checkout and diff would break by butchering
ordering the entries in tree objects.
