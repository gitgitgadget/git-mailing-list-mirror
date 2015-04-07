From: David Turner <dturner@twopensource.com>
Subject: Re: Freeing struct lock_file?
Date: Mon, 06 Apr 2015 21:12:43 -0400
Organization: Twitter
Message-ID: <1428369163.3560.12.camel@ubuntu>
References: <1428097515.31333.2.camel@ubuntu>
	 <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 03:12:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfI4V-0006nj-CE
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 03:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbbDGBMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 21:12:50 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36836 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbbDGBMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 21:12:49 -0400
Received: by qgeb100 with SMTP id b100so17363015qge.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 18:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=dDS/TTn5hNwJoystUzXxstvxyLjdpGLrCdGWnbzzmHQ=;
        b=QyZQnIoHGHJMPfEapLiRmqac6FGA2lI00TVGYRTupS8Mh0fn/YkR+jc6kabwh8foLA
         Tp/RwTh+fUlAplkcbeNfYTDJzbXc1vFod/4KbSuoKBgeC1jZcGG5YQ2csvIFhqGhJ3+9
         R0BLasJZ1TuQD9zFEB+uj8d0uHLmt2uj8wok8no6hmkUdC9GRQ/nzSAIi6n7ka9HoZaA
         ncrw3gxYw0aXmQ4gshcsnYoZndtgas9ZZI/cTNysN1ZAcYbk8KYpM6cGThE+kBgDfKso
         LJQG60IHEWV9hZnUSpb4GNE717nnQ55vRc/AdQKmGCXcLXzi5CTpd6vEUbOIf9nHjMNV
         7J7A==
X-Gm-Message-State: ALoCoQndiA3Xx1WQscWa39hLZlbp4J57ZEUKR1gKadP0YAAdkmcxioj1/pDZnmQ55ZNOoDouML+I
X-Received: by 10.140.25.197 with SMTP id 63mr20717184qgt.14.1428369168551;
        Mon, 06 Apr 2015 18:12:48 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id i14sm4156759qkh.5.2015.04.06.18.12.45
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 18:12:47 -0700 (PDT)
In-Reply-To: <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266894>

On Fri, 2015-04-03 at 15:01 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Why is it impossible to free struct lock_files?  I understand that they
> > become part of a linked list, and that there's an atexit handler that
> > goes over that list.  But couldn't we just remove them from the linked
> > list and then free them? 
> 
> I suspect that the code is worried about getting a signal, while it
> is manipulating the linked list, and then cause the atexit handler
> to walk a list that is in a broken state.

Actually, couldn't we just block signals with sigprocmask while
manipulating the list?
