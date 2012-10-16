From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push race
Date: Tue, 16 Oct 2012 17:45:12 +0700
Message-ID: <CACsJy8D14sv5=+5zfiwgYCb7OoEqvQoVQ0ObAeWtUUSjRAgBeQ@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com> <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
 <20121016045118.GA21359@sigill.intra.peff.net> <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
 <20121016053750.GA22281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, marcnarc@xiplink.com,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO4ep-0003rm-36
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 12:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab2JPKpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 06:45:44 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36946 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab2JPKpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 06:45:43 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so5962509obb.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qN6B8QH7oFawTP87xNrcWMGnrVSYfg9U8S58kgV1ZDg=;
        b=0K3iLoHviiMVgPBdEe7qDM40MwrV8jyLoOHI2y2/pR7W4Uaj4Db0t89Z/7jLK085Mh
         +hUNGdrRThtwV2ZTMDC2uFFNHOtXCrvMGld/MJ6JWk4pKYcvP/4wZ+79Y4PS1tIi5pvQ
         1S1Jx064DiJBpTZ3hjKJ7uTADH1NDCv77XifFwPY/a2wmEnLGmEO431M10xztLslxwnf
         oBgCJ2FyQvrlcpvyOqmEAZUNjj9ixnuiJ18VYYfHKaUtoJg9A14gsMDdPRLax5u51CXU
         Fb8qkng7Bvier9ahfg//jRCwG+nszM23d5up8bOAJ7dDEhv9fX8dlfhWb7PwhX5uEt3f
         3pzg==
Received: by 10.60.1.40 with SMTP id 8mr10299265oej.55.1350384342909; Tue, 16
 Oct 2012 03:45:42 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Tue, 16 Oct 2012 03:45:12 -0700 (PDT)
In-Reply-To: <20121016053750.GA22281@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207811>

On Tue, Oct 16, 2012 at 12:37 PM, Jeff King <peff@peff.net> wrote:
> I suspect a site that is heavy on alternates is invoking the index-pack
> code path more frequently than necessary (e.g., history gets pushed to
> one forked repo, then when it goes to the next one, we may not share the
> ref that tells the client we already have the object and receive it a
> second time).

I suppose we could do the way unpack-objects does: prefer present
objects and drop the new identical ones, no memcmp. Objects that are
not bases, or are ref-delta bases, can be safely dropped. ofs-delta
bases may lead to rewriting the pack. Do-able but not sure it's worth
the effort.
-- 
Duy
