From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 10/41] update-ref.c: log transaction error from the update_ref
Date: Wed, 28 May 2014 07:46:34 -0700
Message-ID: <CAL=YDWnvo-oLd80Kgd1qnqUSSSrwNfcq_wHEjLRCa0Jr4XCjwA@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-11-git-send-email-sahlberg@google.com>
	<20140528002738.GJ12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 16:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpf7n-0001TY-O6
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 16:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbaE1Oqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 10:46:36 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:41888 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbaE1Oqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 10:46:35 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so12487751veb.23
        for <git@vger.kernel.org>; Wed, 28 May 2014 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sz3QCAeKOVWjdzXLVBfmIQq2LSzCQ+HajgPU/TnYYsc=;
        b=I96RjhCL0TYcNumLPXNFQaL73BDMXexsFg6wSolf9lbFKZWwBjqPLBZYHoEATAe02X
         gE/2PUWNBao2JSJIdKROuZT+JgsLDKFvtF5wBXEwXd3Y7BKpj+lAHOtXWAiIkP1LMiF0
         Gglxt3AlmPz1/TxI2fNc+mh9deNfeGmqSZzPOfyGbQXp+D8FxqWjZvKB6o4p0gFiRIE1
         MdAo79BUYIzKt1XXnMUZOLx2OV41sx3omUmDV1Nn5/V5GZIF9d9iD59ELgvSBsy9j1mC
         D2mfbEz/t40jFJQ6eoTuNPwd6zSXpqhgEUWYuLQcl1T1Df1iK9TadEiec4a0+NoELLRA
         Ytug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sz3QCAeKOVWjdzXLVBfmIQq2LSzCQ+HajgPU/TnYYsc=;
        b=lCHDLkBi9nIXEsbjM96RvnbU8AfUS0Tu5w5ihefcJ95gXoImPtOLe/NxbDQPf6F8yo
         cT9AAWdAIQJqLHMd7RVvW3HPgairM9hPnGym5PshYdEj1XXKUdPNOBsuGjHtQMkQ8QGp
         5cAHJrO2ImpFdIxSmUvK7UEOnoOrFeV2rN8vHNc742bKlYeblaPGoU1BWIieNdJvxsg4
         RVTanqNjZ+CVyy7CoeJumbVO2vU5q+AfWjaj83+B4JSPsRVqYyPoZlUNAZ2rpFPhCZjl
         AhvSVFcHa+9AZ2HrOPnIBkpO4IjwEzFCv8++cqCG+rVxmUeVcceBR9SVLrTCTG2B3519
         I2Lg==
X-Gm-Message-State: ALoCoQkeyRjjNceJbxPOs08DBv8WpHUBx5KLNIAJFtkhqrNXlCdwl0VeOiEIU78Id/eimIH3z+m4
X-Received: by 10.58.56.71 with SMTP id y7mr158486vep.24.1401288394471; Wed,
 28 May 2014 07:46:34 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 07:46:34 -0700 (PDT)
In-Reply-To: <20140528002738.GJ12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250286>

On Tue, May 27, 2014 at 5:27 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Comments from http://marc.info/?l=git&m=140079653930751&w=2:
>
> Ronnie Sahlberg wrote:
>
>> [Subject: update-ref.c: log transaction error from the update_ref]
>
> The above description suggests that this is going to add new logging,
> or in other words that update_ref was being silent about transaction
> errors before.
>
> The actual intent is for there to be no functional change, right?  I'd
> say something like "update-ref: use err argument to get error from
> ref_transaction_commit" or something similar to make it clearer that
> this is just about changing APIs.  Or if there's an intended
> functional change, then the commit message could say something about
> that.

Thanks.
I reworded the commit message.

>
> Thanks,
> Jonathan
