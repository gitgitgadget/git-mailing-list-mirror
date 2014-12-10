From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 03:36:31 -0500
Message-ID: <CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
References: <20141209174958.GA26167@peff.net>
	<20141209180916.GA26873@peff.net>
	<xmqqa92wla34.fsf@gitster.dls.corp.google.com>
	<20141210073447.GA20298@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 09:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyclB-0002Uv-CX
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 09:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbaLJIgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 03:36:33 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:46525 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaLJIgc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 03:36:32 -0500
Received: by mail-yk0-f170.google.com with SMTP id q200so1032150ykb.29
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 00:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qV/MV4VmZRvBJUQwUcEvHX453XoKzx/40BrWmtvmnSU=;
        b=1GDNmZ3I7WnuNUn2It8Fb9HP62A9y8z7YvE54IOGYqwdPoxsSn4ZR2rdEDOwZERVX5
         gVuf2MvgygqPkxcuqxeQl9mnMpNCx2PCzYtaSXDsn27p2rqINakLk7EVm3bDy/bCaeVL
         fbLoq5TbvaOnSx2QFQTuS+EHuMMIwujPC/k4rDi72hOoppbzOfQNWxn5xJPrYuZUkfQ6
         LnFqUJN9URtjJBDZcsflBOFaXbPVfA0KoOq+65JwzbGlMXogHq7O3MHztwXNkH/mkHeG
         ztKhFSa+xqfarSlu0n4Asb9SJ8cu0hi8i1esAE3JCunRnIbW1gjng0DUyiiNer2zNgI0
         b1kA==
X-Received: by 10.170.42.151 with SMTP id 145mr2031105ykk.74.1418200591106;
 Wed, 10 Dec 2014 00:36:31 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Wed, 10 Dec 2014 00:36:31 -0800 (PST)
In-Reply-To: <20141210073447.GA20298@peff.net>
X-Google-Sender-Auth: vyf_NmeC5L1QF-omcgNPlcXmnBE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261194>

On Wed, Dec 10, 2014 at 2:34 AM, Jeff King <peff@peff.net> wrote:
> Below is a another iteration on the patch. The actual code changes are
> the same as the strbuf one, but the tests take care to avoid assuming
> the filesystem can handle such a long path. Testing on Windows and OS X
> is appreciated.

All three new tests fail on OS X. Thus far brief examination of the
first failing tests shows that 'expect' and 'actual' differ:

expect:
    long
    master

actual:
    master

> Note that in addition to cheating on the creation of the long ref, I had
> to tweak the fetch test a little to avoid writing the loose ref there,
> too. That makes the test a little weaker (it is not as "end to end",
> checking that all parts of fetch can handle it), but it does check the
> thing we are changing here, that the protocol code can handle it.
