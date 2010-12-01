From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] parse-options: sanity check PARSE_OPT_NOARG flag
Date: Wed, 01 Dec 2010 15:36:51 -0800
Message-ID: <7v39qht698.fsf@alter.siamese.dyndns.org>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino> <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org> <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino> <20101130025223.GA5326@burratino>
 <20101130025551.GB5326@burratino> <4CF4B21B.5030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 00:37:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNwEt-0004DK-Nh
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418Ab0LAXhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:37:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062Ab0LAXhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:37:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 124C42EF9;
	Wed,  1 Dec 2010 18:37:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YrjntyNrMbZXI0Fd4x9sIiZZkfk=; b=psWIH1
	SY91awVPpynLndQkEa5dbWT52RLaR2pC3eq+TMiVVB4+VmVV2ucvQzvIRT7GpYrs
	2OCq3vrDmLB5gp1SvGiJJMql2Feo8eAO0SKOoYLbACpDZ5koxjBC6AXf6N3DRovv
	ojTNSdJcLFBrWNpQcgKEE6RSqgm3Of2PWNX+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kYEybpOLrLhnE0sCm/csbajZ8eVkvkrN
	3y+punZ6OpJDDDGXACkRpas+cJxQU6VKGWL3hNjPqW0/eS89cXuUn0Z5XiS5ths5
	7LD1PEUSsRN+3jqHsgrDvZs76jRfmn6zQ3qzBOZiXJTVjVlxTka96pOo96Bii316
	a9HdBKpfW40=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B3C6C2EF8;
	Wed,  1 Dec 2010 18:37:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 26A922EEC; Wed,  1 Dec 2010
 18:37:11 -0500 (EST)
In-Reply-To: <4CF4B21B.5030401@gmail.com> (Stephen Boyd's message of "Tue\,
 30 Nov 2010 00\:13\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFACDA2E-FDA3-11DF-AA8D-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162649>

Stephen Boyd <bebarino@gmail.com> writes:

> On 11/29/10 18:55, Jonathan Nieder wrote:
>> +static void check_flags(const struct option *opt)
>> +{
>> +	switch (opt->type) {
>> +	case OPTION_BOOLEAN:
>> +	case OPTION_BIT:
>> +	case OPTION_NEGBIT:
>> +	case OPTION_SET_INT:
>> +	case OPTION_SET_PTR:
>> +	case OPTION_NUMBER:
>> +		break;
>> +	default:	/* (usually accepts an argument) */
>> +		return;
>> +	}
>> +	if ((opt->flags & (PARSE_OPT_OPTARG | PARSE_OPT_NOARG)) == PARSE_OPT_NOARG)
>> +		return;
>> +	die("BUG: option '-%c%s' should not accept an argument",
>> +				!opt->short_name ? '-' : opt->short_name,
>> +				!opt->short_name ? opt->long_name : "");
>> +}
>> +
>
> This check should probably go into parse_options_check()...

Very good suggestion---that way we can check and get diagnosis for all the
errors, not just dying on the first one.
