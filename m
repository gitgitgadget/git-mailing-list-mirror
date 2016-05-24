From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] builtin/commit.c: memoize git-path for COMMIT_EDITMSG
Date: Tue, 24 May 2016 12:05:48 +0530
Message-ID: <CAFZEwPN26xyrb1EGrNebW5ybn0OY066+dszvuzLJ54opToz5qg@mail.gmail.com>
References: <1464027390-1512-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7feka8kk.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPN3L5Y-7wNj6TMjg-jPb_oDQYjukBj1uL6OJ8rWAoqjcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 08:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b55wY-0004r1-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 08:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbcEXGfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 02:35:50 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34164 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcEXGft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 02:35:49 -0400
Received: by mail-yw0-f194.google.com with SMTP id j74so1044280ywg.1
        for <git@vger.kernel.org>; Mon, 23 May 2016 23:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=vT+mMKcQr3j/pUH5xSEoxQOVD4FEDBkDTUKn0hpbVFE=;
        b=CabCqowh4Kso+wLfdrsk46cqT93B5dh8yg4SgHuDZRJJJ1YeHhaVXbPhjEqKHNsD8L
         iIR+EgDyzaRacQYWyICSOu7SNSHVGom9BOoSXa4ZmpvibeQgXseUXI6MZwcnr5bePHvE
         jhV5mFf0Nnfrf6R/y8xZw9BNLjFKN8fKZ/dsy3gW8V9dUQ7ZLPSF7HzJmghBZscjwtQH
         3mMAWci/jVlaz6+FZTlF8Jlm0Q45hIesyAExupzIK3WMNA4pmo1Tq79FfYyqY7OTWycw
         Zc9qX6+hPa+wmqX30wxYFzpPnBX+6FMlXSeq4AoHIS0at0HStspbKopHfqyaZ+zEudiH
         ydbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=vT+mMKcQr3j/pUH5xSEoxQOVD4FEDBkDTUKn0hpbVFE=;
        b=kgIfYB7H7HHV4bmDMvwb+2PyhmEybHv+iQ6CGcZ6sW+CPp+ubo0u8LokzvFx2gLGxN
         NUJG6rf5p0JaUJJTECEl6T+VAjlB2zikUSgbLP+guH56mpo+MwHO0cqf38A22yzNYT7w
         yKK1N4/nGPPuhzRy7LFEqCxQ/gEA+rENUCLkvuC9kfKnou+2NMg9xklPQQ2NJvQVySGt
         1KqgaEHVP0Yi+x9W2pdIcRjklpHJkU5O3feyqA/RAtSQDB0Nu8EM5uOqXs0q5vTmxGzS
         aaASmVVjJ1FFrfJ5d0/SR3GNocsEUaJF9kzbzho3xILJ949Due3RwTcAEiQFmfZ6WjgN
         wi5Q==
X-Gm-Message-State: ALyK8tJzDkJGTVwCAYRMgpHqKAsc859GfkClZDo+fjt9laXTrizEZihL1OsK6k091EZ18vwH2luDDmwOCy9xVA==
X-Received: by 10.129.134.133 with SMTP id w127mr1449461ywf.252.1464071748654;
 Mon, 23 May 2016 23:35:48 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 23 May 2016 23:35:48 -0700 (PDT)
In-Reply-To: <CAFZEwPN3L5Y-7wNj6TMjg-jPb_oDQYjukBj1uL6OJ8rWAoqjcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295419>

Hey Junio

On Tue, May 24, 2016 at 11:24 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> And you do not free its return value.
> This is one of the thing that bugging me with GIT_PATH_FUNC. Wouldn't
> not freeing the memory lead to memory leaks?

Slight misunderstanding. I got it now. Thanks!

> Regards,
> Pranit Bauva
