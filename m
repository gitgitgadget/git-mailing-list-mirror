From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv9 4/6] git submodule update: have a dedicated helper for cloning
Date: Wed, 10 Feb 2016 23:46:37 -0800
Message-ID: <CA+P7+xq5ckQ02OZ5O2vR8BT37EiThrNUdY4-WcRVJYr1sSDGbw@mail.gmail.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
 <1455051274-15256-5-git-send-email-sbeller@google.com> <CA+P7+xo=GK79DRvV6ZYds3wx6bayoWHC49UmkWL20=xo=jpS2g@mail.gmail.com>
 <CAGZ79kb70tXVsb0DCpwdU9QJB2PQh_4zxZ6Ab7CLQkxCHG6Xuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 08:47:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTlxu-0005wY-Mu
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 08:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbcBKHq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 02:46:58 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34616 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcBKHq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 02:46:57 -0500
Received: by mail-io0-f176.google.com with SMTP id 9so46879727iom.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 23:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i0VfK1cg/9S/Xcra4mYxSykgj809dPo2yiCbCev5ITg=;
        b=Li7lVbs8KMXHowwWkKbGIfbffnNM/L7cEnCKd9ZuXbCAPlY9OiIMyq8uNIXtY4ScZJ
         U9NHPCnti7JTLqlZtvl2sJ+eQ50u8xkWIDyBp3Dql+YpP8cchd68pfC+S72LBYyvj3uo
         5p2YD/onlhu+/Rc+oap2lkvXZV+zlHT01pax2XJluMsPw3oigrfLgEu0y1Vo2gtcaQPO
         Zs1DMpCGMfB0oNmuqtamcI6SiGrCX/WOOszxIMLWHz3J6onDLeCl0MhJ4idQbiyS81Kk
         TztUFbqMBvruMJFn/yMJ36wZA9JYVD5Qv0HEQvb7ANyUPu3+AbbZvRPM+8EyQrkTPPcp
         RhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=i0VfK1cg/9S/Xcra4mYxSykgj809dPo2yiCbCev5ITg=;
        b=kOiKQKoQrPoa7em39J6bgvIM+5Qg+3Cn9H3HQAg2t0S6MLrlTquj3TEE04yEZOfDSo
         rYchhdEbooTSTT5Q1YKu8F6ID+eyp8t55rTHvts6G1OgRVEM2BhCNfEy4miMUVqEbRX1
         BNBv1cmljbKLrIy5q83fCNZ3mJOJarG6thZYdm5uOOE6rl5k4R/y4J+lwKkiVOr8dbdS
         kqLbdebH1X2CByAmz82wJdZLQpVoBEFuGNu/0yHQmQhiGcym2TeJOCXcyTG762wModpd
         aPw+T3yOMrItRXPF5rTgy2AyVqWrtlclzTTpO6pNzzQYHQqAvC/hjFld3ABq3auwvVeX
         ORZQ==
X-Gm-Message-State: AG10YOSAaU9aKyojHcfiSjig9bKD1IgAhMdaxXBlH02w+Wl/fIL2Z4sFYvMubyYqcOJWYlzwxzliLPi/SY/eLg==
X-Received: by 10.107.170.79 with SMTP id t76mr27446235ioe.71.1455176816901;
 Wed, 10 Feb 2016 23:46:56 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 10 Feb 2016 23:46:37 -0800 (PST)
In-Reply-To: <CAGZ79kb70tXVsb0DCpwdU9QJB2PQh_4zxZ6Ab7CLQkxCHG6Xuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285947>

On Wed, Feb 10, 2016 at 9:49 AM, Stefan Beller <sbeller@google.com> wrote:
> Do you mean the separate bug fix patch as proposed by Jonathan or
> this patch in general helps your idea of passing settings?
>
> Thanks,
> Stefan

This patch in general, I think.

I didn't mean to reply to the whole thread.

Thanks,
Jake
