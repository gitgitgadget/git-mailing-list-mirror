From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/8] xread: poll on non blocking fds
Date: Mon, 14 Dec 2015 15:07:11 -0800
Message-ID: <CAGZ79ka6RB_RFxfTaXmV+9fyCmnnKcKZdRVB1fMywO97F1sbSw@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-3-git-send-email-sbeller@google.com>
	<CAPig+cQoranAhJKSZm6jP-hYutkoXkf6461sY1v5NseQVTNL_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:07:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cDA-0008K2-U2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbbLNXHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:07:13 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34296 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbLNXHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:07:12 -0500
Received: by mail-io0-f174.google.com with SMTP id e126so622678ioa.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 15:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HEu4HnClaMP+wlRS5ep4QxnERwfK7rhuobXy6MM7qYU=;
        b=gBjLGdHuserB8REP/kYzyYmU7KCAA5DItLdZf66C3k07YlQg+77zVd4i2C3WGY3OMr
         7/YYw+xZRrkQEMDnimY0LVYI8Rfmfn25101C5s2Gu33IZdvv0f0yT6IBVTn/O/Kmebhw
         i+hzGDx0al2ymYjqEOVxfMV2/YTJUPaY0WcXH1xpGzQ/SXcRPtHgSnimxc3WmgDTOg+L
         w8CHeBniwzhadSJ9udCjb11xqld70tWsYjaxDeo1lYoOx8X5Sex7nEekrP5a3GQKk1VU
         AAnlAwic3YVEtOuEZvPmL8qYwWD7N/BYavFBWAXQALrqT8KQcrge1VQia6P2gn0Lnbcz
         3Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HEu4HnClaMP+wlRS5ep4QxnERwfK7rhuobXy6MM7qYU=;
        b=Gr88RiZ1Qde253+crejsWkKgFAqawn2Wj0Hwm2dCqw0ckjq07yQdc6EeqOpfNZVdCw
         DZWTtoI8NpAWdGveGYNOqVpZmhiWDTVSGTfZYBH9zwH7c5rjNu4iwuSXLz6bC8B9eEE4
         wrKqE9cPxJtYlcwyQqMumvOmVTB8gHiEOmJmkWK0XsMjSFbKzRoOxVVAjURViQTLukNy
         SAzdPND7P0LqG5U+cyCPYPLdQXVa6eMRCojUoBDmXZ2VAjjQha1HWP4seNI26tMckCth
         9k2UjArZtATUsG7EqsHk24YC1oyO9Gz7OTW0ZMPXeJ5H8MzpIaPEaVX1sntmt2r8Jbkr
         JFHg==
X-Gm-Message-State: ALoCoQkkMcMEDP6fh1R0ADKAvpXRx5zzTbAUd3nDpT8J/mchSUqWQusxA2mZI3gOinQd5ZGG7vdl+R9GkNp66soGttw/QF5ggla4xk0PpHoCdVDpUb/G6Vk=
X-Received: by 10.107.152.142 with SMTP id a136mr37577110ioe.110.1450134431839;
 Mon, 14 Dec 2015 15:07:11 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 15:07:11 -0800 (PST)
In-Reply-To: <CAPig+cQoranAhJKSZm6jP-hYutkoXkf6461sY1v5NseQVTNL_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282446>

On Mon, Dec 14, 2015 at 2:58 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
>> +                               /* We deliberately ignore the return value */
>
> This comment tells us what the code itself already says, but not why
> the value is being ignored. The reader still has to consult the commit
> message to learn that detail, which makes the value of the comment
> questionable.

It at least tells you it's not because of sloppiness. ;)
I'll elaborate that comment a bit further in a resend though.

Thanks,
Stefan
