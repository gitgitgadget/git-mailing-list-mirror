From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Test failures in contrib/remote-helpers
Date: Sun, 11 Nov 2012 20:50:35 +0100
Message-ID: <CAMP44s14J_D_pZuRL4zrc1iphxf7tnFuA4Vpx7d1JTDUts84uw@mail.gmail.com>
References: <CALkWK0mU5O3Rqznkx-qn8VLFEgsMzOba1i8onSvf8X3FBeTs6g@mail.gmail.com>
	<CAMP44s1TLyKoHVouwgCFqi-vwA6rUBYJZXTA7JDFX6bfyQ7_tw@mail.gmail.com>
	<CALkWK0k9trxx8NC1GWw-yYzBKhFchrvg2JLeBtyoAkokmv9A0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXdYQ-0001gr-8K
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 20:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab2KKTuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 14:50:37 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62189 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab2KKTug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 14:50:36 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5599167obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9cjwekIl+Duidw2pTEh4xMJMXZ46sF7rJlq+AeyO9Y0=;
        b=OpD3wch8/lknrFh0sLHE4oMBkt0taWSKAm4mL3tsDJOGsecSP7/vBTSnzn8Y3IEJYH
         czjLl2KRyrjwDIG05uZ+Ov+RTOM48SudyxHxuPIo3B/rdaMsi65omqBiT/afYdYUYZoN
         DK5KkdKBAaUfCKClFn+1D0W9MDBnoZRz0P4A5lKfLrcjibFdC6qfmV57NfTGo6N1m9Bt
         N+6bkHGcu68jWojByTY+RikDwgApq81QqELQQLpe1R0La/4XicjPe0kxkaE7EXEH7BHL
         cS2kXndAEHlalJgy7IYl90hjrweYGG29FEw3dQQpzy4S9qs8jKeKHCmsmk21/R8AGN06
         TNQw==
Received: by 10.60.12.233 with SMTP id b9mr13167231oec.95.1352663436005; Sun,
 11 Nov 2012 11:50:36 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 11:50:35 -0800 (PST)
In-Reply-To: <CALkWK0k9trxx8NC1GWw-yYzBKhFchrvg2JLeBtyoAkokmv9A0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209441>

On Sun, Nov 11, 2012 at 1:48 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Sun, Nov 11, 2012 at 11:32 AM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> I'm experiencing test failures in contrib/remote-helpers.
>>
>> Which are your versions of hg, and bzr?
>
> Mercurial Distributed SCM (version 1.9.1)

I can reproduce the issue, this fixes it for versions up to 1.8:

--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -294,7 +294,7 @@ def export_ref(repo, name, kind, head):
     if tip and tip == head.rev():
         # nothing to do
         return
-    revs = repo.revs('%u:%u' % (tip, head))
+    revs = xrange(tip, head.rev() + 1)
     count = 0

     revs = [rev for rev in revs if not marks.is_marked(rev)]

I don't think it makes sense to aim anything lower.

-- 
Felipe Contreras
