From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Sun, 14 Jun 2015 20:16:46 +0700
Message-ID: <CACsJy8A5ikjGmj+ysTUt9FFi9X0WzVXvnFSVbmFoe8rzHdNNoA@mail.gmail.com>
References: <55300D2C.9030903@web.de> <1429319946-19890-1-git-send-email-pclouds@gmail.com>
 <5533A567.7070301@web.de> <CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
 <xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com> <CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>
 <xmqq8udlgpey.fsf@gitster.dls.corp.google.com> <5537F31D.4090704@web.de>
 <xmqq1tjcdjfa.fsf@gitster.dls.corp.google.com> <5538218B.4010400@web.de> <CAPc5daUA30ZbbJVK9S_FM9Z8qyyEXUez9hGD2JNhTm78QYb5YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 15:17:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z47ms-0002cc-Am
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 15:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbbFNNRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 09:17:18 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36654 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbbFNNRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 09:17:17 -0400
Received: by iecrd14 with SMTP id rd14so16381907iec.3
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FrM0qYUXFcgEgkpAf8a2qIwQygrcj4WtlhSphAVb/1k=;
        b=fVGh5wkk7VPUZOXMWa8Aojm6INRZXE2mrdxmcw0/50fv4rsJf5091Mj1VimffTKCI+
         KLSvUg8Hzh/K9zvh8bAULJP+bOjGOOLdDWPldEqYdrW3/FYphm9RP4pp7mSV6IdvLn3M
         pvMaLcWFloH6ESSsaZQRHbrV/w0EpAHCKPdGmwgf78MX/1/pdCjGQ5J4y3IoOZpO/ta2
         yRaqGgLMrLk1Q5OnWEncpX0JDPqdP40oRgL+v1ocPHJZmfzh3HP/H4HXjqIhFf9GGZ5Q
         Kd0WFZYaYpvOExVJFKE+W32JmhPBkKmZENbLP7RVJZgKOyqDeaTZoBRqm/w1JGQDOXRw
         GKcg==
X-Received: by 10.43.172.68 with SMTP id nx4mr25089815icc.48.1434287836989;
 Sun, 14 Jun 2015 06:17:16 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Sun, 14 Jun 2015 06:16:46 -0700 (PDT)
In-Reply-To: <CAPc5daUA30ZbbJVK9S_FM9Z8qyyEXUez9hGD2JNhTm78QYb5YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271638>

On Thu, Apr 23, 2015 at 10:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Apr 22, 2015 at 3:32 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> ...
>>> But it is unclear if we should still do (2) when "subrepo/.git" is
>>> no longer there.  That has to be done manually and it may be an
>>> indication that is clear enough that the end user wants the
>>> directory to be a normal directory without any submodule involved,
>>> in which case it may match the expectation of the user better to
>>> just nuke the corresponding 160000 entry in the index and replace it
>>> with files in there.  I dunno.
>>
>> The user having removed subrepo/.git is just one reason for that.
>> Another is a user adding a file in an unpopulated work tree of a
>> not initialized submodule. I doubt that simply nuking the 160000
>> entry would be the right thing to do in this case, I expect this
>> to be a pilot error we should barf about ;-)
>
> OK, that sounds sensible.

There are more to this "submodule vs the world". When .git is gone, if
you expect to warn instead of deleting 160000. You may want the same
for the opposite direction: when b/c is in the index and you add
b/.git, you may want "git add b" to complain too (right not it ignores
b/.git and updates b/c).

We may need more surgery around this area. It seems to be the "Path %s
is in submodule" check (in pathspec.c) is at the wrong place. We have
d/f check in add_index_entry_with_check. That should catch it, at the
core, not from call sites like add or update-index. But that check is
not active...

The first version of "path is in submodule" is in 2ce53f9 (git add: do
not add files from a submodule - 2009-01-02). Back then dir.c does not
intervene. If you have "b" as 160000 in the index and tries to add
b/c, the ok_to_replace feature kicks in and kills 'b'. This is why d/f
check is turned off. This ok_to_replace is to deal with symlinks, see
192268c (Add git-update-cache --replace option. - 2005-05-07).

I think we should stop the ok-to-replace feature when submodules are
involved, we consider submdules much more valuable than symlinks. If
we do this, I think we can delete those "Path is in submodule" trick
becaue the index core can handle it well.
-- 
Duy
