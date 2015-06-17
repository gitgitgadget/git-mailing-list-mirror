From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should the --encoding argument to log/show commands make any guarantees about their output?
Date: Wed, 17 Jun 2015 09:42:17 -0700
Message-ID: <xmqqzj3y2snq.fsf@gitster.dls.corp.google.com>
References: <557E91D2.3000908@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jan-Philip Gehrcke <jgehrcke@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:42:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5GPx-0004bj-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbbFQQmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:42:21 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33834 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbbFQQmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:42:19 -0400
Received: by iebmu5 with SMTP id mu5so37697847ieb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZBFhSKnkWy57znMgC9U922p1IEG6KGsATphCWHhGVF4=;
        b=g2PfAgdvZrcRj29im8oGnuoLx1N5u9Kea/tYZo0nNVY1n6uMKshyua7nW277NLh0s4
         /cRr+jTMMLaMHzfSevqDg4otMqKXF8M5xDRwoR4vhP5AuQQ7Ij6lTn/1MKbM83IDKnD0
         wzEdocCLj0dTBgMOb5kXiCySDs/70XtL2qH1a7inq43IVdq4aEItNUZmODDDOa41ATmO
         7360Kzh+1Lvz7h1BM/BzNZLOIrLW/N73yIi4a+6AuNHH3zaHXGWQDdCJHR3rSeKYFn8u
         k5qbPdxWHQYC4Glafx2Syr4/N3EGsd6ox1MrL3//0O8hS9obTsOEOKs9vrpzxbG4Si+t
         5Cyg==
X-Received: by 10.43.139.6 with SMTP id iu6mr1202897icc.32.1434559339411;
        Wed, 17 Jun 2015 09:42:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id rr5sm3486854igb.7.2015.06.17.09.42.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 09:42:18 -0700 (PDT)
In-Reply-To: <557E91D2.3000908@googlemail.com> (Jan-Philip Gehrcke's message
	of "Mon, 15 Jun 2015 10:50:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271867>

Jan-Philip Gehrcke <jgehrcke@googlemail.com> writes:

> I was surprised to see that the output of
>
>     git log --encoding=utf-8 "--format=format:%b"
>
> can contain byte sequences that are invalid in UTF-8. Note: I am using
> git 2.1.4 and the %b format specifier represents the commit message
> body.

Yeah, if the original was bad and cannot be sanely expressed in
UTF-8, you have two options.  You can show the contents as raw bytes
recorded in the object with a warning so that the user can use it as
such (e.g. perhaps the original was indeed an iso8859-2 but was
incorrectly marked as UTF-8, or something like that, and a human
that is more intelligent than a tool _could_ guess and attempt to
recover).  Or you can error out and refuse to produce output.

We deliberately made a design choice to take the former option.
