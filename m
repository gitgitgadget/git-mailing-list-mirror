From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 05/15] refs.c: update rename_ref to use a transaction
Date: Thu, 30 Oct 2014 11:46:34 -0700
Message-ID: <CAL=YDW=jk1wO8KB1=Wpiw-AKa9xzLJYr36zF6HxMDPxUHoP_6Q@mail.gmail.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-6-git-send-email-sahlberg@google.com>
	<xmqqppdcj9m9.fsf@gitster.dls.corp.google.com>
	<xmqqlho0j7dq.fsf@gitster.dls.corp.google.com>
	<CAL=YDWm05PyO07HbiOTiweh+3AEvXnbptbzoreLw-b9YUrm-Hg@mail.gmail.com>
	<xmqqh9ynkiem.fsf@gitster.dls.corp.google.com>
	<CAL=YDWkOZ29+ikXJUzhZqW8-Mk91Z_E1QCiXxT1HZ1oj04pk0w@mail.gmail.com>
	<xmqqtx2myawy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:46:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjukC-0003qJ-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 19:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760715AbaJ3Sqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 14:46:43 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:37205 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760187AbaJ3Sql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 14:46:41 -0400
Received: by mail-qc0-f173.google.com with SMTP id x3so4708118qcv.18
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UiZml8jDs5B8AYGyrUCqTwmFnxUfL3YLkxD4fLA3iZM=;
        b=iRzNx7JvuRc8Ztl9Da/qxM+XmT8aMYdcXykZbDwReEvRsRQ6iTRb8r2xnbVdtfTUaK
         K96ks75HpF17CjdqluEioc79pBZcvoErCJ8WZxeWFTNHC64LkdTf/1JBhzKmVOCBUWOb
         7ITmo1McYt6gf3sFRd0peBBudoHin8zUFk3NLsNe2E8m9UIALv9HXKIsUADsPS7d3FJV
         9UJEMABvkvleJT7ei1vQ8LoakffGNzycp0vOdUoGUPdwB1w3cxWxVqF+DnZoSL5muh2S
         Dq5le2a69Ytp4ISWzeGqRDEevnJjrtgl5oiPj/T5xnSAcPgxmXtHoZdEiEh99xXT2uC0
         lw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UiZml8jDs5B8AYGyrUCqTwmFnxUfL3YLkxD4fLA3iZM=;
        b=IlHcdcEN0JiE5tUXsqtFFt8z4l5saiMvXqJNLlMVx3ktiJXRTTGYNC/5bhZvn6gnl6
         yIu0pNk19pxUp+2NGR2RLgWyvuuy69A7rwbR/uyfmg5M3zTZqDtNXDBOMn7r4MpuJAAQ
         2KM23qT8v6y2FWSgV9GHo2F1kigsKf0Zf/d+rklY1hjiaEq6j99GUfBFK+atXYydUO6T
         n0UBfTZ1j1Q8w6osGbT2AqOBg1K/cMepyibGOXI22mNhqIEchoEAHfXNwLssE+hj/fnS
         HB3OpvL7WTO/KYtYcDCKDv6uzHADVuZisIeGyVltiSRIZ+Ar2R01ll5+NVvn+IJoVz2u
         +57A==
X-Gm-Message-State: ALoCoQmFzOB3AorXBcr3y0a2X18EhTfzWe6aLJJHf21HO7eZUVwDdzDFwk4Qx8jnP2SnJJOuEtRT
X-Received: by 10.140.109.244 with SMTP id l107mr27024202qgf.80.1414694794170;
 Thu, 30 Oct 2014 11:46:34 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Thu, 30 Oct 2014 11:46:34 -0700 (PDT)
In-Reply-To: <xmqqtx2myawy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 29, 2014 at 11:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> On Tue, Oct 28, 2014 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> More importantly, when you know that the end result you want to see
>>> is that the old and new log files are bit-for-bit identical, and if
>>> not there is some bug in either parsing or formatting, why parse the
>>> old and reformat into the new?  What would happen when there were
>>> malformed entries in the old that makes your parsing fail?
>>>
>>
>> Fair enough. I will change it to ONLY use a transaction for the actual
>> ref update and keep using rename() for the reflog handling.
>> Only real change I will do for the reflog handling is to change the
>> temporary file name used to be less collission prone if there are two
>> renames happening at the same time
>> so that they don't destroy each others reflogs.
>
> I think it is a good idea to make renaming the entire reflog a
> logical element of transaction (as you mentioned in our private
> discussion) to allow different backends implement in their best
> efficient & robust way.

Right. I have changed it to use an optimized function to read the
whole existing reflog as a blob into a strbuf
and then a new transaction function   transaction_replace_reflog(...
the-blob ...) to write the whole blob back to the new location.


>
> And for filesystem-backed backends, I actually think "keep the
> original until we know we do not have to roll back", that follows
> the same pattern for the other transactional updates, is a good
> implementation of that "best efficient & robust way", compared to
> the original "just rename it".  It frees us from having to be
> worried about what happens if we cannot rename it back.
>
> Thanks.
