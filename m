From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-sh-setup: Fix scripts whose PWD is a symlink into a
 git work-dir
Date: Tue, 02 Dec 2008 23:20:27 -0800
Message-ID: <7viqq1hghw.fsf@gitster.siamese.dyndns.org>
References: <7vtz9vk6uj.fsf@gitster.siamese.dyndns.org>
 <1228282020-2294-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 08:21:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7m3X-0005RE-4b
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 08:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYLCHUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 02:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYLCHUh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 02:20:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbYLCHUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 02:20:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 25AB917F74;
	Wed,  3 Dec 2008 02:20:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E45421801E; Wed, 
 3 Dec 2008 02:20:28 -0500 (EST)
In-Reply-To: <1228282020-2294-1-git-send-email-marcel@oak.homeunix.org>
 (Marcel M. Cary's message of "Tue, 2 Dec 2008 21:27:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E11A5B9E-C10A-11DD-9F34-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102219>

"Marcel M. Cary" <marcel@oak.homeunix.org> writes:

> If cd_to_toplevel had concatenated $(/bin/pwd) with $cdup to
> avoid the separate "cd", it would require checking for $cdup
> being an absolute path.  I wasn't sure how to check that in
> a way that is both portable and clearly faster than "cd",

    case "$v" in
    /*) : handle absolute path ;;
    *) : everything else ;;
    esac

In all shells that support "case..esac", it is built-in.

Having said that, I think it would probably be better to bite the bullet
and start using "cd -P" soon after 1.6.1 goes final, and at the same time
existing places that use "cd `pwd`" as a workaround if there are some.
