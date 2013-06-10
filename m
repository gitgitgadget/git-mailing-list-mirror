From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 10 Jun 2013 23:03:28 +0200
Message-ID: <CALWbr2zLTUYRnaYxbjyU80zpa3Q6WGcquTPAHqWCJnbEZ7RNPQ@mail.gmail.com>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
	<7vsj0roxnr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:03:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9FW-0004qD-2s
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3FJVDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:03:30 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:53477 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab3FJVD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:03:29 -0400
Received: by mail-qe0-f42.google.com with SMTP id s14so4402626qeb.29
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=S9dRe3o7QtSl74Gs/48Fyyp/iPyxgeFHAwqsm52nwpc=;
        b=ANbz354fOCHxz95/J+s3p4ssJ6b8i8gOHM5rEGME/cQ5G0wIwsueUjaZUw1EAQlUWl
         E28hH7WwmktQ4t9WdlCCwg44dwjPctqR1Rk2HVrjHYf7u1i2URA0XQ69t07bzQ0uybA1
         5GRz9MFcFgKsDBymo1ymhFZZQgFy4P7YjkurAHqyTZE/5T4qLQ+deRj5pCulCTdOtZ8Q
         W6SrVN+cXzdIkElZCr5zBpI/zkwD268CppjfoOaLbcatqfldkAgrqG2lCav/MP/Ki3uo
         bb1+uk/w950mZa+towB7mHv2lkNXsE5aKO/lYqT6v8gLUYL9eUy98wb5R2l7UYdowoT8
         waAA==
X-Received: by 10.224.79.209 with SMTP id q17mr15087446qak.88.1370898208958;
 Mon, 10 Jun 2013 14:03:28 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Mon, 10 Jun 2013 14:03:28 -0700 (PDT)
In-Reply-To: <7vsj0roxnr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227380>

On Sun, Jun 9, 2013 at 10:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When any ignore blank option is used, there will be lines that
> actually has changes (hence should be shown with +/-) but we
> deliberately ignore their changes (hence, if they ever appear in the
> hunk, they do so as context lines prefixed with SP not +/-).  When
> we do so, we show the lines from the postimage in the context.

Don't we actually use preimage (see below) ? I think using pre-image
allows the patch to be applicable to another tree (but ignoring the
space changes).
If we actually hide new blank lines that are in the context, it means
that we won't be able to apply a patch with 2 new blank lines in the 3
line context.

Anyway, I'm starting to think that "show blank lines changes near
other changes" makes sense more and more sense.
By the way I have a patch I *think* is working, but I will check it
another thousand times before sending.

Cheers,
Antoine

$ git diff
diff --git a/x b/x
index e562137..226e35a 100644
--- a/x
+++ b/x
@@ -4,8 +4,9 @@ change
 3
 4
 5
-6
-7
-8
-9
+   6
+7
+change
+  8
+9
 10

$ git diff -w
diff --git a/x b/x
index e562137..226e35a 100644
--- a/x
+++ b/x
@@ -6,6 +6,7 @@ change
 5
 6
 7
+change
 8
 9
 10
