From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Mon, 26 Nov 2012 09:41:41 -0800
Message-ID: <7vhaoctg6i.fsf@alter.siamese.dyndns.org>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
 <7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
 <CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
 <CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td2h9-0002MV-Kc
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 18:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573Ab2KZRls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 12:41:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070Ab2KZRlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 12:41:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A2B495BE;
	Mon, 26 Nov 2012 12:41:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2oC4wfgZA8G1qEfvD7TWsbKmKHk=; b=RovoYl
	UCb/KKmNbogsC/1m5vA6R02NGKvF/inlP5FoHZyn+vydztD9vDhmaKoZjE3erkqF
	17KrRUxssi+bjfQuNXaNsQgEwM2l7pITGoVfi8BM6JWVthC0bbYTofuuwErjT/Nl
	4HuC7JtFNM0HjwFv878zAkQzW7vgEXIdTEM6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eb7kpu1luKeBkgU2wAR1MzFlMM3mZ51z
	3GjlEmHL8yW/bK5fw/Asugn3VBHE3FOes+G4r4oFZGys1dRYpQyfoIRm+lzKRQzM
	WhkajGlxKJVcCoEG4B4eGpTE07jCrtSr5qgSsXD69wfJ5/8zQsIAA1xkj4gsVLOO
	WeOwqskB+zc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2609D95B7;
	Mon, 26 Nov 2012 12:41:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72F1095B1; Mon, 26 Nov 2012
 12:41:43 -0500 (EST)
In-Reply-To: <CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com> (Antoine
 Pelisse's message of "Mon, 26 Nov 2012 14:23:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ACB4670-37F0-11E2-93A0-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210458>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Mon, Nov 26, 2012 at 12:37 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, Nov 26, 2012 at 5:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Is this a safe and sane thing to do, and if so why?  Could you
>>> describe that in the log message here?
>> Why would fast-export try to export something that was pruned? Doesn't
>> that mean it wasn't reachable?
>
> Hello Junio,
> Hello Felipe,
>
> Actually the issue happened while using Felipe's branch with his
> git-remote-hg.  Everything was going fine until I (or did it run
> automatically, I dont remember) ran git gc that pruned unreachable
> objects. Of course some of the branch I had pushed to the hg remote
> had been changed (most likely rebased).  References no longer exists
> in the repository (cleaned by gc), but the reference still exists in
> mark file, as it was exported earlier.  Thus the failure when git
> fast-export reads the mark file.

You described that part very well in your proposed log message and I
got it just fine.

> Then, is it safe ?
> Updating the last_idnum as I do in the patch doesn't work because
> if the reference is the last, the number is going to be overwriten
> in the next run.
> From git point of view, I guess it is fine. The file is fully read at
> the beginning of fast-export and fully written at the end.

I am not sure I follow the above, but anyway, I think the patch does
is safe because (1) future "fast-export" will not refer to these
pruned objects in its output (we have decided that these pruned
objects are not used anywhere in the history so nobody will refer to
them) and (2) we still need to increment the id number so that later
objects in the marks file get assigned the same id number as they
were assigned originally (otherwise we will not name these objects
consistently when we later talk about them).

And I wanted to see that kind of reasoning behind the patch in the
proposed log message, because other people will need to refer to it
when they read "git log" output to understand the change.

Thanks.
