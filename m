From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Wed, 19 Mar 2014 22:25:54 +0100
Message-ID: <87ob11g9st.fsf@fencepost.gnu.org>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:26:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNzr-0007wx-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbaCSVZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:25:55 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:35741 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbaCSVZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 17:25:55 -0400
Received: from localhost ([127.0.0.1]:34780 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WQNzm-0007Lw-Gr; Wed, 19 Mar 2014 17:25:54 -0400
Received: by lola (Postfix, from userid 1000)
	id 1F4FEEAD1A; Wed, 19 Mar 2014 22:25:54 +0100 (CET)
In-Reply-To: <xmqq38id3nfs.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Mar 2014 14:09:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244496>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> The default of 16MiB causes serious thrashing for large delta chains
>> combined with large files.
>>
>> Signed-off-by: David Kastrup <dak@gnu.org>
>> ---
>
> Is that a good argument?  Wouldn't the default of 128MiB burden
> smaller machines with bloated processes?

The default file size before Git forgets about delta compression is
512MiB.  Unpacking 500MiB files with 16MiB of delta storage is going to
be uglier.

>> Forgot the signoff.  For the rationale of this patch and the 128MiB
>> choice, see the original patch.
>
> "See the original patch", especially written after three-dash lines
> without a reference, will not help future readers of "git log" who
> later bisects to find that this change hurt their usage and want to
> see why it was done unconditionally (as opposed to encouraging those
> who benefit from this change to configure their Git to use larger
> value for them, without hurting others).

Documentation/config.txt states:

    core.deltaBaseCacheLimit::
            Maximum number of bytes to reserve for caching base objects
            that may be referenced by multiple deltified objects.  By storing the
            entire decompressed base objects in a cache Git is able
            to avoid unpacking and decompressing frequently used base
            objects multiple times.
    +
    Default is 16 MiB on all platforms.  This should be reasonable
    for all users/operating systems, except on the largest projects.
    You probably do not need to adjust this value.

I've seen this seriously screwing performance in several projects of
mine that don't really count as "largest projects".

So the description in combination with the current setting is clearly wrong.

> While I can personally afford 128MiB, I do *not* think 16MiB was
> chosen more scientifically than the choice of 128MiB this change
> proposes to make, and my gut feeling is that this would not have too
> big a negative impact to anybody, I would prefer to have a reason
> better than gut feeling before accepting a default change.

Shrug.  I've set my private default anyway, so I don't have anything to
gain from this change.  If anybody wants to pick this up and put more
science into the exact value: be my guest.

-- 
David Kastrup
