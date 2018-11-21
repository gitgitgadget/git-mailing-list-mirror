Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FB51F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 04:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeKUPM6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 10:12:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64618 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbeKUPM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 10:12:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E8BA10B110;
        Tue, 20 Nov 2018 23:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EV8T1qWcetGW
        Eyhva2tULJ8X2I0=; b=ue3CY5rAZehk77fhGUilyoG8ip4paiA5vZ4vGixlYvJ5
        tfYIu3ZZ+FxKpp73EcImP04X8ckAUgvrLAH83rzmrna5UG/NIh9ALHJGOVm6n1Fs
        kRO6r/7PkADxgxh62aAugE6r73dJruJ1v0+lUBJama7c/ovUfnyE7QI9ciH7LqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kZCBlt
        ZOO3OGl175a3XUdWx9+NESqEb3F7Sfdz8k2zhnTMrfWS3/9APDMJOvKJjmzKI8Ae
        QdULk1yOvO2VhklPqVA0Y7m2ztI7sE/imHYMZNjNWn/h1roGWftcBZsNa52hygyr
        Fj8Exrfws3E3ckpbd6Mpnqtb953mC84qm6bmc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3580C10B10E;
        Tue, 20 Nov 2018 23:40:11 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9EFE310B10D;
        Tue, 20 Nov 2018 23:40:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] legacy-rebase: backport -C<n> and --whitespace=<option> checks
References: <pull.86.git.gitgitgadget@gmail.com>
        <84e65a4efb3d58ca777cd59c52fe86d63060ea9e.1542744118.git.gitgitgadget@gmail.com>
        <CAPUEspgxNm9oEA-fuT7kBegEp5F2za5Nm6CSvFkMB+Kz_pNbrw@mail.gmail.com>
Date:   Wed, 21 Nov 2018 13:40:09 +0900
In-Reply-To: <CAPUEspgxNm9oEA-fuT7kBegEp5F2za5Nm6CSvFkMB+Kz_pNbrw@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 20 Nov 2018 15:45:52 -0800")
Message-ID: <xmqqin0r82mu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 87813020-ED47-11E8-8929-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> the C version prepends: "fatal: " unlike the shell version for both
> error messages

In addition, "Invalid whitespace option" says 'bad', not
'--whitespace=3Dbad', in the builtin version.

I think the following would address both issues.


 git-legacy-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index ced0635326..b97ffdc9dd 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -340,7 +340,7 @@ do
 		warn|nowarn|error|error-all)
 			;; # okay, known whitespace option
 		*)
-			die "Invalid whitespace option: '${1%*=3D}'"
+			die "fatal: Invalid whitespace option: '${1#*=3D}'"
 			;;
 		esac
 		;;
@@ -358,7 +358,7 @@ do
 		force_rebase=3Dt
 		;;
 	-C*[!0-9]*)
-		die "switch \`C' expects a numerical value"
+		die "fatal: switch \`C' expects a numerical value"
 		;;
 	-C*)
 		git_am_opt=3D"$git_am_opt $1"


