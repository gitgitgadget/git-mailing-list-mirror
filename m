From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/94] builtin/apply: extract line_by_line_fuzzy_match() from match_fragment()
Date: Thu, 12 May 2016 12:20:56 -0700
Message-ID: <xmqqa8jvf5gn.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-6-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:21:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wAT-0008ED-K0
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbcELTVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:21:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752298AbcELTVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:21:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC581A768;
	Thu, 12 May 2016 15:20:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4TZTYQ9i4UtIrP3tExd1/ZtwieY=; b=Ont7II
	xs8sgAlEERKSaOq02gY2X3hUh2hh5KEvIJZosh0inG4kEFXWLfIc6EvY0G5NF/Aq
	Lqd4/zvXWuiP7Jl2eeABF1MgQT0FPcEd6G3cyZPoCHAu7IxOjbxMvOlKBAlZ2LpF
	2GKAoczhGiSFoPym7J1UFOP1YI+HSOKVUx0qU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e2t84EztgHAXEbtneSwbSWswoqfdQvKu
	F3cXWOTViM0+eaD4p9TUyvZCNGMZd4tBB2UohKP6nCKzZN9qMrpYrBD94hmaUBG5
	9wz1ZrQYbItyXGBje4lzRrzTsWE9udqwDMqWJtUQue4jiLVdT0CG9ok9gZP19frN
	gvW7zbxuF6s=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 168D41A767;
	Thu, 12 May 2016 15:20:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 826261A766;
	Thu, 12 May 2016 15:20:58 -0400 (EDT)
In-Reply-To: <20160511131745.2914-6-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A80F686E-1876-11E6-9206-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294431>

Christian Couder <christian.couder@gmail.com> writes:

> The match_fragment() function is very big and contains a big special case
> algorithm that does line by line fuzzy matching. So let's extract this
> algorithm in a separate line_by_line_fuzzy_match() function.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Looks good.

I am puzzled by the "git blame -w -M" output after applying this
patch, though.  The body of the new function came more or less
verbatim from the origina with reindentation.
