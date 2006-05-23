From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 2/2] cvsimport: cleanup commit function
Date: Wed, 24 May 2006 08:29:07 +1200
Message-ID: <46a038f90605231329w35d10cfdg1ac413ebf8d32e11@mail.gmail.com>
References: <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
	 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
	 <20060522214128.GE16677@kiste.smurf.noris.de>
	 <7v8xotadm3.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
	 <20060523065232.GA6180@coredump.intra.peff.net>
	 <20060523070007.GC6180@coredump.intra.peff.net>
	 <46a038f90605230113x2f6b0e4bq5a2ea97308b495e0@mail.gmail.com>
	 <Pine.LNX.4.64.0605230948280.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0605231232360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Matthias Urlichs" <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 22:29:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FidVA-0003XK-HL
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWEWU3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWEWU3J
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:29:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:53511 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932128AbWEWU3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 16:29:08 -0400
Received: by wr-out-0506.google.com with SMTP id i3so1338232wra
        for <git@vger.kernel.org>; Tue, 23 May 2006 13:29:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p2wcB+yl9cTxpxuRVtDocZ5YAA+9sgZW4ALc0QhReo1lLgvvOLNmcnsnxHKgmjUPwjF1v6WE9Ukf9tV75sA6LII4I/+PjcGP3LF+vyKewHOAoWlqpc1jU2n0+ZQ4+W0YjF1O6iJQViYxCedbUe2LL8/p56+D+gZTv9c/ZLdEQY8=
Received: by 10.54.70.17 with SMTP id s17mr3442309wra;
        Tue, 23 May 2006 13:29:07 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Tue, 23 May 2006 13:29:07 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605231232360.5623@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20632>

On 5/24/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Martin, that problem seems to go away when I initialize $res to 0 in
> _fetchfile.
>
> I don't know perl, and maybe local variables are pre-initialized to empty.
>
> It's entirely possible that the fact that it now seems to work for me is
> purely timing-related, since I also ended up using "-P cvsps-output" to
> avoid having a huge cvsps binary in memory at the same time.

Strange! Cannot repro here with v5.8.8 (debian/etch 5.8.8-4) but
initialising it doesn't hurt, so let's do it:

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ace7087..abbfd0b 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -371,7 +371,7 @@ sub file {
 }
 sub _fetchfile {
        my ($self, $fh, $cnt) = @_;
-       my $res;
+       my $res = 0;
        my $bufsize = 1024 * 1024;
        while($cnt) {
            if ($bufsize > $cnt) {

cheers,


martin
