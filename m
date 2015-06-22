From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Move unsigned long option parsing out of pack-objects.c
Date: Mon, 22 Jun 2015 15:03:27 -0700
Message-ID: <xmqqfv5jfljk.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434911144-6781-1-git-send-email-charles@hashpling.org>
	<1434911144-6781-3-git-send-email-charles@hashpling.org>
	<20150621183026.GA7199@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:03:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79oV-0002TR-IH
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbbFVWDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:03:32 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37581 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbbFVWDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:03:30 -0400
Received: by igblr2 with SMTP id lr2so63273510igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=41c7/Q+QTuWpyvwV84vCPJPmgRXLAw/dDXkSZ3+s23k=;
        b=IfuBK/9aDREhi3i87oQK3HmdjsSnOpOjEVuW9xQI2oxNI+YWjohIsN8bXZOgTlyVvk
         JteHZoZ0/RZi5cGjkG2hHX/96BeB8js5kCtVfx2PyShMxoBZ78sj822hw+6ADpXA0nJi
         whYFSDO39AIhl8zNQuiosBj1TyMBpBqKFx3oRE0qfE8BgBpSzTeMCdeqB2e8clwJQZQC
         h7wE76tAeT2U4yJ8GDEtlS9NPrIH6LqkUrOcC9PYCa3e29txcU9mjOkMjZp9t0TvvXwg
         LHXM3UMGA6Dpp4Tp98kkGF5DZOYHZGaR9w7yFB2BJFDQXb8ATWcJnzLNqK5Zil7D9xX7
         FazQ==
X-Received: by 10.107.168.150 with SMTP id e22mr37542905ioj.9.1435010609674;
        Mon, 22 Jun 2015 15:03:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id e3sm8386232igq.21.2015.06.22.15.03.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 15:03:29 -0700 (PDT)
In-Reply-To: <20150621183026.GA7199@hashpling.org> (Charles Bailey's message
	of "Sun, 21 Jun 2015 19:30:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272425>

Charles Bailey <charles@hashpling.org> writes:

> On Sun, Jun 21, 2015 at 07:25:44PM +0100, Charles Bailey wrote:
>> From: Charles Bailey <cbailey32@bloomberg.net>
>> 
>> diff --git a/parse-options.c b/parse-options.c
>> index 80106c0..101b649 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -180,6 +180,23 @@ static int get_value(struct parse_opt_ctx_t *p,
>>  			return opterror(opt, "expects a numerical value", flags);
>>  		return 0;
>>  
>> +	case OPTION_MAGNITUDE:
>> +		if (unset) {
>> +			*(unsigned long *)opt->value = 0;
>> +			return 0;
>> +		}
>> +		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
>> +			*(unsigned long *)opt->value = opt->defval;
>> +			return 0;
>> +		}
>> +		if (get_arg(p, opt, flags, &arg))
>> +			return -1;
>> +		if (!git_parse_ulong(arg, opt->value))
>> +			return opterror(opt,
>> +				"expects a integer value with an optional k/m/g suffix",
>> +				flags);
>> +		return 0;
>> +
>
> Spotted after sending:
> s/expects a integer/expects an integer/

Thanks.
