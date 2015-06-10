From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] send-email: suppress leading and trailing whitespaces before alias expansion
Date: Wed, 10 Jun 2015 09:15:15 -0700
Message-ID: <xmqqfv5zmtf0.fsf@gitster.dls.corp.google.com>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqa8w89d5x.fsf@anie.imag.fr>
	<1281238070.338321.1433928615479.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqqa8w7oarl.fsf@gitster.dls.corp.google.com>
	<vpqoaknr39r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:15:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2iex-0001mt-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbbFJQPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:15:19 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34556 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbbFJQPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:15:17 -0400
Received: by igbhj9 with SMTP id hj9so39280440igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rWeFHKBQqg7F7Tt6TF12zGY+sqwRT3gEumSNDszqIRs=;
        b=VfiBVeEVjtn8OHwdJxNgPuPoxXRNW8OLGth/i/0FsTScBQdxMlsW9RVBlqTUQWrGei
         YCJXw7b6567Q+kTThHfIs6kXUqr2Wh8mTaqWzSi1q8Ib+YnsOF95CoUzwT4AkfTnZpK5
         qnxZzedHB4QEMJB4+Xe0ASNB5Nuq20kxs0DKtYDFfzwyGKPlongIcQ+Ei8tRp9lPk+xY
         PlQiLzf/UTmpMdcBl/pSiMRtsSEyqqJ6maIUxO8c8tJy4Xak1gjOGZKC2078us6dzjDD
         +9SoxRd6n035yotOYmBuRNXIGzLxTxeaqs1ZFYqFon3B9IcJo2ILpFXlC81TVWBJTstz
         rOeQ==
X-Received: by 10.107.37.69 with SMTP id l66mr5400574iol.76.1433952917162;
        Wed, 10 Jun 2015 09:15:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id m193sm6289902iom.19.2015.06.10.09.15.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 09:15:16 -0700 (PDT)
In-Reply-To: <vpqoaknr39r.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	10 Jun 2015 17:28:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271319>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>>
>>> I agree, I'd like to put it right after split_at_commas in a separate
>>> function "trim_list". Is it a good idea even if the function is one
>>> line long ?
>>
>> Hmph, if I have "A, B, C" and call a function that gives an array of
>> addresses, treating the input as comma-separated addresses, I would
>> expect ("A", "B", "C") to be returned from that function, instead of
>> having to later trim the whitespace around what is returned.
>
> It is actually doing this. But if you have " A,B,C  ", then you'll get
> " A", "B", "C  ". But once you're trimming around commas, trimming
> leading and trailing spaces fits well with split itself.

I guess we are saying the same thing, then?  That is, trim-list as a
separate step does not make sense an it is part of the job for the
helper to turn a single list with multiple addresses into an array?
