From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/7] ident_split: store begin/end pairs on their own struct
Date: Sun, 22 Jun 2014 21:28:29 -0400
Message-ID: <CAPig+cSZfm4fL0xBUCMKU5h8gWeSb736T8Rv62QhREg1F=xzqA@mail.gmail.com>
References: <20140618201944.GA23238@sigill.intra.peff.net>
	<20140618203133.GD23896@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 03:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wyt3i-0003G0-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 03:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbaFWB2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2014 21:28:30 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34046 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaFWB2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2014 21:28:30 -0400
Received: by mail-yh0-f45.google.com with SMTP id t59so4554553yho.18
        for <git@vger.kernel.org>; Sun, 22 Jun 2014 18:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3F69UbpE7oKCI7X1qpJvyjxMzhhZLzPkpjBDFSdDUIA=;
        b=PxyDO/64UjLp8S9cvg0lFd9lsvOxuF+zTKVMpDJW2WPwWkGWb76t3dAMOK4XENNxvu
         WzBPFwT9lhdDWG3bnJalL3miYUFmDe6HTeVpsPbUwEx/dBTBavnvdq+kfJ47QmYg9QVM
         C3xLRMzBd6x/q8rQnwjx4clvvg4lVKZtIOAuXSCm/2hEMcss7PXEusE9xtkLTjsQ1rdb
         b9GtxYoxKPrui6qLt9mYLkFVBIzME87FZE22caxTsbc1YrHLtqZdWxjT7kmWuwiDkJkf
         xO5ffwvYubSmr+5dw3upoLM0VPrckkJJGHAbrt8EbslKhoIK0idZt+gGQTo+PV2zBP6N
         2Gxw==
X-Received: by 10.236.31.39 with SMTP id l27mr30581278yha.7.1403486909365;
 Sun, 22 Jun 2014 18:28:29 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Sun, 22 Jun 2014 18:28:29 -0700 (PDT)
In-Reply-To: <20140618203133.GD23896@sigill.intra.peff.net>
X-Google-Sender-Auth: po_j11M52BCvKa2ihLNrYXkUOWI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252317>

On Wednesday, June 18, 2014, Jeff King <peff@peff.net> wrote:
> Subject: ident_split: store begin/end pairs on their own struct

s/on/in/

> When we parse an ident line, we end up with several fields,
> each with a begin/end pointer into the buffer, like:
>
>   const char *name_begin;
>   const char *name_end;
>
> There is nothing except the field names to indicate that
> they are paired. This makes it annoying to write helper
> functions for dealing with the sub-fields, as you have to
> pass both sides. Instead, let's move them into a single
> struct "name", with fields "begin" and "end". This will be
> stored identically, but can be passed as a unit.
>
> We have to do a mechanical update of "s/_/./" at each point
> of use, but other than that, the fields should behave
> identically.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Suggestions welcome on the name "pointer_pair".

str_segment  ;-)

> While writing this series, I also noticed that it would be more
> convenient to have a pointer/len combination rather than two pointers.
> You can convert between them, of course, but I found I was always
> converting the other way.
>
> I left it this way because it makes the mass-update mechanical (and
> because now that I can pass the pair as a unit, I don't have to write
> the same "ident->name_begin, ident->name_end - ident->name_begin" pair
> over and over).
