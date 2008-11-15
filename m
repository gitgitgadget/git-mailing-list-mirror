From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Sat, 15 Nov 2008 01:09:01 +0100
Message-ID: <4ac8254d0811141609k66b7bd6et8a09a64c11ad38f4@mail.gmail.com>
References: <1226028387-23867-1-git-send-email-tuncer.ayaz@gmail.com>
	 <4ac8254d0811101543q612917b5ib83e7e657d17ef3c@mail.gmail.com>
	 <7vy6zon02o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 01:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L18kA-0000Tj-7z
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 01:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbYKOAJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbYKOAJF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 19:09:05 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:39406 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbYKOAJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 19:09:03 -0500
Received: by yw-out-2324.google.com with SMTP id 9so733436ywe.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 16:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IH2fVHbWbg105kA8Ckd2uO/QPOsmQl/Bzss+FPPcO98=;
        b=hC2+rOmK3iwbTsV+oKiMHWI30ymVLdqlJd3WCkqhzCrkgPBQ+hn1jL3RBLPEcAsfk0
         GNrVKHLtcOVsV4TL86kV5fBC9JiAVI4ljEB8JT/CJdOScZdwjuk1v+pbgGkf+dHUg4tq
         xdB+pFNwuWuiynEcEurCGC17IRMTgjbo9m4EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JpcZquL+B2+eQ41YxWB0JuER/xI3uyFJ2hp5lfxhxFjgXN4w6LH5I5lt6bErTx3/gM
         lX6m/bnYB3sNOpmA3L0B9X5Gih8uNw/M+LBjsRsydmMWqQXnyHNdcvQgjDUrMaHNWqM2
         Vk701yFK31kCOvsapo1g1XTztG9Ix4rAsPq7U=
Received: by 10.65.53.19 with SMTP id f19mr1550460qbk.31.1226707742068;
        Fri, 14 Nov 2008 16:09:02 -0800 (PST)
Received: by 10.65.231.17 with HTTP; Fri, 14 Nov 2008 16:09:01 -0800 (PST)
In-Reply-To: <7vy6zon02o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101037>

On Wed, Nov 12, 2008 at 9:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> On Fri, Nov 7, 2008 at 4:26 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
>>> Implement git-pull --quiet and git-pull --verbose by
>>> adding the options to git-pull and fixing verbosity
>>> handling in git-fetch.
>>
>> Junio,
>>
>> is there anything still missing in this patch?
>> Maybe the name of the test-case is bad.
>
> It seems to break t7600.

thanks for the good review, it sure does break.

I hadn't noticed it as I didn't compare test results
of master against my branch and assumed that that
breakage is part of common failing tests.

Shawn helped me out a little bit with debugging the test scripts
and I quickly found out that an if clause is wrong.
the diff for the last patch to correct it is:
 --- a/builtin-merge.c
 +++ b/builtin-merge.c
 @@ -50,6 +50,7 @@ static unsigned char head[20], stash[20];
@@ -163,7 +144,7 @@

        argc = parse_options(argc, argv, builtin_merge_options,
                        builtin_merge_usage, 0);
-+      if (verbosity > QUIET)
++      if (verbosity == QUIET)
 +              show_diffstat = 0;


a corrected patch will arrive here in a minute.
