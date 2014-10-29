From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Wed, 29 Oct 2014 10:18:37 -0700
Message-ID: <CAL=YDWkOZ29+ikXJUzhZqW8-Mk91Z_E1QCiXxT1HZ1oj04pk0w@mail.gmail.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-6-git-send-email-sahlberg@google.com>
	<xmqqppdcj9m9.fsf@gitster.dls.corp.google.com>
	<xmqqlho0j7dq.fsf@gitster.dls.corp.google.com>
	<CAL=YDWm05PyO07HbiOTiweh+3AEvXnbptbzoreLw-b9YUrm-Hg@mail.gmail.com>
	<xmqqh9ynkiem.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 18:18:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjWtP-0002Qh-LC
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 18:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934683AbaJ2RSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 13:18:39 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:47398 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934119AbaJ2RSi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 13:18:38 -0400
Received: by mail-qc0-f180.google.com with SMTP id o8so2804354qcw.11
        for <git@vger.kernel.org>; Wed, 29 Oct 2014 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IjamkfsY0uKayVEm1Wc45rNYBgKU/nVfOj2+b8mLSXo=;
        b=JIT0qugHMsOWNsPQH3S5IYUUF9ZBB/Iba13vXfRE7EDmM0UOCcdE0eypw1666T5zC7
         V9iFSgMAn63pAB/qcmLnfB6/cYLoFbXNWXKDMUmuyeSaD5Hepss33tpJ3XuYIzqWtW3N
         J8+6rcUeKAadoBTOCtP3LHjcAKYySEgiM1dH+cIipzpjBeaHV65ylvVYcO6z3MAniapI
         7SobEPxTCh0qPd659Pr51nYgPEfigkIjkun8Wsk3ZG+bNjxLB3h+UUnGs2R9k/x6Nv4W
         0FX3KwQP3YF6daywtbgZtZQEYZ1sCZ1Kf6GKNlnn7oJMlgbFtJnvqjvwCB4wdcvrfl8H
         I2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IjamkfsY0uKayVEm1Wc45rNYBgKU/nVfOj2+b8mLSXo=;
        b=QV40up6xB5D02FAaPppYPmaH/NQd4tUkEHM+Wzu6Ss/ose+2J/ljK243RHXuHqagZ/
         mkhaIT+RJ1VnKCR5tYHsemJL+Y9UEak4zmoRjByUjOYVgS8/agpReevUaGP3uy22S2cT
         gyEhc/rB66yViAHcjCDKoxMhGssFQZSe3HwKDnU9K//HQ/Sgq5+fe+hv/Xwi8UbqkSCY
         r+1QYEYz5M1U7+0DgiIMgzbkUm16p5eZfKapiL+zf1SHdfNVKZSHjy7dTXLqot5lA5Np
         Us++5TFcetfNowvsKUnfITLPD6D/j1chl68ZKFk0v7RyHnoL2rdCEaY2LbTfPTGhlqtQ
         iViQ==
X-Gm-Message-State: ALoCoQn3M79+Fe6zAmoteNhoyxOcC2G5/u99GiBND2or/ucPQC9xts65T57BbfyiMcbsT8TxX3ff
X-Received: by 10.229.176.70 with SMTP id bd6mr17982561qcb.12.1414603117902;
 Wed, 29 Oct 2014 10:18:37 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Wed, 29 Oct 2014 10:18:37 -0700 (PDT)
In-Reply-To: <xmqqh9ynkiem.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 28, 2014 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> I timed a git branch -m for a branch with ~2400 log entries and it
>> takes neglible time :
>>   real 0m0.008s
>>   user 0m0.000s
>>   sys 0m0.007s
>
> I really hate this line of reasoning.  Small things tend to add up.
>
> More importantly, when you know that the end result you want to see
> is that the old and new log files are bit-for-bit identical, and if
> not there is some bug in either parsing or formatting, why parse the
> old and reformat into the new?  What would happen when there were
> malformed entries in the old that makes your parsing fail?
>

Fair enough. I will change it to ONLY use a transaction for the actual
ref update and keep using rename() for the reflog handling.
Only real change I will do for the reflog handling is to change the
temporary file name used to be less collission prone if there are two
renames happening at the same time
so that they don't destroy each others reflogs.
