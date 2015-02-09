From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/blame: destroy initialized commit_info only
Date: Mon, 9 Feb 2015 18:42:25 -0500
Message-ID: <CAPig+cQs-W=6K70LfsGPDnxRSQXfcQ5d0voc-KKd4BbeZOe9hA@mail.gmail.com>
References: <1423517287-8354-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cQAmYzzVF5+0j6AgcpEsi6SOVkXyqw4uOMCUjExPSLz_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Dilyan Palauzov <dilyan.palauzov@aegee.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 00:42:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKxyI-0003q4-UU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 00:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbbBIXm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 18:42:27 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:47372 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287AbbBIXm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 18:42:26 -0500
Received: by mail-yh0-f49.google.com with SMTP id v1so13498214yhn.8
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4YuW77kb/J8tYG7+TBmsGNjeXJ8ajaBjszas1j5sh5U=;
        b=gsoIWw1EveOMFdrw5yuUHo6EXvnd+YDy10OEc3Ygnbbjakmel5tcVqu+ST1F/YILDw
         PPUb74t2ImDmmLiYhLJCTGF9tgFq5D7h3BnxUUW9HOi9uDd3n4U8V9goxiFlTlQYwamC
         BxqafClM2K+4x2/q80mBLkt5GmuaYQfYp2yi7aenbfBZjF0ynicb9LLHKDCA25NLkVs1
         p6aT8jG0XAifWT8FPNCg9W5a0UzbBv1T2drcU/jyAs6FRiXKYPY3mNNUld4f6fz8g7xU
         r49vlag2WL2fnAQcNx4ywqNHkmlq0J4IqOZQkLfiZzTrOCB0IYCrc4jJrK+vw39nWjvj
         s2IQ==
X-Received: by 10.236.63.6 with SMTP id z6mr7480148yhc.65.1423525345972; Mon,
 09 Feb 2015 15:42:25 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 9 Feb 2015 15:42:25 -0800 (PST)
In-Reply-To: <CAPig+cQAmYzzVF5+0j6AgcpEsi6SOVkXyqw4uOMCUjExPSLz_w@mail.gmail.com>
X-Google-Sender-Auth: JU2LBm1AICu8RC_uT7ixVFkm-xo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263618>

On Mon, Feb 9, 2015 at 4:33 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 9, 2015 at 4:28 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Since ea02ffa3 (mailmap: simplify map_user() interface, 2013-01-05),
>> find_alignment() has been invoking commit_info_destroy() on an
>> uninitialized auto 'struct commit_info' (when METAINFO_SHOWN is not
>> set). commit_info_destroy() calls strbuf_release() for each of
>
> s/each of/each/
>
> ...despite several proof-reads (sigh).
>
>> 'commit_info' strbuf member, which randomly invokes free() on whatever
>> random stack value happens to be reside in strbuf.buf, thus leading to

s/to be/to/

(sigh again)

>> periodic crashes.
>>
>> Reported-by: Dilyan Palauzov <dilyan.palauzov@aegee.org>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
