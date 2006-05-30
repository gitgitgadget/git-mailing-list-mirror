From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Tue, 30 May 2006 19:32:31 +0200
Message-ID: <81b0412b0605301032k1eb7ef4ageafaeb5b7f18e5ba@mail.gmail.com>
References: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
	 <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net>
	 <7vu0782e33.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0605300623h4f915829yb388c8fdc062c009@mail.gmail.com>
	 <20060530152103.GB8931@trixie.casa.cgf.cx>
	 <81b0412b0605300900l7530792dqcea6d812602b9176@mail.gmail.com>
	 <20060530170805.GC32457@h4x0r5.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6859_32794743.1149010351767"
Cc: "Christopher Faylor" <me@cgf.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 19:32:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl855-00085T-TN
	for gcvg-git@gmane.org; Tue, 30 May 2006 19:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWE3Rcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 13:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWE3Rcd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 13:32:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:38042 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932356AbWE3Rcc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 13:32:32 -0400
Received: by wr-out-0506.google.com with SMTP id i5so33895wra
        for <git@vger.kernel.org>; Tue, 30 May 2006 10:32:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=e56LitD8t+TqXWSI1vg2dFNU6XvYldbKXMfD8/CK5MSF/YOt1b388Ae8af3U4Ykc5GbiTbKlh5gmQZwud3abhU9xJOOSAcFY0ac3VO+xIdaoknRAT8c8lD9RloILkJN/otR4nzzWOUH8zNGM2FrSS0oECIZhYrT5XWu9WV1w6lA=
Received: by 10.54.83.6 with SMTP id g6mr3379768wrb;
        Tue, 30 May 2006 10:32:31 -0700 (PDT)
Received: by 10.54.67.11 with HTTP; Tue, 30 May 2006 10:32:31 -0700 (PDT)
To: "Ryan Anderson" <ryan@michonline.com>
In-Reply-To: <20060530170805.GC32457@h4x0r5.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21039>

------=_Part_6859_32794743.1149010351767
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 5/30/06, Ryan Anderson <ryan@michonline.com> wrote:
> On Tue, May 30, 2006 at 06:00:20PM +0200, Alex Riesen wrote:
> > If you actually read the message, you'd probably notice ActiveState Perl.
> >
> > I have no idea why have you taken my post as an attempt to insult cygwin;
> > IF I had that in mind I'd dedicate a whole long post just to that.
>
> FWIW, it was probably this:
>         if test "$(uname -o)"= Cygwin; then
>
> (I only mention becuase I was about to apply this, then I saw that line,
> and now I'm confused, is this a fix for ActiveState, or Cygwin?)
>

Right. My bad. Should be "$(perl -e 'print $^O')" = MSWin32. That ($^O)
is actually how it is checked in git-annotate.perl (open_pipe).

Christopher, my apologies if that was that. I actually am hostile to
Windows and everything around it, and have my reasons for this.
Still, it does not justify the way how I did that patch.

------=_Part_6859_32794743.1149010351767
Content-Type: text/x-patch; name=send-mail-test.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_enuizubk
Content-Disposition: attachment; filename="send-mail-test.patch"

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a61da1e..7afc358 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -25,6 +25,11 @@ test_expect_success \
      git add fake.sendmail
      GIT_AUTHOR_NAME=3D"A" git commit -a -m "Second."'
=20
+if test "$(perl -e 'print $^O')" =3D MSWin32; then
+    say "git-send-mail tests disabled on ActiveState Perl + Windows"
+    # because of windows being such a crap
+else
+
 test_expect_success \
     'Extract patches and send' \
     'git format-patch -n HEAD^1
@@ -38,4 +43,6 @@ test_expect_success \
     'Verify commandline' \
     'diff commandline expected'
=20
+fi
+
 test_done



------=_Part_6859_32794743.1149010351767--
