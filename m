From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Sun, 28 Jun 2015 06:53:09 +0200
Message-ID: <CAP8UFD2nnJYybMVPeQ5QMvsHmcqJf3tmAuSpfrCdqTaucKUuSw@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
	<1435232596-27466-1-git-send-email-karthik.188@gmail.com>
	<CAP8UFD1gT_2RKYc1vvBO9goGwPzFxhu9uMan5+cLO7eWxwwB_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 06:53:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z94av-00044F-Do
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 06:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbbF1ExN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 00:53:13 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33920 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbbF1ExL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 00:53:11 -0400
Received: by wgqq4 with SMTP id q4so116409944wgq.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 21:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MX3zHUbIvyhDZbDimtUwnx8CnzRA44WtYUBHLbbGlsQ=;
        b=FJTT6I1EzAH/IMiRWvfL5+OFkpkHt2iMKHFwBI2DIWdQLaQbixntkP2R5mkuflx9zB
         SVvIaw+GKaV3VeyVp29UXd6j46G3TIqKLjkLEADq8PJILAAIh/8spkJcC5fi0m0YrZvJ
         HwVpmS4wK/9iyA8NIonA31QwJxZMQ6el3S+AYdUgPCdwT+bo0jTCuLrxqHw3qItGIvm/
         9BVyeNSalJfYhxqZga89DwkvRZTqYS6RLd2e79mgSXJYQ0UDmKqG7I4ebFZiICb/WYO8
         O8rZ5eMc+NL/iBtxH3geE5zXD4xHh/3r8Ql7QnXxPSanl9sWwgq0UtR7t07iKD4dtn0X
         XJdQ==
X-Received: by 10.180.86.163 with SMTP id q3mr11008127wiz.75.1435467189430;
 Sat, 27 Jun 2015 21:53:09 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Sat, 27 Jun 2015 21:53:09 -0700 (PDT)
In-Reply-To: <CAP8UFD1gT_2RKYc1vvBO9goGwPzFxhu9uMan5+cLO7eWxwwB_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272866>

On Sat, Jun 27, 2015 at 10:02 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Jun 25, 2015 at 1:43 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
>> +                       if (starts_with(formatp, "lalign")) {
>> +                               const char *valp;
>> +                               int val;
>> +
>> +                               skip_prefix(formatp, "lalign", &valp);
>> +                               val = atoi(valp);
>
> After thinking about such code, I wonder if it would be better to
> support %(refname:lalign=X) instead of %(refname:lalignX).
>
> The reason why it might be interesting to require an = sign between
> "align" and the number X is that if we later want to introduce another
> option with a name that starts with "lalign", for example
> %(refname:lalignall=X) that would truncate the refname if it is bigger
> than X), we might be more backward compatible with old git versions
> that implement %(refname:lalign=X) but not %(refname:lalignall=X).
>
> We will be more backward compatible because the above call to
> starts_with() would probably be something like:
>
>                        if (starts_with(formatp, "lalign=")) {
>
> which means that old git versions would ignore something like "lalignall=X".

Another reason is that it would be simpler if we ever want to have
arbitrary string parameters, like %(refname:substitute=%/%\%).
