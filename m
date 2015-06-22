From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v7 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Mon, 22 Jun 2015 23:07:17 +0200
Organization: gmx
Message-ID: <aaf356d9d155cea34238883f22ed9cc6@www.dscho.org>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
 <xmqqlhfbhb9u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:07:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78wC-0000ih-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbbFVVHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:07:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:52024 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbbFVVHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 17:07:23 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lo3IS-1YaG211naa-00fwQs; Mon, 22 Jun 2015 23:07:17
 +0200
In-Reply-To: <xmqqlhfbhb9u.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ZSwoFHHRBzfXuZ6EnMee3+ZOfL92pmL2TNMb1aLuHZhKrZLgr0e
 9fnsvzgdqY2UWg5ushdLQhjy8cppQB88aFMRwTcv4vjRfyGQh2sVKI2r9q39ZVM+IYF8Yan
 vyTdUvpU/jnJiOjS1TtUzuq089g3kJiaE0Z8/snjNb+G0i3k3UNeWb1e8rxkSURusJpr3qq
 BLPVEfH5GrE8AZbK/0MSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I4gh6Xg8nlQ=:1oipWIIiosgaL0dQA6gcK0
 uvW/uBBVjkcNBlNKqRW9yMGh9/g2O5zTpyRaa9mPScJcVmmLAC0jlxq/hIWA6zwTeAx/WqV+m
 pxhq206GfUNx9LRc9rNF/AMGKL4pG/FJV9azZ/AJwYREcuMPD09MqK5KY81hkL/ISfwNN6Jax
 SFKjf8oPoNPVQcy7nsWn7w4IBZQA02W3tCQ5lYPshLhcBmhBn/8LEum54TMue6P4ZEGvhhAoz
 do/TjSaeolJ5+UiBrV9UyqpaUnoLcmgds07nlqBAAmbyz0yKlB9U4MMRacdd0JB80hOHYPy8U
 IvFAuu5O171tr+qDLJFwY+nrZ+SxzVhvSTmvcMwfW2HRdYzgpdFer5wPkZWlzMoQZlwT4tQ6E
 uOU+IIVn7A3VdgvXrZg1vnnsLeCO/K/OYtzCDgGg7/UDu0kpYpA4rKBilwA+JbVYcVfyKcG1P
 ua4Uyd5YVZ88ewSW3bs0CBb2NHX3wec4MXPXRb7pd1MFqCZf7y78q4q7sbtAGideIxApZzpgx
 xtf5GUCfQHVk2vSISg153lsuUwmhEBFUWewjbthJcrDs5xeli9JzbWDuYmcIUSgQG/MS230P6
 QbPRyZsdfMN/KflqeViHf78XUr1nKBcC4PmOuSAkLdQ2RylWB4thOx0GFUKLMdWRgA0okW8IY
 SK8cbsl619IxYC0aDlHgl6tPkZR71GWCsNivE3OI/JljpxLwn/0eq9c7fPNPnv//WDjM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272417>

Hi Junio,

On 2015-06-22 20:02, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Changes since v6:
>>
>> - camelCased message IDs
>>
>> - multiple author checking now as suggested by Junio
>>
>> - renamed `--quick` to `--connectivity-only`, better commit message
>>
>> - `fsck.skipList` is now handled correctly (and not mistaken for a message
>>   type setting)
>>
>> - `fsck.skipList` can handle user paths now
>>
>> - index-pack configures the walk function in a more logical place now
>>
>> - simplified code by avoiding working on partial strings (i.e. removed
>>   `substrcmp()`). This saves 10 lines. To accomodate parsing config
>>   variables directly, we now work on lowercased message IDs; unfortunately
>>   this means that we cannot use them in append_msg_id() because that
>>   function wants to append camelCased message IDs.
>>
>> Interdiff below diffstat.
> 
> Except for minor nits I sent separate messages, this round looks
> very nicely done (I however admit that I haven't read the skiplist
> parsing code carefully at all, expecting that you wouldn't screw up
> with something simple like that ;-))
> 
> Thanks, will replace what is queued.  Let's start thinking about
> moving it down to 'next' (meaning: we _could_ still accept a reroll,
> but I think we are in a good shape and minor incremental refinements
> would suffice), cooking it for the remainder of the cycle and having
> it graduate to 'master' at the beginning of the next cycle.

Let me submit a v8 with the borked fixup fixed (i.e. part of 04/19 moved to 03/19, where it really belongs), the `for` style fix, the fixed double space and the cast style, too.

Ciao,
Dscho
