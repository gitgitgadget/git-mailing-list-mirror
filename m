From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Sun, 22 Jul 2007 19:45:58 -0400
Message-ID: <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <Pine.LNX.4.64.0707221959100.14781@racer.site>
	 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>
	 <Pine.LNX.4.64.0707222013200.14781@racer.site>
	 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
	 <Pine.LNX.4.64.0707222238180.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICl7m-0001Ij-EI
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762152AbXGVXqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762037AbXGVXqA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:46:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:12607 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759961AbXGVXp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:45:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1789842wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 16:45:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FdN1SJk9HHR0Lni5iOMnXFrRoefNPUgojuEZYOUXxBqYauE+ab+N2SUkJjOCX/1U5ZgE6eG4vZICkJQ+qaECvueo3rgOQAaJQqkPzyslwl/JKBoeSejAZ8AeKl9BZg/Y5sVGKBY6bX5iAW8iB3t7Jg8cSA744Vq5VkS313UX8rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GyRkWmXeUYCCXf2m+xK7E3MakBCiaNBDxd2OjB/wR7dVZRTV8QGk6d3MyhG+Eio44nvCHxh2mPiX5QrLVFHTpTGJY49E3UzgUKbFJwuz1WYxkat+/WeHfc1pzJEBgwbI6LTHbXYKrnRdNbpAN/q2CRcoXs8pTxeszUgP2wkb9zE=
Received: by 10.114.209.1 with SMTP id h1mr2459876wag.1185147958460;
        Sun, 22 Jul 2007 16:45:58 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 16:45:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707222238180.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53370>

On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> As you already did, this is my attempt at a perl script...  Feel free to
> bash my Perl capabilities, or to correct it...

I don't really know Perl but Perl is probably a better language for
this. I was doing it in C.
This doesn't run on the two full kernel samples I sent you. That's the
problem I was having, I can catch 95% of the expanded keywords with my
program but I have to touch up 5% by hand. I'll stare at this and see
if I can increase my understanding of Perl.

>
> Ciao,
> Dscho
>
> -- snipsnap --
> #!/usr/bin/perl
>
> sub init_hunk {
>         $_ = $_[0];
>         $current_hunk = "";
>         $current_hunk_header = $_;
>         ($start_minus, $dummy, $start_plus, $dummy) =
>                 /^\@\@ -(\d+)(,\d+|) \+(\d+)(,\d+|) \@\@/;
>         $plus = $minus = $space = 0;
>         $skip_logs = 0;
> }
>
> sub flush_hunk {
>         if ($plus > 0 || $minus > 0) {
>                 if ($current_file ne "") {
>                         print $current_file;
>                         $current_file = "";
>                 }
>                 $minus += $space;
>                 $plus += $space;
>                 print "\@\@ -$start_minus,$minus "
>                         . "+$start_plus,$plus \@\@\n";
>                 print $current_hunk;
>         }
> }
>
> sub check_file {
>         $_ = $_[0];
>         $current_file = $_;
>         while (<>) {
>                 if (/^\@\@/) {
>                         last;
>                 }
>                 $current_file .= $_;
>         }
>
>         init_hunk $_;
>
>         # check hunks
>         while (<>) {
>                 if ($skip_logs && /^\+ *\*/) {
>                         # do nothing
>                 } elsif (/^\@\@.*/) {
>                         flush_hunk;
>                         init_hunk $_;
>                 } elsif (/^diff/) {
>                         flush_hunk;
>                         return;
>                 } elsif (/^-.*\$(Id|Revision|Author|Date).*\$/) {
>                         $key = $1;
>                         s/^-/ /;
>                         $current_hunk .= $_;
>                         $space++;
>                         $_ = <>;
>                         if (!/\+.*\$Id.*\$/) {
>                                 die "Expected some changed \$$key line: $_";
>                         }
>                         $skip_logs = 0;
>                 } elsif (/^ .*\$Log.*\$/) {
>                         $current_hunk .= $_;
>                         $space++;
>                         $skip_logs++;
>                 } elsif (/^ /) {
>                         $current_hunk .= $_;
>                         $space++;
>                         $skip_logs = 0;
>                 } elsif (/^\+/) {
>                         $current_hunk .= $_;
>                         $plus++;
>                 } elsif (/^-/) {
>                         $current_hunk .= $_;
>                         $minus++;
>                         $skip_logs = 0;
>                 } else {
>                         die "Unexpected line: $_";
>                 }
>         }
> }
>
> while (<>) {
>         if (/^diff/) {
>                 do {
>                         check_file $_;
>                 } while(/^diff/);
>         } else {
>                 printf $_;
>         }
> }
>


-- 
Jon Smirl
jonsmirl@gmail.com
