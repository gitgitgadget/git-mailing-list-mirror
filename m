From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Ambiguous date handling
Date: Wed, 12 Sep 2012 22:09:37 +1200
Message-ID: <50505F61.8040100@gmail.com>
References: <1347442551-7105-1-git-send-email-judge.packham@gmail.com> <7v4nn3fu6s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 12:09:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBjsX-0001gl-SE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 12:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab2ILKI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 06:08:58 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64498 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab2ILKI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 06:08:56 -0400
Received: by oago6 with SMTP id o6so857461oag.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tVCLS5J0fL+LTu3RZvoTuqo+xVd7VHbAwU8jrm8MhgI=;
        b=rOQn3WJL3TXwEv3PPpEyZrlrT5lmHxHJLVoU53I0uaFAtVN5Ba/p0gHl+I9glECtdw
         j1m2IhV4NNOTFMXfUHFuKNBNzS5P5ektVM3wYYSXVHA5lP4IjvAPy9Viklnd1ERRT6MQ
         EOhz554M4OZbLWrsA/LcrsNCnMaN+Lt2zSRU2EsZdHqDzC7ZotnllP5B9tTunnF+OXlv
         zW7bQIlYlNLFFRTc1p4ezYsklwL5VSLFkJFcMAPMDbCSkYQoM05LXl9vLPqj6p8tXBSo
         O4snrpV+IQu913WgM4VACvjotI/ant7RuAVMnMM2nLnKf7GSczkZ4J8mggQSiTEIuXXU
         zU8w==
Received: by 10.60.27.9 with SMTP id p9mr21334052oeg.69.1347444536348;
        Wed, 12 Sep 2012 03:08:56 -0700 (PDT)
Received: from [192.168.1.66] (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id kc5sm19627562obb.21.2012.09.12.03.08.53
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 03:08:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <7v4nn3fu6s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205278>

On 09/12/2012 09:48 PM, Junio C Hamano wrote:
> Chris Packham <judge.packham@gmail.com> writes:
> 
>> Our default MUA has an annoying habit of using a non RFC822 date format when
>> saving an email as plaintext. This means the first 12 days of every month we
>> run into the ambiguous date problem (our date convention is dd/mm/yy).
>>
>> I see code in date.c for refusing a date in the future which would have caught
>> this...
> 
> The most sane thing to do when you know that your MUA *consistently*
> does dd/mm/yy (even though it may annoy you) is to massage its
> output before feeding it to Git.  And it should be a very simple
> matter of a one-liner filter, no?

Consistent as long as you save as the default .txt. Some people have
trained themselves to use the save as .eml option which uses RFC822
style output. sed 's|Date: (\d+)/(\d+)/(\d+)|\1.\2.\3|' should correct
the former and ignore the latter. Could this be done in a applypatch-msg
hook?

> 
> Regardless of the correctness of that "we reject timestamps way into
> the future" logic, it should be taken as the last resort.  If you
> are on September 1st, both 9/12 and 12/9 will look like into the
> future for more than ten days (which is the cut-off, I think).  If
> you are on December 28th, both look like sufficiently in the past.
> 

Duly noted. And I'm implying that the reject timestamps in future isn't
actually working. I've just started looking at t0006-date.sh so see if I
can prove it.
