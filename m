From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Make test script annotate-tests.sh handle missing authors
Date: Sat, 16 Oct 2010 03:43:51 -0700
Message-ID: <09193539-B5AD-4574-9FE4-983566A34355@sb.org>
References: <1287208215-91901-1-git-send-email-kevin@sb.org> <m3sk06617a.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 12:44:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P74FG-0002ku-TT
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 12:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab0JPKnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 06:43:55 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34057 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab0JPKny convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Oct 2010 06:43:54 -0400
Received: by pxi16 with SMTP id 16so241867pxi.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 03:43:54 -0700 (PDT)
Received: by 10.142.185.12 with SMTP id i12mr1549861wff.227.1287225834102;
        Sat, 16 Oct 2010 03:43:54 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id y42sm11621309wfd.22.2010.10.16.03.43.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 03:43:53 -0700 (PDT)
In-Reply-To: <m3sk06617a.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159159>

On Oct 16, 2010, at 12:34 AM, Jakub Narebski wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> Also, I'm not a Perl programmer, so it's possible there's a better idiom
>> for this sort of thing.
>> 
>> t/annotate-tests.sh |    3 +++
>> 1 files changed, 3 insertions(+), 0 deletions(-)
>> 
>> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>> index 396b965..4e37a66 100644
>> --- a/t/annotate-tests.sh
>> +++ b/t/annotate-tests.sh
>> @@ -9,6 +9,9 @@ check_count () {
>> 	cat .result | perl -e '
>> 		my %expect = (@ARGV);
>> 		my %count = ();
>> +		while (my ($author, $count) = each %expect) {
>> +			$count{$author} = 0;
>> +		}
> 
> 
> First, it is a very bad practice to have variables of different type
> named the same way, here %count (hash) and $count (scalar, unused).

Thanks for the pointer, but $count is already used in the while loop below:

		while (my ($author, $count) = each %count) {
			my $ok;
			if ($expect{$author} != $count) {
				$bad = 1;
				$ok = "bad";
			}
			else {
				$ok = "good";
			}
			print STDERR "Author $author (expected $expect{$author}, attributed $count) $ok\n";
		}

I'll go and change the one in my new while loop though, to use the Perl idiom way you listed below.

> Perl idiom way would be
> 
>  -		my %count = ();
>  +		my %count = map { $_ => 0 } keys %expect;

-Kevin Ballard