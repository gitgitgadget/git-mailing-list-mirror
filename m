From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Raw gpg output support for verify-commit and verify-tag
Date: Sun, 14 Jun 2015 14:23:47 -0700
Message-ID: <xmqqd20ym1b0.fsf@gitster.dls.corp.google.com>
References: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Jun 14 23:24:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4FNs-00079w-W6
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 23:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbbFNVXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 17:23:51 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36429 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbbFNVXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 17:23:50 -0400
Received: by igbiq7 with SMTP id iq7so5872582igb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cD0JqS1baOlUmBtzSBhCNCGeFA9oB/LtWt81r6H0fOc=;
        b=bgofrVKw2eX9QWfHrRygg4FfNxH4771J2p31ZkJPmFwSH3mqO/JMfUg4Y0m09MvW5W
         hLK+ZroSAfQdziGNAbUTZb6pT4zf1bzwAeK8ijTCNCHEeLf2hPD4JbJnBmkB9t7YepKZ
         KDTirIuISa5sZLEFS/rrzdVf9Xndpd+QbdljB3PuiGTKx0NTCdFFgUkywOyfkX10Y2G+
         znWFXk5btrc/Ilj763/AzRtBvNSaO86K1sYSXVGUAgJ5raUnmQ8f/8h7TlYXMEhKu6MU
         GdEbQgTEYMCZ6roCyM/dBHl4XYlhsBm8Wsp970n38S/3EwrOnw1z1p1u4wmZkHVok7Z8
         baQg==
X-Received: by 10.50.129.40 with SMTP id nt8mr16624246igb.24.1434317029859;
        Sun, 14 Jun 2015 14:23:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8cf8:478e:8162:753f])
        by mx.google.com with ESMTPSA id f126sm7439009ioe.21.2015.06.14.14.23.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jun 2015 14:23:49 -0700 (PDT)
In-Reply-To: <1434307910-705555-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 14 Jun 2015 18:51:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271650>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Currently, verify-commit and verify-tag produce human-readable output.
> This is great for humans, and awful for machines.  It also lacks a lot
> of the information that GnuPG's --status-fd output provides.
>
> For example, if you wanted to know
> * the hash algorithm;
> * whether the signature was made with a subkey; or
> * the OpenPGP signature version
> none of that information is available in the human-readable output.

What this series wants to achieve makes a lot of sense to me.  One
comment I have after skimming the patfches is that I want the new
"raw" bit added not as a yet another parameter after "verbose", but
by turning the existing "verbose" into an "unsigned flag" flag word
(with "#define GPG_VERIFY_VERBOSE 01") and then defining use of a
new bit in the same flag word "#define GPG_VERIFY_RAW 01" or
something.  That way, over time other people add differnt things to
the interface, we would not have to end up with 47 different
parameters each of which signals a single bit.

Thanks.
