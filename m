From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 19:15:27 -0400
Message-ID: <CAPig+cSqtMOYvxbvXstm9nqQD9sQ378NKCHSK7Ec6GrK5VJiGA@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
	<CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
	<CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
	<xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 01:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCe6H-0002Ai-1F
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 01:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab3HVXP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 19:15:29 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:48640 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab3HVXP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 19:15:29 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so1938262lab.41
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K+hg4bAqK0Znw9V3J+ABcaGITocgDP4Z97QCneem5yk=;
        b=PV1gF7MDXSDvyLInLOKkR6uL6B+E9I2lnaVbYXfXQBIQRMrlvjn9HopMhy50cq15xI
         2C7ugDk7vq+wzi0bMEnsO4XA+64tAvP8i9EZqih+SY6mD87AA8vt/6uvwI8kJUD5khAw
         aZQvQGGjScTxD3kDuA+iIjVURpzI7yEH58aNUYJJ5d8fW8Fbe6fBeZbpxqVk+fJM6ceo
         i3PIFBi2XnT0FOVSUZHoAksmZR8T21xZNI+kXGyPe1oX0/YTKkTfdKBCm0SxInJh9rjO
         mOsbSVoizxMxYpaiTQTEloQzWZIg9Sq+p0n4odmxiWGh4lIJkJxs4atWKpi6nBYW2XYr
         2KGw==
X-Received: by 10.112.130.134 with SMTP id oe6mr3687492lbb.30.1377213327712;
 Thu, 22 Aug 2013 16:15:27 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 22 Aug 2013 16:15:27 -0700 (PDT)
In-Reply-To: <xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 36TPatI0kgbDbdUvEbwXUmywv1I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232791>

On Thu, Aug 22, 2013 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Status update: For the 'pathx' directory created by the t3010 test,
>> directory_exists_in_index() returns false on OSX, but true is returned
>> on Linux.
>
> Because a regular pathx/ju is in the index at that point, the
> correct answer directory_exists_in_index() should give for 'pathx'
> is "index_directory", not "index_nonexistent", I think.

directory_exists_in_index() and directory_exists_in_index_icase() are
behaving differently. You can replicate the problem on Linux by
enabling core.ignorecase in the test (sans gmail whitespace damage):

-->8--
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modif
index 3120efd..8c76160 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -89,7 +89,7 @@ test_expect_success 'git ls-files -k to show killed files.' '
        : >path9 &&
        touch path10 &&
        >pathx/ju/nk &&
-       git ls-files -k >.output
+       git -c core.ignorecase=true ls-files -k >.output
 '
-->8--
