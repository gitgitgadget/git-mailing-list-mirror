From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 22:48:57 +0100
Message-ID: <87zjm6v99y.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<874n4ewouz.fsf@fencepost.gnu.org>
	<xmqqr47i7dt4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAns1-0004L8-LH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934604AbaBDVtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:49:16 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:53905 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933741AbaBDVtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:49:12 -0500
Received: from localhost ([127.0.0.1]:52947 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAnrj-0007AK-OX; Tue, 04 Feb 2014 16:49:11 -0500
Received: by lola (Postfix, from userid 1000)
	id 79A89E0478; Tue,  4 Feb 2014 22:48:57 +0100 (CET)
In-Reply-To: <xmqqr47i7dt4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Feb 2014 13:44:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241562>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Ok, I now wrote
>>
>> 	for (p = buf;; num++, p++) {
>> 		p = memchr(p, '\n', end - p);
>> 		if (!p)
>> 			break;
>> 	}
>
> Looks still wrong (perhaps this is a taste issue).
>
> 	num++ is not "loop control", but the real action of this
> 	loop to count lines.  It is better left inside.

Ok.

> 	p++ is "loop control", and belongs to the third part of
> 	for(;;).

No, it isn't.  The "real" loop control is the p = memchr line.  p++ only
skips over the newline.

> 	Isn't the normal continuation condition "p < end"?

memchr returns NULL when not finding anything any more.

> so something like
>
> 	for (p = buf; p < end; p++) {
>         	p = find the end of this line
>                 if (!p)
>                 	break;
> 		num++;
> 	}
>
> perhaps?

Would crash on incomplete last line.

-- 
David Kastrup
