From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/6] unpack-objects: continue when fail to malloc due
 to large objects
Date: Fri, 15 Aug 2014 12:24:54 +0700
Message-ID: <CACsJy8AF-NdAL-4t9k2-qrQCFFRC8T6==SvYiP14FktrxHEj=w@mail.gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
 <1407927454-9268-1-git-send-email-pclouds@gmail.com> <1407927454-9268-4-git-send-email-pclouds@gmail.com>
 <xmqq7g2b2ele.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 07:25:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIA13-0004TR-N7
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 07:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaHOFZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 01:25:25 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:64587 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaHOFZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 01:25:25 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so1025912igb.9
        for <git@vger.kernel.org>; Thu, 14 Aug 2014 22:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=71X2oxjgP6lCQbzN8tPC1Tvonr2vx2FM5mIdSVmBBZ0=;
        b=aHVXagIfLkOUC6qd7zkl2qpgOMcTHfJFfEwwpG3FAJVbPhSnO+TLeRaruLEl3HnZKf
         KCvm3QEyWd9+ZDYeH7ZMuTQJmdbpozlhq9g9LHQ8qC0tlQPpWhLsgwVlvOj5APRKA7nG
         O9VaQ5dxetFY2FkasxJKQMFNCgB7pPq47k6OpC2fysSCWIxJaQGBckq6IfDzZYH4ZDLy
         zgtR8AI9MJ7yFsu3nfx26s55eGjc3RL264HotZwmN/5jummHhLmzyvV9JX9CU8wfxVTT
         yt085qVFyXzJVlaCWuWHf5qoNGk1RL4x1n4vkqIAbhprAaRwX+SShKqJ/r4LzqJ+H57+
         gFKg==
X-Received: by 10.50.43.164 with SMTP id x4mr39533333igl.27.1408080324450;
 Thu, 14 Aug 2014 22:25:24 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Thu, 14 Aug 2014 22:24:54 -0700 (PDT)
In-Reply-To: <xmqq7g2b2ele.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255279>

On Thu, Aug 14, 2014 at 11:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +static void inflate_and_throw_away(unsigned long size)
>> +{
>
> But more importantly, the basic structure of this loop is the same
> as the loop we already have in the only caller of this new function,
> not just the regular "zlib produced this much that is not yet the
> expected size, go on reading more" and "we are at the end of the
> stream with Z_STREAM_END, and we are done", but even to "the stream
> is corrupt, we need to exit the loop", they are identical.  Is a
> copy-and-paste like this the best we can do to add this "skip to the
> end of the current stream"?  We would really want to keep the number
> of copies of this loop down; we saw a same bug introduced on the
> termination condition multiple times to different copies X-<.

I know. I'm the author of one of those bugs. I considered updating the
inflate loop in get_data() to support this throw-away mode but was
afraid I may make the same mistake like in index-pack again. I'll
probably drop this patch and think if I can unify inflate loop (for
other places too, not just unpack-objects).
-- 
Duy
