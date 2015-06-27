From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sat, 27 Jun 2015 11:41:21 -0700
Message-ID: <xmqq8ub5f0z2.fsf@gitster.dls.corp.google.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<CAP8UFD0Zzjcc94qcUJOpfSrTej-o6hRKzZOuTufzAbOPkjUr_A@mail.gmail.com>
	<vpq7fqppn5h.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:41:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8v2f-0007kJ-ID
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 20:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbbF0SlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 14:41:25 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34058 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbbF0SlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 14:41:23 -0400
Received: by igcsj18 with SMTP id sj18so53408970igc.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vI3/ucLx0iiygHX2OK6rQm6q8JLH5CGQTiSS77NFFN8=;
        b=NJvzpCngVsC14ou0oGoyiabXp3keudrE/79RBfSmBbx3/n0LNf5sz7NaDIqII2il1e
         X/pqWBQEn2hY3CknGhfpWBPNv/7avo1Q3QQM/lIYJvOhQFwCAiWCcaSa5ZNecyCRI8Um
         3cz5t6sElW1dTdP2ot7PL8+8HlJ8b8Up4lsrNVxWBfS4VjajLbLMRagfCpa8LLaq3UmG
         8yEwBoRNAKu5wt/EC+RLsR4+bwDUu45XF+BnTa7zJ8sflqv/xh5ShJ77X/eyI6Xr0SOC
         PJXoxwWzAYULIKzYMVHUQPBQnMumc6zpOhuSc8Xm/j8mwjE8CROGQw3scqrKWWyxbruH
         /qZQ==
X-Received: by 10.42.197.5 with SMTP id ei5mr9514695icb.80.1435430482938;
        Sat, 27 Jun 2015 11:41:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:205e:4a52:83c1:a37f])
        by mx.google.com with ESMTPSA id pg5sm1681799igb.4.2015.06.27.11.41.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Jun 2015 11:41:22 -0700 (PDT)
In-Reply-To: <vpq7fqppn5h.fsf@anie.imag.fr> (Matthieu Moy's message of "Sat,
	27 Jun 2015 10:32:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272860>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Sat, Jun 27, 2015 at 6:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Fri, Jun 26, 2015 at 9:10 PM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>>
>>>> If we don't want to support positional arguments, then I would suggest
>>>> supporting first the following instead:
>>>>
>>>>          git bisect terms --name-good=fast --name-bad=slow
>>>>          git bisect terms --name-bad=slow --name-good=fast
>>>>
>>>> This would make the interface consistent with the code.
>>>
>>> Which somewhat defeats the point of introducing "old" and "new", though.
>>> The "terms" support is for people who feel that good/bad would be too confusing
>>> for the particular bisect session (e.g. because they are hunting for a fix).
>>
>> Well if --name-old and --name-new are also available as synonyms, it
>> would not be too bad I think.
>> People could use the option names that fit their mental model or their
>> use case better.
>
> OK, I'll add both.

I moderately hate to see both from aesthetics point of view, but can
we at least lose "--name-" prefix?  Having to repeat that twice does
not add any value to the subcommand.
