From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] remote-helpers: tests: use python directly
Date: Fri, 17 May 2013 22:04:49 -0500
Message-ID: <CAMP44s1w98hDbJx10PFDnS3YeYhFAHDyw=O2LdwCendLG6DVQQ@mail.gmail.com>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
	<1368825008-2815-2-git-send-email-felipe.contreras@gmail.com>
	<7vwqqxujby.fsf@alter.siamese.dyndns.org>
	<CAJDDKr6Qnx5ddBn=6reNOY44CxaDgD254H7M3K2mb8bbd8jpmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:05:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXT1-00028J-Hl
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758892Ab3ERDEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:04:52 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35404 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758733Ab3ERDEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:04:51 -0400
Received: by mail-la0-f43.google.com with SMTP id ez20so3676504lab.2
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mx3iTZpAHw7tRF1YkNYTfJ9zmLDGc4cWLm6WMBGW4kY=;
        b=Ja3VxRy1jxVeawl45/2Lbdrgl+YsLNiZqhoGNrLj7UzcbcsfU0SL5GvGIuXQfTZtgE
         IlUF4F6lh9ix9UZEwiWfhCYQL/hlKZxMNx6G7eYzhWtHUU9B6VEZvaFI06gtpY/fMpGS
         n8ulHwKYu9BdiYtaiWnIF1cEumZgbnzZcEJGTSgRJJv4+ZGquWJytA4TVBM66BNrKjTF
         aSR3Hl4WdnDH+Or6EEjtcldSqhz/KhY/GKcux2wvzaR9h/F+0KEhBaZExb9YAtjWKrLQ
         FHmzfrvd2jYpSVT/wJgPusS5O3PGLRO7PJBw7vibzenqy4j2WQE//xw5PpiIQgHUvtjr
         UEig==
X-Received: by 10.152.120.4 with SMTP id ky4mr24233644lab.5.1368846289704;
 Fri, 17 May 2013 20:04:49 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 20:04:49 -0700 (PDT)
In-Reply-To: <CAJDDKr6Qnx5ddBn=6reNOY44CxaDgD254H7M3K2mb8bbd8jpmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224754>

On Fri, May 17, 2013 at 9:51 PM, David Aguilar <davvid@gmail.com> wrote:
> On Fri, May 17, 2013 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> These remote helpers use 'env python', not PYTHON_PATH, so that's where
>>> we should check for the extensions. Otherwise, if 'python' is not
>>> PYTHON_PATH (e.g. /usr/bin/python: Makefile's default), there will be a
>>> mismatch between the python libraries actually accessible to the remote
>>> helpers.
>>
>> What I am reading here is that what the "helper" uses and what the
>> "test" checks to see if it can use the "helper" were different; and
>> this patch fixes that misalignment by testing what the "helper"
>> actually uses.
>>
>> So it is a right thing to do in that sense.
>>
>> I however am having this nagging feeling that I may be missing
>> something subtle here.  Comments from others are very much welcome.
>
> Yes, this is correct.  Another way to skin this cat would be to do
> search/replace in a Makefile to burn in the PYTHON_PATH similar to how
> we do for the .sh scripts and other .py files in the main Makefile.
> The remote helpers are in contrib/ so they do not go through the main
> Makefile, which is the root cause.
>
> Longer-term, it would be good to treat these uniformly, but this is no
> worse for now.

Yeap, I initially thought it would be tricky to implement in the
rather minimal Makefile, but it seems it wouldn't. Whoever, I still
find it useful that I don't have to run 'make' to test these, and I
think it's nice that people can download directly as the final name
('git-remote-hg'), and don't have to rename. And since these aren't
installed with 'make install' anyway, I don't see any big hurry.

Cheers.

-- 
Felipe Contreras
