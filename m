From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Thu, 14 Feb 2013 13:43:55 +1100
Message-ID: <CAH5451kogwuzOs+BrHksDSdECbHrmW8DwTve0_kKq+-PTx+4bw@mail.gmail.com>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org> <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org> <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
 <7vpq04b5e2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 03:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ooW-0000Tc-4k
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 03:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab3BNCoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 21:44:19 -0500
Received: from mail-ve0-f176.google.com ([209.85.128.176]:39780 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3BNCoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 21:44:18 -0500
Received: by mail-ve0-f176.google.com with SMTP id cz10so1698572veb.35
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 18:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uR/0P4qIPzB594z2E5QhM+C+BYDkpHMxKUxLUDEhJr4=;
        b=wDwIAwARPx7xSvyL3dUHezs5BgFGVuIV909OpCdZEbE6dGG1nyV3a59BFpVVCTg3rG
         7J04IcPZK6OQANMtpFpetVyWpCvyPbX7Vuxy6aB2Zqt5a/XQGTUEKUvq4G/QiV5DdoXa
         N7TIuC8FJlxtsfF2Of0EtzT4O6PkpFejXjbc8TtTFLDTdwJjoQxcxLuJ67oD6kuUPAFd
         Y+pH9Zhw5yX81AbOFwmZAZsm/UKaIklrdEJOBzSmyizKPShrXB9QP79e8C8+a/OZHf/6
         weoxJ1BxdS2mVcnk9FEv6yoAqMd5sPqMKYcMBhRtlI09M3mrPxE2Pp1hBpNqTPc/CvIB
         kYOQ==
X-Received: by 10.220.228.138 with SMTP id je10mr32405258vcb.67.1360809855589;
 Wed, 13 Feb 2013 18:44:15 -0800 (PST)
Received: by 10.220.107.82 with HTTP; Wed, 13 Feb 2013 18:43:55 -0800 (PST)
In-Reply-To: <7vpq04b5e2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216296>

On 14 February 2013 02:27, Junio C Hamano <gitster@pobox.com> wrote:
>> If we need to support this behaviour than I would suppose a config
>> option is required. A default config transition path similar to git
>> push defaults would probably work well, in the case where breaking
>> these expectations is unacceptable.
>
> We've discussed that before.
>
> http://thread.gmane.org/gmane.comp.version-control.git/171811/focus=171818

Something that I couldn't find discussed was the option of, rather
than providing a config to 'turn it off', inverting the current
default/flags combo.

That is, currently git add defaults to not staging file deletions, and
we provide command line flags to include them. The consensus in the
thread is that it is better to stage them by default; it seems
reasonable to me that if we stage deletions by default we should
provide flags to _not_ stage them. If that was the entirety of the
change, would your position from that thread, "if we need this
optional, then it is not worth doing this", still hold?

Some people would be adversely affected by this change, but any
objections I can come up with are not game stoppers.
- It is possible newcomers might stumble at deleted files being staged
for commit by a command called 'add', but if they can already grok the
concept of staging then including deletions in that is trivial. If
they don't understand staging then we have a different issue.
- For people who rely heavily on file deletions remaining out of the
index, providing a flag allows them to keep their workflow. No data
would be lost, and most accidents would be easily recoverable.
- For scripts that rely on this behaviour, a flag allows it to be
updated, though it may break in the meantime. (I would presume that
not many of these scripts exist in the first place, but I don't really
know)

Finally, making this change makes sense from a consistency point of
view. For example, we don't track file renames because (and I
paraphrase) we can work that out from the content that is moved.
However if I rename a file and then 'git add .' I see that a new file
is added, not that it has been renamed! Manually adding the deletion
to the index causes git to correctly detect the rename, however this
is unintuitive and not consistent with how git works and is
communicated in general.

Git add is also inconsistent with git add -p (although that might be
due to unclear documentation for -p). When in patch mode, git add will
propose deletions get added to the index as well, not just additions
and modifications.

Regards,

Andrew Ardill
