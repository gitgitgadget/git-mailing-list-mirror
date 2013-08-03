From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] gc and impatience
Date: Sat, 3 Aug 2013 10:53:38 +0700
Message-ID: <CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com>
References: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 05:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5SvK-00081O-9b
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 05:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab3HCDyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 23:54:10 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58535 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab3HCDyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 23:54:09 -0400
Received: by mail-oa0-f46.google.com with SMTP id l10so2816911oag.19
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rZw0pLvBfkTQhQDH8ZmoyDNzI7pXOiBtwYLnOaq+7aM=;
        b=Ki6b7svUcDNQdxG7KaWOqT8+9sscOXIY45nWecmcun9Je+Iw4zfDfZTX5X71YXKeWL
         /MifS2k3XPk5trGC6FrQYNFmOivB6wuUzB+t/NxA8APteqajLjp887pq3dYybdCaetXK
         OdXSDiiw3XXShCisHX50Ji4jwdPJARIRm54VLwE71VElQ60eiUhVZoRHO7nqhfQH5pC3
         78yTsL5Exioc3cdg/Rt08a7U4QpDns41AlM6vm43NkPNjM0VHDv8EH8Qq8FQ9aa8fHir
         wOZHKjJtcQyjdg0TVLFz76DeZs4ebR+FmAlhfxFkgTr9DoPcYMjTtqDSJewxl60Aozpy
         6ZAg==
X-Received: by 10.60.145.241 with SMTP id sx17mr7519558oeb.57.1375502048239;
 Fri, 02 Aug 2013 20:54:08 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 2 Aug 2013 20:53:38 -0700 (PDT)
In-Reply-To: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231557>

On Sat, Aug 3, 2013 at 8:48 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>  Auto packing the repository for optimum performance. You may also
>  run "git gc" manually. See "git help gc" for more information.
>
> Being my usual impatient self, I opened another prompt and started
> merging changes. After the checkout, it started running another gc
> (why!?),

Good point. I think that is because gc does not check if gc is already
running. Adding such a check should not be too hard. I think gc could
save its pid in $GIT_DIR/auto-gc.pid. The next auto-gc checks this, if
the pid is valid, skip auto-gc.

> Why is gc not designed for impatient people, and what needs to be done
> to change this?

Some improvements could be made in gc, for example warn users about
upcoming gc so they can run it in background (of course the above bug
should be fixed)

http://thread.gmane.org/gmane.comp.version-control.git/197716/focus=197877

or speed up repack by implementing pack-objects --merge-pack:

http://thread.gmane.org/gmane.comp.version-control.git/57672/focus=57943

Or you could just make a cron job to gc all repos every week and the
problem goes away ;-)
-- 
Duy
