From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Wed, 2 Jan 2013 09:23:39 +0700
Message-ID: <CACsJy8D0fQ4-DiLx=mqm16Om829Zcno2oTi5F1c78H615-Hivw@mail.gmail.com>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net> <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net> <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net> <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
 <20121230213124.GA15946@sigill.intra.peff.net> <CAJo=hJtjtpiPVd6Koy9q5je7s7A4EyDa-CptJNCnHLSLgd9W7g@mail.gmail.com>
 <CACsJy8CygfaM+Ee6rURFB-cP2khO8URGDJMG2f3mqg0ebYz+8Q@mail.gmail.com>
 <CACsJy8DpnO6X6jdQVsr1NwrXF2MDBBcHZQTay=TyLFc5p_z9eg@mail.gmail.com> <CAJo=hJsZedd0kfYJnXPhcud8bz3mgU0NMf6O6-_PY1yqv-EfDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 03:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqE0M-0001hu-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 03:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab3ABCYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 21:24:11 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:63005 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3ABCYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 21:24:10 -0500
Received: by mail-ob0-f181.google.com with SMTP id oi10so12158210obb.40
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 18:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cvpAFca/VMe5V10epvhjGG5Z7y3j4up7evV+b0JZB0Q=;
        b=GzGNxWuQ0txDTpee+Z34Qn3e/TWYMZ9zSoXGU7zwoIX8WBc45EJ37UruW7Abz4b+xv
         /G+sX6vMwn/HTpDk5m7MBproIIW+M6Dx4HnUkZRy7GQa6t40lkIyoQtv8K7mQI++7PvT
         50Hxy67lg1EXvracVxGijD4TQJ9z/iedJfuwunSCRHvDA0T9bkYKaKusLYPojNvpp4kK
         ClABXfDP9rCfbw3A1+Kn032J9YNqjAYQkmUC45ZLTI/9EBQqJzhiW6Owk39bY/RLswbh
         jWKAfpFlr3EgfSTaIkHb2atlRstuaCMPKT7TMXfiKZc7OlPPCf26MSux46Fnl88kAXMX
         +kJA==
Received: by 10.182.212.2 with SMTP id ng2mr36342346obc.81.1357093449153; Tue,
 01 Jan 2013 18:24:09 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Tue, 1 Jan 2013 18:23:39 -0800 (PST)
In-Reply-To: <CAJo=hJsZedd0kfYJnXPhcud8bz3mgU0NMf6O6-_PY1yqv-EfDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212489>

On Wed, Jan 2, 2013 at 12:17 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> And I was wrong. At least since 1b4bb16 (pack-objects: optimize
>> "recency order" - 2011-06-30) commits are spread out and can be mixed
>> with trees too. Grouping them back defeats what Junio did in that
>> commit, I think.
>
> I think you misunderstand what 1b4bb16 does. Junio uses a layout
> similar to what JGit has done for years. Commits are packed, then
> trees, then blobs. Only annotated tags are interspersed with commits.
> The decision on where to place tags is different, but has a similar
> purpose.

This is embarrassing. I looked at verify-pack output and somehow saw
trees mixed with commits. I must have read it wrong. "git verify-pack
-v <pack>|awk '{print $2;}'|uniq on recently created pack shows that
only tags and commits are mixed. Sorry for the noise.
-- 
Duy
