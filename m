From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] sequencer: factor code out of revert builtin
Date: Sun, 13 Nov 2011 16:10:12 +0530
Message-ID: <CALkWK0n7v15n_s3CNq1Qu3LHjYkV-ENAkv2b+oB+VBkyV+Sphw@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-2-git-send-email-artagnon@gmail.com> <20111106001232.GC27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:40:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXUN-0006jO-Mi
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab1KMKkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 05:40:35 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49956 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1KMKke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 05:40:34 -0500
Received: by wyh15 with SMTP id 15so5050284wyh.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LGtCXSgCN7Bm/3MDkzDcHWYTv2IO9AQCwnaYCEu0qxs=;
        b=l9D+dw5zqgMKs1y0CoUCJwodgO+DEIgwv5GFySQcErLFos7H2/32kLyAfTaeTSpFik
         Jh8Kt3bqT3PSPZR4zBhy58YQSBQQRs15Ljyr5urc+/CO+138f33JfmNHSIoynGkKi9of
         QijJ7xRR9HVAIFIDVO4nIiLPMT1sb1NCF3pXY=
Received: by 10.216.133.155 with SMTP id q27mr424681wei.101.1321180833101;
 Sun, 13 Nov 2011 02:40:33 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Sun, 13 Nov 2011 02:40:12 -0800 (PST)
In-Reply-To: <20111106001232.GC27272@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185327>

Hi,

Small note.

Jonathan Nieder writes:
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1,7 +1,27 @@
>> =C2=A0#include "cache.h"
>> +#include "object.h"
>> +#include "commit.h"
>> +#include "tag.h"
>> +#include "run-command.h"
>> +#include "exec_cmd.h"
>> +#include "utf8.h"
>> +#include "cache-tree.h"
>> +#include "diff.h"
>> +#include "revision.h"
>> +#include "rerere.h"
>> +#include "merge-recursive.h"
>> +#include "refs.h"
>> -#include "sequencer.h"
>> -#include "strbuf.h"
>> =C2=A0#include "dir.h"
>> +#include "sequencer.h"
>
> Why did sequencer.h move to after dir.h?

1. I like the convention of including the "foo.h" as the last header
in "foo.c".  I suppose it has to do with the way I include standard
headers in my own code (for pet projects).
2. I didn't want to include many of these headers in sequencer.h again
-- it uses a lot of these data types.  I've noticed that ordering of
header inclusion is important in many parts of Git, so the convention
just stuck.

Thanks.

-- Ram
