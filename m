From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - Fix errors regarding resolve_relative_url
Date: Sat, 14 Jun 2008 11:28:11 -0700
Message-ID: <7vd4mjhnwk.fsf@gitster.siamese.dyndns.org>
References: <1213463381-3316-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 20:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aV5-0003Hm-Gn
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbYFNS2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753562AbYFNS2Z
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:28:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbYFNS2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:28:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F29AF2571;
	Sat, 14 Jun 2008 14:28:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6A4232570; Sat, 14 Jun 2008 14:28:18 -0400 (EDT)
In-Reply-To: <1213463381-3316-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Sat, 14 Jun 2008 13:09:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AB273E8C-3A3F-11DD-BED5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85033>

Mark Levedahl <mlevedahl@gmail.com> writes:

> git-submodule was invoking "die" from within resolve-relative-url, but
> this does not actually cause the script to exit. Fix this by returning
> the error to the caller and have the caller exit.

Thanks for catching this.  But don't you think the first hunk is
unnecessary?

> While we're at it, clean up the quoting on invocation of
> resolve_relative_url as it was wrong.

Yup.  if you make it pass through the non-zero exit status that would be
perfect, like this:

    realrepo=$(resolve_relative_url "$repo") || exit
