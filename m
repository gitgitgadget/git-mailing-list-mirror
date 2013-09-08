From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] index-pack: add --unpack-limit to unpack objects
Date: Sun, 8 Sep 2013 13:28:47 +0700
Message-ID: <CACsJy8DeJnwJ2hxbKs+ks3Rp6h+uedFA+qt8JTTwyen8sF7XMw@mail.gmail.com>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
 <1378428363-14086-1-git-send-email-pclouds@gmail.com> <20130908044417.GD14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 08:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIYUs-0006Lu-OA
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 08:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab3IHG3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 02:29:19 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:63801 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3IHG3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 02:29:18 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so5502694oag.36
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tQ/r4bDhVy496lM9v7S8LF+ZSQIfHwZfNT8Gx/7hOhI=;
        b=tgkk0JtZZuiMHwNIFRrXx1ZBOW9kuzGfQqFuGKxffbHPpQvt4wxARlfFtzofMu7g+V
         G5fTMe+KKK8dh9RLD04OXglhWaHaMSgTkaCt6G+4Up++D4oABADlR3cyIMl8Alp8+I5A
         ze9OyeLfNDL4pGIu3p6xCz3cufAa8L0IA0ZAYC+znT0Ie6Axne2CQfty8MD7vYjU7J8q
         JLw7AqXU6k+PuYxKklYEJyDvg4Mttx9vxqBm0wVgon5FN7OWrv70ydFB5hpe4Iefs9if
         hpqot7RfHMNNUQXRI/+NZDPv1jElVdNaTIOcRbLDywIghVS/g0nrLYW/E8ZnhRx/GPeu
         Qq+Q==
X-Received: by 10.60.132.178 with SMTP id ov18mr261599oeb.39.1378621757965;
 Sat, 07 Sep 2013 23:29:17 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Sat, 7 Sep 2013 23:28:47 -0700 (PDT)
In-Reply-To: <20130908044417.GD14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234192>

On Sun, Sep 8, 2013 at 11:44 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 06, 2013 at 07:46:01AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> ---
>>  I had something that could unpack without writing to temp pack file
>>  but I scraped it and chose this way because it follows closely how
>>  index-pack works. It's a good thing imo because .pack v4 is coming
>>  and I don't know how v4 may impact this unpack code path. Once things
>>  are settled, we can revisit and open a separate code path if it's
>>  still a good idea.
>
> From a cursory read, this seems fine. If it were done in complete
> isolation, I'd say it was a slight regression, just because we are doing
> more I/O for the unpack case, and it is not really saving us any code
> (it is not like we can throw away unpack-objects, as I think we would
> want to keep it as a last resort for getting data out of malformed or
> otherwise non-indexable packs).

I can see unpack-objects is more tolerable on corrupt/incomplete
packs. If index-pack finds something wrong, it aborts the whole
process. I think we can make index-pack stop at the first bad object,
adjust nr_objects, and try to recover as much as possible out of the
good part. Any other reasons to keep unpack-objects (because I still
want to kill it)?

> But I can also see it making pack v4 handling easier. So it would make
> sense to me to put it at the start of a series adding pack v4 indexing.
> By the end of the series you would be able to see the benefits of the
> reduced code complexity. Until then, it is a "probably this will help
> later" change.

Agreed.
-- 
Duy
