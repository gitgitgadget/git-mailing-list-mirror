From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/11] dir: add new_untracked_cache()
Date: Thu, 24 Dec 2015 08:35:10 +0100
Message-ID: <CAP8UFD0phWoR3qf7wZ6vE0BmrPLQYRgqgRBn14jGPemgey7Nsg@mail.gmail.com>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
	<1450904639-25592-8-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cQoho_EAjvS2z5Wa3jV2zd_bMzdZRP5PFyruqB=cXGigw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 08:35:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aC0Qi-0005nn-C9
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 08:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128AbbLXHfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2015 02:35:14 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36598 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933090AbbLXHfM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2015 02:35:12 -0500
Received: by mail-lb0-f182.google.com with SMTP id oh2so57010540lbb.3
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 23:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Uaq8VgREqiYdkOUjjDnzEI+tX8wgAvpIoQx8dq8c5Ow=;
        b=J710ABy2CyjpQciDwNyQl6d4wmp9p/QWzCCeNItk1nKkb595ueAsi0bQgU8FSFFPMV
         AgMmlsNkYsI/Smm5G/fFGYuyJEf8egxUjgX9BRneXOsggvM7DhLoI7srA3dWnYriJBmn
         Y3/vmq2AUTfoBmIod43forha3EBGGTtTUhP4UtILb9EX6JwnvvVvxW8ZayS9WwhnIdP1
         SU1vrHoh5f70CuK+PxU/q4nk4/T7ejLN/JMQ3bNjeoBCxcXh7XA+a8TrhcFAICGm5Ed7
         JmheeLHowXnmYsLeRxReBAa8sP4pxuNzS7CNwb9opTXbVwuWa9EZqFKvD8RFZuwvM1cZ
         ptLg==
X-Received: by 10.112.190.67 with SMTP id go3mr5051224lbc.56.1450942510836;
 Wed, 23 Dec 2015 23:35:10 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Wed, 23 Dec 2015 23:35:10 -0800 (PST)
In-Reply-To: <CAPig+cQoho_EAjvS2z5Wa3jV2zd_bMzdZRP5PFyruqB=cXGigw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282972>

On Wed, Dec 23, 2015 at 11:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 23, 2015 at 4:03 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>     Factor out code into new_untracked_cache(), which will be used
>>     multiple times in a later commit.
>
> Odd indentation: s/^\s+//

Yeah, will fix.

>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/dir.c b/dir.c
>> @@ -1938,16 +1938,20 @@ void add_untracked_ident(struct untracked_cache *uc)
>>         strbuf_addch(&uc->ident, 0);
>>  }
>>
>> +static void new_untracked_cache(void)
>> +{
>> +       struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
>> +       strbuf_init(&uc->ident, 100);
>> +       uc->exclude_per_dir = ".gitignore";
>> +       /* should be the same flags used by git-status */
>> +       uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
>> +       the_index.untracked = uc;
>> +}
>
> This and the previous patch both move the same code around. As a
> reviewer, I could easily see the two patches combined, and would not
> find the unified patch onerous to review.

Ok, I will squash them.

By the way it looks like I have overlooked some reviews by David and
Tosten from the previous round.
Sorry about that. I will take them into account in the next version.
