From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 22/48] refs.c: make ref_transaction_begin take an err argument
Date: Mon, 14 Jul 2014 10:45:37 -0700
Message-ID: <CAL=YDWksQ_xf_nys1M8Ugoo8kqYZFeOmEXvePE+F1hFQQhfQ6Q@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-23-git-send-email-sahlberg@google.com>
	<53BBDBA0.5070308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:45:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6kJr-0001un-U7
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbaGNRpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 13:45:40 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:39622 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbaGNRpi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 13:45:38 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so7790166vcb.24
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5yAAloyq/mTb8Egd9qx5FkzH14y8Z9fStFNR+oBhuZg=;
        b=JB5HtChrWr8dI1+F02LEeLigIu7d6sMpvMQFqwGEd4V1Dh5ys9IOO/7T9kRkBXqJbS
         +Y5XauUYi5nO0fV6j/hDaQKLEbUmlQmH/CizuFy90DSrMygNd7zw8sfWqui3fVr2b/8N
         zptbKBcicu8jwF+lvY61orFWFRjRlUbcJGe4aBEmMl9X2L9zvLmcgSUpK7GC0ba2s+iR
         biyYE3ORAR3LE3dsdigxiP64MpLR1Qziprus0+sXzvc3cIADAYN8ehn0RHvzaGklzq1k
         m5mrXGcD15YXFLvaiuaihf/YQQRbQczz10/xwK/BsiJnEjvlE/n8qJhUBIXHJGkMvVpD
         Dvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5yAAloyq/mTb8Egd9qx5FkzH14y8Z9fStFNR+oBhuZg=;
        b=YpO2SpnTHWbGRzg5iFItxH3DveUBJCm6EhC/UYPtEDxVElH9bbQvLIGLBlqslNYTsH
         RFQqPlFGzSz+O6K8lqGn4eSbFYN8z/jksQphq5zZOvZifcPBm/1bNWSGzZObAs2rYYEj
         qKxP00KnlF/sxdene0N6OOE14ZLHgdUba5ius133xhFrdxc1KkL6kaOf+D1+vQ+zqNhJ
         UaonaisFAHr6zk8agtRodcIPk+dkkKBepxLiF1s42orsKnSSHQu+21sizaxDV6Xzm4L/
         KwUz27RIMY3+iw8Q1LOtOGof38JXzHt1bG50Hc+uSbconV6ogNAWMFtL+UkC4LtzmCru
         PkUA==
X-Gm-Message-State: ALoCoQms78XfiKVSzC3oRH8f7qIWT/DwAY4R+GWJGaIVzeNji0kiNHAA+At/+vSdFIHcy6FeeOX5
X-Received: by 10.221.41.135 with SMTP id tu7mr533179vcb.70.1405359937482;
 Mon, 14 Jul 2014 10:45:37 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 10:45:37 -0700 (PDT)
In-Reply-To: <53BBDBA0.5070308@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253502>

Thanks. Fixed.

On Tue, Jul 8, 2014 at 4:53 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Add an err argument to _begin so that on non-fatal failures in future ref
>> backends we can report a nice error back to the caller.
>> While _begin can currently never fail for other reasons than OOM, in which
>> case we die() anyway, we may add other types of backends in the future.
>> For example, a hypothetical MySQL backend could fail in _being with
>
> s/_being/_begin/
>
>> [...]
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
