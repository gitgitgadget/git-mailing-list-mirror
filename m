From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 1/3] compat/regex: use the regex engine from gawk
 for compat
Date: Mon, 16 Aug 2010 23:08:40 -0500
Message-ID: <20100817040840.GC17840@burratino>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
 <1282015548-19074-2-git-send-email-avarab@gmail.com>
 <20100817033701.GB17840@burratino>
 <AANLkTikKB6dLF9RVPt7s9KyVdafvOY-i3z+VCMbEwF=m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 06:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlDVP-0003xh-RP
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 06:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892Ab0HQEKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 00:10:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41101 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0HQEKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 00:10:16 -0400
Received: by gwj17 with SMTP id 17so1247468gwj.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 21:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s7OjfJZGE6sm3K4GhLoSBhJ+ymDCHWt3V0trjrApklw=;
        b=CuIAxKcHy+jNGoWhzYBVtO4uOW+czWgykAGUiCittq40/o0ChEYn0EQKdYIhRFVBIf
         V3vHXIuBu+sGAFhVj+qHxWLG7jdgqp3YCyD4v1FXLxdPzXu1JRD+R7w9vKE9PcBaFbGy
         eOB7U22hPDHqrimHXr7kKnVn9QvRFCzdQt7Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BNl6M55de4nqXuD1NmWbH/ow410RyEnbRW8wNloFOvEfbY/zF12XtbfhObrG0VLf4l
         6W7DOtaQlnvjYJaj5hHL3HnJbtJYfv9SEquaGTmPT7OliM41UaWbErYAuMcLIsi7iWG3
         4rfWwJdFK+5b+cVZDfykmWsNjaxsPSWSCUg+8=
Received: by 10.100.197.6 with SMTP id u6mr6908410anf.117.1282018215727;
        Mon, 16 Aug 2010 21:10:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i25sm11485152anh.37.2010.08.16.21.10.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 21:10:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikKB6dLF9RVPt7s9KyVdafvOY-i3z+VCMbEwF=m@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153694>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Aug 17, 2010 at 03:37, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>>> +++ b/compat/regex/mbsupport.h
>>> @@ -0,0 +1,59 @@
>>> +/*
>>> + * mbsupport.h --- Localize determination of whether we have multi=
byte stuff.
>>> + */
>>> +
>>> +/*
>>> + * Copyright (C) 2004, 2005 the Free Software Foundation, Inc.
>>> + *
>>> + * This file is part of GAWK, the GNU implementation of the
>>> + * AWK Programming Language.
>>> + *
>>> + * GAWK is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as publish=
ed by
>>> + * the Free Software Foundation; either version 3 of the License, =
or
>>> + * (at your option) any later version.
>>
>> Worrisome. =C2=A0(Most of git is still GPL-2 only, which would not b=
e
>> compatible.)
>
> Actually it's LGPL-2.1 (all the copyright headers in the *.[ch] files
> agree), I just copied the wrong license.

Thanks for checking.  That=E2=80=99s good to hear.
