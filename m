From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 2/2] submodule: port init from shell to C
Date: Wed, 20 Jan 2016 14:33:36 -0800
Message-ID: <CAGZ79kajF9zR_m0+hbvasf+rwQcuDeywCzmdjuT6C4M5MBvmUQ@mail.gmail.com>
References: <1453255396-31942-3-git-send-email-sbeller@google.com>
	<1453260274-31005-1-git-send-email-sbeller@google.com>
	<xmqq60yo55jh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:33:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM1Jt-0001NR-Kx
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 23:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbcATWdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 17:33:38 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34725 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbcATWdh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 17:33:37 -0500
Received: by mail-io0-f175.google.com with SMTP id 1so35563795ion.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 14:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/Hz4EPpcULClLLyPUq0/wTxJet9yIDc8qf1ljCCxgRw=;
        b=F9NJ6o7okBINKnbryRxzwfXL0Vpm//MhDZe5kAbhm4VMaXy5RrF8HuUrlkw4yYgqe5
         LUQ7HhCQqQuemfJmPgP1lxaOiu0kHTE8d61CQ4Dhp+gZoC7dPp3OD6WBERajvsmeaqth
         dvMt7y4Vv09zsa7U9j+HfqwbJliMTv2OrhMou5eSLa97nnydgHbTW9tBZWZB+MRwyLQh
         JE32FS/2oDBB1yQzDSBPc6iwnMSDmo2nCJ9ceSgwrrJmnP3BI/p/7PbtK91dWUey90Ib
         EYxKxYiVYACTYJVZvmBMwZVLUYX/orSBD4S0Yoz8cetfKn2qIInPhp7FlgWTaHMe4390
         gzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/Hz4EPpcULClLLyPUq0/wTxJet9yIDc8qf1ljCCxgRw=;
        b=cpcqMJLmmDTVCg7pJfPm42aWq6Rm4jWN/sivg4mX/s+PQ86JjDH2vg5XCn8RlawdUI
         86IE3GlEZoDmX7JwJANhqfjFCMRNt0Vx1ExOpmJvMHBN+m3K4zb6EUf5iOrbO235Prri
         ks/YzrS4XgFzOI4GECkyZPvckDrusBRqzPgrLqP8ED+SHZDlc/zkKP5m9wS9JH2l5bd9
         nRlV56tIPiXrdkiEnfgXgM9TlPQMh1ugGp9bZLvVP5lnVDfTyjbetSvOnQf6Q6EZ++Vg
         yW8crvhGILayaVb+lCA1FQf3G8spV0DlN9qD2bZt2IiG+AeQVQOF85HMdZCoCnXp+kvt
         UA0Q==
X-Gm-Message-State: ALoCoQltwTKwOoR/gXlPnAmfpWdWFwJ2QJZOo21MW1Dr3wOyziWja1Y8jhLuU12t5aiu/ux9pX3710OrQ7sZ6+bmk4lli87AOkVekjp5XPg5TXaxc4m/Rt0=
X-Received: by 10.107.168.203 with SMTP id e72mr33930571ioj.96.1453329216357;
 Wed, 20 Jan 2016 14:33:36 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 20 Jan 2016 14:33:36 -0800 (PST)
In-Reply-To: <xmqq60yo55jh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284477>

On Wed, Jan 20, 2016 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> By having the `init` functionality in C, we can reference it easier
>> from other parts in the code.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> How faithful a conversion is this aiming to be?  For example, one
> thing I noticed is that some messages that were originally given
> with "say" and sent to the standard output, which is emitted to the
> standard error with this rewrite.  I didn't read both patches
> carefully, so there may be other discrepancies I didn't spot.
>
> I think you would want to do this in three steps:
>
>  - A faithful rewrite from shell to C;
>
>  - s/printf/fprintf(stderr, / for some messages; and finally
>
>  - Hiding of some messages under --quiet.
>
> in the above order.

"say" respects the setting of GIT_QUIET, which is usually set when
--quiet is passed, so I think I want:

-  A faithful rewrite from shell to C including messages respecting
   --quiet, such that the "say" behavior is kept.

- s/printf/fprintf(stderr, / for some messages

and then be done with it.

Thanks,
Stefan


>
