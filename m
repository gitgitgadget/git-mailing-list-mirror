Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ECAC206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbcLLTFE (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:05:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752512AbcLLTFD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:05:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA51B5870F;
        Mon, 12 Dec 2016 14:05:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=68GxJ4jA0jyL4AhvuTfGTprDnoo=; b=MH1D+8
        ZEiNOUbgNPfHsOQmGdDGfxLzW4QB+riFk2erjl6X/h2pSYMVW3jFCd+Ui8/zvs2+
        Es02SZKVvR9/BEIaJnqC+pkkcFTiIOTNImiNp988ATIKJBcBMNuJxctSFT0mC/JH
        fWjbfA+5snnzaN6yLsm0a7x4qU6RKSMiM/Td8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ArBQ/xX4hiMgYLdu3NlsNn51QlNa+Lt6
        17jCTCxfy2CSQ484UVt45PLYyfwh3eiWXL810QQC/SskztOyYamBYsAb+eCMKL/s
        szQsdiyz+IHRV2irYbXwoHvnQDVgvICit25P+nrebFBOSkwrRg1LQnvLUG7Hcvp/
        f8xHnB+oEnw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C8735870A;
        Mon, 12 Dec 2016 14:05:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 201C958709;
        Mon, 12 Dec 2016 14:05:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-svn: allow "0" in SVN path components
References: <20161212110914.GA24736@starla>
Date:   Mon, 12 Dec 2016 11:04:58 -0800
In-Reply-To: <20161212110914.GA24736@starla> (Eric Wong's message of "Mon, 12
        Dec 2016 11:09:14 +0000")
Message-ID: <xmqqinqpm0it.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E12D74A4-C09D-11E6-BE00-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Blindly checking a path component for falsiness is unwise, as
> "0" is false to Perl, but a valid pathname component for SVN
> (or any filesystem).
>
> Found via random code reading.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>   Junio: this bugfix should go to "maint".
>   Will push along with a doc fix for Juergen.
>
>  perl/Git/SVN/Ra.pm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index e764696801..56ad9870bc 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -606,7 +606,7 @@ sub minimize_url {
>  			my $latest = $ra->get_latest_revnum;
>  			$ra->get_log("", $latest, 0, 1, 0, 1, sub {});
>  		};
> -	} while ($@ && ($c = shift @components));
> +	} while ($@ && defined($c = shift @components));
>  
>  	return canonicalize_url($url);
>  }

Makes sense to me.  Thanks.
