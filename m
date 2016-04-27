From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 22/83] builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
Date: Wed, 27 Apr 2016 08:26:38 -0700
Message-ID: <xmqqa8kfax8x.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-23-git-send-email-chriscool@tuxfamily.org>
	<xmqq37q8f748.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0Xx4d=751yhaHpRKUgDQ1G2FkuCEziwdZpVMiJbjyaMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:26:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avRMU-000432-JM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbcD0P0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:26:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752270AbcD0P0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:26:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CA6DC14ECE;
	Wed, 27 Apr 2016 11:26:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h6hVjvpV4zFgBJ3d1Fxq4oSOc6c=; b=gGKQqI
	cmBnURETMIh/WNCK7t32OSXcjGjgboYujdxo+R0eJ4X/4sK+2RACn6pzniSNaSkE
	Vc86YJxlwUDLU8jDnrztCmoDK8ioJee6vkNCz4XhB1N9rx7gDqV1o+01J0h+VGBN
	+gjfi9AgJEyrzto/XiXvnHUTvxfqWmQTeR+P4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8bEzHHhxS7+8BJ7A4TbnFzBUXkM32kH
	I6URKB8SKIYVIfniDDw3qhKswNsPq2allihlUWfUY+qp578avn6JNvmoO1uT2jnR
	Am6qE38ziKW99Tljwo+/BJoUz3TXxOSF7rRkjaYf2RmrkjRMRsLVDKshIkTHRoqg
	uxwAPqgrASY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C03CC14ECD;
	Wed, 27 Apr 2016 11:26:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DBC614ECC;
	Wed, 27 Apr 2016 11:26:40 -0400 (EDT)
In-Reply-To: <CAP8UFD0Xx4d=751yhaHpRKUgDQ1G2FkuCEziwdZpVMiJbjyaMg@mail.gmail.com>
	(Christian Couder's message of "Wed, 27 Apr 2016 14:14:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7065AAF4-0C8C-11E6-B5D2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292733>

Christian Couder <christian.couder@gmail.com> writes:

> The reason I added some blank lines is that I moved comments that were
> all in one block at the top.
> I moved each comment near the related variables and sometimes a
> comment is related to 2 variables, like in the extract below the
> comment that starts with "For "diff-stat" like behaviour,...":

Don't.

If you have four things there, and two are related, you would do

    /* used for --distim option */
    int distim_weight;
    int distim_target;

    int unrelated;

    int another;

And the first two are shown clearly to be related and unrelated to
the other ones.  That sound nice in theory, but think what you would
do when you want to comment further on one of the related ones.  You
would likely do this:

    /* used for --distim option */
    int distim_weight;
   -int distim_target;
   +int distim_target; /* which dosh to distim? */

    int unrelated;

For the same reason, if you are to comment on one of the ungrouped
things, you would do this:


   -int unrelated;
   +int unrelated; /* this is not used for --distim */

    int another;

Notice that a blank between unrelated and another is not helping
anything?  There is no reason to keep blanks in between each and
every unrelated things.

See how "struct diff_options" is done for a better example.  A blank
line every once in a while that roups related things together is
good.  Blindly applying it to all groups of one defeats the benefit
by making the result harder to read.
