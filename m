From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Sun, 16 Nov 2014 02:51:11 +0100
Message-ID: <CAHYJk3Q9tcS+o0hDnDz24ysSKkL6m16OmhyHuj=W88VQjTximw@mail.gmail.com>
References: <1416000835-79274-1-git-send-email-davvid@gmail.com>
	<xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, git <git@vger.kernel.org>,
	Adri Farr <14farresa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 02:54:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpp36-0006wx-5Z
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 02:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbaKPBvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 20:51:13 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:56481 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaKPBvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 20:51:12 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so3200017ier.4
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 17:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t2nfKQjs40AHq06RAZgjaa5vCZc7CLOq4yfXQ3M+yLI=;
        b=oZG9TTi3S5vY9w+fFcwAfZnO8Kc/ZRS1vgaHj+fjQ9LoJuQHtFll+V06hTlgsgxYvY
         u6nD+OTbmAoran8Vk4nG8SEv7KzA5Bu4DyloR58+F9UO9zUKowQqR4aMft5EuhAO6RJ/
         TVALBUybaloccsBBIdTLuYdHP87AsFImOm43K96bEI+amcJMnAR3fSMYilXrChiHCzjn
         C909pBFfRj38fnxzAtyaOi2xNpPsQh0YBhYnPSIDYKCh8TnBd1HRHFZX37EiOk+q8wX2
         EZWShobjtTS3Em4Po46RPmDmnGUdq3KMHHr6a/olYBGLQJ02tF/kGPamm6MAbExvoQmh
         1E5w==
X-Received: by 10.50.137.65 with SMTP id qg1mr16409073igb.37.1416102671650;
 Sat, 15 Nov 2014 17:51:11 -0800 (PST)
Received: by 10.51.14.163 with HTTP; Sat, 15 Nov 2014 17:51:11 -0800 (PST)
In-Reply-To: <xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, 2014 at 10:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> run_merge_tool() was not setting $status, which prevented the
>> exit code for builtin tools from being forwarded to the caller.
>>
>> Capture the exit status and add a test to guarantee the behavior.
>>
>> Reported-by: Adria Farres <14farresa@gmail.com>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>>  git-mergetool--lib.sh | 1 +
>>  t/t7800-difftool.sh   | 5 +++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>> index a40d3df..2b66351 100644
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -221,6 +221,7 @@ run_merge_tool () {
>>       else
>>               run_diff_cmd "$1"
>>       fi
>> +     status=$?
>>       return $status
>>  }
>
> Thanks for a quick turn-around.  As a hot-fix for what is already in
> -rc I am fine with this fix but the patch makes me wonder if $status
> as a global shell variable has any significance.

$status is an alias for $? in zsh, and so cannot be assigned to. But
other than that I don't think it holds any meaning and should be fine
in a .sh script.

-- 
Mikael Magnusson
