Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0816220189
	for <e@80x24.org>; Sun, 19 Jun 2016 18:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbcFSSLS (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 14:11:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751269AbcFSSLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 14:11:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5F7022E65;
	Sun, 19 Jun 2016 14:09:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U/yLxTX3Q2zThjLU2bcBkEDO6ks=; b=GgztmH
	UjsLKoGTGWdwPjeisbFJLJeKYsrCSL/0LhO3htrq04ePo8tqq5PH+bRSlSGmXxTP
	lQZUVT5M8iQQ+2GoeYQIQga3jgrDoLdww1lQi3JCUWWShJqaeVw82n3YlZ4j82+h
	IvH/h+Q2RB3CFw1TF1jHVleshc74RFyS5GSE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tl/XL0tog7M5EHvRBMI6gg5yO73cjRTR
	p2u2NR/kNzrgczxLT9cSwyqU2ZEKiSid7EA5KQJBI+jEPAwt8W+yYI2ZdJFsS8Py
	p7UoYQX5gmgfx3B9RvZ7SynisGMsPbmo2j6VWWF1OGb/smihZIPJFOeLv8HJMgpm
	2M9gDBV+eh4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE91D22E64;
	Sun, 19 Jun 2016 14:09:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F3B822E63;
	Sun, 19 Jun 2016 14:09:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
	<576650E7.70107@alum.mit.edu>
Date:	Sun, 19 Jun 2016 11:09:34 -0700
In-Reply-To: <576650E7.70107@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 19 Jun 2016 09:59:35 +0200")
Message-ID: <xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB52152C-3648-11E6-B998-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> According to [1], something in that test seems to have been trying to run
>
>     git update-ref -d git-p4-tmp/6
>
> Similarly in the other failed test.

Ah, OK, that would try mucking with .git/git-p4-tmp/6 but that is
not a place to have a ref.  It will not participate in reachability
analysis and will end up losing the referents.

Perhaps placing it under refs/git-p4-tmp would fix it (both in
git-p4 and in tests)?
