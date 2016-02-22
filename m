From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: clarify textconv interface
Date: Tue, 23 Feb 2016 06:01:47 +0700
Message-ID: <CACsJy8Cg4cgCEqwo=9ujdTV8aw5CO-irVxOCanzBG4n7Nm-0kg@mail.gmail.com>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
 <1456145545-5374-3-git-send-email-pclouds@gmail.com> <20160222180645.GB4587@sigill.intra.peff.net>
 <20160222182854.GA11732@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:02:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzUp-0002KI-44
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 00:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbcBVXCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 18:02:21 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32780 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbcBVXCS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 18:02:18 -0500
Received: by mail-lf0-f52.google.com with SMTP id m1so105052557lfg.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eI//l8dJlzg4CG3Pk2N9NEtkG+IH3ITvufwmXkOVC3s=;
        b=YWYUtAYmTigF+Ikp4cw/7X4v/IW/SQp4ROOQ5+ua9hj68gQzwLd5TTYAe4Qg0XVStQ
         +8Vc+1pRON+2hk92IKObRsJ3aD6In/Jmz/2RmdYPp04FINLATO6Cj9NLGMY8adVjcl34
         rXhqTJg8ex3LO59ztAwCKCVw1e7svnIRbVwz2bmWeE3nw36NhV7iFqUVYgl+HcBRKsb+
         pMOjYwUdyv3216BPcrSGYDHfFRkbseOZGVXnumwF2SMDujFl/Uc5tMlCEDcFVejf/lIc
         N59Di+1HDcU0lf5+decETR19y4QTB2JiEpQNLYwQ/fRxAzss2xwz6v76t+8A2C1LF+SA
         LGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=eI//l8dJlzg4CG3Pk2N9NEtkG+IH3ITvufwmXkOVC3s=;
        b=Wf6iOUYpb/t8KzTDLCRPxDxMy5PQpg0eQbgTQpRuPzTAEaH+nFJXCj4LTof2EIGafm
         TZqZ3vrgk/AHh2P+GqBmZVGs0i7gGvzeHOZE3HAFxrghx18wmUSS0WR5sz4gSnqrf97d
         /r5oXGwDBbb2iFIokgmnBYCPnNQuWK2BeiVIHo4F8UX3oLfdZ7dE7inI1IkB8hx1k5+J
         gd4Echz3UMRk3tEaq/prL7WX0urhis9aZQox569R/BsBGqQ87sWzlkFFJB5+tgnhCKFc
         WunegyhGJLffbTK39n5Rgd2jsWdYNCtUIbjLWkkfO0xVe+B5pXfC46wq7WY6BT0QlGWe
         E2Jg==
X-Gm-Message-State: AG10YOSMyjqaBHZ0PGW6kzzUmGG85l8lkQbHRGMjrF10fZNlfpxJi0trtIlhgYQmQCutZ0Et8JdIV2keMzdUIw==
X-Received: by 10.25.4.7 with SMTP id 7mr10897201lfe.45.1456182136973; Mon, 22
 Feb 2016 15:02:16 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 22 Feb 2016 15:01:47 -0800 (PST)
In-Reply-To: <20160222182854.GA11732@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286995>

On Tue, Feb 23, 2016 at 1:28 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 22, 2016 at 01:06:45PM -0500, Jeff King wrote:
>
>> I have a feeling you were confused by the fact that fill_textconv()
>> does:
>
> Looking over it, I agree this is a pretty confusing interface that grew
> out of control over time.  But refactoring it is kind of tricky, because
> we really do want to avoid extra allocations, or cross-module
> assumptions (e.g., userdiff doesn't know about diff_filespec, but rather
> the other way around, and we probably do not want to muck with the
> internals of a diff_filespec when doing a textconv).
>
> So I think the patch below is an improvement, but if somebody really
> wants to dig into refactoring it, be my guest.

I almost went this way but I wasn't sure if driver->textconv can be
NULL on purpose. Definitely an improvement.
-- 
Duy
