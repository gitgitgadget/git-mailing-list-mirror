From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Wed, 30 Apr 2014 10:26:12 -0700
Message-ID: <xmqqzjj2g24r.fsf@gitster.dls.corp.google.com>
References: <1398718883-5630-1-git-send-email-dborowitz@google.com>
	<CABPQNSYDD7g3nOwb2ZaOQ9M9gQnjzQyKP4Zo-i8p4o-s30bk1Q@mail.gmail.com>
	<xmqqk3a6hmv6.fsf@gitster.dls.corp.google.com>
	<CABPQNSZVFWhP+oTYpU2HeenJXwMsDNQGegwYZVb=bZ2+BRz3-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Borowitz <dborowitz@google.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 30 19:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfYH4-0005Ro-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 19:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933877AbaD3R0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 13:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933897AbaD3R0U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 13:26:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE3A7C5FD;
	Wed, 30 Apr 2014 13:26:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HQGhpvOWU2/CW2SZbWvIbhfNybM=; b=JSW90P
	uDyOJqTGK+lJ9mpFTr/bg4HQ/Q06nYtco9/J02JZIcsWhRHnSDx0m0CK9p5yb6wS
	nPYcGyP2wv0QPRZMwb0NJdmGH8Q2Ma6mT9t6wxApIUdeVPF6dlXuSKOddeM+SRUP
	TUtd1PTD2Th5AYM8bI6vtIdOb8hcsyznHsfbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kVO1BmLiOMOzoJuZeJAyVCkqFb5clSEo
	yvfB+XnO62vW6wCfhjftLECBFSaBSXw3daq8+hfs+XGGR/fiSJQOOO8+peXUFf/R
	cRWbID8wsV9gJvjpDnq1WX399ST5mKh41QFBsrzaDIP8ADBlLzC5ICsi27fbiZBE
	h0MMlZRe0D4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C64B7C5FC;
	Wed, 30 Apr 2014 13:26:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A3C47C5F8;
	Wed, 30 Apr 2014 13:26:14 -0400 (EDT)
In-Reply-To: <CABPQNSZVFWhP+oTYpU2HeenJXwMsDNQGegwYZVb=bZ2+BRz3-w@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 30 Apr 2014 18:05:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87FECB3E-D08C-11E3-92A2-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247747>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Wed, Apr 30, 2014 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think something along the lines of
>>
>>         ifdef CURLDIR
>>                 CURL_LIBCURL =
>>         else
>>                 CURL_CONFIG = curl-config
>>                 CURL_LIBCURL := $(shell sh -c '$(CURL_CONFIG) --libs' 2>/dev/null)
>>         fi
>>
>> may be the right way to write this?
>>
>> Note that $(shell $(CURL_CONFIG) --libs) when CURL_CONFIG is empty
>> would barf when $(CURL_CONFIG) expands to an empty string.
>
> There's still the fact that msysGit does *not* need CURLDIR, but
> doesn't have curl-config either. So I think this one will also
> complain for us.

Even with 2>/dev/null?
