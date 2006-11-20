X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 11:22:08 +0100
Message-ID: <200611201022.10656.andyparkins@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com> <200611200951.05529.andyparkins@gmail.com> <7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 10:22:46 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LnUEB4/uYMii4Ls66O1zfJjGE4GmIRvuyLx1BsAGpudA7knboxyzDhZm2Ym1IBnWGzlNIY253fy9LnmPaX8D5FWm4f9gTXP0wuOJJ85MwJOajJdyc6DiB4FV2j1OI6OMrm1iWhlWENcwii3VN+DfTyWp8J/tnIGAJPjDsR3s+Yw=
User-Agent: KMail/1.9.5
In-Reply-To: <7vejry5t4g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31897>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm6I7-0006qa-OM for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965685AbWKTKWR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965687AbWKTKWR
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:22:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:57117 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965685AbWKTKWQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:22:16 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1133661ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 02:22:15 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr2509432ugg.1164018135138; Mon, 20
 Nov 2006 02:22:15 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 72sm7470299ugb.2006.11.20.02.22.13; Mon, 20 Nov 2006 02:22:14 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 November 20 10:07, Junio C Hamano wrote:

> The real issue here is because the b/a on the command line
> applies on the input-side, and does not act as the output
> filter.  This comes from _very_ early design decision and if you
> dig the list archive you will see Linus and I arguing about
> diffcore-pathspec (which later died off).

I don't think so; even without the b/a on the command line, git does not find 
copies made in this way...

$ git init-db
defaulting to local storage area
$ date > fileA
$ git add fileA
$ git commit -a -m "fileA"
Committing initial tree 3ef607fd139dd955f868305462d99dfc4cfff70f
$ cp fileA fileB
$ git add fileB
$ git commit -a -m "fileA -> fileB"

Now let's try and get git-diff to notice this was a copy...

$ git diff HEAD^..HEAD | cat
diff --git a/fileB b/fileB
new file mode 100644
index 0000000..ec620df
--- /dev/null
+++ b/fileB
@@ -0,0 +1 @@
+Mon Nov 20 10:16:29 GMT 2006
$ git diff -C HEAD^..HEAD | cat
diff --git a/fileB b/fileB
new file mode 100644
index 0000000..ec620df
--- /dev/null
+++ b/fileB
@@ -0,0 +1 @@
+Mon Nov 20 10:16:29 GMT 2006
$ git diff --find-copies-harder HEAD^..HEAD | cat
diff --git a/fileA b/fileB
similarity index 100%
copy from fileA
copy to fileB

As I said - I don't see what "-C" ever does for you in all but the rarest of 
uses.  --find-copies-harder is the only way to list copies successfully.  
It's nothing to do with any input or output filtering.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
