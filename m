From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make test script annotate-tests.sh handle missing authors
Date: Sat, 16 Oct 2010 14:22:16 +0200
Message-ID: <201010161422.17483.jnareb@gmail.com>
References: <1287208215-91901-1-git-send-email-kevin@sb.org> <m3sk06617a.fsf@localhost.localdomain> <09193539-B5AD-4574-9FE4-983566A34355@sb.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 15:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P76jH-0004io-BJ
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 15:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab0JPNXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 09:23:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39768 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab0JPNXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 09:23:12 -0400
Received: by bwz15 with SMTP id 15so1702873bwz.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LxtncOJKAIlgyI3AbywePwZa3CpmxcNmVNxlos55Fc8=;
        b=bF9UwJ/llDosAN3cAWYi/AcR4T7WOZvoatHQQts3ed0v5482+U4gKtx5NOjcz7o2CK
         PHY0IvLNocVKMqeRe6yJqZ/0sEJW1vV/4hmgpkM0hEkRRxN5nL7zXgqbn4BcdyssB7eX
         av0/08evS4OyUyBetRGfVuHKzymzFCH2JwWlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=k1Wqvs5ZVOW8BYk289ELw9XnApfeX9ebEUZrG+aaPEQ0KMSXaNa+CHeC1c5gW5IGKy
         M/NBkdDB9SIl6KBBJOLgrzyDezCv42JaNdp7ZpeVet3BHGz0BqTAD5NxpIRIQj0DwLc9
         elx/W7nQz+yyN2at8UEDr0CC0LYUAKQUX2WOg=
Received: by 10.204.131.200 with SMTP id y8mr2011958bks.107.1287231750388;
        Sat, 16 Oct 2010 05:22:30 -0700 (PDT)
Received: from [192.168.1.13] (abwd201.neoplus.adsl.tpnet.pl [83.8.227.201])
        by mx.google.com with ESMTPS id a25sm12269812bks.8.2010.10.16.05.22.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 05:22:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <09193539-B5AD-4574-9FE4-983566A34355@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159162>

On Sat, 16 Oct 2010, Kevin Ballard wrote:
> On Oct 16, 2010, at 12:34 AM, Jakub Narebski wrote:
>> Kevin Ballard <kevin@sb.org> writes:
>> 
>>> Also, I'm not a Perl programmer, so it's possible there's a better idiom
>>> for this sort of thing.
>>> 
>>> t/annotate-tests.sh |    3 +++
>>> 1 files changed, 3 insertions(+), 0 deletions(-)
>>> 
>>> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>>> index 396b965..4e37a66 100644
>>> --- a/t/annotate-tests.sh
>>> +++ b/t/annotate-tests.sh
>>> @@ -9,6 +9,9 @@ check_count () {
>>> 	cat .result | perl -e '
>>> 		my %expect = (@ARGV);
>>> 		my %count = ();
>>> +		while (my ($author, $count) = each %expect) {
>>> +			$count{$author} = 0;
>>> +		}
>> 
>> 
>> First, it is a very bad practice to have variables of different type
>> named the same way, here %count (hash) and $count (scalar, unused).
> 
> Thanks for the pointer, but $count is already used in the while loop below:
> 
> 		while (my ($author, $count) = each %count) {
> 			my $ok;
> 			if ($expect{$author} != $count) {
> 				$bad = 1;
> 				$ok = "bad";
> 			}
> 			else {
> 				$ok = "good";
> 			}
> 			print STDERR "Author $author (expected $expect{$author}, attributed $count) $ok\n";
> 		}

Hmmm... the %count hash should probably be named %actual (to complement
%expect), or %attributed (like in output).

-- 
Jakub Narebski
Poland
