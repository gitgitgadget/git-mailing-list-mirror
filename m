From: "David Syzdek" <syzdek@gmail.com>
Subject: Re: [PATCH] Add support for uintmax_t type on FreeBSD 4.9
Date: Mon, 27 Oct 2008 05:23:15 -0800
Message-ID: <9a0027270810270623h4c0c34d0vcd92f61edff6da5@mail.gmail.com>
References: <1225021957-11880-1-git-send-email-david.syzdek@acsalaska.net>
	 <7vy70aip06.fsf@gitster.siamese.dyndns.org>
	 <9a0027270810262239r311074m51d382bdd95fd0dc@mail.gmail.com>
	 <9a0027270810262246i56cf5515l5fa0875f91d90a7a@mail.gmail.com>
	 <7v1vy2imt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 14:24:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuS59-00060s-8F
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 14:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbYJ0NXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 09:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYJ0NXR
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 09:23:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:38678 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbYJ0NXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 09:23:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2050961wfd.4
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=u0mLz00kolgF3sXZnUX69DY3ZL1dn55c9PAdYzCrDgw=;
        b=YFsvM+ZPySfzPUuTHSMyJDTgyr82PzZtdNmIm2bwy9/Rovx/VDjm/9N0PL0nnpz02f
         H78haQy2GhPEVOGQCKo5qm6FOoHRWdu3IWUm/KtLYa0tjVGP2LXaO4DdA8Ip+FCU5aSe
         exG6papr34o8g/f6D2k2j1y1fR3lC/8S7JXL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=om8C78+AYlxYrJGJK6HPr7SqJ100PAgUY7bLW0IXJBfHGp4w9dUgOyj2s4zmtrnBv8
         AJA5eshhKbkFiwWUofyoM7GEBk96kVylnqDmDfaVYhcR8U5l+KZqmZWX6OuXg8kgi+wO
         KRdzcBGDOIeGcJqfSKGfK+PQW2mmo4xeFN3PI=
Received: by 10.141.69.1 with SMTP id w1mr3243102rvk.147.1225113795573;
        Mon, 27 Oct 2008 06:23:15 -0700 (PDT)
Received: by 10.141.77.7 with HTTP; Mon, 27 Oct 2008 06:23:15 -0700 (PDT)
In-Reply-To: <7v1vy2imt2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99230>

On Sun, Oct 26, 2008 at 10:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "David Syzdek" <syzdek@gmail.com> writes:
>
>> On Sun, Oct 26, 2008 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> I have a stupid question.
>>>
>>> Would it be a more appropriate improvement to do it like this:
>>>
>>>        ifdef USE_THIS_AS_UINTMAX_T
>>>            BASIC_CFLAGS += -Duintmax_t="$(USE_THIS_AS_UINTMAX_T)"
>>>        endif
>>>
>>> and then add a section for FreeBSD 4.9-SECURITY like this:
>>>
>>>        ifeq ($(uname_R),4.9-SECURITY)
>>>                USE_THIS_AS_UINTMAX_T = uint32_t
>>>        endif
>>>
>>> That way, an oddball 64-bit machine can use uint64_t here if it wants to,
>>> possibly including FreeBSD 4.9-SECURITY backported to 64-bit ;-).
>>>
>>
>> Your suggestion provides more flexibility for other environments. I
>> was making the assumption that 64-bit systems would define uintmax_t,
>> however in retrospect that would be unwise.
>> Would you like me to resubmit the patches with your modifications?
>
> Actually there was a reason why I said this was a "stupid" question.  I
> think your assumption on 64-bit platforms would hold in practice, and my
> suggestion could be an unnecessary overengineering.  If nobody knows of a
> system that would benefit from such a generalization, your original patch
> would be better, partly because I think:
>
>  (1) USE_THIS_AS_UINTMAX_T is just for demonstration of concept and is a
>     terrible name we cannot possibly use in our Makefile.  We have to
>     spend brain cycles to come up with a better name; and
>
>  (2) It may be tricky to come up with autoconf macros to determine what to
>     set USE_THIS_AS_UINTMAX_T to.
>
> As a slightly unrelated aside, I find it somewhat unfortunate that the
> conditional says "4.9-SECURITY", which is a bit too explicit and specific.
> to my taste.  I do not know how FreeBSD versioning scheme works, but
> wouldn't your change work equally well for 4.9-RELEASE or 4.11-RELEASE?
>
> I suspect that you would want to say "$(uname_R) that begins with '4.' or
> smaller needs this workaround", as strtoul(3) manual page seems to appear
> first in FreeBSD 5.0-RELEASE (but not found in FreeBSD 4.11-RELEASE).
>

The following should match against FreeBSD 4.x:

	FREEBSD_MAJOR := $(shell sh -c 'echo $(uname_R) |cut -d. -f1')
	ifeq ($(FREEBSD_MAJOR),4)
		NO_UINTMAX_T = YesPlease
		NO_STRTOUMAX = YesPlease
	endif

Is the use of FREEBSD_MAJOR okay, or would another name be more appropriate?



-- 
An earthquake wiped out Etchisketchistan today.
   -- Onion TV
