From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 2 Feb 2009 01:50:12 +0100
Message-ID: <4ac8254d0902011650g714c5a7cya3c5111a74b8d8ea@mail.gmail.com>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch>
	 <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
	 <20090119172939.GA14053@spearce.org>
	 <4ac8254d0902011448t242e7fcek3ae7fda609648ef0@mail.gmail.com>
	 <7vwsc9rae9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 01:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTn2L-0006ss-9U
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 01:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbZBBAuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 19:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbZBBAuP
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 19:50:15 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:5434 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZBBAuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 19:50:14 -0500
Received: by ey-out-2122.google.com with SMTP id 25so312870eya.37
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 16:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9Xagsmm0zcGsMbCrsZ+iDztv9t5P+fneFPL6/0OGnZA=;
        b=r87/JoN4ImHJf7ed3l4bethMct4k+Unkp6JSL0qIA0ZtV+A3BsRTi3ppQ/dTJb0v8p
         5YlsMz9B573AP41Ij41HT+jDWU9lrav6j/QgDItYUIL+0tWDiWQGkHaz6UX8nA/Yt6bC
         k1EaarW+RI/vvJTzXDwwFUpx6UKsauxSs5UGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wzbaT1x82SZAOP4rISAvR4/47UQ8cR9Ohacf7XAX2u9zip4itQiQFZUWqgKvgz9Y+6
         DhLxbC6gcm8POR8w3Apn8eFVK081sufckQSuml7Jxe9gcjVlSyBXDyPZLSJi//VNPQW8
         qhcqwuCs3nIcY79QnyQU2eKhYeOzLB43X2kTA=
Received: by 10.210.81.3 with SMTP id e3mr4162158ebb.30.1233535812536; Sun, 01 
	Feb 2009 16:50:12 -0800 (PST)
In-Reply-To: <7vwsc9rae9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108031>

On Mon, Feb 2, 2009 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>
>> On Mon, Jan 19, 2009 at 6:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>> Junio C Hamano <gitster@pobox.com> wrote:
>>>> Thomas Rast <trast@student.ethz.ch> writes:
>>>>
>>>> > +           if test ! -z "$GIT_PS1_EXPENSIVE"; then
>>>> > +                   git update-index --refresh >/dev/null 2>&1 || w="*"
>>>>
>>>> This makes the feature unavailable for people who care about the stat
>>>> dirtiness and explicitly set diff.autorefreshindex to false, doesn't it?
>>>
>>> Yup, and I'm one of those people who sets autorefresindex to false
>>> in my ~/.gitconfig, usually before I even have user.{name,email} set.
>>>
>>> I do like the idea of what Thomas is trying to do here, but its
>>> so bloody expensive to compute dirty state on every prompt in
>>> some repositories that I'd shoot myself.  E.g. WebKit is huge,
>>
>> I've been thinking about this and wondered
>> whether implementing "status --mini" or
>> "status --short" which prints "+?*" in wt-status.c
>> could be made fast enough.
>>
>> Should we try to implement and profile this
>> or do we know it will be slow beforehand?
>
> I think I've seen a patch to do something like that, soon after Shawn
> announced his repo tool.

The best I could find is your patch from October 25th 2008
which implements:
       $ ./git-shortstatus
       M     Makefile
       R100  COPYING -> RENAMING
           M builtin-commit.c
           M builtin-revert.c
           M builtin.h
           M git.c
           M wt-status.c
           M wt-status.h

Is this what you meant?
