From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/2] open() error checking
Date: Tue, 16 Jul 2013 11:25:34 +0200
Message-ID: <87hafukga9.fsf@linux-k42r.v.cablecom.net>
References: <cover.1373618940.git.trast@inf.ethz.ch>
	<7vtxjzlmaf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, "Dale R. Worley" <worley@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1Vs-0005eI-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433Ab3GPJZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:25:35 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:27675 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab3GPJZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:25:35 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:25:29 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 16 Jul 2013 11:25:33 +0200
In-Reply-To: <7vtxjzlmaf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 12 Jul 2013 10:29:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230554>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> I originally had a four-patch series to open 0/1/2 from /dev/null, but
>> then I noticed that this was shot down in 2008:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/93605/focus=93896
>
> The way I recall the thread was not "shot down" but more like
> "fizzled out without seeing a clear consensus".  As a normal POSIX
> program, we do rely on fd#2 connected to an error stream, and I do
> agree with the general sentiment of that old thread that it is very
> wrong for warning() or die() to write to a pipe or file descriptor
> we opened for some other purpose, corrupting the destination.
>
> I briefly wondered if we can do the sanity check lazily (e.g. upon
> first warning() see of fd#2 is open and otherwise die silently), but
> we may open a fd (e.g. to create a new loose object) that may happen
> to grab fd#2 and then it is too late for us to do anything about it,
> so...

I think we'd have to do it on startup.  Since we do many things already,
a few extra dup calls should hardly matter.

I'll send the patches in reply in a minute, I had them lying around
already.  But if you (again) decide that it's not worth it, I don't care
too deeply.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
