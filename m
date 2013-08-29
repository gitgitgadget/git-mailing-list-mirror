From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 0/7] Multiple simultaneously locked ref updates
Date: Thu, 29 Aug 2013 13:09:07 -0400
Message-ID: <521F8033.6070302@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <201308290932.18199.mfick@codeaurora.org> <521F6CF0.6040905@kitware.com> <xmqq7gf479jm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:17:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF5qh-0003AK-FG
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab3H2RRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:17:31 -0400
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:44651 "HELO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751820Ab3H2RRa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 13:17:30 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2013 13:17:30 EDT
Received: from mail-oa0-f51.google.com ([209.85.219.51]) (using TLSv1) by na3sys009aob116.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+CKpSWV3hn8jHffPOosHhGtUq6XHf5@postini.com; Thu, 29 Aug 2013 10:17:30 PDT
Received: by mail-oa0-f51.google.com with SMTP id h1so950224oag.24
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 10:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wBkwt7Ia8N35zzags/SMi2qtPbwAYd+tJEKG/drclUc=;
        b=Af0JCx1JFPv5xLyyQwQ2S+kWtpq6bFcMRNA5b2HqQUSu7eN11wV9vgnM2kuceEaQK/
         vpxg6q7AI4P4yFF6nO8kDMEK1/p5sQ5DT2mRTMDO/v07yXRimoiQB6iU39OgwRIJVfwi
         FAnShcJmhXGpGFAjyrK2Flh9caezXWQf41hVqPIPSBrLrbRhlpBWeU1CuaOHY1FaTQto
         pzH4AkY5W0Mlcy/kIOnuDPj3kbzibALtXEf1xpglN9ttPN8u6MzJ2EaSUuMq+d+lEsh3
         8enMhZ12cx2bIDIP6Xe4f/Kmj+Ty+LYXvytsIpe4YbEhVVYn9GK/kb2F4hw6O44cNmjp
         8/MQ==
X-Received: by 10.182.106.114 with SMTP id gt18mr3251273obb.77.1377796246770;
        Thu, 29 Aug 2013 10:10:46 -0700 (PDT)
X-Gm-Message-State: ALoCoQlQxFQZYWWIIOHx5lpoJUD+CiCsjs6+kUeSRwRkNBKVwuR6WPXJxOtLMcOkGQjVWRRhJMJO8SL/LfdQhpFudei6pD9yU8kY705BG0Ffvu0Jnqf2B+8M48ABIATLrqOoaJ4SOYKm7iSHzLr/WdE+7OrB1ucdHw==
X-Received: by 10.182.106.114 with SMTP id gt18mr3251261obb.77.1377796246688;
        Thu, 29 Aug 2013 10:10:46 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id nw5sm4230104obc.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 10:10:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqq7gf479jm.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233287>

On 08/29/2013 12:21 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>> needs to reject duplicate ref names from the stdin lines before
>> trying to lock the ref twice to avoid this message.
> 
> How about trying not to feed duplicates?

Sure, perhaps it is simplest to push the responsibility on the user
to avoid duplicates.  However, the error message will need to be
re-worded to distinguish this case from a stale lock or competing
process since both locks may come from the same update-ref process.

Without checking the input for duplicates ourselves we cannot
distinguish these cases to provide a more informative error message.
However, such a check would add runtime overhead even for valid input.
If we prefer to avoid input validation then here is proposed new
wording for the lock failure message:

--------------------------------------------------------------------
fatal: Unable to create '....lock': File exists.

The lock file may exist because:
- another running git process already has the lock, or
- this process already has the lock because it was asked to
  update the same file multiple times simultaneously, or
- a stale lock is left from a git process that crashed earlier.
In the last case, make sure no other git process is running and
remove the file manually to continue.
--------------------------------------------------------------------

IIUC the message cannot say anything about a 'ref' because it is
used for other file type lock failures too.

Comments?
-Brad
