From: James Pickens <jepicken@gmail.com>
Subject: Re: [git wiki PATCH 1/3] "Improving parallelism in various commands" project
Date: Fri, 2 Mar 2012 10:35:24 -0700
Message-ID: <CAJMEqRAXa+qdXa_6S1PieD2SwcSDo5kkCwe3_PedTRet-vk-Fw@mail.gmail.com>
References: <20120302091114.GA3984@sigill.intra.peff.net> <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 02 18:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3WOU-0001ON-Pa
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 18:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188Ab2CBRfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 12:35:46 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48061 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab2CBRfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 12:35:45 -0500
Received: by wgbdr13 with SMTP id dr13so1789075wgb.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 09:35:44 -0800 (PST)
Received-SPF: pass (google.com: domain of jepicken@gmail.com designates 10.180.103.35 as permitted sender) client-ip=10.180.103.35;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jepicken@gmail.com designates 10.180.103.35 as permitted sender) smtp.mail=jepicken@gmail.com; dkim=pass header.i=jepicken@gmail.com
Received: from mr.google.com ([10.180.103.35])
        by 10.180.103.35 with SMTP id ft3mr7405183wib.0.1330709744406 (num_hops = 1);
        Fri, 02 Mar 2012 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=R8xdc/C3eY+OnK1EFjoVsLIQxHlEKP5LbYXvfuLADC8=;
        b=ZqNZWKShMKeidaSEWkz6iNozyqrRw7BJ3X1yRfsI7+Y7X84WvqWu1hjFDd0Defz87r
         cDJITU2gR5s3ZkYidnPespXmghsNIZBpetMROmclq+o9pGdkdlkjJRC4tPbph043u3a2
         7xUIII2ezr7KgMnDPOGJOPJJSzWPNtLKVsRrt7q1b3MLGRsQFsasEfNqkjZk5JpBWKwd
         TXYuZlAFSXXAgBcMY7a78AKxXF3A+0QhKipyKgOP0MFGEQwDo3m0/DvnntiZAbfIUCkQ
         RIbfEHyL67DUn2VGwV9m0GPtP0xP7rUfnp9BvKY3lcGschH3X2CyiKUtKqCuxy9kKrSo
         XCTQ==
Received: by 10.180.103.35 with SMTP id ft3mr5937466wib.0.1330709744245; Fri,
 02 Mar 2012 09:35:44 -0800 (PST)
Received: by 10.223.109.82 with HTTP; Fri, 2 Mar 2012 09:35:24 -0800 (PST)
In-Reply-To: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192053>

[Resend since the first try had HTML and the list rejected it]

On Fri, Mar 2, 2012, Thomas Rast <trast@student.ethz.ch> wrote:
+ * In preparation (the half-step): identify commands that could
+   benefit from parallelism.  `git grep --cached` and `git grep
+   COMMIT` come to mind, but most likely also `git diff` and `git log
+   -p`.  You can probably find more.

For those of us who must work on NFS for various reasons, it would help
tremendously to write out work tree files in parallel, during 'git clone',
'git reset --hard', and any other command that writes lots of files to the
work tree.  You can get a huge speedup (benchmarked at ~3.5x) without even
unpacking those files in parallel; unpacking them serially and writing them
to disk in parallel is sufficient.

I submitted a patch [1] ~2 years ago that added that capability.  It was
not accepted, but it did demonstrate the huge potential speedup on NFS, and
the pitfall of degrading performance on a local drive.  The patch itself is
probably not useful any more, but it includes some benchmarks, and the
discussion may be helpful.

James

[1] http://thread.gmane.org/gmane.comp.version-control.git/103489
