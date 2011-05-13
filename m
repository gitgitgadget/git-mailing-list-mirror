From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Fri, 13 May 2011 09:39:14 -0400
Message-ID: <BANLkTinoGfj1NUzTveSH0vgwZczCaFr8HA@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com> <BANLkTi=YDZa+BRaG90vJsjrT9VxgySrDRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 15:39:49 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKsan-0005vT-5q
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 15:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933122Ab1EMNjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 09:39:37 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52877 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092Ab1EMNjf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 09:39:35 -0400
Received: by pzk9 with SMTP id 9so1170810pzk.19
        for <multiple recipients>; Fri, 13 May 2011 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mGCQ/+/NaE+xFPIPa2CBgfDMznjr6VHgGqn3EO2eh50=;
        b=K8U8DM3DQDzqbgOg8O1xktOJbTcvJ+puAvr0vP+uYab10HskO8VkdsFXHUrWxp266f
         AwHO0WdBloHOlf7TLWX6tWz4qFRe/60JgW7devCs/+0P39KhWAoXvLY3+wLyZXoWhLyi
         wuakxh83+8S6HFv3qseZSoPtG48RCKFRfKPnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=g8smaR+x9vmYW3WJSZxpg//lDRMp99nMqYsat5AXonzeUkGi4YkefvBOTuDaRPIuhl
         NDwM0VkflDLxT1niqALV1fxjjZtLAczDlfzT5kULskOPkJWxH9kTPGwh68rhPZrNVouN
         NgD5Hvues8lvHGoY2JFOyzOCmr6Wt4qrolEqw=
Received: by 10.68.48.168 with SMTP id m8mr2246221pbn.113.1305293974098; Fri,
 13 May 2011 06:39:34 -0700 (PDT)
Received: by 10.68.41.197 with HTTP; Fri, 13 May 2011 06:39:14 -0700 (PDT)
In-Reply-To: <BANLkTi=YDZa+BRaG90vJsjrT9VxgySrDRQ@mail.gmail.com>
X-Google-Sender-Auth: v-59R5pg1k7NOho4jAexC06Mqxk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173538>

[resend because the Android gmail client apparently generates HTML
emails even for plain text]

On Thu, May 12, 2011 at 1:37 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, May 12, 2011 at 10:15 AM, Andrew Lutomirski <luto@mit.edu> wr=
ote:
>>
>> OK, this sucks. =A0In the course of bisecting this, I've hit two oth=
er
>> apparently unrelated bugs that prevent my from testing large numbers
>> of kernels. =A0Do I have two questions:
>>
>> 1. Anyone have any ideas from looking at the log?
>
> Nope, that doesn't look very helpful.
>
>> 2. =A0The !&$#@ bisection is skipping all over the place. =A0I've se=
en
>> 2.6.37 versions and all manner of -rc's out of order.
>
> That's the _point_ of bisection. It jumps around. You can start off
> trying to pick points on my development tree, but I only have a
> hundred merges or so. You're going to start delving into the actual
> development versions very quickly. And if you don't do it early,
> bisection is going to be much much slower, because it's not going to
> pick half-way points.
>
> So bisection works so well exactly because it picks points that are
> far away from each other, and you should just totally ignore the
> version number. It's meaningless. Looking at it just confuses you.
> Don't do it.
>

I actually had better results looking at the version number, saying
"blech", and running git merge v2.6.38.  (git bisect good gets a
little confused if I feed it the merge result, but I can just lie.)

Anyway, I must have made a mistake somewhere.  The regression is in
drm (presumably i915) and it has a new thread now.

--Andy
