From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Fri, 15 Jan 2016 18:24:26 -0500
Message-ID: <CAPig+cTfH2JvPpG9mnv0L0oAdXmuHDCQVk_98VnOdiOVS4_Y1Q@mail.gmail.com>
References: <1452806795-26621-1-git-send-email-davidw@realtimegenomics.com>
	<1452818503-21079-1-git-send-email-davidw@realtimegenomics.com>
	<xmqq4meeisas.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "David A. Greene" <greened@obbligato.org>,
	Git List <git@vger.kernel.org>,
	Dave Ware <davidw@realtimegenomics.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:24:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDjN-000543-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbcAOXYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:24:31 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36070 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbcAOXY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:24:27 -0500
Received: by mail-vk0-f66.google.com with SMTP id e64so7252786vkg.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bKZ0I2sh6AqppG6QvWH81Jw3BrMqlXDkEwkqjwiNKmE=;
        b=VpKxPqGR4DLbkucO+DfqFaA4ZnPZWi3xz0uBidrIDUNChCB5axF+tQ7GzC6gi+8wZu
         /ckSd/Su4r5EjHhZGb48nBz+obAWf09Tu3Eq3LF51pcnDMdJLy92u3Yvt5l1YThrTOl+
         2cQTVJzb7qDCfHAugLmtA0Bvahsjn/SDGl4DxmyEsyjovmLdZtA7uDkAyuFIL/EJI/ki
         519ZdO2OzjkUDzzMNq0aU7ztb5hCzsa0hzQx30WwQ/thwcqDzpbNeVe5ajmTQFiUsllV
         0nzoTvnQpjKpCOiProLxPXO2Q4bMt1FIbVvWPCL0oGcTBDsrwJpxQEefnw7iDaj5eUT3
         9uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bKZ0I2sh6AqppG6QvWH81Jw3BrMqlXDkEwkqjwiNKmE=;
        b=IoCsDZlzWZ1zn34dKigAxuObvVTYfkTV9ymcWWQeskodDB5Ubj4pe+3hSqlSJpOKuz
         9D/yLUlGVU57sx/EqmFm1jd/onh8PGAHQ4ZhP2yn1sI+b/gL4vxTbq1XCxVSXOuX4hxQ
         5IWbu93ZJgrm9VG9oTVhgGWl5Hr228YAUUTopflH9sEri+7l5FKciWGGQ+/rcXc2I7Bs
         xZzfIGq3CJ1RWa7jv9v/zz+ok2wsaLu2O4KL2WD5bmtZh8ZLstivpjqt1cSZRZtMcdAb
         AlBps3+zWnLP45Mbf835+SifE1raDWp+FSEqlARNESZMkZtC9/zn0VfHSae4caXgDukp
         dwvg==
X-Gm-Message-State: ALoCoQlx3ir93Vz2k/MQPXvgMKJ2WEVsxuIGbhhzIbS+KjNZDfDayZAGQv2Tfphs8F89NH3o01lzdZLZLBIMGh+sli8YYOtTng==
X-Received: by 10.31.164.78 with SMTP id n75mr10029936vke.14.1452900266735;
 Fri, 15 Jan 2016 15:24:26 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 15 Jan 2016 15:24:26 -0800 (PST)
In-Reply-To: <xmqq4meeisas.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: A4k5grkrl3Dj_p2x0xcYhsQVLrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284231>

On Fri, Jan 15, 2016 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Ware <davidw@realtimegenomics.com> writes:
>> 'git subtree split' can incorrectly skip a merge even when both parents
>> act on the subtree, provided the merge results in a tree identical to
>> one of the parents. Fix by copying the merge if at least one parent is
>> non-identical, and the non-identical parent is not an ancestor of the
>> identical parent.
>>
>> Also, add a test case which checks that a descendant remains a
>> descendent on the subtree in this case.
>>
>> Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
>> ---
>
> David, how does this round look?  Can we proceed with your (and Eric's)
> Reviewed-by: with this version (with one grammo fix Eric pointed out)?

As I'm not a subtree user, I'm not qualified to give a Reviewed-by:;
my review comments were general, not specific to subtree
functionality. At best, that might qualify for a Helped-by: if my
comments had any value.
