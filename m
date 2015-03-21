From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/15] read-cache: free cache entry in add_to_index in
 case of early return
Date: Fri, 20 Mar 2015 22:10:44 -0700
Message-ID: <CAGZ79kYVWUofm+Hc2tWv8vLBxc01HqCGM=efYyb0jdGB-64zBg@mail.gmail.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-4-git-send-email-sbeller@google.com>
	<xmqq1tkjc9g6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 06:10:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZBgW-0000Ja-Q2
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 06:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbbCUFKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 01:10:45 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37843 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbCUFKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 01:10:45 -0400
Received: by igcqo1 with SMTP id qo1so4087485igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 22:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1OsSYeolzJUWXs29eYBsTNQTVBkNEcZCHzmOlVdNGLs=;
        b=hZQfm/aRlWQMOqkHwtbsuxxdQxqDsJs7C+85xeTtHXWRfJkcUHjJKwJM9+qKT36TUb
         xdggQcKcPClqZYi5+5hLnK16/GOsKssGbbJd2K2T/14TuMiw096JGwCyOS8ZWeWtHuGW
         rMceL/1ch8R1Bagpyjwx8nTH/MEvqKCNSsQHuBVsAdTqcTcKhYvM4z+eEVqnHyhcgdh7
         TluA0XD424Dyof+7X9+ej3B3xF4JvOowFDWalyi8fEw/GN/5quLmStn+yGVCyxWMQlKV
         CmCsJkmvxtI/1XZJnfzMRpCegeLtDVWfxBhPOdLVp+WlZ2M1YBZ8V2mvzHg9HmCveV1g
         hy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1OsSYeolzJUWXs29eYBsTNQTVBkNEcZCHzmOlVdNGLs=;
        b=W/5+E2/YW/TjvEKtR/ZTVwfK1f9mqvwBUTi5ugWnXOjusOxLp4EkHzYS8wuu9R5T7A
         va+ChHzIinlbuh8ILAvw+8NnUrrjK+Wwj46Hd33BbgO4HJsuVMT+A0O0nUXCJujsepVQ
         atrFol5+uok02d7MT6muZseOXwSWZC8vlVf57BVO5T5huqI7jhPVVQwZ74P2RubwG5qd
         Z9j29Q0A7gb1eA3nTBr1rGLyKOhXzvG7clxF/rZyoZYgJNb/dqOM3YEzal26/gtJ8+nR
         VIJgt9aHcDOpHjP59Dt7k1R0z3XRgzBeO+c9DCtMo/dmmp5Bo4Z2SKWHNm5mH9gLpt7S
         JIxA==
X-Gm-Message-State: ALoCoQmbT3buqiAS0QDET/gg8FnI4zj4E9vtv7xRNfgfhOEs7Ul5W3SpJ2WlWeUofE6fZ+n/AKsH
X-Received: by 10.107.16.158 with SMTP id 30mr57505723ioq.2.1426914644287;
 Fri, 20 Mar 2015 22:10:44 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 20 Mar 2015 22:10:44 -0700 (PDT)
In-Reply-To: <xmqq1tkjc9g6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266008>

On Fri, Mar 20, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This frees `ce` would be leaking in the error path.
>
> At this point ce is not yet added to the index, so it is clear it is
> safe to free it---otherwise we will leak it.  Good.
>
>> Additionally a free is moved towards the return.
>
> I am on the fence on this one between two schools and do not have a
> strong preference.  One school is to free as soon as you know you do
> not need it, which is a valid stance to take.  Another is, as you
> did, not to care about the minimum necessary lifetime of the storage
> and free them all at the end, which is also valid.  Technically, the
> former could be more performant while the latter is easier on the
> eyes.

I only recall to have seen the latter school so far, which is why I
made the change in the first place assuming the school of freeing
ASAP has no strong supporters inside the git community.

I can resend the patch dropping the reordering, if you prefer.
