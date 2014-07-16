From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Date: Wed, 16 Jul 2014 10:59:33 -0700
Message-ID: <xmqqiomxrxq2.fsf@gitster.dls.corp.google.com>
References: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
	<1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
	<20140715234240.GB5572@peff.net>
	<1405467974.2577.21.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "peff\@peff.net" <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Keller\, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7TUZ-00068i-IW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 19:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934650AbaGPR7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 13:59:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64557 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbaGPR7l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 13:59:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF9A527F55;
	Wed, 16 Jul 2014 13:59:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZwZHY5VrbQCcKCq1acS/BoQDkeQ=; b=sxIsLr
	3+pE/Qd0Jzh8ETpEJx5knqPDg5YNvKVR56sjF5orOLhNDNN4huLAA6gySaohfJXv
	bSAw2cpim18VI3uCubS4NJOr6kEk0TD7aJ7KFCQpDXAWSeITgDDcq1CpPUPm5XWM
	cVtuENY3GYg7LwjH6i0kmU7eKnN4pN3u+D3RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KCS2ZvkeQlCG+DDLdqHKmZknRz8drONx
	Q8SX9TOZFetiNZKndcce3+/2vaHeqOlD6u6ZNSHJ+cNnicVgcYe02zdnImrM8crp
	r/4Kv7x8MbFhKh0e4qNE3+hjRn9N1h2hCfF7gSitN234dRQ8OWnTu5pTvaGczCiO
	T2W3Rumt4fo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C60D827F54;
	Wed, 16 Jul 2014 13:59:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 038CE27F4B;
	Wed, 16 Jul 2014 13:59:34 -0400 (EDT)
In-Reply-To: <1405467974.2577.21.camel@jekeller-desk1.amr.corp.intel.com>
	(Jacob E. Keller's message of "Tue, 15 Jul 2014 23:46:14 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F2192452-0D12-11E4-977D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253681>

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

> On Tue, 2014-07-15 at 19:42 -0400, Jeff King wrote:
>> On Tue, Jul 15, 2014 at 04:32:59PM -0700, Jacob Keller wrote:
>> 
>> > +static void error_bad_sort_config(const char *err, va_list params)
>> > +{
>> > +	vreportf("warning: tag.sort has ", err, params);
>> > +}
>> 
>> This feels a little like an abuse of the "prefix" field of vreportf, but
>> as you probably saw in my "for fun" patch, doing it right means
>> formatting into a buffer and then reformatting that (which we're
>> already doing again in vreportf, but less flexibly). I dunno.
>> 
>> At any rate, this should be marked for translation, no?
>> 
>> -Peff
>
> Oh, yes it probably should. It's definitely a little bit abusive of the
> prefix field, but that seemed easier.

And i18n would automatically mean this will not work, no?  There is
no guarantee that the translation of "warning: " will be followed
directly by the translation of "tag.sort has" without any words from
variable part in all languages.

After all, it seems to me that the one in

    http://thread.gmane.org/gmane.comp.version-control.git/253346

struck the right balance among various abuses; let's use the error
reporter from that version, instead of going down this rabbit hole.

Thanks.
