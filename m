From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/8] Fix some problems with reflog expiration
Date: Mon, 9 Feb 2015 10:57:52 -0800
Message-ID: <CAGZ79kak+K+ZquHoPLra+ABbtxWQLLuEj+z049sACHvjA2oZqg@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:57:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKtWv-00044F-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760939AbbBIS5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:57:54 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40459 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758932AbbBIS5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:57:53 -0500
Received: by iecrp18 with SMTP id rp18so12442851iec.7
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SDorg9WisagtKpCnEM6s/F/KVHHtzEsKvETQuj6iPa0=;
        b=CfjfErMxoBBX5hVG+0UdJAGGJxcNVYkVGuup8F8irSXq45ck8VFqg2YcAzoKS2/qP3
         kq3uQHUk0wPb9MNo+3h4ueEQVXdWmBhDuBeT/FLtA8t1P8ZzG2WONbXWhfNbKuKh27yG
         WDJhqyIhErEe9ouLfqK6rz95ES4Q5ghjqWLTzekrmhEVnuG3Xj4a42qgVFnaT8RIAfD1
         XA6GvmeLVUFvRIj6AOBp9MGapb6FaZg/UuLe15Bhwv5m6O52r+Q6GI2YK5sLxHbkIgIJ
         DvbwWBkGdLAd1vpo1g3oA24HnmuYj7DkieJb9OSvMi9UM8Z0cSaeEMnlwGIEZ1tQbTgL
         t4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SDorg9WisagtKpCnEM6s/F/KVHHtzEsKvETQuj6iPa0=;
        b=LrxJvLJiFPOx88Gtq0KUUe1x6sWm+QgKFumooQVYNPSIvpRvy2Kx2WcOJFJ/H/Vdw6
         FBaiSwHe1Z5+XYXffedm4IOYNWjuZ0JDCuHVBW1njj64ELryDpfEHUL+rxgtEQkW+SFh
         V79BOWK9OGQCzfHuAzkAigQ5QDMZg5BsvxxT5bQSvAM3aCwdmBHqTcxCGP6wvdM1WcW2
         9fNuG9VhJ5HIl0x3ODMRHMuTmnttv4bOvuKPAXSE68oFb1055FciaeCA9ab93Fb4zNSe
         NSBr8F+plYIz3rjFUwBXFpdRFX2NWr7Lm0dKExOHgbQaxA3n9ZtHRtUBRif//7AsPNXV
         ZjrA==
X-Gm-Message-State: ALoCoQmjOHoynChTGbfPdkNVJRYfrdzzAaDTJfr8YcLdOJZ+AritpZukCfoN/EFa0UFXOZN9AbQU
X-Received: by 10.42.207.129 with SMTP id fy1mr26473101icb.17.1423508272500;
 Mon, 09 Feb 2015 10:57:52 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:57:52 -0800 (PST)
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263583>

On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> By the way, both of these patch series conflict with
> sb/atomic-push-fix, which is in pu. My understanding is that Stefan
> wants to rework that patch series anyway, but if not I would be happy
> to show how to resolve the conflicts.

Heh, I had it already reworked on Friday evening, but forgot to send it out
for review. As mentioned before, sb/atomic-push-fix is a misleading branch name
as it actually enables large transactions [ "large" means > $(ulimit -n) ].

I don't mind reworking that series again on top of either this or the other
patch series you sent out, as I wasn't entirely happy with it anyway.
(Naming is hard)
