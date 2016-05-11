From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] submodule-config: check if a submodule is in a group
Date: Tue, 10 May 2016 18:19:17 -0700
Message-ID: <xmqqd1otl7ca.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 03:19:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IoA-0007AC-JY
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbcEKBTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:19:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751214AbcEKBTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:19:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A24D1BA2C;
	Tue, 10 May 2016 21:19:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GoHHhfzJBPgb+Xyi8LjqK/lrVcs=; b=gOpQ2j
	V/DvPNvdCHfEv6oVWS1ti+fE6kysQLJaGnvIDDGevR7bVrTSI1vhmU9o0kN5pwdd
	pMihS+cDtEuYd1HoGyJve/Z8f+6xqDOGRl013EH749++pG3NlU+7MjJCudNR5dmn
	HKvhf+RPjFFKRYDFPemILXu6G0mVZ9o5pu1H8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XcNTnwUUqyBvGE/QibDDfOOlhyw/a954
	U3t2mcSsBdAlhhQhmkzSxXCoamdNIeQK+ZGou7YZe9gEHPKGew18HBPkSJbiDPaP
	fhdFHHAVuJdCqugULSDWkztMFwiBLXbL6We8jcFYHQnmgoqnWbeUWoQKdxEMDfWL
	pm3+x7eAa0E=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 224EE1BA2B;
	Tue, 10 May 2016 21:19:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 867311BA2A;
	Tue, 10 May 2016 21:19:19 -0400 (EDT)
In-Reply-To: <1462928397-1708-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 May 2016 17:59:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 62CC2B18-1716-11E6-A960-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294221>

Stefan Beller <sbeller@google.com> writes:

> +static int in_group(int argc, const char **argv, const char *prefix)
> + ...
> +	if (!group)
> +		list = git_config_get_value_multi("submodule.updateGroup");
> +	else {
> +		string_list_split(&actual_list, group, ',', -1);

Is this expected to be used only by test scripts, or will it have
real scripted Porcelain as its users?  I am wondering if
concatenation with ' ' would be more natural if it is the latter (if
only used for testing, I don't care that much).
