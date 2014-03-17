From: Kicer Jiao <joykicer@gmail.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Mon, 17 Mar 2014 17:34:14 +0800
Message-ID: <CAGRPCXyf_QtHm3g2DY9Q3+9qrHegbE+nXoR=YAw_YcQvS+kCRg@mail.gmail.com>
References: <CAGRPCXzJXfKtB1wkOMN_7dQ6RdXAs5YNQ+p70eoUYOr5zXkM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 17 10:34:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPTw4-0003y2-OO
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 10:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbaCQJeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 05:34:16 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:50195 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbaCQJeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 05:34:15 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so4321496wes.9
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rs+7W6+PIOAKRDcrMEQs/Pk2AxIoKX6hh93ZMkRqgYM=;
        b=nICpujeLFF9lad8V4cG4VzUofoXC7mkRkLsayCUzV3FUPnRmadQF0QNYExcvWY4gTs
         99/GNfukDw+djlrzWCGMfkbkSI3LAeRPammiR4q2PtmTXgITrM0QcVmi5o0pRB4gySzX
         UkZrTU08j3twwbMqrTuQGtL2IdStsi3U2cl6bj0ezJRdQnyALSJyXSWhu+QGZLauORHo
         bKdZPK4Kr9C/jon0WnyMhDtJjigkY/RgMirfsvjwjLkSrkaHEf86/EX3ELLzyc+CClIV
         1hfS5u6Yq/kag7y5bD2rNPriqWl8WgFzijIdm7DwMiGdWY8I6h9rBOHvbxVEumyAqrjp
         PV+A==
X-Received: by 10.180.19.138 with SMTP id f10mr8642202wie.11.1395048854747;
 Mon, 17 Mar 2014 02:34:14 -0700 (PDT)
Received: by 10.227.107.5 with HTTP; Mon, 17 Mar 2014 02:34:14 -0700 (PDT)
In-Reply-To: <CAGRPCXzJXfKtB1wkOMN_7dQ6RdXAs5YNQ+p70eoUYOr5zXkM_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244236>

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
