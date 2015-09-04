From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Fri, 04 Sep 2015 09:08:02 -0700
Message-ID: <xmqq37yugobh.fsf@gitster.mtv.corp.google.com>
References: <1415626412-573-1-git-send-email-anarcat@koumbit.org>
	<87twspe6ix.fsf@marcos.anarc.at>
	<xmqqegjticd7.fsf@gitster.dls.corp.google.com>
	<55E7FEF3.2020400@drmicha.warpmail.net>
	<xmqq613rl92s.fsf@gitster.mtv.corp.google.com>
	<55E9A5B2.5080606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@koumbit.org>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:08:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXtXE-0001aY-HF
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 18:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236AbbIDQII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 12:08:08 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33338 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760235AbbIDQIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 12:08:05 -0400
Received: by pacex6 with SMTP id ex6so28316114pac.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5hjdARMoGoZ+YNsswmEmVJlq2LXTUd6Q5C4hS0c86YE=;
        b=aIBuzwW03gKqHYkGMPBVwez7YntHOR2Z6jBLRpJecQMv6Pb37viNaRdPHrRmrdowVH
         mewfDPP9CJ9CAxGX5vOf0smFjPIoKyLoKAOgwLIIuHfr+yUuFrGycObcbQQMWVc2Bj1C
         daRyCZ3wV/0N7WghjzDDiOq/kB7bbUOHzM2JrvVSodB2YXeh3qX/5k8mG3JkUzhS88iL
         gfebfgra6XdJnLjMNxfMYg7j2Pe78bJKFc9ZxjjuYFrQUjCcOS9z5+u3MVWNJXjcbFkZ
         MQgEuNqLAYyqYVzKp/g7RMcOFPbko2cJqRI2J8GkwsymQCFtliABzQ7cYBG+s/+2kzaX
         FN3g==
X-Received: by 10.66.234.202 with SMTP id ug10mr9976790pac.50.1441382884838;
        Fri, 04 Sep 2015 09:08:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id fl6sm3003160pab.12.2015.09.04.09.08.03
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 09:08:03 -0700 (PDT)
In-Reply-To: <55E9A5B2.5080606@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 4 Sep 2015 16:07:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277319>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> How would it? "--left-right" information is requested specifically and
> not overridden. Root information is not requested specifically [by the
> user].

If this "highlight root prominently" were a config, then using both
config and --left-right would mean one of them needs to give.  If
this were always on, then the act of the user running "git log"
alone is a sign that the user explicitly asked the log to be shown
with the new world order, i.e. the root is promised to be shown
visible.  Either way, the user is not getting what s/he asked.

>>> If we want to put more information into log --graph simultaneously we
>>> should really go beyond ASCII and look at how tig does it, e.g. using
>>> unicode characters.
>> 
>> That's another way to do so, but shifting columns to show where the
>> history is not connected also does not change the overall layout,
>> provides more information by default, etc., and a big plus is that
>> it would be an approach to do so without having to go beyond ASCII.
>
> That would consume more horizontal space and annoy at least some people.

I sense that we are working from different perceptions of what
"shifting columns" should look like.

A history that reaches two roots would be shown like this, with or
without any special treatment for root:

 * tip
 |\
 | * tip of the side branch
 * | tip of the trunk
 * | second of the trunk
 * | root of the trunk
   * second of the side branch
   * root of the side branch

so it does not give us any more "wasted space" issue with or without
"showing root more prominently".

The case where we would see differences is to have two or more
totally disjoint histories.  But "shifting columns" does not have to
draw that case like this:

 * tip of history A
 | * tip of history B
 * | second of history A
 * | root of history A
   * second of history B
   * third of history B
   * fourth of history B
   * fifth of history B
   * root of history B

It can do this instead to save horizontal space (which I agree with
you is the more precious one than the vertical one):

 * tip of history A
 | * tip of history B
 * | second of history A
 * | root of history A
   * second of history B
  /
 * third of history B
 * fourth of history B
 * fifth of history B
 * root of history B

It does spend more space around the root of each history (in this
case, history A) when it shifts the column for history B to the
space now vacated by history A in order to save horizontal space.
But drawing the graph around the root differently from other parts
is exactly to show roots more prominently; it draws the users' eyes.

Here is another example of drawing the same history.  If the
traversal is topologica:, "shifting columns" does not have to draw
this:

 * tip of history A
 * second of history A
 * root of history A
   * tip of history B
   * second of history B
   * third of history B
   * fourth of history B
   * fifth of history B
   * root of history B

It can do this instead:

 * tip of history A
 * second of history A
 * root of history A
   * tip of history B
  /
 * second of history B
 * third of history B
 * fourth of history B
 * fifth of history B
 * root of history B

Again I am not saying that "shifting columns" is the only way we can
do this, and there may be other ways to do this without losing
information.  Going beyond ASCII as you hinted would be one example.
