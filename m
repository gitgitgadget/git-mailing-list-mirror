From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 4 Mar 2014 20:00:44 -0500
Message-ID: <CAPig+cRqyG_JXSO-DsdP0mAjfmgS+FUCxLz+0+rHeUXrjmcjJg@mail.gmail.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<CAPig+cTzOxn5t0JOwxQyVrU___QPAQvwHR-zqFccaEQw+mYUCA@mail.gmail.com>
	<20140305003721.GA11509@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 02:00:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL0CZ-00063s-9c
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 02:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbaCEBAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 20:00:46 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:61152 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbaCEBAp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 20:00:45 -0500
Received: by mail-yk0-f174.google.com with SMTP id 20so918947yks.5
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 17:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BHD/PfqYO4gBexfQHRq0zEF2+J5krKUubu8PvpfUGww=;
        b=LmA0KC+JD9yzqLd5vwxnGs6h74Zm6dezUUo9q/s9nmUvZbH4TEV/qpw/VQAa6Bkxuy
         iOw8E3Pi86WnGe+OaiFG5oh8hWPeMAlROJgSODoJ3Th/0eMCOvoePXhUYV5sfJmkoHy3
         txYCjSaDCRO45OJ1FJqDN/qd5GVIDOi5addjWmQI2omUB1gGrFpU8p3lP2iSXmDmmfzv
         XU5OP0Rm0ZId2qaqET700OYwoBDJcL3KQIz3g+twQVTwnBjHZcjJq7KINmgaNAxvWLFA
         C83x/kRoWFpfeHtfTsG4pkSzcFiNRK8Qj0hMsx4uq29igbbtOnAh89sEwkGx9T4ruKsl
         qQYw==
X-Received: by 10.236.50.194 with SMTP id z42mr8716yhb.145.1393981244389; Tue,
 04 Mar 2014 17:00:44 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 17:00:44 -0800 (PST)
In-Reply-To: <20140305003721.GA11509@sigill.intra.peff.net>
X-Google-Sender-Auth: 0LvynEmI_wi9abs3Kr92Wrgpj1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243411>

On Tue, Mar 4, 2014 at 7:37 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 04, 2014 at 06:36:07PM -0500, Eric Sunshine wrote:
>
>> On Tue, Mar 4, 2014 at 12:48 PM, Jeff King <peff@peff.net> wrote:
>> > diff --git a/commit.c b/commit.c
>> > index 6bf4fe0..886dbfe 100644
>> > --- a/commit.c
>> > +++ b/commit.c
>> > @@ -114,6 +114,11 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
>> >  static struct commit_graft **commit_graft;
>> >  static int commit_graft_alloc, commit_graft_nr;
>> >
>> > +int commit_grafts_loaded(void)
>> > +{
>> > +       return !!commit_graft_nr;
>> > +}
>>
>> Did you mean !!commit_graft ?
>
> Shouldn't they produce the same results?

Yes they should, but the use of !! seemed to imply that you wanted to
apply it to the pointer value. (If you indeed intended to use
commit_graft_nr, then 'return commit_graft_nr', without !!, would have
been sufficient and idiomatic C.)
