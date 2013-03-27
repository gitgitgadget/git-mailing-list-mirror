From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Wed, 27 Mar 2013 20:05:07 +0700
Message-ID: <CACsJy8C9NM9BJHAftjWFby5EG7Yx3ofR7W3zQC9-KBgmpcWn2A@mail.gmail.com>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org> <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
 <20130326094844.GA32583@duynguyen-vnpc.dek-tpc.internal> <20130326150428.GA3847@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Richard Weinberger <richard@nod.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 14:06:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKq3R-00022V-K0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 14:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab3C0NFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 09:05:40 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:48198 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab3C0NFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 09:05:38 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so5078482obc.34
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fvX+VLQMAreXLG3VBBnd+ipj8P/FvaG4yNeFeLNeLt4=;
        b=uPUTDha3L4Oc77moM4Tzfya05tkC7USv99lfxl70Wbe7GojoBFjh7zlQWnxdbHxLOV
         C9VdARt6O5d7gKYObRnDxA+1/xFI2OOsGDIzY40kvh2llg1OX+DTOxRCkJ2X9znSvR2K
         LscQH8/aURcYBWSANIlsaaM5dEUwBCfjvrAIbb0Ao6r0K0HkLJ/dT780Ri0aM6uRUWYD
         ulHebhApMY/RtWRW8Rj1EMXhYVu16cAp4sU6ak6AGnTXFbFdKk1azztSQ1iXsA7kCREW
         qJRo7gBYnwjynyBhajXjr0OGq7lygwxHsXHun34sQ31Dcmkr4WdDcFdluwKLPpHkVUU5
         EDsA==
X-Received: by 10.60.99.68 with SMTP id eo4mr2260315oeb.126.1364389537962;
 Wed, 27 Mar 2013 06:05:37 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Wed, 27 Mar 2013 06:05:07 -0700 (PDT)
In-Reply-To: <20130326150428.GA3847@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219246>

On Tue, Mar 26, 2013 at 10:04 PM, Jeff King <peff@peff.net> wrote:
>>       specifies a path to use instead of the default `.git`
>>       for the base of the repository.
>>       The '--git-dir' command-line option also sets this value.
>> +     If neither GIT_WORK_TREE nor '--work-tree' is set, the
>> +     current directory will become the working tree.
>
> I think this is a good thing to mention, but a few nits:
>
>   1. core.worktree is another way of setting it
>
>   2. This can also be overridden by --bare (at least in "next").
>
>   3. I think having core.bare set will also override this

Yeah, I looked back at t1510 and gave up. I think it's still true:

-- 8< --
A few rules for repo setup:

1. GIT_DIR is relative to user's cwd. --git-dir is equivalent to
   GIT_DIR.

2. .git file is relative to parent directory. .git file is basically
   symlink in disguise. The directory where .git file points to will
   become new git_dir.

3. core.worktree is relative to git_dir.

4. GIT_WORK_TREE is relative to user's cwd. --work-tree is
   equivalent to GIT_WORK_TREE.

5. GIT_WORK_TREE/core.worktree was originally meant to work only if
   GIT_DIR is set, but earlier git didn't enforce it, and some scripts
   depend on the implementation that happened to first discover .git by
   going up from the users $cwd and then using the specified working tree
   that may or may not have any relation to where .git was found in.  This
   historical behaviour must be kept.

6. Effective GIT_WORK_TREE overrides core.worktree and core.bare

7. Effective core.worktree conflicts with core.bare

8. If GIT_DIR is set but neither worktree nor bare setting is given,
   original cwd becomes worktree.
-- 8< --
-- 
Duy
