From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/15] git submodule summary respects groups
Date: Fri, 29 Apr 2016 11:38:28 -0700
Message-ID: <xmqqh9ekxntn.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-13-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:38:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awDJE-00009H-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbcD2Sic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 14:38:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615AbcD2Sic (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 14:38:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF7AD170BB;
	Fri, 29 Apr 2016 14:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UiA/UE43ejGek5sYkecswuIS1kQ=; b=YxWSIF
	lEDNmcwzp7+13wBBOudKwpbaNm4zHYRCtLAU957YNUIerzIqHOga0K4hxFu208B3
	FdzwWqSqrqPaOupCT/MR3XdIYdhEQ41O0VWEreFANH7loNzordL1p84Qkd/Wy066
	JYrjDAEJoc/mI6vCSUkHh1G8c/qqMEgXVfQIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvxeb6In8BFBiKTFjqHbBBfKqZ4WgEgx
	nlxwv2UHS/vns10AuwZRs1RXYTA3413Fveh5N2xYJF1+aAMYZ9FLxGRzB6kLWZSP
	WexXqJJtmKsj005zm3iRQDq1KBhXLV52AzpIbhKwQ7xMoEOcJMwD6zayVZF5TmC/
	9dcfCi6iPAI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E75E2170B9;
	Fri, 29 Apr 2016 14:38:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62F02170B7;
	Fri, 29 Apr 2016 14:38:30 -0400 (EDT)
In-Reply-To: <1461703833-10350-13-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91D87186-0E39-11E6-9157-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293045>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Same comment as 11/15 applies here.

>  git-submodule.sh             |  5 +++++
>  t/t7413-submodule--helper.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 253ad07..f065b1f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -833,6 +833,11 @@ cmd_summary() {
>  		sane_egrep '^:([0-7]* )?160000' |
>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>  		do
> +			# ignore modules not in group
> +			if ! git submodule--helper in-group $sm_path
> +			then
> +				continue
> +			fi
>  			# Always show modules deleted or type-changed (blob<->module)
