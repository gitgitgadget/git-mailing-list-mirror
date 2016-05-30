From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: git add without whitespace
Date: Mon, 30 May 2016 10:26:44 -0500
Message-ID: <CAHd499Agn=vLBxDpHi2dy1HMy-_58PZGs7VNtFJnBfP5zXatTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 17:27:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7P5t-0007wE-3P
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 17:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933412AbcE3P0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 11:26:47 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35515 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000AbcE3P0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 11:26:46 -0400
Received: by mail-vk0-f67.google.com with SMTP id f62so2498225vkc.2
        for <git@vger.kernel.org>; Mon, 30 May 2016 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=hN/pCpGEi9BcJmUjxacpy1zn58oekBOdul1wJHezP6E=;
        b=DgMDdfQtvfXO3pIg1rT/Xzt5DcrxnPuYFpAatBI6pT2EeZoaCfSwP3G1ULPu/uBco6
         Fus2h3vJJK3PCyP0rTlxZg9LpJzoIqGewKN8VJmlEXQcVHLTVqyt0e8T04s4jdDEA7hn
         sls5W3ExT+r9440q6gE//SK/CVTs3cWIXni6cUfBn5gYix31m3PAUDpHZf2wTjVQKlwC
         NuCMq9A5nrIHT5bOpcgyW7y4ieLsC0ask678/u7KKqnzJuc2I3DwYR/3HWs6k7rj41hu
         xjYc3a8zckJWsFCp8febstfCEaih83u8KYgFEMcuYskPY0e3L/Rn4Zi0nHjB743K/da0
         RxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=hN/pCpGEi9BcJmUjxacpy1zn58oekBOdul1wJHezP6E=;
        b=DIE1hUm+A6umhEnrBZNrMuU9QGCGQ+aVkHiX9AbSdvevjUs6xQUfaPu+9cKfgmOuVc
         tFRsLXr43M8ACbkM2FfVVzj/UIFt3VerJNRxGqAYilIcORkV534Kaj9sORQDMgMWDg5p
         Ei0HabQ7PG1Yw4zv9XFOoUM+MsUCOni6NDIuCT84jcmb0NK0yZHiqUdYsd7IBR0KvyqX
         RJ2ZG1aD81y8VAKGozmUQ735jgyysIyUFMDr3LeTZWnC+VGLmAT3aFH5jL03TFcRnDw0
         HmSOGWSX+EWsExFTXL1YHT9YFohjsrR3WHib1Er+UM7xw6xTGfabKw1UZmePcVUkGw4s
         vuiQ==
X-Gm-Message-State: ALyK8tIzIUMz6DhUzNQcOTQ7CaymQx95/UOP5xoAZoPQps/MN72FnC+j3c6ZMMZCaTN4xJlGRSqMs8uHKbkmBQ==
X-Received: by 10.159.55.196 with SMTP id q62mr13259618uaq.8.1464622004953;
 Mon, 30 May 2016 08:26:44 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.34.134 with HTTP; Mon, 30 May 2016 08:26:44 -0700 (PDT)
X-Google-Sender-Auth: bxNfPtHCYKoBuI_GplLRdkswH0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295908>

I think it would be useful to have a '-w' option for 'git add' that
completely ignores whitespace changes, the same way that 'git diff -w'
does.

Real life scenario:

Sometimes developers will use tooling that does not properly strip
trailing whitespace in source files. Next time I edit those files for
a simple 1-line code change, my tooling will strip whitespace from the
whole file. I *do* want these changes, however I want 2 commits: 1
commit with the bugfix, and a supplementary commit with just the
whitespace changes.

At the moment, there is no way for me to conveniently add the source
file to the index without whitespace. The only way to accomplish this
today that I'm aware of is via this command:

$ git diff -U0 -w --no-color | git apply --cached --ignore-whitespace
--unidiff-zero

This command explicitly leaves out context because it can sometimes
cause the patch to fail to apply, I think due to whitespace being in
it, but I'm not completely sure myself.

It would be useful to be able to do this instead:

$ git add -w

This would effectively function the same as my workaround command
shown earlier. It should also be valid to use -w with -i and -p. In
the -p case, it just won't show hunks containing whitespace changes.
For -i, it would assume '-w' as part of any command run during the
interactive session.

Does this idea sound good? I have some free time on my hands so I
wouldn't mind implementing this. Maybe there isn't a huge audience for
this kind of thing, or maybe I'm just going about this the wrong way.
Thoughts would be much appreciated.
