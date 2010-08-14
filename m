From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Highlight every 5th line for add -i
Date: Sat, 14 Aug 2010 03:33:33 -0700
Message-ID: <4C6670FD.9010100@gmail.com>
References: <1281703569-8833-1-git-send-email-ciaran.mccreesh@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 12:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkE3e-0003N0-8D
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 12:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934682Ab0HNKdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 06:33:40 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46881 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934672Ab0HNKdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 06:33:39 -0400
Received: by pxi10 with SMTP id 10so1133562pxi.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=jYGnIYXvFe2PRIgxHFfXbk8GQOz6RliO4LMEDQZnAK8=;
        b=bVWgrncV+1SK5PExb2PYy3gsO221F3I2xCAuOewwA/sHDOlZJ6PfMWNnZIHCraqbs7
         YQ9/BXo1JePD8GaLcyOmtevebG9mbUITrFnqNsKQNO0QN/BX8yBhY+JCa6TEcQRrmqRL
         9WK6XXIaf2WszzzhAkB2XnHDaKZXZffOKOjwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ljAhBdhilzMsJFUTUhuModf6IHjD9zH58EfxvF0C1XWOfUC2cTeXqa1mnEmqmbF7YS
         WToZZIJatgP+gDZEp5gB/fGMcN4RRNXCTTHUzpmxTu8PIWpMMf5jRWNFKwziTrKfVwSI
         k9whB9ayeZ/0sE71cGnk7Ely08MXpwoYl+zHY=
Received: by 10.142.211.5 with SMTP id j5mr2290183wfg.261.1281782019436;
        Sat, 14 Aug 2010 03:33:39 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id w4sm2654485wfd.20.2010.08.14.03.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 03:33:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.7) Gecko/20100805 Lightning/1.0b2pre Thunderbird/3.1.1
In-Reply-To: <1281703569-8833-1-git-send-email-ciaran.mccreesh@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153552>

  On 08/13/2010 05:46 AM, Ciaran McCreesh wrote:
> It's easier to match up numbers to filenames when there's lots of output
> that way.

Interesting. Maybe it would be better to reorganize the listing so that the number is adjacent to the path name? For example:

    staged    unstaged   #  path
unchanged     +5/-2     1: git-add--interactive.perl
unchanged     +100/-2   2: builtin/log.c
unchanged     +49/-2    3: builtin/add.c
unchanged     +0/-60    4: git.c
unchanged     +5/-2     5: help.c

I'm mostly concerned that the highlighting (boldening?) is going to be confused with selection.

Patch below (I'm sure someone more versed in perl can do it better).

--->8----8<---

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 27fc793..002122d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -225,8 +225,8 @@ sub list_untracked {
         run_cmd_pipe(qw(git ls-files --others --exclude-standard --), @ARGV);
  }

-my $status_fmt = '%12s %12s %s';
-my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
+my $status_fmt = '%12s %12s %4s%s %s';
+my $status_head = sprintf($status_fmt, 'staged', 'unstaged', '#', ' ', 'path');

  {
         my $initial;
@@ -488,7 +488,7 @@ sub list_and_choose {

                 if ($opts->{HEADER}) {
                         if (!$opts->{LIST_FLAT}) {
-                               print "     ";
+                               print " ";
                         }
                         print colored $header_color, "$opts->{HEADER}\n";
                 }
@@ -506,12 +506,14 @@ sub list_and_choose {
                                 $print = sprintf($status_fmt,
                                     $print->{INDEX},
                                     $print->{FILE},
+                                   $i + 1,
+                                   ":",
                                     $value);
                         }
                         else {
                                 $print = $highlighted || $print;
                         }
-                       printf("%s%2d: %s", $chosen, $i+1, $print);
+                       printf("%s%s", $chosen, $print);
                         if (($opts->{LIST_FLAT})&&
                             (($i + 1) % ($opts->{LIST_FLAT}))) {
                                 print "\t";
