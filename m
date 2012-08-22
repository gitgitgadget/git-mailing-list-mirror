From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Wed, 22 Aug 2012 22:56:18 +0800
Message-ID: <CANYiYbE9sJNOXxxFX_xdow=tnWfUwBYOx4S0_CgaB+bUQxDSRg@mail.gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
	<1345523464-14586-7-git-send-email-pclouds@gmail.com>
	<7v628bdhol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 16:56:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4CM8-0006Ws-5J
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 16:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab2HVO4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 10:56:22 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:64811 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab2HVO4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 10:56:20 -0400
Received: by ggdk6 with SMTP id k6so745790ggd.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=boDQUZ1zTtTGNgtv24T+Z7eouB5C1LKk8ozH8XStP/U=;
        b=SyCbzm2BmEyndTe8KQb8k3Vp6alutLULoXOEhBNLsm69SplyC9GI94z+0TiRIUtbzi
         WxIP410fwE6rbfbn3CPjMvsOwh2IMS3av7g5W/elau3uAg/slpA6Mz3zh0s6RL3nKoEJ
         NRETQxgkZMANhgWntyOzAklU7Qt5LxYq0pE9kYCCvnBE4iwNDtB45SxuPQyYQ0hJtOl0
         6M5IOFT+OwPDZ2PPeV62pLx6q2Xk+7tw4LWPc4vmjCOy7ifExXdqDA54IgWpI08y3WQN
         ggFfXpueRaM9U2dZJRtPmLJVX9oZXYgWiWZ155Z/zivSQZq4+Nht4hL8iyEUNBPz/atc
         aT2A==
Received: by 10.50.207.106 with SMTP id lv10mr2535046igc.0.1345647379357; Wed,
 22 Aug 2012 07:56:19 -0700 (PDT)
Received: by 10.50.17.104 with HTTP; Wed, 22 Aug 2012 07:56:18 -0700 (PDT)
In-Reply-To: <7v628bdhol.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204020>

2012/8/22 Junio C Hamano <gitster@pobox.com>:
> Which part of the output from "git remote show" does this test
> expect to be translated?  Specifically, does "tracked" ever get
> translated?
>
> It appears that _(" tracked") is indeed marked for translation in
> the source, so how can we expect value in $actual be any useful for
> any comparison?
>
> Confused...

Yes, because _("tracked") is marked for translation,  check_remote_track()
is hard to do right.

>  check_remote_track () {
>         actual=$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')
>         shift &&
> -       tokens_match "$*" "$actual"
> +       tokens_i18nmatch "$*" "$actual"
>  }

Output of command "git remote show origin" is:

    # GETTEXT POISON #
    # GETTEXT POISON #
    # GETTEXT POISON #
    # GETTEXT POISON #
    # GETTEXT POISON #
        master# GETTEXT POISON #
        side  # GETTEXT POISON #

Maybe we should bypass all testcases which calling check_remote_track().
Changing 'tokens_match' to 'tokens_i18nmatch' won't fix but hide the problem.

- test_expect_success 'remote information for the origin' '
+ test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '

- test_expect_succes 'remove remote' '
+ test_expect_success C_LOCALE_OUTPUT 'remove remote' '

- test_expect_success 'add another remote' '
+ test_expect_success C_LOCALE_OUTPUT 'add another remote' '

-- 
Jiang Xin
