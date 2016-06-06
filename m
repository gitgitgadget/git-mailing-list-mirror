From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] commit: don't count i-t-a entries when checking if the new commit is empty
Date: Mon, 06 Jun 2016 13:28:45 -0700
Message-ID: <xmqqy46iukn6.fsf@gitster.mtv.corp.google.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
	<20160606111643.7122-4-pclouds@gmail.com>
	<xmqqbn3ew0mf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, thomas.braun@virtuell-zuhause.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:28:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA18n-0004Yo-VR
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 22:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbcFFU2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 16:28:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbcFFU2t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 16:28:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0227623A65;
	Mon,  6 Jun 2016 16:28:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eMoykyE8V4o7EEFvA/BYDRhT3Ko=; b=prLuHB
	AK8azYiK38OrB1nATbLF0OqX5OI6MFQa3XzX1zl/n1OWx4ZRcYmbiJxNJlOtcTaq
	xjvya086r+VN1Sy2DXH56DAMsNoxQMbqr9OAzd+1lKEq87n2mpUuvjhbb8/bv1FY
	uCIVFRItR+sOS+oVocJbbHSEQy6hnaiOUXiak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OhYiY9jhCZmRzlJ/wPtddkrIs8BU4jpy
	vvsqP6+JbhYsffRQpb3VXrNJoRoZE5BGNWwGCmQ6fjX/rQQ/8lzbksYicMFE0r7K
	o5zPVqcIF67LYaK8U/YqOxvUNieo4UswWlKH93fue5yqkZdfo+68c1PL/Rz7D2Yt
	+WydW1N/ZL4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE45023A64;
	Mon,  6 Jun 2016 16:28:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BE1A23A62;
	Mon,  6 Jun 2016 16:28:47 -0400 (EDT)
In-Reply-To: <xmqqbn3ew0mf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 06 Jun 2016 12:58:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45AE1040-2C25-11E6-B19F-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296562>

Junio C Hamano <gitster@pobox.com> writes:

> I am wondering if this "we do not include status and do not ask
> run_status() about commitable bit" codepath should share more with
> the other side, which you do not touch at all with this series,
> which in turn must be doing the right thing already, apparently
> without having to know anything about the SHIFT_INTENT_TO_ADD
> hackery.
>
> Or does "git commit" that uses run_status() still allow an empty
> commit after this patch?

Ah, I didn't see what 2/4 does.  The duplication still does make
this look an ugly hack, but I can see that the series is at least
internally consistent.
