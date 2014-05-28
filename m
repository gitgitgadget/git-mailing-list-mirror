From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 13/41] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Wed, 28 May 2014 11:01:13 -0700
Message-ID: <CAL=YDW=-FFB=8u7TxMJf_bxeDF2L_AiqS6ST293ZGc6MO=Az_A@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-14-git-send-email-sahlberg@google.com>
	<20140528004200.GK12314@google.com>
	<CAL=YDWkQhq2oCkyBG0-ojUDwgApYj1qZt1vXa2gnYsJOEbnvxQ@mail.gmail.com>
	<20140528170700.GM12314@google.com>
	<CAL=YDWnZQajozAcjLi85xKgkRazScv0Q_5XoVvV47u7AumL2gg@mail.gmail.com>
	<20140528172507.GO12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpiAA-0006kC-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbaE1SBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:01:15 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:37959 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaE1SBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:01:14 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so12788000vcb.15
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lomTDoM87xg1efCb0ctm6af8QX/kCY4qt8DtYXwGlYU=;
        b=Z6o7ELgeRkcJ9BDqNAmodRktviiJx9xQX3WCQ6gPQWyIRPlUDqE1KzRqT4UPwwKUqm
         SBm86AwUPqoDx67LXY3pbLI/usRLAKyRMbK3X/ANk2jgV6rg9Zf6Cr0WZjDwhJL6RFrs
         vm+nNBGctJu9MEOF6gT4UP+2zReGOjtDFgL+gp4lc1lQ98IuQ6cxNo3eiY9MaxO5wPSK
         V0bbZyXCM5QYoFqWC5VnPnhmj4oYG1hm6JOKb1wSwfdL/PGO+ToOxQpe97E6DBXn4sng
         eth8qUl3++kidbM1uziHHQBomKNxQkPLQzYvYZ8yoOS0BinntanxRt6rZd5A0ATptmlS
         4UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lomTDoM87xg1efCb0ctm6af8QX/kCY4qt8DtYXwGlYU=;
        b=kJetwypNnCqO5QJCeGuFug8y+4YZcnCxCQkXLRt1vVpM6t4XITPG0epQ3g0sCFFAle
         nB0DFMH3gc2PtXdbFHqwDW1S8Dwd859ELv88ltQjZaXZ2LH2vnIRo66y5zexB4aLCqBQ
         QutXrMRf8R0QITLmMq6e2OVe4PnsrN9xxvJ0HyVqm/FKJALDfT/v20hr0FpCItxurg/7
         m+Nxdh59E5rd6hSvDg7DM2+geepxrF54HhNuN9TC2ovN2vtwaR99BMwIdQW548zfc2vR
         KPxLcRwzaHNp5yyEzz2M+oph5xQhXdNXlJrqhOiU2mJHBryABAHRI32jCpByqcahaFpw
         vyoA==
X-Gm-Message-State: ALoCoQl979qZXyWTkQbXsHj/hCjShbOCzELRPyZegqQTmdYWUlJBE06HnD6MeMHoKBPV2kpC6hRe
X-Received: by 10.220.53.72 with SMTP id l8mr1741953vcg.16.1401300073645; Wed,
 28 May 2014 11:01:13 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 11:01:13 -0700 (PDT)
In-Reply-To: <20140528172507.GO12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250303>

Thanks

Can you re-review these patches for me :

please review

67b8fce refs.c: add an err argument to repack_without_refs
738ac43 refs.c: add an err argument to delete_ref_loose
b78b0e0 refs.c: update ref_transaction_delete to check for error and
return status
e558f96 refs.c: add transaction.status and track OPEN/CLOSED/ERROR
5a7d9bf sequencer.c: use ref transactions for all ref updates
0ea69df fast-import.c: change update_branch to use ref transactions
57c92fb refs.c: change update_ref to use a transaction





On Wed, May 28, 2014 at 10:25 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Please re-review.
>
> 06df8942 is
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.
