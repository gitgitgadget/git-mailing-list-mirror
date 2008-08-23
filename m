From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] Segfault in git rev-list --first-parent --bisect
Date: Fri, 22 Aug 2008 22:31:07 -0700
Message-ID: <7vzln42t7o.fsf@gitster.siamese.dyndns.org>
References: <32541b130808222020v146e015dm8a98a005ad3e76a7@mail.gmail.com>
 <7v7ia848aa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git ML" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 07:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWljh-0005eq-Lq
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 07:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbYHWFbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYHWFbP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 01:31:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbYHWFbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 01:31:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5728D6A118;
	Sat, 23 Aug 2008 01:31:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B77576A117; Sat, 23 Aug 2008 01:31:10 -0400 (EDT)
In-Reply-To: <7v7ia848aa.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 22 Aug 2008 22:20:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B33C71AC-70D4-11DD-8E1D-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93424>

Junio C Hamano <gitster@pobox.com> writes:

> "Avery Pennarun" <apenwarr@gmail.com> writes:
>
>>     $ git rev-list --first-parent --bisect 5109c91 ^d798a2bfe094
>>     Segmentation fault
>
> Totally untested, usefulness fairly unknown.

The latter part of this statement needs a bit of explanation.  I do not
mean "--first-parent --bisect" is useless.  What I meant is that the
approach is only catering to --first-parent and not about non-standard way
to limit the list such as --since, --max-count, etc.

The current bisection algorithm only pays attention to the pathspec based
history simplification and bottom..top (aka "UNINTERESTING or not").  A
proper fix to handle these cases should work inside do_find_bisection(),
and count_interesting_parents() instead of hiding the parents away that
first_parent traversal did not touch, like the patch I sent out.
