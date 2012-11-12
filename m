From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Update cygwin.c for new mingw-64 win32 api headers
Date: Mon, 12 Nov 2012 16:39:39 -0500
Message-ID: <CAK2bgnXLnKmnVwzE5U_1qZueUdj-QaT23f-iFmhJyRto3tWnhA@mail.gmail.com>
References: <1352679440-4098-1-git-send-email-mlevedahl@gmail.com>
	<20121112205832.GI4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1ja-0003No-Js
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab2KLVjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 16:39:46 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65368 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab2KLVjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 16:39:40 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so9770143iea.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 13:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2+Hlld4TVLdGuP7qe9A7m/fSk5Uh/7Q1V+F4UV/8v1c=;
        b=YzP7ZghaIm7Yjl9ob2hQf/ai5bO/ZrWIRDcqdY0EZDk05PA4h9KKwZY3mDx5lskOxq
         OfV7b0tncXBW4JD2NSIDmf/p+4sOPsZt+wwwlifb/GwWWynJz0cBF2vwzqz3R0pqO8Y9
         Y+HnpNKHMXsI6ppwKNGsUuROUYsXLpFcKZ8+5UqvrTkeYphVRA7HXvNxj07Hz4NLm68v
         NwTgtyFD+onE/oKEDibkd4RXf0GPR+KqsLJiA1yaXkyqRsbC07DD8Xfhc48xwAUYcqBV
         1imEcsj80x/ApKbtf4QZ4gNEPLqPPsL68e3TEUHmn+TBh8jK3utRrwaGipzjon1UgDvn
         WDPg==
Received: by 10.50.57.200 with SMTP id k8mr9306305igq.29.1352756379669; Mon,
 12 Nov 2012 13:39:39 -0800 (PST)
Received: by 10.64.70.170 with HTTP; Mon, 12 Nov 2012 13:39:39 -0800 (PST)
In-Reply-To: <20121112205832.GI4623@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209529>

On Mon, Nov 12, 2012 at 3:58 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2012 at 07:17:20PM -0500, Mark Levedahl wrote:
>
>> The cygwin project recently switched to a new implementation of the
>> windows api, now using header files from the mingw-64 project. These
>> new header files are incompatible with the way cygwin.c included the
>> old headers: cygwin.c can be compiled using the new or the older (mingw)
>> headers, but different files must be included in different order for each
>> to work. The new headers are in use only for the current release series
>> (based upon the v1.7.x dll version). The previous release series using
>> the v1.5 dll is kept available but unmaintained for use on older versions
>> of Windows. So, patch cygwin.c to use the new include ordering only if
>> the dll version is 1.7 or higher.
>
> I have very little knowledge of cygwin compatibility, so thanks for a
> nice explanation.  I'll queue it in 'pu' for now, and hopefully we can
> get some test reports from other cygwin folks (on new and old cygwin).
>
>> diff --git a/Makefile b/Makefile
>> index f69979e..1cc5d96 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1082,6 +1082,7 @@ ifeq ($(uname_O),Cygwin)
>>               NO_SYMLINK_HEAD = YesPlease
>>               NO_IPV6 = YesPlease
>>               OLD_ICONV = UnfortunatelyYes
>> +             V15_MINGW_HEADERS = YesPlease
>>       endif
>
> The "if" part of the conditional that did not make it into the context
> above is an expr match for "1.6.*" From the name, I would think that we
> would want to use these headers on cygwin 1.5.* , too. Is v1.5 too old
> to care about now?
>
> -Peff

The opening if expression is:
    ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
which I believe matches any version below 1.7. 1.5 is what is released
opensource, 1.6 is (or was) available as a supported product from
redhat. So, I think the stanza is ok as is.

Mark
