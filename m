From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 16:28:24 -0400
Organization: Twitter
Message-ID: <1438115304.18134.33.camel@twopensource.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	 <xmqqa8ugdpu7.fsf@gitster.dls.corp.google.com>
	 <1438113266.18134.26.camel@twopensource.com>
	 <xmqq6154dpkt.fsf@gitster.dls.corp.google.com>
	 <xmqq1tfsdp60.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:28:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBUF-0008Qp-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbbG1U21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:28:27 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:32778 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbG1U20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:28:26 -0400
Received: by qged69 with SMTP id d69so82026082qge.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=2XBBcso2m42bMcum/r1hA2BFiOEkUBdZx0BZax1ldPQ=;
        b=DPV8TWt4+zb1YfdU0mnY2wVexN9Y5+h+tn7uSnK8E27PVbHRMrZoxpPQjF1Ihiy8fa
         E2BSJu9C3nbwJjlHqWgaJ/telep25QUwS++W4ktst51+tgfH4aKcHo5o8Tdx6hpRj687
         2OaDvu5+F81vD6irVZk4qRB1j7cYmEiqhPkc+gALx5OtQEjoFLQD+C6Bh025lscDvMnT
         WSA7igOTc10I47MclXGmYOXVXhjIGK5SARaSB+tygoA5A6HUtzBfUpVlueqOmTdoq52O
         LO45Guiq148Vgf+Y4YS38vH9tKL8oG9PaDzC4OJto3T883ygddkbbTr9YtPLOaOIx4/R
         WFYg==
X-Gm-Message-State: ALoCoQnTBM97DTMcrUE0525IchT7CJLXBY82+k+kD49HcozgdVF82EKhft1kXECQDYOljbor+gFQ
X-Received: by 10.140.16.74 with SMTP id 68mr50758154qga.99.1438115306036;
        Tue, 28 Jul 2015 13:28:26 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 16sm11950001qkt.27.2015.07.28.13.28.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 13:28:24 -0700 (PDT)
In-Reply-To: <xmqq1tfsdp60.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274838>

On Tue, 2015-07-28 at 13:04 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > David Turner <dturner@twopensource.com> writes:
> >
> >> The work done to produce the cache-tree is work that the commit would
> >> otherwise have to do.  So we're spending extra time in one place to
> >> eliminate that work in a different place.
> >
> > Good point.  Thanks.
> 
> Hmm, I forgot about another codepath.  What about operations that
> are purely done to pouplate the index, without necessarily creating
> a tree out of the index?
> 
> The most worrisome is "git checkout $branch" (two-tree merge).

Git checkout $branch already populates the cache-tree; this is due to
patches I added last year:

commit aecf567cbfb6ab46e82f7f5df36fb6a2dd5bee69
Author: David Turner <dturner@twopensource.com>
Date:   Sat Jul 5 21:06:56 2014 -0700

    cache-tree: create/update cache-tree on checkout
    
    When git checkout checks out a branch, create or update the
    cache-tree so that subsequent operations are faster.
----

Admittedly, we do not test for the case where we must do a two-way merge
during a checkout, but I just tested that case, and it appears that we
do already populate the cache-tree in that case.
