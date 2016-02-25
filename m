From: Stefan Beller <sbeller@google.com>
Subject: Re: git mv messed up file mapping if folders contain identical files
Date: Thu, 25 Feb 2016 05:56:22 -0800
Message-ID: <CAGZ79kZApquSRaY_BtHrqfvuWmtYuPjeshmT-oW6T8Z7atYdFQ@mail.gmail.com>
References: <CADsr5c_Hk34KBN06dM9Hk5HPW9-Mt3eZLMgvyes8sSgxCA-k0w@mail.gmail.com>
	<20160225114958.GC15324@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bill Okara <billokara@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:56:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYwP6-0003PS-RK
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760268AbcBYN4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:56:24 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33050 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760194AbcBYN4X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 08:56:23 -0500
Received: by mail-ig0-f173.google.com with SMTP id y8so14576657igp.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 05:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=DW4TEYYDtH1YslQtPQ6pAj5Uoms3jaL6x3i6iiWTr3s=;
        b=iEJaVKpie116YEatsHVgbQg/FWn+CdiATLKjOSngFFgZw4dfsOPeUXgQ5t+q8trN5/
         HisKqrZmjA5zG0wLr4mBIzRQXffc52qutXNxfSsWb20ipJZa9ou9Xo37gM3BmnCFGxvo
         ZK9Sa4peWP2sfSzmBQV+Ix5OoyUVG818i54s0nxUZUTW+kwsCeLc4i8AyHjDzp3kikqx
         XUFdNhU+Z8lgtaxJvVWjYhPcYnsxRSbs21P1OxLfIl3+YPu88ndQqsBQJcUT1c02K596
         DEnYjog2I+PfS/wbmvCCjjdj3XPp2EBqHGGEcX9vOaCEWO95BN1GlDFF3Jkk9GXEEBko
         RFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=DW4TEYYDtH1YslQtPQ6pAj5Uoms3jaL6x3i6iiWTr3s=;
        b=HWlPWXEef7LIE+4YalmGIbxVTVQNs42P3Hnor/a9lm9nsoS1hO0Mjc0ryRnCDWQv43
         gOnWzVJv1z3kx1IU1w4mhyZoZW3YlayaQysgKiJeNjAP4hHwt3lYn4vnUKEcBnEiaESH
         yaI32KYrdTS7/pTQ68cYeqzWLWWGk4yejcaf7cdy7bRT2ThxSJJr3u8edLZx9sWPsuyd
         6snvaYgeHa4pz0A3i5HwO4UkCc19X3ZekpwvB29Y3mZcDvMc49W80LVkm3XCDNyEOujN
         2B2aZtDWfq7o0C7XwVvT1SI7/mcR0tO3N0cIgLpXxYsSKue8227Ojo6FYaanNuouxLxm
         2KQg==
X-Gm-Message-State: AG10YOT+VFIbFtCgncGZJ/YSaehNJ4N19Kn8hae7FZeFktGwe8vNxyohDeBeTXapBmESOkKjU8fD3FuYUzMsGBIB
X-Received: by 10.50.112.10 with SMTP id im10mr3212735igb.93.1456408582438;
 Thu, 25 Feb 2016 05:56:22 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Thu, 25 Feb 2016 05:56:22 -0800 (PST)
In-Reply-To: <20160225114958.GC15324@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287388>

On Thu, Feb 25, 2016 at 3:49 AM, Kevin Daudt <me@ikke.info> wrote:
> On Wed, Feb 24, 2016 at 04:38:11PM -0700, Bill Okara wrote:
>> Hi,
>>
>> I noticed the following 'git mv' issue with:
>> git version 2.6.4
>>
>>
>> If there are identical files in different subfolders, 'git mv' the
>> root folder (and/or each file individually) will mess up the file path
>> mapping. that is, if having identical 'content.txt' file under
>> gitmvtest
>>     |--demo/content.txt
>>     |--dev/content.txt
>>     |--prod/content.txt
>>
>> after doing the "git mv gitmvtest/resources
>> gitmvtest/src/main/resources", the 'git status' will show:
>>
>> renamed:    gitmvtest/resources/demo/content.txt ->
>> gitmvtest/src/main/resources/demo/content.txt
>> renamed:    gitmvtest/resources/prod/content.txt ->
>> gitmvtest/src/main/resources/dev/content.txt            <== NOTE:
>> wrongly mapped the prod/content.txt to dev/content.txt
>> renamed:    gitmvtest/resources/dev/content.txt ->
>> gitmvtest/src/main/resources/prod/content.txt            <== NOTE:
>> wrongly mapped the dev/content.txt to prod/content.txt
>>
>> I tried running 'git mv' on each file individually, got the same problem:
>> > git mv gitmvtest/resources/demo/content.txt gitmvtest/src/main/resources/demo/content.txt
>> > git mv gitmvtest/resources/dev/content.txt gitmvtest/src/main/resources/dev/content.txt
>> > git mv gitmvtest/resources/prod/content.txt gitmvtest/src/main/resources/prod/content.txt
>>
>> > git status
>> renamed:    gitmvtest/resources/demo/content.txt ->
>> gitmvtest/src/main/resources/demo/content.txt
>> renamed:    gitmvtest/resources/prod/content.txt ->
>> gitmvtest/src/main/resources/dev/content.txt          <== WRONG
>> renamed:    gitmvtest/resources/dev/content.txt ->
>> gitmvtest/src/main/resources/prod/content.txt          <== WRONG
>>
>>
>> NOTE:
>> =======
>> if modified the content.txt in the 3 folders to contain different
>> data, then repeating the above 'git mv' will produce correct result,
>>
>> renamed:    gitmvtest/resources/demo/content.txt ->
>> gitmvtest/src/main/resources/demo/content.txt       <== CORRECT
>> renamed:    gitmvtest/resources/dev/content.txt ->
>> gitmvtest/src/main/resources/dev/content.txt             <== CORRECT
>> renamed:    gitmvtest/resources/prod/content.txt ->
>> gitmvtest/src/main/resources/prod/content.txt          <== CORRECT
>>
>>
>>
>> just want to see if this is a bug, user error (on my end), or??
>>
>
> This looks like the same issue as submodule--helper list has:
> http://article.gmane.org/gmane.comp.version-control.git/287227

The submodule--helper is not called from within git-mv, so it may be
a similar but not the same issue. ;)

Looking through the code, the pathspec is not treated according to the newest
style convention, I think it is one of the last places where the
pathspec internals
are poked with, instead of using parse_parsespec && match_parsespec.
(That said it is very old hence often tested code in the wild. old
code != bad code)

Stefan
