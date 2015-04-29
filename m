From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report : bad filter-branch (OSX only)
Date: Tue, 28 Apr 2015 22:39:44 -0700
Message-ID: <xmqqy4lbtrvj.fsf@gitster.dls.corp.google.com>
References: <CAM=W1NkZr6o-DCxXskeWC8xjRMiT2P9qXeeUe91qLBqOxzqNtg@mail.gmail.com>
	<20150428055506.GJ24580@peff.net>
	<CAM=W1NnR2-T7vpMSM-3-VypnR-T235tMudyjJowtj5utNmoKNQ@mail.gmail.com>
	<20150429043947.GA10702@peff.net> <20150429045600.GA10781@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olivier ROLAND <cyrus-dev@edla.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 07:39:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnKiu-0005N3-9N
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 07:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbbD2Fjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 01:39:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751264AbbD2Fjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 01:39:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F7D940439;
	Wed, 29 Apr 2015 01:39:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cxzwuPozojsGhAXdZEQbXWOdzO8=; b=eLszzP
	UQ66ynHeQwBHoFj/PmkEdYMeXxWPvkxoZ0rUpwUv+4tOvO1Ic2QHg0C3yWXsXOta
	pJyIlEtt1GJU/FHvaYSoDuJjQsCby4FBQhG3pzc6Es8TMUmah4CVzMtoemBcmgop
	XkIL3AI0hmNIBGOeyNVxrdwlpDPL5P7JUWwcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FO2tye1AkZlbPBq5TIsATGRYeoWpJQB6
	PJa9/eNkxJ2yXMDX8bkFloFJcvf7U8wJI7u6OKXJlBn6LZbeXeAFfoXYu9dJZts9
	b/TgAYf+6thTrBAn4Odo9uDXhtaaqLhAWjTtXtV9UefnW9a3cJHSWI15F/g0iJSE
	U7GthzL30A0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08C9C40438;
	Wed, 29 Apr 2015 01:39:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FAAD40436;
	Wed, 29 Apr 2015 01:39:45 -0400 (EDT)
In-Reply-To: <20150429045600.GA10781@peff.net> (Jeff King's message of "Wed,
	29 Apr 2015 00:56:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2474EFFC-EE32-11E4-9763-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267958>

Jeff King <peff@peff.net> writes:

> I'm not sure of a solution short of replacing the use of sed here with
> something else. perl would be a simple choice, but filter-branch does
> not otherwise depend on it. We could use a shell "read" loop, but those
> are quite slow (and filter-branch is slow enough as it is!).

You need to only skip the header part, right?
I would imagine that

(
	while read x && test -n "$x"
        do
        	:;
	done
	cat
) <../commit | eval "$filter_msg"

would not spin too much in shell loop, perhaps?
