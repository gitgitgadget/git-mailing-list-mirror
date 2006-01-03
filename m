From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Howto send many commits as mail-patches?
Date: Tue, 3 Jan 2006 12:24:17 -0500
Message-ID: <20060103172416.GA23896@mythryan2.michonline.com>
References: <20060103113859.GA15832@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 18:24:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Etptr-0006Sf-S2
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 18:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWACRYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 12:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWACRYh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 12:24:37 -0500
Received: from mail.autoweb.net ([198.172.237.26]:31155 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932456AbWACRYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2006 12:24:36 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Etpth-0008R0-Od; Tue, 03 Jan 2006 12:24:35 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1Etptb-0005iu-Cv; Tue, 03 Jan 2006 12:24:33 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1EtptW-0006GU-34; Tue, 03 Jan 2006 12:24:22 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20060103113859.GA15832@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14154>

On Tue, Jan 03, 2006 at 12:38:59PM +0100, Sam Ravnborg wrote:
> Hi all.
> 
> I have a collection of commits in my GIT repository that I like to send
> out to linux-kernel.
> But my initial experiments with git-send-emails.perl fall out bad.
> 
> I did the following:
> 
> 1) First I created a mbox with the patches:
> git format-patch -n --mbox --stdout -M -B b286e39207237e2f6929959372bf66d9a8d05a82 > mbox


> The mbox looked OK. -M -B were from the man page and since the patchset
> includes a number of renames it made the mbox considerably smaller.
> 
> So I went on an tried to send the mails:
> 
> It just send out two huge mails containing all of the mbox.
> Also it cc:ed all people included in "Signed-off-by". That is sometimes
> a nice feature but for testing I like it to be optional.
> 
> Can someone give me a nice howto so I can see how to send out the mails.

Try:
	mkdir ../pending/
	git format-patch -n --mbox -o ../pending/ -M -B b286e39207237e2f6929959372bf66d9a8d05a82
	git-send-email.perl --from "Sam Ravnborg <sam@ravnborg.org>" --to "sam@ravnborg.org" --chain-reply-to "" ../pending/

With this method, you can examine the files in ../pending/, edit patch
comments if you want, add an "introductory" mail, etc.

The Signed-off-by: cc:ing is currently not something that can be
disabled, but you can do something like this to stop it temporarily:

(cut and pasted, so it probably won't directly apply)
diff --git a/git-send-email.perl b/git-send-email.perl
index ec1428d..9c7d0b8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -322,7 +322,7 @@ foreach my $t (@files) {
                        }
                } else {
                        $message .=  $_;
-                       if (/^Signed-off-by: (.*)$/i) {
+                       if (/^XSigned-off-by: (.*)$/i) {
                                my $c = $1;
                                chomp $c;
                                push @cc, $c;

Hope that helped,

-- 

Ryan Anderson
  sometimes Pug Majere
