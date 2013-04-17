From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 17 Apr 2013 16:36:39 +0530
Message-ID: <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 13:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USQD1-0007CE-8S
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 13:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106Ab3DQLHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 07:07:21 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:40680 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934715Ab3DQLHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 07:07:20 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so1317182iah.31
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=X6zteUdkFNd3wk2UZCuvE31m+v/noMWhvFOXMajkk14=;
        b=xgcJAw0utaOI1gszh6qFuuDX4u71P+a/VPEJI0y5VDow9yxeIMbHm+wCgp3Jo3BfLu
         sYRbQpUUd7ORFE6M71c4M3BzTHPXVSS6LPXL+Oe30w7erqATgwXBV1e7RaCYLcLsUXBi
         RHl3U7y/Zf/i98a/4/va41V4lqOhY7aOgYjw7qZExlamYNqmtTXPvmU84WRn5Oky9Fk1
         FRLE0cK3vdr05h7V0jB+evhWyaGvBm5E6aRfZQQhQMfgpwGxqFtGwaYNdpySmUc4T1L3
         jNLzPzYUJJ3/+6zq+sXvRAizD+rmsScCGUVZvEFuVnxD7IalRgPcyZERjehBDxkABJST
         aUoQ==
X-Received: by 10.50.50.71 with SMTP id a7mr10210975igo.14.1366196839509; Wed,
 17 Apr 2013 04:07:19 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 17 Apr 2013 04:06:39 -0700 (PDT)
In-Reply-To: <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221534>

Duy Nguyen wrote:
> Somewhat related to the topic. Why can't .gitattributes be used for
> storing what's currently in .gitmodules?

It can.  It's just a small syntax change from "key = value" attributes
inside a toplevel [submodule <name>] section separated by newlines, to
a path marked with multiple "key=value" attributes separated by
whitespace.  However, we don't want to make this change because these
submodule attributes are somewhat "different" from .gitattributes
attributes.

Roughly speaking, the current .gitmodules design treats submodule
directories as "directories with special attributes", with two
differences: these directories have a special mode in the index, and a
commit object is created in the database to represent the "partial
state" of this submodule.  If you think about it, the information
stored in the commit object is no less/ no more important than the
path-attribute mapping in .gitmodules.  I was arguing for using a
special OBJ_LINK to represent the full state of the submodule, and
doing away with the attributes altogether, but not everyone agrees.
