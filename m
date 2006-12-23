From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: Allow search to be disabled from the config file.
Date: Sat, 23 Dec 2006 14:00:18 +0100
Message-ID: <200612231400.18774.jnareb@gmail.com>
References: <11668449162618-git-send-email-robfitz@273k.net> <emiomr$f4m$1@sea.gmane.org> <20061223122841.GD11474@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 13:57:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy6Ra-0000ZN-Rb
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 13:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbWLWM5h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 07:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbWLWM5h
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 07:57:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:1032 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbWLWM5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 07:57:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3184404uga
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 04:57:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ct7MXUAgDeBTfOeW41PhrGCMBffiopTMoxcIW1+dpRZcdz99YZdtvOUHKCjN9Pt9Oq+Fm2GvgATJ/fL8pPGqNC/bRcFGTn9x99yjmjVBLVx38qASm4BcmxrDmnOnCv6M/3rCp6gcP4osrQywXsFxFOXjJn+AQabZHYlRtjQ+EWM=
Received: by 10.67.19.20 with SMTP id w20mr2067914ugi.1166878655412;
        Sat, 23 Dec 2006 04:57:35 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id 54sm17074844ugp.2006.12.23.04.57.34;
        Sat, 23 Dec 2006 04:57:35 -0800 (PST)
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061223122841.GD11474@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35314>

Robert Fitzsimons wrote:
> Jakub Narebski wrote:

>> I'm not sure if it is worth disabling such not demanding in resources
>> (contrary to pickaxe, blame and to some extent snapshot). Perhaps it would
>> be better to simply paginate search result, like "history" view got
>> paginated?
> 
> Yes that makes sense.  I'll withdraw this patch and try and come up with
> a new one which can paginate search results.

Besides having removed search, it would follow removing search _form_.
Hmmm... perhaps we should add 'pickaxe' to search form only if it is
enabled?

Something like (warning: this diff is certainly whitespace damaged!):

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5feebaf..585d9fd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1894,7 +1903,8 @@ EOF
                      $cgi->hidden(-name => "a") . "\n" .
                      $cgi->hidden(-name => "h") . "\n" .
                      $cgi->popup_menu(-name => 'st', -default => 'commit',
-                                      -values => ['commit', 'author', 'committer', 'pickaxe
+                                      -values => ['commit', 'author', 'committer',
+                                      gitweb_check_feature('pickaxe') ? 'pickaxe' : ()]) .
                      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
                      " search:\n",
                      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .



Take a look how it was done for "history" view in commit 8be683520e
  "gitweb: Paginate history output"

Although with search you have additional complication with marking match,
and "log" view like rather than "shortlog" like view... so I'm not sure
if it would truly help. On the other hand you can use --skip option you
have introduced...
-- 
Jakub Narebski
Poland
