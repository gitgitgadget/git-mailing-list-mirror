From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Tue, 17 Nov 2015 02:20:49 -0500
Message-ID: <20151117072049.GA25414@flurp.local>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
 <1447717227.23262.10.camel@intel.com>
 <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
 <1447719035.23262.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:21:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyaa6-0000Vb-AA
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 08:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbKQHU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2015 02:20:57 -0500
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34217 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbKQHU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 02:20:56 -0500
Received: by igbxf8 with SMTP id xf8so1034884igb.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 23:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8tHy1tDy421N052lGsHMCe4Iett/xymHv+FNL1EC3Xg=;
        b=d1R4HJyDyAvAcHYath9dy/gE4dytJ1+DFQk0A3RHiqK9dRRblkCrOMDVPsXKOxePMs
         swIxxSS6ZMqUxYq4oE7U0bLh/AzgSW7Yn9ouarcvpF1Q18xQ4YVnJf+xg3coEC7pT1iy
         CD6jkvqBCkef67HByTwUUeqxHrrNYM2Ksp3FC5pFhpT8GyMr+urJo2Pcbh5cVgzO0diX
         k98p5OdXKflOqrS7fJ5eG8D2QGi+jFV2h+79PZcdB4B837XgLiksM4Tn7IonaYpGQOvV
         ZWGYDYMnYBo2W2qf1v4hqBenE49Sn/GmwPDKbjk/a4QonhEXccUbUcJYxsHN6Ybjhedg
         smAA==
X-Received: by 10.50.87.100 with SMTP id w4mr470868igz.62.1447744855904;
        Mon, 16 Nov 2015 23:20:55 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id 124sm12113429ioz.10.2015.11.16.23.20.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 16 Nov 2015 23:20:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447719035.23262.17.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281383>

On Tue, Nov 17, 2015 at 12:10:35AM +0000, Keller, Jacob E wrote:
> On Mon, 2015-11-16 at 18:50 -0500, Eric Sunshine wrote:
> > It should be possible to extract the alias within the shell itself
> > without a separate process. For instance:
> >=20
> > =A0=A0=A0=A0read alias rest
> >=20
> > will leave the first token in $alias and the remainder of the line =
in
> > $rest, and it's all done within the shell process.
>=20
> I'll look into this :)

My reason for asking is concern about scripts possibly breaking if
someone comes along and wants to "fix" --dump-aliases to also dump
the alias expansions. One possibility is just to punt today and say
that when that feature is needed in the future, then that someone can
add a --verbose option to complement --dump-aliases which would emit
the alias expansions as well. One nice thing about punting at this
point is that we don't (today) have to define a format for the output
of the expansions. If we did want to think about it, one verbose,
non-ambiguous format would be to show the alias name on a line by
itself, and each expansion value on a line by itself indented by a
tab. For instance:

    managers
        bob
	fred
    devs
        jane
	john

> > Also, shouldn't --list-aliases (or --dump-aliases) be mutually
> > exclusive with many of the other options? New tests would check suc=
h
> > exclusivity as well.
>=20
> I am at a loss for how to do that correctly in the perl. Help would b=
e
> appreciated here.

Since git-send-email.perl already configures GetOpt::Long with the
'pass_through' option, one possibility would be to invoke
GetOptions() once for --list-aliases (or --dump-aliases), and then
again for the normal options. Doing so may be a bit ugly; on the
other hand, it does indicate pretty clearly that --list-aliases is a
distinct "mode" of operation. On top of your patch, it might look
something like this:

--- 8< ---
diff --git a/git-send-email.perl b/git-send-email.perl
index ee14894..cada5ea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -296,6 +296,12 @@ $SIG{INT}  =3D \&signal_handler;
=20
 my $help;
 my $rc =3D GetOptions("h" =3D> \$help,
+		    "list-aliases" =3D> \$list_aliases);
+usage() unless $rc;
+die "--list-aliases incompatible with other options\n"
+	if !$help and $list_aliases and @ARGV;
+
+$rc =3D GetOptions(
 		    "sender|from=3Ds" =3D> \$sender,
                     "in-reply-to=3Ds" =3D> \$initial_reply_to,
 		    "subject=3Ds" =3D> \$initial_subject,
@@ -349,7 +355,6 @@ my $rc =3D GetOptions("h" =3D> \$help,
 		    "force" =3D> \$force,
 		    "xmailer!" =3D> \$use_xmailer,
 		    "no-xmailer" =3D> sub {$use_xmailer =3D 0},
-                    "list-aliases" =3D> \$list_aliases,
 	 );
=20
 usage() if $help;
--- 8< ---

Though, it may be overkill for this minor use-case.
