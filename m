From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Convert all fnmatch() calls to wildmatch()
Date: Thu, 20 Dec 2012 19:36:06 +0700
Message-ID: <CACsJy8B3jdE5h272d0-R-OUcS-Fput+7ADBT4UZEMf58b9=2eA@mail.gmail.com>
References: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
 <1355922488-20976-4-git-send-email-pclouds@gmail.com> <7v8v8tanyn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:36:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlfMt-0002Ge-R7
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 13:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab2LTMgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 07:36:38 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:39796 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab2LTMgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 07:36:37 -0500
Received: by mail-ob0-f180.google.com with SMTP id wd20so3246121obb.11
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 04:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gWPfFfX2GzAc04nmLm+3Y/CU1QCObOrDQxMlufLB4TE=;
        b=uVmT9lBnKAiRajrcgkza4F5nKXHRrAhEUR84GTQdvZm0OFZ1yxehLBAZgGKVNw/mLi
         8oPCDFZhyE5iAeBZixZfzPw8LE2jea/Xf1msk5N3gqj44b8WX9SN1K9bwzdUITxnYmbB
         pEa/CeT5dBYF7ec10ze2YW8XxbiOk0kiVAfZzb+5vmSAJrFNmz3/kwYcaE9LXhCPpIFJ
         T6XzOmcr5QRl6C6fn+mf7vuh/00zm7mxGXHwQlnwCaTArwTUOPe9LrBkC11A8L9ldqN1
         j08tY0KUdH1pCy5CSlnIzmRmQXJznPU2l3fgirCAgurWHSnIosr4kOUjxZ0c5oUrUOmN
         HQRA==
Received: by 10.182.212.2 with SMTP id ng2mr7635011obc.81.1356006996674; Thu,
 20 Dec 2012 04:36:36 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Thu, 20 Dec 2012 04:36:06 -0800 (PST)
In-Reply-To: <7v8v8tanyn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211886>

On Thu, Dec 20, 2012 at 1:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -627,7 +628,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
>>                               return entry_interesting;
>>
>>                       if (item->use_wildcard) {
>> -                             if (!fnmatch(match + baselen, entry->path, 0))
>> +                             if (!wildmatch(match + baselen, entry->path, 0))
>>                                       return entry_interesting;
>
> This and the change to dir.c obviously have interactions with
> 8c6abbc (pathspec: apply "*.c" optimization from exclude,
> 2012-11-24).
>
> I've already alluded to it in my response to 2/3, I guess.

Conflict of plans. I did not expect myself to work on replacing
fnmatch soon and git_fnmatch is an intermediate step to collect more
optimizations and gradually replace fnmatch. Eventually git_fnmatch()
would become a wrapper of wildmatch, all the optimizations are pushed
down there. If we replace fnmatch->wildmatch first then there's little
reason for the existence of git_fnmatch(). Maybe I should merge this
with the fnmatch elimination into a single series.
-- 
Duy
