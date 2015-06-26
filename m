From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false positives
Date: Fri, 26 Jun 2015 09:16:20 -0700
Message-ID: <xmqq381ewiln.fsf@gitster.dls.corp.google.com>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
	<1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
	<1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
	<20150626131524.GA2626@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 18:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8WIn-0007vG-3k
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbbFZQQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:16:25 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33255 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbFZQQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:16:23 -0400
Received: by ieqy10 with SMTP id y10so79094998ieq.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 09:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5r2LpJy7s9+0GGT6iYC2aIK93kJMqlaVBBPHzmqzcO4=;
        b=iW4jSuu5WtrCh5sb4nsYAwXMkJPb3fvQCPFhBHNQFUXSvqcPiqXAjh4fpxrA/OrrPl
         fcMyk4Xsu7vhVaRTn1D1/aspdubhVF+Kn3GHcmjbCnR7q7V4OEbRTJDLWEt5nk2689EI
         muHdmKJrA4YW+aaVNxZQM9hM/lNbPDmndDwFQduZODkP67ebtWWWIQ34PzAsvyhWfpIe
         eI6JjjNICNIUwPkCqaQmbeiKZNPH/7MEq4UHNp833Vn3n2F+0oQOWV220xy/qaadYKzN
         eeLCkoC6pm/OvzZgImDsRru65Ro7ynINQx6KEseLZ/5xRzZqyT992Gj6nxcQQHhW3T1p
         8Cjg==
X-Received: by 10.50.108.102 with SMTP id hj6mr4490533igb.39.1435335383072;
        Fri, 26 Jun 2015 09:16:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id j3sm1145329ige.0.2015.06.26.09.16.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 09:16:22 -0700 (PDT)
In-Reply-To: <20150626131524.GA2626@peff.net> (Jeff King's message of "Fri, 26
	Jun 2015 09:15:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272785>

Jeff King <peff@peff.net> writes:

> On Sun, Apr 26, 2015 at 08:30:12PM +0000, brian m. carlson wrote:
>
>> Improve the check by looking for "plink" or "tortoiseplink" (or those
>> names suffixed with ".exe") only in the final component of the path.
>> This has the downside that a program such as "plink-0.63" would no
>> longer be recognized, but the increased robustness is likely worth it.
>> Add tests to cover these cases to avoid regressions.
>
> FYI, this ended up biting me today. We have some integration tests that
> make sure we can clone over putty, and we wrap plink in a
> "plink-wrapper.sh" script that tweaks a few extra options. That used to
> match under the old scheme, but not the new. It would also match if we
> looked for "plink" anywhere in the basename (but not in leading
> directories).

So this was a minor regression? ;-)

> I was able to work around it pretty easily by changing our test setup,
> but I thought I would include it here as a data point. It's probably not
> that representative of real-world users.

I'd imagine that "/usr/local/github/wrapped/bin/plink" may be a more
appropriate name to install that wrapper as than "plink-wrapper.sh",
but then people would need to think how to help that wrapper find
the real plink, so...
