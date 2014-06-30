From: Shawn Pearce <spearce@spearce.org>
Subject: Re: How to populate index/worktree when recursive merge merges
 multiple common ancestors?
Date: Mon, 30 Jun 2014 14:30:18 -0700
Message-ID: <CAJo=hJsVSqvEB4wnSp_RtfF3rMXyLWjm8kUXHxmOWmzYn6MM2Q@mail.gmail.com>
References: <CAENte7jg7RnpEFmZ0QWGw=a-AvAN6AF=cknHXWyTEuo9zq7ERg@mail.gmail.com>
 <CAJo=hJtLzMqrBf5Y1dzUxi_0nGmY72xURRmcvmjoFD+=j0FCwQ@mail.gmail.com> <CAENte7i3f_zvPmnPZe2s7guPv03o1d_Ln+nVaj5PYmP8uoK=rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 23:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1j9w-00015M-WA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 23:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757156AbaF3Val (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 17:30:41 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:44633 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149AbaF3Vai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 17:30:38 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so4755159igb.17
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mwJo/ZzvQQEqvA66o9NlQkTmYW55Hl2kk25/LAlUeS4=;
        b=MT4oQMkR6gKV2dcs/gq5ZAvmaFyF11Tt0433gy6KESY4Y4c5OiQjQP561B8ZbJTNvB
         7si3lAwqQHRf0/xjTqW1a/RfRRaB7XtoGFk4kIH4307rz6C1f4C5ek6bJhsQunm4o80g
         e7AbdulX2Cf7jApjDDnoQh7IqqMIUgDNk6GMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=mwJo/ZzvQQEqvA66o9NlQkTmYW55Hl2kk25/LAlUeS4=;
        b=Adw60Twr92dPmW4SLz672ZsmISmMrDztrl7wLeLEAhY8nlGRMsQSgnTrKTK8WS+/l9
         wsyIF7+a/UuVZMx2wPmh6QSuZ767V9xmK5+4AxZLcKFYIW/XfsuB18OXTAwOpRebVpH/
         4pOQmjonJoQ6SxZedMMTo17wtCYGWukTORCjZ7OeY+MmqcxQwB/jOTy6f+dBkA4E3pzC
         fw8pQiOKqjBnMUuwU+kMN5xzQfqJEyXAdsek1exucTBAePksNBdmGbFLCwqQ+jR3ZosS
         oengv+BMrmyDRQPjJsuTNa6GU25e2Rc6lsBpiklKZn+kEdExuboAzUecpluDCejgAm4O
         0gMg==
X-Gm-Message-State: ALoCoQnyrZDdxOW6WIWsU1Ubttf2m1tKuK5Bdf/dlfYtXAWmuvuIKAENJipZuTrLx+6Rk2/ahNc+
X-Received: by 10.42.76.205 with SMTP id f13mr10762929ick.63.1404163838191;
 Mon, 30 Jun 2014 14:30:38 -0700 (PDT)
Received: by 10.64.208.12 with HTTP; Mon, 30 Jun 2014 14:30:18 -0700 (PDT)
In-Reply-To: <CAENte7i3f_zvPmnPZe2s7guPv03o1d_Ln+nVaj5PYmP8uoK=rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252702>

On Mon, Jun 30, 2014 at 5:48 AM, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
>> They don't. The conflicts are preserved into the virtual ancestor. The
>> user only sees the final conflicts during merging of A and B with
>> virtual X3 as the common ancestor.
>
> Ah, now I understand. When I merge X1 and X2 into the virtual X3
> I should not stop if this is not doable without conflict resolution. I
> should store in memory the X3 content, including all the conflict
> markers. If I finally merge A and B I will specify a common base
> content which may contain conflict markers. Right?

Yes.

If X3 content is large, it could flow to loose objects on disk. These
will be unreachable and cleaned up automatically in a future garbage
collection.

> Are git config param's like merge.conflictstyle=diff3 are also
> effective when creating the virtual X3 content? Couldn't that lead to
> complicated conflict marker situations? In the area where you expect
> common base content you again see conflict markers in diff3 style.

Yes, but I think this is the correct behavior. The machine can't
reconcile the two branches any better than this, so now a human has to
step in and fix all of the conflicts.

IIRC, this is uncommon. Usually you use A's common content as A and B
do not differ relative to X3 in the regions where X3 has a conflict,
so those conflicts aren't considered relevant when A and B merge.
