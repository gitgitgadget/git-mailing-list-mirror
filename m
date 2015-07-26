From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 04/10] ref-filter: support printing N lines from tag annotation
Date: Sun, 26 Jul 2015 00:46:34 -0400
Message-ID: <CAPig+cS92cJ=OmaG2_HWNXNq9-D5V4f032WqeU0SVh_XCtxpXA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 06:46:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJDpt-0007ZD-GK
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 06:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbbGZEqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 00:46:36 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35898 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbbGZEqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 00:46:35 -0400
Received: by ykay190 with SMTP id y190so47153604yka.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 21:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uKHYqbq37LcRaqg0IF4WN+ezao1jXMExhwYQjojUC34=;
        b=keyEWA+goPN4+l7cz1/5YBzO6+jbZ3vx+EmVX0/vcgXx5B1acVUKAujT9L6Qws5Vm1
         ZVG4L+8PJPWzdZRcfcmNlml+aZkuH3dTFSnlNBbx8+uv5YHRLDPwhILJbncPDrluOOnV
         qeltoEk+JlR9Ki5ObFdJ8lpJjhaqx9J2ihoVQFGpuUR8Yp/fE1fDBkgR3eTkIp1eBSLH
         QJumBwo3009KnXt5QHVJs5fXy6fvLOWyskZCfo00MdDLSPY/2AItFgJyHJyzbpZwHC4E
         2ZmhAAVHdUvL375KmKNPkYrWAYmllChZRxoEi/zV9IY1Zv8h9cWRxznhUDIikHiNc6Fz
         5QUA==
X-Received: by 10.13.192.132 with SMTP id b126mr23300933ywd.163.1437885994895;
 Sat, 25 Jul 2015 21:46:34 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 25 Jul 2015 21:46:34 -0700 (PDT)
In-Reply-To: <1437764685-8633-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: QFdVc1qZvtooVP1MGerOWvggrYE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274629>

On Fri, Jul 24, 2015 at 3:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> In 'tag.c' we can print N lines from the annotation of the tag using
> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
> modify 'ref-filter' to support printing of N lines from the annotation
> of tags.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/for-each-ref.c                             |   2 +-
>  builtin/tag.c                                      |   4 +
>  ref-filter.c                                       |  51 ++++++++-
>  ref-filter.h                                       |   9 +-
>  ...ter-add-option-to-align-atoms-to-the-left.patch | 124 +++++++++++++++++++++
>  5 files changed, 186 insertions(+), 4 deletions(-)
>  create mode 100644 v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch

Somehow you managed to "git add" and "git commit" your v3 patch 1 file
inside this v4 patch 4/10.

> diff --git a/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch b/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
> new file mode 100644
> index 0000000..350acae
> --- /dev/null
> +++ b/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
> @@ -0,0 +1,124 @@
> +From 3a07ca1f56f74ca54b7f3c30e3dfd9fe2fed1cc3 Mon Sep 17 00:00:00 2001
> +From: Karthik Nayak <karthik.188@gmail.com>
> +Date: Wed, 10 Jun 2015 17:19:55 +0530
> +Subject: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
> +
> +Add a new atom "align" and support %(align:X) where X is a number.
> +This will align the preceeding atom value to the left followed by
> +spaces for a total length of X characters. If X is less than the item
> +size, the entire atom value is printed.
> +
> +Helped-by: Duy Nguyen <pclouds@gmail.com>
> +Mentored-by: Christian Couder <christian.couder@gmail.com>
> +Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> +Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> +---
> + ref-filter.c | 41 +++++++++++++++++++++++++++++++++++++++--
> + ref-filter.h |  1 +
> + 2 files changed, 40 insertions(+), 2 deletions(-)
