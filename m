From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 27/83] builtin/apply: move 'read_stdin' global into cmd_apply()
Date: Tue, 26 Apr 2016 13:28:39 -0700
Message-ID: <xmqqy480dsi0.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-28-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:28:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9bD-0005GF-7K
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbcDZU2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:28:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753944AbcDZU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B9942143A9;
	Tue, 26 Apr 2016 16:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iKnCMv/A3kHOwW+Mv+gd2D21dqU=; b=s9vhPl
	ijXuayZXy+vHTNtiEDN05PQh5UgQZOAFj2Uox3k/4/cbCMYrgJ90r/miaBb6kUJg
	TWG/fB6lnSc7rgC2buYAWmVFZMyTbxdgMBwCq1bIDiM2nNxqm0mgkd609irjZtyK
	ky9NRr8AVs3HhqRuuSXh3tGBQ8xxYGM0FpDOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gzF3c39Bc2MEdFsFZospOm2qqYEUFP8d
	0LXRf/q+26pFsz2I5uzG76QZoFz20r3wZOHkOMey5NSHJHNGuKTfxDrNwn5fYUXU
	ngTYz5oxnp8+5jcD0ZVM3E4FyKo97EUi87Ob9PxKQndhFzGKH9DdEIYvbblbQ/8h
	6qDMfgtD5x4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B1EF0143A8;
	Tue, 26 Apr 2016 16:28:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D3AD143A6;
	Tue, 26 Apr 2016 16:28:41 -0400 (EDT)
In-Reply-To: <1461504863-15946-28-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 24 Apr 2016 15:33:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76E5E10E-0BED-11E6-9313-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292662>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense but do so immediately next to 06/83, "options" thing?

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 699cabf..be237d1 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -96,7 +96,6 @@ static enum ws_ignore {
>  
>  static const char *patch_input_file;
>  static struct strbuf root = STRBUF_INIT;
> -static int read_stdin = 1;
>  
>  static void parse_whitespace_option(const char *option)
>  {
> @@ -4586,6 +4585,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>  	int is_not_gitdir = !startup_info->have_repository;
>  	int force_apply = 0;
>  	int options = 0;
> +	int read_stdin = 1;
>  	struct apply_state state;
>  
>  	const char *whitespace_option = NULL;
