Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2868620C11
	for <e@80x24.org>; Wed,  6 Dec 2017 16:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdLFQk0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 11:40:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55836 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752484AbdLFQkV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 11:40:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39295AD80C;
        Wed,  6 Dec 2017 11:40:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=amzsZgN69UqjBrk6kzwSmvOyalc=; b=AsjbmJ
        n8kwz2ea6hDTsoQm5B7bkQwdKoXJp4iElybyyQdt4/GFA88CnBnB0VgNfwwVJR92
        chCYzErqDH9z/BAIPr8xyonwtDSr67CU+uECU/q/dyMZ+MjOSJ3x4ucRBjulkYN3
        renKpZN3lvxwG3YOD7EiZATSs+H+mKm/gfW28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QepyCv9KG0O19KYqXX/qWQt4GqRk5mfl
        Qy0puvIrhGpbod4cbxoryRfzS58zBkS65sdHCP915KJGclD2hhyvT0nMJORmcCPl
        sjhRoA1lDCSzODptGtUAaLp/1ySQi3XYv0qO2yewSiDvPXr6+Coo3BHZOjmKM8YQ
        OQnVF4kquGQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F639AD809;
        Wed,  6 Dec 2017 11:40:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 993DCAD807;
        Wed,  6 Dec 2017 11:40:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFE] install-doc-quick.sh should accept a commit-ish
References: <002701d36eaa$ef39bab0$cdad3010$@nexbridge.com>
Date:   Wed, 06 Dec 2017 08:40:18 -0800
In-Reply-To: <002701d36eaa$ef39bab0$cdad3010$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 6 Dec 2017 10:57:30 -0500")
Message-ID: <xmqqtvx3hkst.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 257B626C-DAA4-11E7-BE69-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Having the git-manpages repo available is fantastic for platforms
> that cannot easily build documentation on demand, for example,
> when too many dependencies that do not build properly.
>
> It would be really nice to have a version of install-doc-quick.sh to either:
>
> 1. Use whatever version is checked out in git-manpages; or
>
> 2. Use the proper commit associated with the git commit being installed (0a8e923 for v2.6.0 , as an example); or
>
> 3. Allow the commit to be passed through the Documentation Makefile on demand so that any version of documentation can be installed.

Do you mean something like this so that you can say "not the tip of
the master branch but this one?"

 Documentation/install-doc-quick.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index 327f69bcf5..83764f7537 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -3,8 +3,9 @@
 
 repository=${1?repository}
 destdir=${2?destination}
+head=${3+master}
+GIT_DIR=
 
-head=master GIT_DIR=
 for d in "$repository/.git" "$repository"
 do
 	if GIT_DIR="$d" git rev-parse refs/heads/master >/dev/null 2>&1
