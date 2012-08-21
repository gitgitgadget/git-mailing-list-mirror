From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/7] Fix tests under GETTEXT_POISON on pack-object
Date: Tue, 21 Aug 2012 17:39:12 +0700
Message-ID: <CACsJy8DHdj61sH8DjLsUfKdb4yzbnACWdCsgmFDtjJqq08c2TQ@mail.gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
 <1345523464-14586-6-git-send-email-pclouds@gmail.com> <20120821051706.GA55686@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 12:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3lsD-00076r-Py
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 12:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423Ab2HUKjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 06:39:45 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:35845 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab2HUKjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 06:39:43 -0400
Received: by ggdk6 with SMTP id k6so5681051ggd.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UWzn7FKNKumkUW6faG8JWJhryAvtkmMnzpZufakXxEY=;
        b=mBUkHS3Rtomrc1cguNxqZUf3p1dbrmC9o5LbLqQQqNrhEQYDvKNnwCP1ksjymTVnkP
         hmqeKTQTIcjsuvT6sgETj1PSw8PDA0Z5kJyOx1y7t5BIrIP68DS3daSFD0psaRTyznzr
         hPLBlYFvaUIam6l5qbrdb5XZViMI1V1o2+bCSw4d8cBtOqZlJ0eSNtrcRB2aLW4iS8hS
         84qXoEeWVPdVNDsQHqnuFwRqxIsHrrFBEq0nZgtMRN3yXoCUT2ixPkYHdbt/tGgf1Ca8
         gy9EZK1IZ/z6vUa1f1k7G4fQcBgwLDp/oRAxXh08Za6b9tQoTnsPNxcgo8ED+4MCOvsl
         2I4g==
Received: by 10.50.159.130 with SMTP id xc2mr12961093igb.15.1345545582297;
 Tue, 21 Aug 2012 03:39:42 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Tue, 21 Aug 2012 03:39:12 -0700 (PDT)
In-Reply-To: <20120821051706.GA55686@mannheim-rule.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203962>

On Tue, Aug 21, 2012 at 12:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> --- a/t/t5530-upload-pack-error.sh
>> +++ b/t/t5530-upload-pack-error.sh
>> @@ -35,7 +35,7 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
>>       printf "0032want %s\n00000009done\n0000" \
>>               $(git rev-parse HEAD) >input &&
>>       test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
>> -     grep "unable to read" output.err &&
>> +     test_i18ngrep "unable to read" output.err &&
>>       grep "pack-objects died" output.err
>
> Wouldn't it make sense to change the second "grep" of output intended
> for humans to test_i18ngrep while at it?

This comes from error("git upload-pack: git-pack-objects died with
error.") in unpack-trees.c, which is not i18n-ized yet. There's
another test in t5530 that does the same grep. I think we should leave
it as is until we mark the string for translation, then gettext poison
will spot it (verified) and we can fix it.
-- 
Duy
