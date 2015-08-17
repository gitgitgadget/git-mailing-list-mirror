From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Add a config option push.gpgSign for default signed pushes
Date: Mon, 17 Aug 2015 12:47:25 -0700
Message-ID: <xmqqfv3hd7ea.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<1439492451-11233-8-git-send-email-dborowitz@google.com>
	<xmqqy4h9et2m.fsf@gitster.dls.corp.google.com>
	<CAD0k6qTnJPc+Nh6dck0_Zx9vnyn5YVMCmy3E=7vr8bTpRSppAA@mail.gmail.com>
	<xmqqk2std7lt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:47:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQNY-0006A9-6X
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbbHQTr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:47:28 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35557 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbHQTr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:47:27 -0400
Received: by pacgr6 with SMTP id gr6so114886038pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hJWB7Ocf49Z3kx9+qTXnyCrauNDQsUVNpbcGJye0r3w=;
        b=BO0J3Y1bNbF99GPPKlT1j4YFQkRZDrdfxVC7u29j9HF+T0Sb/BMEi4XhktoqS7ksD/
         rGoPNmqz+VlAFV0iBs+IKQ1q/CWHkoH77yJFM3bZNMvSy9Q6Ig06Qfb3B/D3GVmYsQBU
         5v0pkle9D7NiPesWTU7A7h+pgOalad+z6lwzOJhcgNVg/eXn1x29yfS4kdOMcj+Z/x86
         a7/hnvMLwVfa64ndowYHRO2K+XFLsIXJqV2KkTCqgazm/59NuyLq4Eq1WFqxDKWsnjz2
         XtPesRKyKNLE5mA69cF8hbT/s6JglPCo5o6hJFaCyp+5xJ2oG2+Ks9fC1SAE0tvyJvK9
         lxdQ==
X-Received: by 10.66.55.105 with SMTP id r9mr5669867pap.143.1439840846897;
        Mon, 17 Aug 2015 12:47:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id ns3sm15509559pbc.77.2015.08.17.12.47.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:47:26 -0700 (PDT)
In-Reply-To: <xmqqk2std7lt.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 17 Aug 2015 12:42:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276083>

Junio C Hamano <gitster@pobox.com> writes:

> Dave Borowitz <dborowitz@google.com> writes:
>
>> The issue is that if both _ALWAYS and _IF_POSSIBLE are set,
>> git_transport_push interprets it as _ALWAYS. But, we are also supposed
>> to prefer explicit command-line options to config values.
>>
>> Suppose we parsed config first, then options. If the user has
>> push.signed = always and and passes --signed-if-possible, then the end
>> result is (_ALWAYS | _IF_POSSIBLE), aka always,...
>
> Doesn't that merely suggest that the option parsing is implemented
> incorrectly?  Why is --signed-if-possible just ORing its bits into
> the flag, instead of clearing and setting?

That is, "git config alias.myp push --sign=if-asked" followed by

    $ git myp --sign=no

would internally expand to

    $ git push --sign=if-asked --sign=no

and the result should follow the usual "last one wins" rule.
