From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 00/12] ref-filter: use parsing functions
Date: Thu, 4 Feb 2016 19:34:48 -0500
Message-ID: <CAPig+cRr3UTfcegcw6L6qXr7TFaCw2Uno696q6Kfkttp97fGRg@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<xmqqr3gwt6dp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:34:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRUMQ-0000Ma-NF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 01:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbcBEAeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 19:34:50 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34939 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcBEAet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 19:34:49 -0500
Received: by mail-vk0-f67.google.com with SMTP id e185so2082876vkb.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 16:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3mkKoeM2pmLKdR3EKlfhDDme4tJpPkF/UAyd6ZmdIHY=;
        b=SdaBGtl6etRcavsjbQ9m1FMzTdRYglXuCdXWWqS2J0GYugyZFQcpJbispOCBammDfa
         /o6CEf24pDzwT9HAy3uxCUpavnxPJkcAoTrLJ1uXi0WcZjU4dxN8woz8jLwowuWONyDq
         sAPudvODW4ITzHexmtwXnuO996J6un8ABjMa8mdw1pmX6eOmrmxpprysM5OdPNC8/KT4
         3O7Mx3+3q+tBqNcyWIDgB1c38Kzvbm6+kdVxqWyGvzPVZ3Xrc+zIXc2eT1OGmVpcLkCf
         eqsR33CESx0mCGZ9KpLd6leHtFLtZcBjOv0+gNxFFEV7GR/6f3sJno23/Ijxp37OYLqP
         RvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3mkKoeM2pmLKdR3EKlfhDDme4tJpPkF/UAyd6ZmdIHY=;
        b=YBfX4sg6941cQ4KH+B4XsYAsT6thIpYcxjgaztYCpTTjp5f8lfYYooI7ud07diXJSl
         qd4L4g7mk1VlqboT3IsgvuQFOfGzzgowW8kjtwkUKVeQa9B+5FIiuJv7ou3XYExnVheI
         i+MU0lNrEMi9jIEHWdxJI2tgUTaXjjl8/d+rRQq0a9LSJvyGotDkLbSuNuids14i/CW3
         BKmeQxuLFGDxT6Bvbrdg3/s+cFV1kD5M8gm2WjzmPPcf6NSBy+c5GqqBATZOR0dUT4/1
         fjZsoaCfr1/Rn81lMig+zulJP0b5MoUkmAVNja2oq1PjrJgkIyTg42lkFAi12JK5n2la
         WCCA==
X-Gm-Message-State: AG10YOQS61pJ8lJVnjXMwoWyNkxn0zgeoXQ0Q8CBje/8+uUiy4dKhewgk8uaZjTTp6RoDpuBqf+afsjQKNMnqQ==
X-Received: by 10.31.41.14 with SMTP id p14mr7360157vkp.151.1454632489009;
 Thu, 04 Feb 2016 16:34:49 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 16:34:48 -0800 (PST)
In-Reply-To: <xmqqr3gwt6dp.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: lXTu-_M_oJf138mftIUojbTL118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285532>

Karthik Nayak <karthik.188@gmail.com> writes:
> This series cleans up populate_value() in ref-filter, by moving out
> the parsing part of atoms to separate parsing functions. This ensures
> that parsing is only done once and also improves the modularity of the
> code.
>
> v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
> v2: http://thread.gmane.org/gmane.comp.version-control.git/282563
> v3: http://thread.gmane.org/gmane.comp.version-control.git/283350
>
> Changes:
> * The parsing functions now take the arguments of the atom as
> function parameteres, instead of parsing it inside the fucntion.
> * Rebased on top of pu:jk/list-tag-2.7-regression
> * In strbuf use a copylen variable rather than using multiplication
> to perform a logical operation.
> * Code movement for easier review and general improvement.
> * Use COLOR_MAXLEN as the maximum size for the color variable.
> * Small code changes.
> * Documentation changes.
> * Fixed incorrect style of test (t6302).

v4 is a nice improvement. With the retirement of match_atom_name() and
its misleading and confusing use in the parsers, overall the parsers
are now more concise, straightforward, and easier (in fact, dead
simple) to comprehend.

As most of my review comments this round were relatively minor, and
there don't seem to be any major problems, hopefully this series will
wrap up with v5. Thanks.
