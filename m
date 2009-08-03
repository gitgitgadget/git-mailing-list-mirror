From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase -i: use "git sequencer--helper --reset-hard"
Date: Mon, 03 Aug 2009 01:03:54 -0700
Message-ID: <7vbpmxe32t.fsf@alter.siamese.dyndns.org>
References: <20090803024023.3794.6487.chriscool@tuxfamily.org>
 <fabb9a1e0908022158g2578071ewd44bc8d730fb2b8b@mail.gmail.com>
 <200908030829.21424.chriscool@tuxfamily.org>
 <fabb9a1e0908022330l6d0ab44fwc1b6454ba67c9af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 10:04:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXsWu-0001Ff-9e
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 10:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbZHCIEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 04:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbZHCIEN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 04:04:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbZHCIEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 04:04:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 645B01B14E;
	Mon,  3 Aug 2009 04:04:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E41041B14B; Mon,  3 Aug 2009
 04:03:55 -0400 (EDT)
In-Reply-To: <fabb9a1e0908022330l6d0ab44fwc1b6454ba67c9af1@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 2 Aug 2009 23\:30\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A4924D0-8004-11DE-A39B-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Sun, Aug 2, 2009 at 23:29, Christian Couder<chriscool@tuxfamily.org> wrote:
>> This is part of my work to port git-rebase--interactive.sh to C using code
>> from the sequencer project. So the advantage is that it introduces and uses
>> the reset_almost_hard() function that will be used in the end when
>> everything is done by C code.
>
> Hmmm, that almost makes sense, but I don't see the new C code
> replacing any existing shell code, so what am I missing here?

More importantly, I found the "almost_hard()" function way underexplained.
What it does (e.g. does --hard when able but otherwise gives up and falls
back to something else?), why it is necessary (e.g. when should callers
use it, instead of calling unconditional "reset --hard"?), what kind of
preparation is necessary by the caller (e.g. should it read the index
before calling the function?  should it discard the index before?), and
what kind of result should it expect (e.g. is it safe to write a tree out
of the resulting index, or does it screw up the cache-tree and the caller
should discard it before writing a tree?), etc. etc....
