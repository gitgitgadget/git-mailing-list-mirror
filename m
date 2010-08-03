From: =?ISO-8859-1?Q?Simon_Gr=F6nlund?= <simongronlund@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Tue, 3 Aug 2010 11:31:08 +0200
Message-ID: <AANLkTinfebXbQGb2L1nkebdXzi9cfJbHFA-r_DLLNoFf@mail.gmail.com>
References: <AANLkTine9j=PsfsOPmEWmDLUDrHCJF0MQ6X+6XJkQD0d@mail.gmail.com>
	<0015174c437c389602048ce7f16c@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 11:31:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgDqA-0001Sw-0U
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 11:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab0HCJbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 05:31:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49309 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab0HCJbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 05:31:12 -0400
Received: by eya25 with SMTP id 25so1540716eya.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=fhPtRD99qEnvFj1X0f7G+fYSTIysGm+bF4dlqMh3XVU=;
        b=MeslAB5pyXgcZX4+TqLZF2x284qd4xp0BzUUNwGef5Qx1TvvI1yK3HF2gmC7JYxDFZ
         lS1dXtxZOcQBYG7sttbyjSzC7QS7MK8ScT440bvOlf1Z8uMuswzfWPgSWkou4F+GOPsh
         IswcIRShPrOwFvdKDY6QHAtRKZCWiooUU5Gyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=tJtATMUppAlo6g4bOfl+XbUv7yh6ebrnjNcvifE1r75C6mR9o1ce8stxupbo+9OS3B
         7jrdkqRxyoFsUAzfo9+zKFumv6ZAEw8KT0L851A93il9+/4Wg++uwGe1W0YHDdTmlFmN
         b+13zs57cAUURLickxaew5Ghd/yuhRIA0QL8g=
Received: by 10.213.3.83 with SMTP id 19mr591996ebm.99.1280827868222; Tue, 03 
	Aug 2010 02:31:08 -0700 (PDT)
Received: by 10.213.8.66 with HTTP; Tue, 3 Aug 2010 02:31:08 -0700 (PDT)
In-Reply-To: <0015174c437c389602048ce7f16c@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152495>

Since recent weekend I face an error trying to execute git svn fetch
-q. trying to build an index from scratch does not help.

$ git svn fetch
error: short read No such file or directory
fatal: Unable to add (null) to database
   at /usr/lib64/perl5/SVN/Ra.pm line 623

$ git --version
git version 1.7.2

$ svn --version
svn, version 1.6.9 (r901367)

$ sqlite3 --version
3.6.22

$ perl --version
This is perl, v5.10.1 (*) built for x86_64-linux-thread-multi

$ uname -a
Linux host 2.6.33.6-147.fc13.x86_64 #1 SMP Tue Jul 6 22:32:17 UTC 2010
x86_64 x86_64 x86_64 GNU/Linux

yum says
git-1.7.2-1.fc13.x86_64
subversion-1.6.9-2.fc13.x86_64
sqlite-3.6.22-1.fc13.x86_64
perl-5.10.1-114.fc13.x86_64

The error points me to perl5/SVN/Ra.pm line 623 which is at the lat line in
our $AUTOLOAD;
sub AUTOLOAD {
    my $class = ref($_[0]);
    $AUTOLOAD =~ s/^${class}::(SUPER::)?//;
    return if $AUTOLOAD =~ m/^[A-Z]/;

    my $self = shift;
    no strict 'refs';

    print $self, "\n";
    print $AUTOLOAD, "\n";
    print @_, "\n\n";

    my $method = $self->can("invoke_$AUTOLOAD")
        or die "no such method $AUTOLOAD";

    no warnings 'uninitialized';
    $method->(@$self, @_);
}

The 3 print-debug lines are added by me and they emits the following:
$ git svn fetch
SVN::Ra::Reporter=ARRAY(0x2b04418)
set_path
Use of uninitialized value $_[3] in print at
/usr/lib64/perl5/SVN/Ra.pm line 621.
721210SVN::Pool=REF(0x2b04130)

SVN::Ra::Reporter=ARRAY(0x2b04418)
set_path
Use of uninitialized value $_[3] in print at
/usr/lib64/perl5/SVN/Ra.pm line 621.
branches721210SVN::Pool=REF(0x2b04130)

SVN::Ra::Reporter=ARRAY(0x2b04418)
set_path
Use of uninitialized value $_[3] in print at
/usr/lib64/perl5/SVN/Ra.pm line 621.
branches/4.272117SVN::Pool=REF(0x2b04130)

SVN::Ra::Reporter=ARRAY(0x2b04418)
finish_report
SVN::Pool=REF(0x2b04130)

error: short read No such file or directory
fatal: Unable to add (null) to database
 at /usr/lib64/perl5/SVN/Ra.pm line 627

Unfortunately I have been unable to debug this further.




Git works flawlessly in this setup with another branch of the same SVN
repository but I have not been able to pinpoint which revision or what
else that can be wrong here.

Is this error introduced with the recent release of Git?
Is there some mismatch between Git, Svn, Perl, or Sqlite?

Grateful for tips or hints.

/Simon
