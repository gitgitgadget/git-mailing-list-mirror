From: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Thu, 16 Aug 2012 15:10:42 -0700
Message-ID: <fd74d7233b4b29fe06afad23fb87552a@localhost>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net> <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
 <20120703051426.GA12965@sigill.intra.peff.net>
 <7vvcgizesm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 00:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T28It-00012u-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 00:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933438Ab2HPWM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 18:12:28 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:53593 "EHLO
	piggy.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933416Ab2HPWMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 18:12:24 -0400
Received: from venus.rz.tu-ilmenau.de (venus.rz.tu-ilmenau.de [141.24.4.158])
	by piggy.rz.tu-ilmenau.de (8.13.7/8.13.7/Debian-2) with ESMTP id q7GMAgRN027076;
	Fri, 17 Aug 2012 00:10:42 +0200
In-Reply-To: <7vvcgizesm.fsf@alter.siamese.dyndns.org>
X-Sender: 8WNMocA5eZ8I4TPBqpL5KU64mUxdq6/DoAPhElPChzV13XRp+f+Sog==@vger.kernel.org
User-Agent: Roundcube Webmail/0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Jul 03, 2012 at 11:25:16AM +0700, Nguyen Thai Ngoc Duy wrote:
>>
>>> On Tue, Jul 3, 2012 at 10:45 AM, Jeff King <peff@peff.net> wrote:
>>> > On Tue, Jul 03, 2012 at 12:43:42AM +0200, Andreas Schwab wrote:
>>> >
>>> >> Jeff King <peff@peff.net> writes:
>>> >>
>>> >> > It's very odd for pread to report ENOENT (since it is always operating
>>> >> > on an already-opened file descriptor).
>>> >>
>>> >> It doesn't, but gettext will clobber errno:
>>> >>
>>> >>               n = pread(pack_fd, inbuf, n, from);
>>> >>               if (n < 0)
>>> >>                       die_errno(_("cannot pread pack file"));
>>> >>
>>> >> There is nothing that saves errno.  This isn't limited to i18n though,
>>> >> any function call in the arguments may potentially clobber errno.
>>> >
>>> > That's horribly lame of gettext. I don't expect arbitrary functions to
>>> > save errno, but when the entire purpose of a function is to be a
>>> > non-intrusive wrapper to massage messages to the user, it seems kind of
>>> > evil to overwrite errno. Isn't the whole point of calling it "_" that
>>> > you don't want to or have to notice it?
>>>
>>> Agreed.
>>
>> Hmm. According to gettext(3):
>>
>>   ERRORS
>>          errno is not modified.
>>
>> And googling for "gettext" and "errno" reveals several bugfixes in GNU
>> gettext to make sure that gettext preserves errno. I wonder if there are
>> systems where that is not the case, though; I don't know what non-GNU
>> gettext implementations are in common use these days. I'd still be
>> curious to hear what platform the server is for this bug report.
> 
> Hrm, has this ever been resolved?

Thank you for asking.
My local git version is 1.7.5.4, the server version that I actually
ended up pushing the files to was however still some 1.6.x.
So it was a false alarm. Sorry about that.

As far as I can follow, there is no non-GNU gettext involved. Thanks
for digging that deep into the problem, but it was my fault, probably
not something about lost errno.
