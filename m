From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 05 May 2016 16:54:03 -0700
Message-ID: <xmqqpot06oys.fsf@gitster.mtv.corp.google.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbmW5U+uFCnBhz4r2-ciGsWSwXHU5Va2r-MEca=iacfgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:54:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayT5x-0006No-3h
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbcEEXyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:54:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756240AbcEEXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:54:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 423B4197F5;
	Thu,  5 May 2016 19:54:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4QFXsSCkcCCh8HBRrmVMlzgY3nE=; b=xQdxbp
	owPS0mpQuaDvkKP/L75AX0+x7JF8D306iEa2LZXLx/GXrHKj7mRLvNjmao+sVQYR
	Fq9pDqJyc1t/J2SexejL8jc4yuXd2jQcC4h2SHVgOczZMtgJdYU6AL54HPOSwl1t
	GunDMuRZRPiWl27DbBLeYlQ98xK+d0i07Ns/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQXwP6CcQjrW22zksv0UyE3OKpWJ76ui
	q4mRbt2xQU9namJJMzsiDAAPn89zLCJLx15ePJouY78S6+W2ghs0rJPIN/HXHa9w
	KX6e6b8NfAAatKJQ5J9+Z8Rc+uak/0aVbX82oKBchZhZGx4udY9XmpU4w2tn3FEp
	dtr7/ZtzvTA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AAE5197F3;
	Thu,  5 May 2016 19:54:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE877197F2;
	Thu,  5 May 2016 19:54:04 -0400 (EDT)
In-Reply-To: <CAGZ79kbmW5U+uFCnBhz4r2-ciGsWSwXHU5Va2r-MEca=iacfgQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 16:32:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A60D060C-131C-11E6-90A5-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293729>

Stefan Beller <sbeller@google.com> writes:

> That was my first reaction as well. However after a while of thought I actually
> like that bug. Consider the possibilities how gitk/git-gui or other subsystems
> can be developed. When accepting a patch for that you can either apply the
> patch in the outer or inner repository, depending on what the sender used.
>
> I am not so sure if it is a bug plain and simple, but devolved into a
> "feature" now.

I'd freely admit that I have not considered its possible upsides at
all.  When deep/in/ is an unrelated repository, and running either

    git add deep/in/the
    git add deep/in/the/tree

would add deep/in/the/tree/is-a-leaf.txt to my index, but if I did

    git add deep/in

I'd lose that and suddenly everything there turns into a submodule.

And that is enough for me to declare that it is not worth my time to
consider possible upside of that hole.  Can you tell offhand what
would happen if you do "git add deep" (before adding deep/in as a
submodule) without experimenting?
