From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] git submodule update: have a dedicated helper for cloning
Date: Thu, 04 Feb 2016 13:57:06 -0800
Message-ID: <xmqq4mdogmvh.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-7-git-send-email-sbeller@google.com>
	<xmqqr3gtjs23.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbeDBf=AfA2RUhkfjwJqJ7pr30xW3UTXqiha_EPpisvnw@mail.gmail.com>
	<xmqqegctjnvm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kb-G=GHdtcH323LbHQ4V_azif04eHVuf8Z3gCeb-e=iKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:57:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRRtq-0007jr-RA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 22:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbcBDV5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 16:57:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752121AbcBDV5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 16:57:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C65942818;
	Thu,  4 Feb 2016 16:57:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r1YhMz3FsrKNvyfcn6PAuXOK9w0=; b=XifyKw
	JCGB+RhzK02l0RIyzu60ZZ5INo8HL9Jq7JpRudQHhoaCfefa2PNF2rTE0P91m2fU
	FuTpqefintyPm0kiDIYzVk83t+wCfvi/uFMeI4Lk0lwly11hHLtcT1W3vkZgWlY8
	xv5aGjpkDOM5oYeR9iMcnLn0xGGQpY7DSBzpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wJLHIW8APOPPDaHSrn0Y8z9IubFCM4xi
	s7A9QhpOAM9htfFCv1YKQuOTztCcGvtE3qUBoyhG9jbZK3wQQTOuRJq+z/BwhB5f
	ao9xvgkOnGAePyq0jNVLaGjs7ptG6pnE3jHBG2AsTR/CQWfnVCdQ3aqUTqKk/QBY
	gPCGvi8T+R0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82FF142817;
	Thu,  4 Feb 2016 16:57:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F047242816;
	Thu,  4 Feb 2016 16:57:07 -0500 (EST)
In-Reply-To: <CAGZ79kb-G=GHdtcH323LbHQ4V_azif04eHVuf8Z3gCeb-e=iKQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 4 Feb 2016 12:22:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C29CC72-CB8A-11E5-9FE4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285498>

Stefan Beller <sbeller@google.com> writes:

> I do not think that is a better place as not every consumer of module_list
> (and module_list_compute as the nested function) will need to use the
> submodule caching API.

Ah, if that is the case, then OK.

I was imagining that module-list may someday would return a list of
"struct" instances each of which describes a submodule and has .name
and .path fields, or something, instead of just being a "here is the
path to the submodule, go look it up yourself" interface.  But we
are not there (at least not yet--and I am not saying we agreed that
we would eventually want to go there)
