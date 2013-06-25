From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 13/16] repack: consider bitmaps when performing repacks
Date: Wed, 26 Jun 2013 01:16:52 +0200
Message-ID: <CAFFjANQ4wbMZQO-Y++bzakpqKcD_Co4KPo8sj3i-wCC+730Sig@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-14-git-send-email-tanoku@gmail.com> <7vbo6tztgn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 01:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrcU9-00015Q-6o
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 01:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab3FYXRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 19:17:13 -0400
Received: from mail-vb0-f54.google.com ([209.85.212.54]:55320 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab3FYXRM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 19:17:12 -0400
Received: by mail-vb0-f54.google.com with SMTP id q12so10109232vbe.27
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 16:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DaXryzdB414Kd8R6TDI7Q03gHwtgPEFWNeoQhVa6UmM=;
        b=u3dffiIGhTsJZV2szWiXDx9fy4SscjiZYsZg/mFIXI8kGTpq/r61PNGN0DJc8DPeye
         nIMJI3tDPoWOKkTSlRIYZSw6orYyokNDBQwkzkIOJNsiqIS9UNO9fzx8/EUEEHGCADUp
         cXaKNC4CfghWh4JPO8sadFnkESj9c0n75jGqaD1GG6AqLnR6oXtfdZUU08QXBi/AS+IO
         Z4jn/FWC21TQTTL0sLzlxGucBGbMMNUo8SrBPzgbLxLtHM8Yq9ZHZ2WP74XTMpuTb27Z
         2EzdyLxvzHlPtfg7YIIYaGHqot9lmDCD58ZRcZqTAhYrdYrN0tLAua3ouxbt9GWDtcs/
         WmuA==
X-Received: by 10.58.230.135 with SMTP id sy7mr744447vec.42.1372202232166;
 Tue, 25 Jun 2013 16:17:12 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 16:16:52 -0700 (PDT)
In-Reply-To: <7vbo6tztgn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229017>

On Wed, Jun 26, 2013 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -156,6 +156,11 @@ do
>>       fullbases="$fullbases pack-$name"
>>       chmod a-w "$PACKTMP-$name.pack"
>>       chmod a-w "$PACKTMP-$name.idx"
>> +
>> +     test -f "$PACKTMP-$name.bitmap" &&
>> +     chmod a-w "$PACKTMP-$name.bitmap" &&
>> +     mv -f "$PACKTMP-$name.bitmap" "$PACKDIR/pack-$name.bitmap"
>
> If we see a temporary bitmap but somehow failed to move it to the
> final name, should we _ignore_ that error, or should we die, like
> the next two lines do?

I obviously decided against dying (as you can see on the patch, har
har), because the bitmap is not required for the proper operation of
the Git repository, unlike the packfile and the index.
