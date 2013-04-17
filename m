From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Wed, 17 Apr 2013 21:27:40 +1000
Message-ID: <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com>
 <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 13:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USQXC-0002aq-OJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 13:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965870Ab3DQL2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 07:28:14 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:55408 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab3DQL2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 07:28:13 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so1308441obc.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IeTL5I1dueSkmCGu+1g15Cxl6Hb4Y20SMJuOhl7dso0=;
        b=kxw5270z5spprA62elPO/zp5C8B3XkY4foS+mUEmmK8wms6+lxImA9b5XdPcrWHOjn
         +szQhSvSp5yyVfr+iGn9/bTkg0URg80QvSxSqE7ebqoQJRkjraX/bQqCerazU3aDQMhm
         hXdXZq5mD2xlwEr5GZY3fLg1a9h0SV5TU8oFNvNl3v9yUcFbdk9xuP/weQxHvStH0TQq
         5IEQZg72bLUNs5E2c6GBz2gqkK/WkkuB6VtIWoNsLp/cL3GGH1fb0226Pt5Y2JlpmOEk
         9iJAYlN2Wy8/HfU91nILBZtj/18N5dJZVa+gfBg/t8Hy0f9CxtSshrZo5jHli29KoIAF
         6epw==
X-Received: by 10.182.116.70 with SMTP id ju6mr2213590obb.48.1366198090741;
 Wed, 17 Apr 2013 04:28:10 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Wed, 17 Apr 2013 04:27:40 -0700 (PDT)
In-Reply-To: <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221536>

On Wed, Apr 17, 2013 at 9:06 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> Somewhat related to the topic. Why can't .gitattributes be used for
>> storing what's currently in .gitmodules?
>
> It can.  It's just a small syntax change from "key = value" attributes
> inside a toplevel [submodule <name>] section separated by newlines, to
> a path marked with multiple "key=value" attributes separated by
> whitespace.  However, we don't want to make this change because these
> submodule attributes are somewhat "different" from .gitattributes
> attributes.
>
> Roughly speaking, the current .gitmodules design treats submodule
> directories as "directories with special attributes", with two
> differences: these directories have a special mode in the index, and a
> commit object is created in the database to represent the "partial
> state" of this submodule.

That was my thinking. .gitmodules would break if a user moves the
submodule manually (or even if .gitattributes is used)

> If you think about it, the information
> stored in the commit object is no less/ no more important than the
> path-attribute mapping in .gitmodules.  I was arguing for using a
> special OBJ_LINK to represent the full state of the submodule, and
> doing away with the attributes altogether, but not everyone agrees.

Include me to those everyone. url feels like a local thing that should
not stay in object database (another way of looking at it is like an
email address: the primary one fixed in stone in commits with .mailmap
for future substitution). Other attributes like .update,
.fetchRecursiveSubmodules... definitely should not be stored in object
database. I think if they are stored in the submodule's config file,
then the manual move problem above will go away.

And if you're dead set on storing some submodule state in object
database, why not reuse tag object with some nea header lines?
--
Duy
