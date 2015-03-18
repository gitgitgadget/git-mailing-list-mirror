From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 21:33:29 +0700
Message-ID: <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 15:34:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYF2s-0007FB-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 15:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbbCROeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 10:34:01 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34101 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbbCROeA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 10:34:00 -0400
Received: by igbue6 with SMTP id ue6so74314897igb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MKn7+RTAwYZv8tYNkU+8gXyEJIVs6u9Wh9jve1DrRaM=;
        b=BZSkjpP+L2cqgnYER6ML+JTDs/u6uVwY49/ppAB7r0Poq3NBuCYZ9KKC0Pb3XdnuMY
         o7skOqu6+kIgssH3oHg3MD4Hl/+kOK2HmGUWIAPZ2xmUy4WlMdN8Fe8pYGSuAng6y7u3
         cPo6L/6nr45e0c+3r1GdZcQo/SEXU6DzEcAcqUMaGc5wMQ6nBkqbp/3Og1+Vzab1KWJ0
         Z2c7X6F7OUKs0QYEfjRFlBRo280kq0sBJqeDbF6jp8+mwoNlU+nDaLXkfNL60EQjkr9X
         03enyPhqh9PWHPKo4TPbhb4YaNuGY7V07raQWQ3p8fVnZuNxf4PhDuWx3j4upo5BTqli
         qnJA==
X-Received: by 10.107.19.204 with SMTP id 73mr106878258iot.83.1426689239609;
 Wed, 18 Mar 2015 07:33:59 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 07:33:29 -0700 (PDT)
In-Reply-To: <55098A49.1020003@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265733>

On Wed, Mar 18, 2015 at 9:23 PM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=
=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
<dilyan.palauzov@aegee.org> wrote:
> Hello,
>
> # git gc --auto
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
>
> and calls in the background:
>
> 25618     1  0 32451   884   1 14:20 ?        00:00:00 git gc --auto
> 25639 25618 51 49076 49428   0 14:20 ?        00:00:07 git prune --ex=
pire
> 2.weeks.ago
>
> # git count-objects -v
> count: 6039

loose number threshold is 6700, unless you tweaked something. But
there's a tweak, we'll come back to this.

> size: 65464
> in-pack: 185432
> packs: 1

Pack threshold is 50, You only have one pack, good

OK back to the "count 6039" above. You have that many loose objects.
But 'git gc' is lazier than 'git count-objects'. It assume a flat
distribution, and only counts the number of objects in .git/objects/17
directory only, then extrapolate for the total number.

So can you see how many files you have in this directory
=2Egit/objects/17? That number, multiplied by 256, should be greater
than 6700. If that's the case "git gc" laziness is the problem. If
not, I made some mistake in analyzing this and we'll start again.
--=20
Duy
