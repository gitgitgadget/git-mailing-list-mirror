From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Fri, 21 Mar 2014 09:02:44 +0100
Message-ID: <87ior8c72z.fsf@fencepost.gnu.org>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
	<87ob11g9st.fsf@fencepost.gnu.org>
	<xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 09:12:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQuYY-0005LT-SR
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 09:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbaCUILp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 04:11:45 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41818 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbaCUILb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 04:11:31 -0400
Received: from localhost ([127.0.0.1]:40861 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WQuY5-0007DF-Ja; Fri, 21 Mar 2014 04:11:29 -0400
Received: by lola (Postfix, from userid 1000)
	id C6106E08C8; Fri, 21 Mar 2014 09:02:44 +0100 (CET)
In-Reply-To: <xmqqlhw5260l.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Mar 2014 15:11:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244680>

Junio C Hamano <gitster@pobox.com> writes:

> I know that the 512MiB default for the bitFileThreashold (aka
> "forget about delta compression") came out of thin air.  It was just
> "1GB is always too huge for anybody, so let's cut it in half and
> declare that value the initial version of a sane threashold",
> nothing more.
>
> So it might be that the problem is 512MiB is still too big, relative
> to the 16MiB of delta base cache, and the former may be what needs
> to be tweaked.

Well, the point with the 512MiB limit is basically that you can always
argue "if you are working with 500MiB files, you will not be using just
128MiB of main memory anyway".  The 16MiB limit, in contrast, will get
utilized for basically every history, even one of small files, that's
deep enough.

> If a blob close to but below 512MiB is a problem for 16MiB delta base
> cache, it would still be too big to cause the same problem for 128MiB
> delta base cache---it would evict all the other objects and then end
> up not being able to fit in the limit itself, busting the limit
> immediately, no?

I think, but may be mistaken, that the delta base limit decides when to
flush whole blobs.  So a 500MiB file would still be encoded relative to
a single newer version anyway and take memory accordingly.

But I am not sure about that at all.

-- 
David Kastrup
