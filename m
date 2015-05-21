From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Occasional wrong behavior of rev-walking (rev-list, log, etc.)
Date: Thu, 21 May 2015 15:59:48 -0700
Message-ID: <CAPc5daVnrjdjoiq8-H7vs2WAre+Kt7J5re_kZ2YD9tF8dG8UUw@mail.gmail.com>
References: <20150521061553.GA29269@glandium.org> <xmqq617llw6k.fsf@gitster.dls.corp.google.com>
 <20150521224956.GA23810@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri May 22 01:00:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvZRn-0008BR-0m
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 01:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbbEUXAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 19:00:10 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35683 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755185AbbEUXAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 19:00:09 -0400
Received: by oihd6 with SMTP id d6so1603609oih.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1iuiFl8bqvqaQQnb+VFlEMV+FT+2VUww4s+gh6Ha3Bc=;
        b=t17OuYD8yYC7TFbKNClxZX01SWAVw+lyCboylsVHSAyD89ylb1FohGMICKG9CTUP1E
         g8dWmByBIQSssFRUlj/jWN+A/Tk1xOsN2r4bWyjjOKeC20BSL842OGYA79Vro+I+NdDk
         cREjTVaPxg4leD+BBYzrAhy5bcFUistqjjRuCp4x1jKjqwUQbVAyWiQByTajueaauAZD
         5A5s2LgadvVNBddSsDpMbt9QW0Uj6P4uXSiMCbZWks7/KpP1WgoXxABxuDHo7J7pHc0S
         N90oLnB6d52o+H/3xfiE1a767WR4ZGe4V5h2h1L7wCN53CbFXn22gK3wbbIH+8JoTZZg
         HgYg==
X-Received: by 10.182.29.101 with SMTP id j5mr4358457obh.0.1432249208497; Thu,
 21 May 2015 16:00:08 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Thu, 21 May 2015 15:59:48 -0700 (PDT)
In-Reply-To: <20150521224956.GA23810@glandium.org>
X-Google-Sender-Auth: mSevWVF-a5LEAiKkiWucmh3fF5s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269673>

Depends on why you are running rev-list.

If you want to know if one commit is contained in another, the way
that should work the most reliably is to use merge-base, as the
traversal engine of that command was written not to trust the commit
timestamps but go with the topology alone.

(pardon top-posting and overlong lines; typed in GMail)


On Thu, May 21, 2015 at 3:49 PM, Mike Hommey <mh@glandium.org> wrote:
> On Thu, May 21, 2015 at 09:41:55AM -0700, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>>
>> > My guess is that rev-walking is tripping on the fact that this repository
>> > has commit dates in random order.
>>
>> Yeah, that is well known (look for SLOP both in the code and list
>> archive).
>
> I found the recent thread about git describe --contains. (and now I
> realize this is also why git describe --contains doesn't work quite well
> for the same repository).
>
> Now the question is what can we done in the short term? (short of
> introducing something like generation numbers) I tried increasing
> SLOP and to remove the date check (with the hope that making one or
> both configurable might help). Neither fixed the particular test
> case I started this thread with.
>
> Mike
