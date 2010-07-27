From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] hash: Remove useless init_hash()
Date: Tue, 27 Jul 2010 08:55:46 -0700
Message-ID: <AANLkTikjDCookAhrku=kGZsKw+moqVXu5517bO3n1pSp@mail.gmail.com>
References: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 17:56:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdmWT-0003Pc-Qq
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 17:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab0G0P4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 11:56:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47982 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361Ab0G0P4r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 11:56:47 -0400
Received: from mail-yx0-f174.google.com (mail-yx0-f174.google.com [209.85.213.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o6RFuBfm008873
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:56:17 -0700
Received: by yxg6 with SMTP id 6so534810yxg.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:56:06 -0700 (PDT)
Received: by 10.150.66.14 with SMTP id o14mr11341086yba.125.1280246166336; 
	Tue, 27 Jul 2010 08:56:06 -0700 (PDT)
Received: by 10.231.157.204 with HTTP; Tue, 27 Jul 2010 08:55:46 -0700 (PDT)
In-Reply-To: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
X-Spam-Status: No, hits=-4.95 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151953>

On Mon, Jul 26, 2010 at 10:36 PM, Stephen Boyd <bebarino@gmail.com> wrote:
>
> init_hash() is essentially a memset() so just use that.

I disagree.

Yes, technically right now the initialization just zeroes out all the
fields, and memset() does the same. But there is no advantage to using
memset(), since init_hash() will create the same or better code, and
using init_hash() is way more readable.

Also, it's not at all the case that init_hash() is always going to be
a memset(). Imagine a threaded hash-table with a lock associated with
it or something. Now, admittedly that's not necessarily something we'd
ever do in git, but I still think it's simply a good idea to have a
clear "initialize this" routine, rather than depending on the fact
that zeroing it out is sufficient.

                    Linus
