From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri, 8 May 2015 13:17:58 -0700
Message-ID: <CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
 <1431108819-6831-2-git-send-email-dturner@twopensource.com> <CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:18:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqoj3-000409-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbbEHUSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:18:21 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34226 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932199AbbEHUST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:18:19 -0400
Received: by qkgx75 with SMTP id x75so55775779qkg.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LClOe9uS1vhUK3Gch3sBNrj03RPNm3CfDpIuhO5+3nk=;
        b=GLK7JFvP53zEmKQnuwZf2DVlAZMOMUVwDS7xiq9H2dT5HRtoZ74ymASHQczCtbP2uD
         fZjOi6LiqcO6uVZSjlir3hC1kH8x4LWnQmSuedxptc+n5aqx7Ww//6MMupzYrgYvTvId
         tVn46n1pVNUuzGTI/HNSAWrNkamQSSPOGIJYRKcVqPFIsGOYHgz5PfOz6KvHVp1CxXwv
         H5ditwa/H+5pC8yzrJ/cX4gKTMAAs4xr4vOsbHaimhiOl+R6Kr71gmlXom5XuovYrLUj
         mrbkGNyN1Q+lHNqwf5A9tgXZZP+tU7tuldxYTNMOdUkS5dVM6CcbKMlbP0owxwQXyYDp
         DMZA==
X-Received: by 10.55.31.167 with SMTP id n39mr11797198qkh.59.1431116299028;
 Fri, 08 May 2015 13:18:19 -0700 (PDT)
Received: by 10.140.179.22 with HTTP; Fri, 8 May 2015 13:17:58 -0700 (PDT)
In-Reply-To: <CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com>
X-Google-Sender-Auth: DYHrGYSjzrzVmv-LgaLETDvcoLI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268658>

On Fri, May 8, 2015 at 12:45 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +       if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
>> +               die(_("internal error: bad flags for get_sha1_with_context"));
>
> There may not be much value in marking an "internal error" string for
> translation.

The whole point of this kind of messages is so that the end users,
when they see it trigger, can notify us and then to allow us to
identify which die() triggered.  It is not just "may not be much
value in", but is actively unproductive to make it translatable,
even if we ignore the cost to i18n/l10n teams to translate such
messages.

By the way, we would want to standardise the string before the
colon, so that we can tell users "If you see an error message that
begins with 'internal error:', please report that to us---it is a
programming error".  I think the majority of existing code uses the
string "BUG:" for that, and I do not mind using 'internal error:'
for that purpose instead, but the important thing is to use just one
single string thoughout the codebase, so that the "please report
when you see this" message we give the users can be simple.

Thanks.
