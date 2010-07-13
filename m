From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Tue, 13 Jul 2010 22:16:40 +0000
Message-ID: <AANLkTin0UtjqOIpbEwu9YTCtt2A_QNiWExu-ov13DVfd@mail.gmail.com>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
	<20100713054949.GB2425@burratino>
	<AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
	<AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
	<AANLkTimCjfFh25vbzotufpTnUjfRglzHiQeDzWz8O5RJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Daniel F <nanotube@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 00:16:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnmR-0000we-8c
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab0GMWQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 18:16:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37941 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab0GMWQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 18:16:41 -0400
Received: by iwn7 with SMTP id 7so6282541iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=foZumJb4K/pP08Y9pZd4uodZxgLk0EW2MvCihSERa1o=;
        b=b+69zyaizBhXN6BEqCyM+l92jL8e3i0KLeNoISastd9yRRnvoD71PIBuNFXeN5RqTQ
         dGOMG9GrhC+y9mbwjIQBhTmshyMPC4lbNNB+EStZMetJiS14SlI3d16hv7UBV0yymxMW
         b36bs7ht0UfsZHuCm6TXPOFwFeBdxKENLOZrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=B7VEIUY0E++1Qt8zGPiAjwMmLjOG1+Ybs1o731P396pzUFC5VQ0pH78Q81F794RLnI
         EE8GvO5Z9XJckmCqlfwLcTo10h3aMfp8Kf2GZMYk3JxnOlhKZbVXKqSCJ7idbW/72lyA
         2VIp7hpnyqy9Ny9+wx8G3o3vcn7xtQQgoq6Mc=
Received: by 10.231.17.13 with SMTP id q13mr15665018iba.14.1279059400615; Tue, 
	13 Jul 2010 15:16:40 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 13 Jul 2010 15:16:40 -0700 (PDT)
In-Reply-To: <AANLkTimCjfFh25vbzotufpTnUjfRglzHiQeDzWz8O5RJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150930>

On Tue, Jul 13, 2010 at 15:48, Daniel F <nanotube@gmail.com> wrote:

> Ah yes, indeed... Well, is there any reason to even have that
> length sanity check in the first place? If someone wants to be
> identified with a nick of 1 or 2 chars, what's wrong with that?

I don't know. The whole thing seems a bit silly. I changed it:

    -   if (name->len < 3 || 60 < name->len || strchr(name->buf, '@')
||
                   +   if (name->len < 1 || 60 < name->len ||
strchr(name->buf, '@') ||

And nothing in the test suite broke. Removing the `name->len <' clause
completely broke one test in t5100-mailinfo.sh however.

But I don't understand that part of Git, maybe it really will break
horribly somewhere with:

    Author: av <a@v.net>
