From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: make '--always' fallback work after '--exact-match' failed
Date: Thu, 20 Aug 2015 11:39:27 -0700
Message-ID: <xmqqegix7qjk.fsf@gitster.dls.corp.google.com>
References: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 20:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSUkQ-0000it-Ig
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 20:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbbHTSja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 14:39:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33824 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbbHTSj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 14:39:29 -0400
Received: by paom9 with SMTP id m9so155131pao.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=/BVG9Lt/rzaCxGbW2QKP1SN0q76kGeFVbGfigsuQj7Q=;
        b=mXNTHg7wYkgytrbf/TSbVHhdTW6EnR4qCdTLzeuRuJY6tiEa2soqCSy1Zlo2w1tf6R
         vuKHR60k80KBHXpE/mWd5qTOTV0hjoE3oDmTq/6mFY5RFVzwafLGVVvv8dpUbCn97z2R
         fyI5VSYWD2zDJTlQKuD89YW15w625CwoYovgerK3PvqNbq3rjbOHDkZsu1sj8J2kQrg3
         xQUumPmB6nE2Hxbqg9GyoA6NzeamadANmGfml6Qn5TxlFVLqM/3lTHyxG26/MD/smnXV
         kon7wb1XVqG567Z1EAfmrXwsZSjHnXK/3vLAnAX0ug2UNrk+9ZpxvPhNmPWCsB18WHN5
         eagw==
X-Received: by 10.68.69.34 with SMTP id b2mr8885397pbu.119.1440095969067;
        Thu, 20 Aug 2015 11:39:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id s17sm5174223pdl.2.2015.08.20.11.39.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 11:39:28 -0700 (PDT)
In-Reply-To: <1440072823-18024-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 20 Aug 2015 14:13:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276259>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'git describe [...] --always' should always show the unique abbreviat=
ed
> object name as a fallback when the given commit cannot be described w=
ith
> the given set of options, see da2478dbb0 (describe --always: fall bac=
k
> to showing an abbreviated object name, 2008-03-02).
>
> However, this is not the case when the combination '--exact-match
> --always' is given and the commit cannot be described, because in suc=
h
> cases 'git describe' errors out, as if '--always' were not given at a=
ll.
>
> Respect '--always' and print the unique abbreviated object name inste=
ad
> of erroring out when the commit cannot be described with '--exact-mat=
ch
> --always'.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Well, that can be argued both ways.  Your patch introduces a
regression, as "--exact-match" is an instruction to error out when
no tag exactly matches, and you deliberately break that.

My knee-jerk reaction is that the most sensible way forward is to
make --exact-match and --always mutually incompatible.
