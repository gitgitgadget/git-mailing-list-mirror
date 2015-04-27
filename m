From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Mon, 27 Apr 2015 14:38:15 -0400
Message-ID: <CAPig+cTcAq_p3QXqcG+o1saWZyvDHCW=_JWYn6s7B1L4X5X1cQ@mail.gmail.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
	<20150419002807.GA11634@hashpling.org>
	<xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
	<20150420074433.GA30422@hashpling.org>
	<8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
	<20150420091920.GA31279@hashpling.org>
	<553520CF.6070304@gmail.com>
	<20150421101641.GA13202@hashpling.org>
	<CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com>
	<xmqqh9s9gqw9.fsf@gitster.dls.corp.google.com>
	<553B78E2.5070608@gmail.com>
	<xmqqsiboyw90.fsf@gitster.dls.corp.google.com>
	<553E2427.4090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:38:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmnvC-0002B6-2K
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbbD0SiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:38:17 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34615 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbbD0SiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:38:16 -0400
Received: by iget9 with SMTP id t9so74087047ige.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aYOHeBSjCS7oKMV0Y5edkByUDibLE8m3ixrvFdHMWLY=;
        b=r7S2dSO4zE7Sl/NJVbMRirEZ/uLYTN6BT8uLVvDuolcRPgkMXQCe+Ayk3l6Pb+tck5
         ONyfFTTEDD0W4Yz84G83ZZfMW4860Gi23moD2s6fuCfz1vrWlcY3/LE9qli+cNxJXQGv
         X2fNO/rC7BpIDX59HoZo/2+SAUPGCgb8W4Ata7Qn4sZXKBFoeqJLpppJIVvHFESs1LDK
         MJ60jsHyOfW/8o9dri5dXi5fCWMMZwggt6qEc6cyT2kU6QoaL1CZxsiLm+MADk9wKU50
         DMwB/PSggqRPJi5bmZphuTreaZBMBzkWZfB5STtC4wT5s6WFdnVDIqm7JAuA05HVAYmR
         KESQ==
X-Received: by 10.107.3.199 with SMTP id e68mr15173877ioi.92.1430159895948;
 Mon, 27 Apr 2015 11:38:15 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 27 Apr 2015 11:38:15 -0700 (PDT)
In-Reply-To: <553E2427.4090700@gmail.com>
X-Google-Sender-Auth: Yx5Zse8BVIt8O96gpCo1PjT2EQo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267867>

On Mon, Apr 27, 2015 at 7:57 AM, karthik nayak <karthik.188@gmail.com> wrote:
> On 04/25/2015 10:34 PM, Junio C Hamano wrote:
>> karthik nayak <karthik.188@gmail.com> writes:
>> > Yes this gives the best description, but its large, while we could use
>> > something like --no-strict instead.
>>
>> We could, if you answered my first question with "no".
>>
>> By naming this "--no-strict", the first bug report you will receive
>> may be that "cat-file --no-strict" should parse a zlib deflate that
>> begins with "blob 1234\n\0" (notice that there are two SPs instead
>> of the usual one, and length is followed by LF that should not be
>> there before the NUL) but it does not.
>>
>> As your option name "--no-strict" signals that you will make the
>> best effort to parse such nonsense, that would be a valid bug
>> report, against which you would need to update the code to make it
>> work.  But is it worth the effort to make such a thing work?  I
>> dunno.
>>
> Nice point, I don't see the need to parse such objects at the moment.
> That rules out "--no-strict" and everything similar.
>
> I still find "--allow-unkown-type" a bit too big, what about something like
>
> * --any-type
> * --arbitrary-type

As a diagnostic aid when encountering a (hopefully rare) broken or
corrupt object, this option is not likely to be used often. The
"allow" in --allow-unknown-type conveys the intended purpose more
accurately than either of the shorter names suggested above; and
considering how infrequently it is likely to be used, the extra six
characters should not be a significant burden.
