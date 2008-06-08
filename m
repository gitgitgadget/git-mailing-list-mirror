From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 08 Jun 2008 14:19:26 -0700
Message-ID: <7v8wxfiq01.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain>
 <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
 <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0806081443130.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SJV-0003J0-P3
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbYFHVTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYFHVTk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:19:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYFHVTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:19:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92A5E37E7;
	Sun,  8 Jun 2008 17:19:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E7E3437E6; Sun,  8 Jun 2008 17:19:33 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0806081443130.18454@xenau.zenez.com> (Boyd Lynn
 Gerber's message of "Sun, 8 Jun 2008 14:47:54 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A0266CA-35A0-11DD-BAFE-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84321>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> So the patch should be
> ...

Thanks.

I'll apply, but I'd reword the part on _XOPEN_SOURCE like this:

    Looking at the the various platform headers, I see around line 450:

            #if defined(_KERNEL) || !defined(_POSIX_SOURCE) \
                 && !defined(_POSIX_C_SOURCE) && !defined(_XOPEN_SOURCE)

    which hides u_short and other typedefs that other header files on these
    platforms depend on.  With _XOPEN_SOURCE defined, sources that include
    system header files that depend on the typedefs such as u_short cannot be
    compiled on these platforms.

Honestly, I'd have to say that such platform header files are buggy ;-)

If they want to use u_short and other custom types for their internal use,
that is understandable and perfectly fine, and if they want to hide these
names when _POSIX or _XOPEN is defined because you are not supposed to
contaminate the namespace, that is also sensible, but at the same time you
(not you, Boyd, but whoever developed the system header files) should have
taken an alternate measure (perhaps by using __u_short or something) not
to break the features they declare in the other header files of their own.

And not defining _XOPEN nor _POSIX would be a reasonable workaround to
the problem on such systems.
