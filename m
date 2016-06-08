From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Tue, 7 Jun 2016 21:51:42 -0400
Message-ID: <CAPig+cSsgmu6dHDrqHybKMJiQ9bi29TqnJWq78=1r+pLyDR1kw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com> <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 03:51:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bASeq-0003bv-Dw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 03:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbcFHBvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 21:51:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33295 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbcFHBvn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 21:51:43 -0400
Received: by mail-it0-f67.google.com with SMTP id u203so16210032itc.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MGwuoBzA4cr365FyOj/UB6qmsktSU5WNYxh1DY9qKaQ=;
        b=ORat3cT4U8Thjghgc9FeCpg6BlTFAfHLbiynMgWoRJkT1PdYozeJ52nM3r5sumXIRJ
         FNsdluh2LWmixTVx0iq1JSrV9kX6sKayf1AIXUd6KUINPuclGo9YHld55/MU4P9qp/Q4
         Zborl6vI2dFYkkmzN/6ynVRWkjve3/QGEgHkN6q+0/jLzna6PQxV+8lBIjvKxJZd2Kf6
         BD5s0gV5t5P6SpESRN7bNfQeRFXY65QZnz9kgDxsdtr7GiCdCenVFGdQMUIGf6SaEsIc
         7yjeh1BvzTxGjYhqaFyJ1NtaFvu2fpxcNelE9A7IBY7IcoUdXGJvwXn5xBcphMDORxql
         szvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MGwuoBzA4cr365FyOj/UB6qmsktSU5WNYxh1DY9qKaQ=;
        b=UQ11yF0M2+85ATU3dho0JQmqlJf2XxTPjFCBRZ+JhPEeyvdrdnFJCRM4GuyTVQJdkq
         gWnINXdXYn3dvIXpqAS5YO/E/nCs3maK7hTgH2jduC7xuYye6ZJUQGDRTMov+gSPVE/A
         XfgW58A4xKvyHIIbkw/m6AdDbnvhHwbq/PSKzNmWw9HB0FZzW1Inn90KwmiTnQAu5Brb
         F8ebOauTmzJkcgFSogZ8ITFFG5iCZeqPnljEyBSTarRO48s3ROrujPULTFvuirkPvvcA
         FwBr28QjjSGsHXBBFA2UHoJu5KlOBF5Oyb7tE72yKu3OYtrCMLGunq4DI2Qcm7jTGsKW
         mswg==
X-Gm-Message-State: ALyK8tK0hxH8DrDimX0krpEmBYv5HA5O/3uKRSFXylWa2P5JRAnSZZJAnf81ZLbRIuJDfXjJI3tmUizTK4fMQw==
X-Received: by 10.36.112.81 with SMTP id f78mr4619609itc.32.1465350702661;
 Tue, 07 Jun 2016 18:51:42 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 7 Jun 2016 18:51:42 -0700 (PDT)
In-Reply-To: <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
X-Google-Sender-Auth: MuvNrpZtuhPpLWfe20cKMBqRVe8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296755>

On Tue, Jun 7, 2016 at 6:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> +int bisect_clean_state(void)
>> +{

I forgot to mention that this and other functions should be 'static'.

>> +       int result = 0;
>> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
