X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 18:50:46 +0100
Message-ID: <200610291850.46321.jnareb@gmail.com>
References: <200610291122.30852.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 17:51:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Jin+awCxqf7SvDAVpCAc/O1Fs+emQ0AUMfhX+SXPKhtIpUYr2do1RcVKR6sT6c4VL5i5c0aZMCfKbPZFK6lFuj3ROuy2AN0FtShhJmQN4EVzX/6nL7krZ9UuM8hOd/el5o9y3I2iOc+8T5qD8OcaFafDPCQZYj0k4Mt/3klUyqI=
User-Agent: KMail/1.9.3
In-Reply-To: <200610291122.30852.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30435>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeEoY-0002uF-Ms for gcvg-git@gmane.org; Sun, 29 Oct
 2006 18:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965320AbWJ2RvE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 12:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWJ2RvD
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 12:51:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:23234 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965318AbWJ2RvB
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 12:51:01 -0500
Received: by ug-out-1314.google.com with SMTP id 32so998176ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 09:51:00 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr2830339ugj; Sun, 29 Oct 2006
 09:50:59 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id j33sm1916590ugc.2006.10.29.09.50.58; Sun, 29 Oct
 2006 09:50:59 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

A couple of questions regarding new patchset/diff look for gitweb.
Currently patch starts with "git diff" header

  diff --git a/file1 b/file2

then we have a couple of extended header lines

  old|new|deleted file|new file mode <mode>
  copy|rename from|to <path>
  (dis)?similarity index <percent>
  index <hash>..<hash> [<mode>]

then we have two-line from-file/to-file header

  --- a/file1
  +++ b/file2

then patch itself.


1. Which parts to convert to hyperlinks, and which to do not? Which
   links have visible and which hidden (underline on mouseover, the same
   color as neighbouring text)?

   I think that a/file1 in "git diff" header should be turned into
   visible hyperlink unless file is created, and b/file2 should be link
   unless file is deleted.

   Also both <hash>-es in "index" extended header lines should be turned
   into links, as it is the only way to have hyperlink to all previous
   versions of the file in the case of "combined diff" format (to be
   added later). The question is if those hyperlinks should be visible;
   I don't have compelling reason against. Should we use title attribute
   to give filename perhaps, or is it unnecessary?

   Currently file1 and file2 in "--- a/file1" and "+++ b/file2" are
   turned into hidden links. Should we leave it, or should we remove
   this link as we have similar link just above? If we decide to have
   this link, should we also hyperlink <path> in "copy|rename" extended
   header line?

2. Use quoted or unquoted filename, remove or leave surrounding quotes
   in quoted filename? Should we unquote the not hyperlinked filename
   in the case of creation/deletion? What should be span of link:
     "a/_file1_", "_a/file1_", _"a/file1"_
     "_file_", _"file"_ 
   (where '_' marks beginning and end of link) for quoted filenames?
   What should be span of link for unquoted filenames:
      a/_file_, _a/file_
   Currently gitweb uses a/_file_ in ---/+++ line.

3. How (and if) to explain numerical mode: the currently used
   <mode>/<symbolic mode> (<file type>) e.g. 100755/-rwxr-xr-x (file).
   Or <mode> (<file type>) should be enough? Should we mark the addition
   compared to git-diff output? Or should we explain <mode> only on
   mouseover, using for example:
     <abbr title="100644/-rw-r--r-- (file)">100644</abbr>
   or just
     <abbr title="executable file">100755</abbr>?
-- 
Jakub Narebski
