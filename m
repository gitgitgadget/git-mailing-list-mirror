From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 07 Aug 2015 15:18:54 -0700
Message-ID: <xmqq1tfeyc6p.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	<xmqq614qyebl.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZx=ML-tT6vvjynZ91x6JYqpgKVaEp-Q43MShz0J2EanQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 00:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNpyp-0005bv-DT
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 00:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946390AbbHGWS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 18:18:57 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34830 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946315AbbHGWS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 18:18:56 -0400
Received: by pdrg1 with SMTP id g1so49773528pdr.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DKWJQlL88YyffK7goSt5il26v5sGfiZD0Y8PNua8I9E=;
        b=HNzDIV/KOxYJvvvjEbTrVW8F2rOKiXOFkDMB/5p5PzwU4aeSosAmcBeg+bDPXnLDiQ
         Udc4jlR2QnhMU624AMGLHExXDrDpRKlDJ7t2coROeN30SdQeukoWTYdQaKWKr0SH9999
         O/Fe5agTowJyLO7qjxeOCG+HI9jZxA5Qn9iuhUgKBoRP2MgV1wUiA4NG6jEv1mP1IcR3
         Y+8J3tbozD4oLHox14uO0PHr7/1k1gjxA9T84pc8GqS3ihBugw5UvZVKn3QSvMjiNFlh
         m8+HDWudorYAM670WYx4MiG9m2Ui+xju1lrTdXGbnTc2zQKQDjRKYEw5bV++D95IyR8g
         dNhw==
X-Received: by 10.70.49.73 with SMTP id s9mr18982751pdn.149.1438985935970;
        Fri, 07 Aug 2015 15:18:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id fk7sm7798298pab.31.2015.08.07.15.18.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 15:18:54 -0700 (PDT)
In-Reply-To: <CAGZ79kZx=ML-tT6vvjynZ91x6JYqpgKVaEp-Q43MShz0J2EanQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 7 Aug 2015 15:04:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275495>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 7, 2015 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>>> If we followed what you just said, that patch will try to directly
>>>> read the data in config_name_for_path string list, which is removed
>>>> by Heiko's series, if I am reading it right.
>>
>> By the way, the above is more important part of the message you are
>> responding to.  The result does not simply link, because your
>> unsorted_string_list_lookup() will no longer have the string list in
>> the first place X-<.
>
> I looked through Heikos series and think it is an improvement. I mean I
> can redo my patches on top of his. Specially this patch will be easy,
> as patch 2/4 (extract functions for submodule config set and lookup)
> implements get_name_for_path. All I would need to do then is expose it
> to the shell via the helper.

Yes, that is exactly what I said a few messages ago, wasn't it?

But that would require that you read and understand Heiko's work and
that you understand what its future direction should be, communicate
that vision to others to share, before building on top of it.  And
with that effort, you would already be in a good position to polish
Heiko's stalled work and move it forward.  After all, you cannot
just build on a stalled work, declare "my part is done; the result
is not mergeable because the foundation is not cooked, but that is
not my problem" ;-).

IIRC, the issues around the topic were nothing show-stopping, but
the primary reason it stalled was that Heiko got busy with his other
obligations, so I'd appreciate others like you to help the topic
move forward.

Thanks.
