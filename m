From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] silence missing-link warnings in some cases
Date: Mon, 01 Jun 2015 09:11:56 -0700
Message-ID: <xmqq7frn8l2r.fsf@gitster.dls.corp.google.com>
References: <556C0BAD.80106@atlas-elektronik.com>
	<20150601081450.GA32634@peff.net>
	<556C1A95.9010704@atlas-elektronik.com>
	<20150601085226.GA20537@peff.net> <20150601095410.GA16976@peff.net>
	<xmqqmw0j8o9i.fsf@gitster.dls.corp.google.com>
	<20150601154103.GA14538@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:12:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzSJp-00040t-GV
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 18:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbbFAQMB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 12:12:01 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33494 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbbFAQL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 12:11:59 -0400
Received: by igbpi8 with SMTP id pi8so65084550igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=DMYDIKbgO55MNR03mkNeuSba/BN0mhp2NXkZQ1T5/Ec=;
        b=VA6Sr52VmFapUSsPk+OQzsuyv0ElOhF7hXkKtL1EQHqodVvQF1MO4vdyYVwHNskDWA
         xojA/2r6zO6HWZYOAgv4ZUvt4b0aFcxwUmYyWkJjxhbPUqQwpZ3o9U1gqF2ea5lsozO7
         F50JoHvEPpOUS6DG+Cqzdj9uOLGIwZjPbQ/awPcejrX69IO0avmJjPhZqmTTSUj2gt0t
         g4YVp+7lcp8qT7YkG/0oYCHnzGEQ+wWUBLpQRvhWG9tWJb8fdE8TXWcDPV15J6AN3pcI
         dnPMUSABW+9mKT+GIa+BOXAG0AWoeWP1g1uCcekSAAe+vOxmDJ6GCf+dNo9qtw0Drjzo
         0jUQ==
X-Received: by 10.107.40.144 with SMTP id o138mr18008116ioo.66.1433175118891;
        Mon, 01 Jun 2015 09:11:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id l1sm10684621ioe.32.2015.06.01.09.11.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 09:11:58 -0700 (PDT)
In-Reply-To: <20150601154103.GA14538@peff.net> (Jeff King's message of "Mon, 1
	Jun 2015 11:41:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270433>

Jeff King <peff@peff.net> writes:

>> The fixes make sense to me (I haven't carefully read the
>> implementation, but design/approach explained in the proposed log
>> messages are very sound), and I think 3/3 is a good thing to do,
>> too, in the new world order after d3038d2.
>
> I think it's rather the opposite. In a post-d3038d2 world, a missing
> object is _more_ likely to be a real corruption, and we would probabl=
y
> prefer to complain about it. I am on the fence though.

Sorry, but I wasn't talking about that far in the future.

In the immediate future that necessitates patches 1 and 2, a warning
on such a missing object from the codepath in 3 would be equally
annoying noise, no?  And a purely post-d3038d2 world, all of these
warnings may be pointing at a real corruption, as you referred to as
"yet another possibility".

As you said, these should have been part of ignore-missing-links, so
I'd say we should treat the codepaths that special case the callers
that pass that option the same way.

Having said all that, I do not think it is healthy to assume that
pre-d3038d2 prune is the only thing that may leave an incomplete and
unreachable island of objects in the repository (two easy ways to do
so are to interrupt unpack-objects or the commit walker dumb fetch).
So from that point of view, these three patches are reasonable
things to keep even in the longer term (in other words, I do not
think "yet another possibility" of waiting for the older versions of
gc/prune to die out is a viable solution to the issue Stefan N=C3=A4we
noticed).

Thanks.
