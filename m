From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 14:37:24 -0700
Message-ID: <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
	<xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	<6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	<CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	<1432070690.14498.4.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue May 19 23:37:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupCf-0006gE-LF
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 23:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbESVha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 17:37:30 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35590 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbESVh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 17:37:26 -0400
Received: by igbyr2 with SMTP id yr2so87416246igb.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oDfzA57PzJSmXMnnnlpUqmlkJZ0ivvAmg2E4P3iU31I=;
        b=Z3LVEolWoXZjmySSlxJUVrCKaIKGAyojKFNbzjofaKEYU9EYzYJwR/P6RHOYhaV0Xr
         TBpKq7HKrEIldDQ5u4O3umj+BJEC21Qm1ZUdPCnP8aH9a5J/ctwet5LqrVpPeeSnr4oD
         zg15+l0FOpr6J8h+2oj7KfQp5JzUvqdMsZs0QiUpcOU2YQ+mCLgZ5DZBi/hoMAUeEAN0
         Cd5ox38xGeCw3c/QHMc4hwI7xIGRf/bw4IgTjfNYmiW0NnxmOZ5Lmb7pJyvZeMSMjaJE
         7RLAXY1VV+L/+dGfWxH5SH0t9aJstHvQbow9q634TP7qsXCfz28II5TXhc61TsWIl6i7
         rutA==
X-Received: by 10.107.159.7 with SMTP id i7mr26277975ioe.4.1432071445990;
        Tue, 19 May 2015 14:37:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id j4sm137298igo.0.2015.05.19.14.37.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 14:37:25 -0700 (PDT)
In-Reply-To: <1432070690.14498.4.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Tue, 19 May 2015 23:24:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269405>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> I took a stab at this, adding a --tag option to test_commit and adding
> the option to the test_commit calls that need it (or removing tests'
> reliance on these tags where appropriate, or removing tests' workarounds
> for dealing with these tags when they don't want them), and the result
> is 59 files changed, 280 insertions(+), 281 deletions(-)
>
> A test run on master with GIT_TEST_LONG set causes 1138 calls to
> test_commit on my system, of which 255 now use the --tag option
> (measured with a really crude hack that INCR's some keys in redis at
> appropriate points in test_commit).
>
> Is this interesting enough to turn into a proper patch series?

Wow.

A proper patch series would probably be

 [1/N]   Teach "test_commit --tag" and replace existing "test_commit"
         with "test_commit --tag"

 [2-N/N] For all the test scripts, analyse and judge if they are
         better off with the auto-generated tags (i.e. no change wrt
         the result of 1/N) or tags that are created by the script
         at strategic places only as needed, and convert those that
         are better read without "test_commit --tag".

[1/N] would be mechanical and easy, but justifying the change in the
remainder would be a lot of work and reviewing would be, too, and
would require a good taste.

Perhaps if we see two sample patches to see how it looks like, would
that help us decide?

That is, the mechanical [1/N] and [2/N] for one of the test script
that can do without --tag, and a sample "do not apply" patch to show
"if we change 'test_commit --tag' to 'test_commit', the script t1234
needs this many manual tagging by the caller, and it is not worth
doing"?  I dunno.

Thanks.
