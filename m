From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem running 'make install' as root when on mounted fs
Date: Fri, 07 Aug 2009 10:51:12 -0700
Message-ID: <7vbpmr1pin.fsf@alter.siamese.dyndns.org>
References: <8F9F4A8A-9515-4A7D-90EE-4BD3DA3F7A2B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 19:51:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZTbC-0005E1-9D
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 19:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbZHGRvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbZHGRvR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 13:51:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690AbZHGRvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 13:51:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B33AB21C08;
	Fri,  7 Aug 2009 13:51:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE64D21C04; Fri,  7 Aug 2009
 13:51:13 -0400 (EDT)
In-Reply-To: <8F9F4A8A-9515-4A7D-90EE-4BD3DA3F7A2B@gmail.com> (Alex Blewitt's
 message of "Fri\, 7 Aug 2009 11\:08\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7DDB9CA-837A-11DE-8256-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125206>

Alex Blewitt <alex.blewitt@gmail.com> writes:

> I think it would be possible to restrict the GIT-BUILD-OPTIONS to be
> generated during a build phase, so restructuring the Makefile like:
>
> install: build
> all:: build GIT-BUILD-OPTIONS
> build: ...

If you did:

	make prefix=$HOME all
        make prefix=/usr install

then the second step needs to notice that the gitexecdir computed and
stored in exec_cmd.o in the first step is now invalid, and needs to
recompile the file.  The whole purpose of GIT-BUILD-OPTIONS is to detect
such a case---doesn't your change defeat it?
