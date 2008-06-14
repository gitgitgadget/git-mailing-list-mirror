From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG REPORT] "git ls-remote http://git.domain.com/repo.git HEAD"
 doesn't work
Date: Sat, 14 Jun 2008 11:09:32 -0700
Message-ID: <7vlk17horn.fsf@gitster.siamese.dyndns.org>
References: <loom.20080614T065448-251@post.gmane.org>
 <20080614071011.GA29699@glandium.org>
 <7vprqkh423.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven <svoop@delirium.ch>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 20:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aDU-0006U0-9v
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYFNSKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbYFNSKB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:10:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbYFNSJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:09:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 36E042442;
	Sat, 14 Jun 2008 14:09:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 805FD2441; Sat, 14 Jun 2008 14:09:40 -0400 (EDT)
In-Reply-To: <7vprqkh423.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 14 Jun 2008 00:24:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10E93AB6-3A3D-11DD-8693-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85029>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> http://www.kernel.org/pub/scm/git/git.git/info/refs doesn't contain HEAD.
>> Shouldn't it ?
>
> Traditionally it _never_ talked about HEAD...

Well, to clarify:

 (1) I do not think it is unreasonable to change update-server-info to
     include HEAD in its output.  That would make ls-remote output over
     all protocols consistent;

 (2) However, the client-side tools that run ls-remote may have to
     interact with repositories that are managed with older git (including
     "Today's git").  If they rely on the presense of HEAD, they _are_
     buggy today (and have been so forever), and they _will stay_ buggy
     when they need to access such repositories.

So I do not mind (1) for its "consistency" value, but that would not be a
"fix" for your problem.

Also we can do (1) only after somebody audits our own callers to make sure
that they do not to get upset by presense of HEAD.  They might have been
assuming they'd get nothing outside refs/ when talking via http, and
suddenly starting to emit HEAD might break them, in which case we cannot
afford to do (1) --- that would break older clients.
