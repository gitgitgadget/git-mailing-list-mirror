From: Nikolaj Shurkaev <snnicky@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 12:21:13 +0300
Message-ID: <4F475689.4040203@gmail.com>
References: <4F46036F.3040406@gmail.com> <20120223102426.GB2912@sigill.intra.peff.net> <4F462E61.4020203@gmail.com> <m34nuhelnf.fsf@localhost.localdomain> <4F4643BB.8090001@gmail.com> <20120223193451.GB30132@sigill.intra.peff.net> <7vy5rt2u0c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 10:21:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rLF-0001wD-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 10:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab2BXJVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 04:21:21 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:51280 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552Ab2BXJVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 04:21:19 -0500
Received: by werb13 with SMTP id b13so1298154wer.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 01:21:18 -0800 (PST)
Received-SPF: pass (google.com: domain of snnicky@gmail.com designates 10.180.79.229 as permitted sender) client-ip=10.180.79.229;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of snnicky@gmail.com designates 10.180.79.229 as permitted sender) smtp.mail=snnicky@gmail.com; dkim=pass header.i=snnicky@gmail.com
Received: from mr.google.com ([10.180.79.229])
        by 10.180.79.229 with SMTP id m5mr3125298wix.6.1330075278402 (num_hops = 1);
        Fri, 24 Feb 2012 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fbbgna5fT0dkaXJ7VBwdXFmshNqqsiAyZx5bygju4nE=;
        b=TiZBq32LqY6yJwlLJYtADAEewJ3X8oXekyMiEwWuDn/wuemgu1aURj7iZ09lnA6a5r
         vibuAR01sVhE7f4fxZzTDaFh8NtGutFYVgGsPWFH605NM+MZT9t4RttA8SsuJ1H3uBlf
         sCAA526g6gf06li6ISqI9PExUeOWf1OoV2ilw=
Received: by 10.180.79.229 with SMTP id m5mr2501777wix.6.1330075278271;
        Fri, 24 Feb 2012 01:21:18 -0800 (PST)
Received: from [192.168.1.130] ([80.249.81.45])
        by mx.google.com with ESMTPS id d7sm5803441wiz.6.2012.02.24.01.21.15
        (version=SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 01:21:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vy5rt2u0c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191418>

Hello.

Thank you for the hint.

git format-patch HEAD~3..HEAD -- SomePath

does exactly what I need. But that way of usage is not described in git=
=20
documentation thus I thought there is no way to do that. I've just=20
double checked

git format-patch --help

doesn't describe that. I'll propose to put something like this into git=
=20
documentation
-----------------------------------------------------------------------=
---------------------
diff --git a/Documentation/git-format-patch.txt=20
b/Documentation/git-format-patch.txt
index 6ea9be7..63267c6 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -23,6 +23,7 @@ SYNOPSIS
[--cover-letter] [--quiet]
[<common diff options>]
[ <since> | <revision range> ]
+ [[\--] <path>...]

DESCRIPTION
-----------
@@ -219,6 +220,12 @@ you can use `--suffix=3D-patch` to get=20
`0001-description-of-my-change-patch`.
range are always formatted as creation patches, independently
of this flag.

+[\--] <path>...::
+ Put in patches only those modifications that affect specified files
+ and folders. It's important to understand that log message of the
+ commit may become inappropriate because some parts of patch may be
+ cut off.
+
CONFIGURATION
-------------
You can specify extra mail header lines to be added to each message,
-----------------------------------------------------------------------=
---------------------

--
Nikolaj.

23.02.2012 23:07, Junio C Hamano =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Jeff King<peff@peff.net>  writes:
>
>> On Thu, Feb 23, 2012 at 04:48:43PM +0300, Nikolaj Shurkaev wrote:
>>
>> Doesn't:
>>
>>    git format-patch HEAD~3..HEAD SomePath
>>
>> do what you want? It is certainly designed to, and it seems to work =
for
>> me.
> It is not quite "designed to", though.
>
> It happens to work that way, and I do not think we want to forbid its=
 use,
> but we would want to discourage anybody from blindly using it without
> thinking if the end results suits his/her purpose (and the reason sho=
uld
> be obvious to those who think, the hint is "log message").
>
