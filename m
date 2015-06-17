From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/i18n.txt: clarify character encoding support
Date: Wed, 17 Jun 2015 13:45:42 -0700
Message-ID: <xmqqr3pa5aix.fsf@gitster.dls.corp.google.com>
References: <557C9161.6020703@gmail.com>
	<xmqqmw01ltid.fsf@gitster.dls.corp.google.com>
	<557EA421.5050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5KDW-0002qe-A6
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbbFQUpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:45:46 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33075 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbbFQUpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:45:45 -0400
Received: by igbos3 with SMTP id os3so3025347igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fwBNBUzyht3iYu2sWgJhlW4hx8p+sGbEzEX8skuMlWY=;
        b=gSsdiapHfuropTXu8e8QQSQFrcOh8o8aRrZT/GFafaHTEFvxP0duRd+3QmXIYYKUuE
         FybvIdOvOnzPBjvi8sTwpQvI7+Z81NcqemqSCBXD2wBezp342Z1yYibvcX4m0Zc0THuu
         ZBvjwgeEAypFz1VXtJIsi/fnrNrK3iTe4201mMBiC/EPk1RFKjBqq7fLp9zgP3DGGoD0
         iDEcVT/kCUG50kZu93HBzbbyKqD3UYTVjZAF7bt69GQjC81+Zjv2wHEvLoMIGbcJ9e95
         8Tc+3DudS5+7HIGtMMdBrs/z1MPWPsJ176kps+nSkKif4kzUCuUxUJU/Of4l6D7lyxZY
         5JfA==
X-Received: by 10.43.96.5 with SMTP id ce5mr2268702icc.96.1434573944497;
        Wed, 17 Jun 2015 13:45:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id pg7sm12660675igb.6.2015.06.17.13.45.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 13:45:43 -0700 (PDT)
In-Reply-To: <557EA421.5050706@gmail.com> (Karsten Blees's message of "Mon, 15
	Jun 2015 12:08:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271909>

Karsten Blees <karsten.blees@gmail.com> writes:

>> I do not think the removal of the text makes much sense here unless
>> you add the equivalent to the new text below.
>> 
>>>   - The contents of the blob objects are uninterpreted sequences
>>>     of bytes.  There is no encoding translation at the core
>>>     level.
>>>  
>>> - - The commit log messages are uninterpreted sequences of non-NUL
>>> -   bytes.
>>> + - Pathnames are encoded in UTF-8 normalization form C. This
>> 
>> That is true only on some systems like OSX (with HFS+) and Windows,
>> no?  BSDs in general and Linux do not do any such mangling IIRC.
>
> Modern Unices don't need any such mangling because UTF-8 NFC should
> be the default system encoding. I'm not sure for BSDs, but it has
> been the default on all major Linux distros for more than 10 years.

So?  All major distros do not have to worry (and do not even need to
know).  As I said,...

>> I
>> am OK with mangling described as a notable oddball to warn users,
>> though; i.e. not as a norm as your new text suggests but as an
>> exception.

... I am OK to describe "pathnames are mangled into UTF-8 NFC on
certain filesystems" as a warning.  I am OK if we encourage the use
of UTF-8, especially if a project wants to be forward looking
(i.e. it may currently be a monoculture but may become cross
platform in the future).  I just do not want to see us saying "you
*must* encode your path in UTF-8 NFC".

> ISO-8859-x file names may be fine if you won't ever need to:
> - use git-web, JGit, gitk, git-gui...
> - exchange repos with "normal" (UTF-8) Unices, Mac and Windows systems
> - publish your work on a git hosting service (and expect file and
>   ref names to show up correctly in the web interface)
> - store the repo on Unicode-based file systems (JFS, Joliet, UDF,
>   exFat, NTFS, HFS, CIFS...)

Yes, that is exatly what I said, isn't it?  "Use whatever works for
your project, we do not dictate."

> These restrictions are not that obvious when you start a new git
> project,...

Or any project for that matter, not limited to "git project", no?
Perhaps that is a moot point by now, as everything in the workd
seems to be a "git project" these days.
