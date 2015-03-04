From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Wed, 4 Mar 2015 08:54:57 +0700
Message-ID: <CACsJy8B_r_0nP9NyKFBnr9bXgwjx8dJkSVkHbZw+Mxin_YpZZw@mail.gmail.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
 <CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
 <CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
 <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <xmqqioekawmb.fsf@gitster.dls.corp.google.com> <20150302092136.GA30278@lanh>
 <20150303103351.GA4922@lanh> <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 02:55:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSyX8-0003Se-E6
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 02:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbbCDBza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 20:55:30 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43404 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbbCDBz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 20:55:29 -0500
Received: by iebtr6 with SMTP id tr6so63679750ieb.10
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 17:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xYkzEQk6JOGuw2FKttj18277F1zPDPcE3NchI07qytE=;
        b=a5CVMCigPPq01owow8miAQMLcG2ZWXxAnwf7SYzEPiNtyOKfbs+IwoFlKpe9Nykab1
         YsJMMzv3LgNz+sW3NGxzhcbi792621YtHyrKvtJUmJBk/1VZfx86aFTcOXpDwSHyKZ3F
         w4icKam2zpnQsROthB4hgTA7+9xwuTEfK7gOeTUM6YGkd2N3vW1C8ZVK3PI8QTz3PzFT
         XuxZM2cGfya7DJekQ4VdU1k6KLGLH3JeQkGqzoX48iq3KomX0vEu515CN9E7w/zIrpIl
         odcm9yRNblylCt6BRV+Lx3wNumkgv4/DASXyFIUuHIimTvfvxK/IbvaHdxZU0/LbrMUN
         hRuQ==
X-Received: by 10.50.131.196 with SMTP id oo4mr7049433igb.2.1425434128476;
 Tue, 03 Mar 2015 17:55:28 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Tue, 3 Mar 2015 17:54:57 -0800 (PST)
In-Reply-To: <xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264714>

On Wed, Mar 4, 2015 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> My recollection is that the consensus from the last time we
> discussed protocol revamping was to list one capability per packet
> so that packet length limit does not matter, but you may want to
> check with the list archive yourself.

I couldn't find that consensus mail, but this one [1] is good enough
evidence that we can hit packet length limit in capability line
easily.

With an escape hatch to allow maximum packet length up to  uint_max, I
think we'll be fine for a long time even if we don't send one cap per
pkt-line. So I'm trying to see if we really want to go with one cap
per pkt-line..

Pros:

 - better memory management, current pkt-line static buffer is probably fine
 - a capability can contain spaces after '='

Cons:

 - some refactoring needed to hide away differences between v1 and v2

Looks like one cap per pkt-line is winning..

[1] http://thread.gmane.org/gmane.comp.version-control.git/237929
-- 
Duy
