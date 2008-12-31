From: "David Aguilar" <davvid@gmail.com>
Subject: Re: git-difftool
Date: Wed, 31 Dec 2008 12:11:07 -0800
Message-ID: <402731c90812311211p548c49d3p100f79ddee7163b0@mail.gmail.com>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Dec 31 21:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI7Qf-0004qT-2F
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 21:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYLaULL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 15:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYLaULK
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 15:11:10 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:51744 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbYLaULJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 15:11:09 -0500
Received: by wf-out-1314.google.com with SMTP id 27so5937996wfd.4
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4TLJFeP0EPvgifEo6j9HqRIvaNyGSxLnejbhOJq9ito=;
        b=nkF51DASSkGSolAUCz8sME2HIUxDV3ksTK+K8yA10fP4ZrVLwe8UXnRLAY+ERn+tEz
         7WVn7F7ffktWUH3moatyOQrQN1CuE43SE1EkkCQS2HC7TPJ7yP9opWkE0pWmi09de4fE
         j2H4upUt6VxRQVDUxdlbmNK47E9X2SodNVKSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=is5bBCXcB2KZ/+G2Krz7JDLXjBaf1QhflBWKDF6PINEfQTcwUK0I89n+VNdHt5/S+c
         griXFapnHms+jlDRzWI3hNMucxSEOqiez9NEYNC3tTUE4puUqjVXSd6usrizRgEFfqLg
         v5wybqxrjWVckqhmQT/tLQJ+LQuL1v+7dxCSg=
Received: by 10.142.185.21 with SMTP id i21mr6616727wff.220.1230754267185;
        Wed, 31 Dec 2008 12:11:07 -0800 (PST)
Received: by 10.142.241.20 with HTTP; Wed, 31 Dec 2008 12:11:07 -0800 (PST)
In-Reply-To: <vpqhc4kz5zh.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104284>

On Wed, Dec 31, 2008 at 8:04 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> The usual use case for this script is when you have either
>> staged or unstaged changes and you'd like to see the changes
>> in a side-by-side diff viewer (e.g. xxdiff, tkdiff, etc).
>>
>>       git difftool [<filename>*]
>
> Is it not a complex way of saying
>
>        GIT_EXTERNAL_DIFF=xxdiff git diff
>
> ?
>
> (My 2 cents, and happy new year ;-)
>
> --
> Matthieu
>

Hmm... in theory, yes, but in practice, no.
xxdiff is too gimp to handle what 'git diff' hands it =)


For example:

$ GIT_EXTERNAL_DIFF=echo git diff test
test /tmp/.diff_1dh4TW 9daeafb9864cf43055ae93beb0afd6c7d144bfa4 100644 test 0000

$ GIT_EXTERNAL_DIFF=xxdiff git diff test
xxdiff (cmdline.cpp:762):
You can specify at most 3 filenames.
Extra arguments: " 100644 test 0000000000000000000000000000000000000000 100644"
Use 'xxdiff --help' for more information.
external diff died, stopping at test.


I checked the git-diff documentation and could not find a way to
inhibit the sha1, mode, etc. args that are sent to GIT_EXTERNAL_DIFF
(nor should there be, I presume).

I'm all for finding the simplest way and GIT_EXTERNAL_DIFF seems like
the right entry point.  What I should do is change the script so that
it handles all of the choosing-a-merge-tool-logic and just have git
call it via GIT_EXTERNAL_DIFF.  That would definitely simplify the
script since 'git diff' would be handling all of the tmp file and
option processing logic.  wow, I really like that idea.  Thanks for
the tip!


Happy new year,

-- 
    David
