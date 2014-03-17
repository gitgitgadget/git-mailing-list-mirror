From: Kicer Jiao <joykicer@gmail.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Mon, 17 Mar 2014 17:21:56 +0800
Message-ID: <CAGRPCXzJXfKtB1wkOMN_7dQ6RdXAs5YNQ+p70eoUYOr5zXkM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 17 10:22:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPTkB-0007Ul-8Q
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 10:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbaCQJV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 05:21:58 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:53426 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbaCQJV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 05:21:58 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so4311375wes.15
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=rs+7W6+PIOAKRDcrMEQs/Pk2AxIoKX6hh93ZMkRqgYM=;
        b=LfcxMOrYboaakx2urVINPQ6LFUOd9vBhaM2xxW7J1KtZNVJJo9QdUkH/5Mu9n5Nz5U
         +kr2fB6lkgUpfwZbxEJv0o/2HDxMCKWAUAv2wurgW/uuyGyzzK7K4RjGbkojgd5s/Oec
         tJNAgfkcYfdOZ5TXrPj75iSmLNjh3ig82G8LLIu4gFNozHcymEveBbHCCwWfcHNnlQno
         UVKkUBIMtz6s8BVLcyKfPU43b27CA/NjqDusVbDZi26UvqiAuyzrovaYm75BKrqvFAO8
         nME9iqd5S6XS0WF3k9TIDsqlm75CaJSoBNL0RPAxl54s2FRva2aokKrU4+koJBmeZyd3
         LKzw==
X-Received: by 10.180.19.138 with SMTP id f10mr8595986wie.11.1395048116869;
 Mon, 17 Mar 2014 02:21:56 -0700 (PDT)
Received: by 10.227.107.5 with HTTP; Mon, 17 Mar 2014 02:21:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244234>

Dear all,

I have a git-project which source code use gbk encoding. When use
gitweb blame view, it will report an error then stop parse:
>    Malformed UTF-8 character (fatal) at /usr/share/gitweb/gitweb.cgi line 1595, &lt;$fd&gt; line 45.

After apply this patch, blame view of gbk source file will back to normally.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 79057b7..e6fdcfe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6704,7 +6704,6 @@ sub git_blame_common {
                        $hash_base, '--', $file_name
                        or die_error(500, "Open git-blame --porcelain failed");
        }
-       binmode $fd, ':utf8';

        # incremental blame data returns early
        if ($format eq 'data') {

When I search the git.git log, this commit add the "binmode ..." line,
maybe should recheck this commit? Thanks.
fd87004e51df835e5833bfe1bff3ad0137d42227  "gitweb: Fix the author
initials in blame for non-ASCII names"


BR,
2014-03-17
