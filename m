From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 09:11:07 -0700
Message-ID: <xmqqoaknmtlw.fsf@gitster.dls.corp.google.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqbngpl5zu.fsf@anie.imag.fr>
	<550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
	<1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqk2vcat2t.fsf@anie.imag.fr>
	<xmqqegljoayp.fsf@gitster.dls.corp.google.com>
	<vpqvbevr3eh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:11:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ib6-000810-FA
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571AbbFJQLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:11:19 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37077 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964959AbbFJQLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:11:11 -0400
Received: by igbsb11 with SMTP id sb11so37063487igb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DbilpPQ5Cj+FFcsQxw/n1HN9OrYWkBKSsXRMxdY4nNA=;
        b=vAXmg+dKkoH/eIcCFv7ymH8fd/s3CY4la8eSIaK78d9rwOcN1EmnUiqgnlw+B540dX
         s0fBoOTfysIvSgWvsMpECL5VAu4M2D6Xu78JkuveIh4EJ8+VihI3cS8Zu709UpqWjgIh
         YJ8eWyIjTmTQ56CQLEIA0k5pVAeFU4dvGCSWs2ar/+47ZFFBV3uTNRNfsZnoqJ3Ln2UQ
         WSlyyiHWoCWfMku1eoDa1aYFTtbwUKcKV/cYdyDLz7VWppCciyRuegDbD1Yoq8P0C9rp
         +uVgRaovXW7rjo9Oh5isl+9CFR5cuvlfqzPNZlFZXNF4b1E5EckfIbESsvs5F7PSLGFT
         dRig==
X-Received: by 10.43.14.65 with SMTP id pp1mr5770554icb.40.1433952670257;
        Wed, 10 Jun 2015 09:11:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id o19sm3521296igi.14.2015.06.10.09.11.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 09:11:09 -0700 (PDT)
In-Reply-To: <vpqvbevr3eh.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	10 Jun 2015 17:25:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271317>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> But I do not think it is a good idea to penalize the normal case by
>> writing the terms file and reading them back from it when the user
>> is bisecting with good/bad in the first place, so....
>
> No strong opinion on that, but creating one file doesn't cost much, and
> one advantage of writing it unconditionally is that it unifies bad/good
> and old/new more in the code. Just the creation of BISECT_TERMS becomes
> a special-case.

You have to handle that case anyway when I start bisection, which is
going to take very long and I had to leave for the day to come back
the next day to continue, and during the night the sysadmin updates
the installed version of Git.
