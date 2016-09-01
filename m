Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD46C1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757071AbcIAVIy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:08:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757037AbcIAVIt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:08:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A359F394BD;
        Thu,  1 Sep 2016 17:08:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=1
        RoaciCrUE09reeuLR9uHjJ2tFE=; b=wlLRl0SnthDrwDeoe+5/2/np6V5/cSBdw
        cweRm8TXnOueitN6Lge0wkPlw45Y/bztnNToH8lQLOh0kBkqcuRZqqjfPDGXu1mF
        Y3SQ5a4utRuH//7FbM8N53SKEh48ipntZWymu253D20/QAQ9WWaPa+BtYSYU+U4W
        A5Ar/Efnzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=nv9
        7ghLXw+yImFR2qvxscoQI+rcmc7cSp/vST10taYI5sv9UhoogZ4lS5AUJVZ+yQ5j
        TWxgZudNMZx/ITot6QMccerODfhP+TDDCWsD90Je5ARGkvV56KjyhIQKF+aCK0cz
        Bn/DhUO4/i6WIAYGRiWzFYjvfF1Aj9KPzdlOVu9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AE2D394BC;
        Thu,  1 Sep 2016 17:08:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13A03394B9;
        Thu,  1 Sep 2016 17:08:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Should "git symbolic-ref -d HEAD" be forbidden?
Date:   Thu, 01 Sep 2016 14:08:08 -0700
Message-ID: <xmqqpoonuy4n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FC8F874-7088-11E6-A4C2-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think we should.

t1401 expects to be able to, but if you really do it:

	$ cd /tmp
	$ git init throwaway
        $ cd throwaway
        $ git symbolic-ref -d HEAD

the setup machinery considers that you are no longer in a working
tree that is controlled by a repository at .git/ because .git/ is
no longer a valid repository, so you cannot even do

	$ git symbolic-ref HEAD refs/heads/master

to recover.
