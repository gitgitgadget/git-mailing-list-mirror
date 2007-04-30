From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn failure when symlink added in svn
Date: Mon, 30 Apr 2007 07:33:38 -0700
Message-ID: <m2abwqq6d9.fsf@ziti.local>
References: <loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
	<7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
	<m2k5vwfbf6.fsf@ziti.fhcrc.org>
	<7vwszwi0h2.fsf@assigned-by-dhcp.cox.net>
	<20070429183136.GE12375@untitled>
	<7vr6q2dhex.fsf@assigned-by-dhcp.cox.net>
	<20070429222136.GA1800@untitled>
	<7vmz0qcuut.fsf@assigned-by-dhcp.cox.net>
	<20070430063133.GA14414@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 16:34:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiWx1-0006OF-6N
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 16:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423313AbXD3Odo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 10:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423311AbXD3Odn
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 10:33:43 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:61569 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423310AbXD3Odm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 10:33:42 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1933605nzf
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 07:33:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=fZY3O7OAGQ1iEVUs0GGsCkz2CVO5NTrKecfem4glDaxzMt4Q6JxjqJuLio5pVsRJQ9D3hKxBlAY0+hn3qNijJ3AM4eE+bPjZRhNRYlTJB0nFilw1Ubq4XkSxEWM7N4KLvL/WyDBRVQkvT0P5Y9Qexp/ys4JIdqNd3KMVVhspD20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=OHtW2eJG8h40vdvhdttzUVcZ8sFtv5znEVQQOn3ls2nuyNoAqLFKI4yQK6hP+queoHPVw/al3oUWoes/DK8nPXluijet56Ok0ni0/TbPjI+Yv7M0Pllf1C3286APmj3wAw0Dl/IsuWX+MDmpdFZQ7sW7EM5NlptSNsiwsFDBsxs=
Received: by 10.114.25.3 with SMTP id 3mr2051438way.1177943620978;
        Mon, 30 Apr 2007 07:33:40 -0700 (PDT)
Received: from ziti.local ( [24.19.44.95])
        by mx.google.com with ESMTP id y25sm1196244pod.2007.04.30.07.33.40;
        Mon, 30 Apr 2007 07:33:40 -0700 (PDT)
In-Reply-To: <20070430063133.GA14414@untitled> (Eric Wong's message of "Sun, 29 Apr 2007 23:31:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45868>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> 
>> > Junio C Hamano <junkio@cox.net> wrote:
>> >> diff --git a/git-svn.perl b/git-svn.perl
>> >> index 4be8576..cef6697 100755
>> >> --- a/git-svn.perl
>> >> +++ b/git-svn.perl
>> >> @@ -2464,15 +2464,15 @@ sub close_file {
>> >>  	my $hash;
>> >>  	my $path = $self->git_path($fb->{path});
>> >>  	if (my $fh = $fb->{fh}) {
>> >> -		seek($fh, 0, 0) or croak $!;
>> >> +		sysseek($fh, 0, 0) or croak $!;
>> >>  		my $md5 = Digest::MD5->new;
>> >>  		$md5->addfile($fh);
>> >
>> > We may want to keep the plain seek() here and do both seek and sysseek,
>> > I'm not sure if $md5->addfile() uses read or sysread internally.
>> 
>> Ok.  The seek before Digest::MD5 can stay as it has been that
>> way for a long time without causing problems.  How about this as
>> an replacement then?
>
> Looks good to me.  Seth?

The test cases passes as does the small example I had come up with.  I
also tried doing a git svn clone on a small repos and checking that
the resulting HEAD was the same as a previously created one (it was).

> If Seth is okay with it, then:
> Acked-by: Eric Wong <normalperson@yhbt.net>
Acked-by: Seth Falcon <sethfalcon@gmail.com>


+ seth
